param (
    [Parameter()]
    [string]$FilePath
)

if(Test-Path $FilePath){
    $ProgressPreference = 'SilentlyContinue'	# hide any progress output

    Write-Host "[${env:username}] Start to install $FilePath ..."

    $process = Start-Process -FilePath 'msiexec' -ArgumentList `
    "/i $($FilePath)", `
	"/qn", `
	"/norestart" `
	-NoNewWindow -Wait -PassThru

    Write-Host "[${env:username}] End to install $FilePath ..."
    
    return $process.ExitCode
}
