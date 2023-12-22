param (
    [Parameter()]
    [string]$Organization,
    [Parameter()]
    [string]$Project,
    [Parameter()]
    [string]$Feed,
    [Parameter()]
    [string]$Package,
    [Parameter()]
    [string]$Version,
    [Parameter()]
    [string]$Destination,
    [Parameter()]
    [string]$PAT
)

if($PAT) {
    # if PAT is provided, we just use rest api to download the artifact as sysadmin   
    az extension add --name azure-devops
    Write-Output $PAT | az devops login --organization https://dev.azure.com/${Organization}/
    if($Project){
        az artifacts universal download --organization https://dev.azure.com/${Organization}/ --project $Project --scope project --feed $Feed --name $Package --version $Version --path $($Destination)
    }else{
        az artifacts universal download --organization https://dev.azure.com/${Organization}/ --feed $Feed --name $Package --version $Version --path $($Destination)
    }
    
}else
{
    # if PAT is not provided, we use ado cli to download the artifact as the current user
    $Command = @"

az login
az extension add --name azure-devops
"@
    if($Project){
        $Command += @"

az artifacts universal download --organization https://dev.azure.com/${Organization}/ --project $Project --scope project --feed $Feed --name $Package --version $Version --path $($Destination)
"@
        
    }else{
        $Command += @"

az artifacts universal download --organization https://dev.azure.com/${Organization}/ --feed $Feed --name $Package --version $Version --path $($Destination)
"@
    }
    function SetupScheduledTasks {
        param(
            [string]$RunAsUserScriptPath,
            [string]$lockFileFullPath,
            [string]$cleanupfullPath
        )

        $RunAsUserTask = "DevBoxCustomizations"
        $CleanupTask = "DevBoxCustomizationsCleanup"

        if(!(Test-Path -Path $lockFileFullPath)){
            New-Item -Path $lockFileFullPath -ItemType File
        }
    
        $ShedService = New-Object -comobject "Schedule.Service"
        $ShedService.Connect()
    
        # Schedule the cleanup script to run every minute as SYSTEM
        $Task = $ShedService.NewTask(0)
        $Task.RegistrationInfo.Description = "Dev Box Customizations Cleanup"
        $Task.Settings.Enabled = $true
        $Task.Settings.AllowDemandStart = $false
    
        $Trigger = $Task.Triggers.Create(9)
        $Trigger.Enabled = $true
        $Trigger.Repetition.Interval="PT1M"
    
        $Action = $Task.Actions.Create(0)
        $Action.Path = "PowerShell.exe"
        $Action.Arguments = "Set-ExecutionPolicy Bypass -Scope Process -Force; $cleanupfullPath"
    
        $TaskFolder = $ShedService.GetFolder("\")
        $TaskFolder.RegisterTaskDefinition("$($CleanupTask)", $Task , 6, "NT AUTHORITY\SYSTEM", $null, 5)
    
        # Schedule the script to be run in the user context on login
        $Task = $ShedService.NewTask(0)
        $Task.RegistrationInfo.Description = "Dev Box Customizations"
        $Task.Settings.Enabled = $true
        $Task.Settings.AllowDemandStart = $false
        $Task.Principal.RunLevel = 1
    
        $Trigger = $Task.Triggers.Create(9)
        $Trigger.Enabled = $true
    
        $Action = $Task.Actions.Create(0)
        $Action.Path = "C:\Program Files\PowerShell\7\pwsh.exe"
        $Action.Arguments = "-MTA -Command $RunAsUserScriptPath"
    
        $TaskFolder = $ShedService.GetFolder("\")
        $TaskFolder.RegisterTaskDefinition("$($RunAsUserTask)", $Task , 6, "Users", $null, 4)
    }
    
    $CustomizationScriptsDir = "C:\DevBoxCustomizations"
    $LockFile = "lockfile"
    $RunAsUserAppendScript = "runAsUser.ps1"
    $CleanupScript = "cleanup.ps1"

    $RunAsUserScriptPath = "$($CustomizationScriptsDir)\$($RunAsUserAppendScript)"
    if(!(Test-Path -Path $CustomizationScriptsDir)){
        New-Item -Path $CustomizationScriptsDir -ItemType Directory
        Copy-Item -Path $RunAsUserAppendScript -Destination $RunAsUserScriptPath -Force
    }

    $lockFileFullPath = "$($CustomizationScriptsDir)\$($LockFile)"
    $cleanupfullPath = "$($CustomizationScriptsDir)\$($CleanupScript)"

    if(![string]::IsNullOrEmpty($Command)){
        Add-Content -Path $RunAsUserScriptPath -Value $Command
    }

    Copy-Item "./$($CleanupScript)" -Destination $CustomizationScriptsDir -Force

    if (!(Test-Path -PathType Leaf "$lockFileFullPath")) {
        SetupScheduledTasks $RunAsUserScriptPath $lockFileFullPath $cleanupfullPath
    }
}

