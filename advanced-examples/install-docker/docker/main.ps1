$Choco = "$Env:ProgramData/chocolatey/choco.exe"

if(-not (Test-Path "$Choco")){
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
Write-Host "Start to install docker desktop"
choco install docker-desktop -y --no-progress
Write-Host "End to install docker desktop"

net localgroup docker-users "NT AUTHORITY\Authenticated Users" /ADD
