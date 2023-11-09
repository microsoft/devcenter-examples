param (
    [Parameter()]
    [string]$SourceURL,
    [Parameter()]
    [string]$Package,
    [Parameter()]
    [string]$Version,
    [Parameter()]
    [string]$DestinationDirectory,
    [Parameter()]
    [string]$FileExtension
)

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

if($SourceURL -ne "" -and $Package -ne "" -and $Version -ne "" -and $DestinationDirectory -ne "") {
    $SourceURL = $SourceURL.TrimEnd('/')
    $packageFileURL = "$SourceURL/$Package-$Version.$FileExtension"
    Write-Host "packageFileURL:$packageFileURL"

    if(!(Test-Path $DestinationDirectory)) {
        New-Item $DestinationDirectory -ItemType Directory
    }

    $zipFile = Join-Path $DestinationDirectory "$Package-$Version.$FileExtension"

    if(!(${env:REPO-GET-SECRET})){
        Invoke-RestMethod $packageFileURL -OutFile $zipFile
    }else{
        Invoke-RestMethod -Headers @{Authorization=('Basic {0}' -f ${env:REPO-GET-SECRET})} $packageFileURL -OutFile $zipFile
    }

    if(Test-Path $zipfile){
        $packageFolder = "$DestinationDirectory/$Package-$Version" 
        if(Test-Path $packageFolder) {
            Remove-Item $packageFolder -Force -Recurse
        }
        
        if($FileExtension -eq "zip"){
            Unzip $zipFile $packageFolder
        }
        
    }else{
        Write-Host "Cannot download the zip file: $packageFileURL to $zipFile"
    }
} else {
    Write-Host "SourceURL, Package, Version and DestinationDirectory are not expected. SourceURL: $SourceURL, Package: $Package, Version: $Version, DestinationDirectory: $DestinationDirectory"
}
