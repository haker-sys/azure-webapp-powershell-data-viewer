$body = @{
    message = "Hello from PowerShell"
    computer = $env:COMPUTERNAME
    username = $env:USERNAME
}

Invoke-RestMethod `
    -Uri "<your webapp url>/data" `
    -Method POST `
    -Body ($body | ConvertTo-Json) `
    -ContentType "application/json"