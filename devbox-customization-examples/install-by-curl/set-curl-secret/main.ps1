param (
    [Parameter()]
    [string]$RepoSecretBase64
)

#winget install curl
[System.Environment]::SetEnvironmentVariable('REPO-GET-SECRET',"$RepoSecretBase64", 'Machine')