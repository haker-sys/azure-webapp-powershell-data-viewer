# Get all installed applications
$InstalledApps = Get-ItemProperty `
    HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, `
    HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, `
    HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* `
    -ErrorAction SilentlyContinue |
    Where-Object { $_.DisplayName } |
    Select-Object `
        @{Name="Application"; Expression={$_.DisplayName}},
        @{Name="Version"; Expression={$_.DisplayVersion}},
        @{Name="Publisher"; Expression={$_.Publisher}},
        @{Name="InstallDate"; Expression={$_.InstallDate}},
        @{Name="InstallLocation"; Expression={$_.InstallLocation}}

# Sort applications alphabetically
$InstalledApps = $InstalledApps | Sort-Object Application

foreach ($InstalledApp in $InstalledApps) {

	$body = [ordered]@{
		Computer = $env:COMPUTERNAME
		Application     = $InstalledApp.Application
		Version         = $InstalledApp.Version
		Publisher       = $InstalledApp.Publisher
		InstallDate     = $InstalledApp.InstallDate
		InstallLocation = $InstalledApp.InstallLocation
	}

    Invoke-RestMethod `
        -Uri "<your webapp url>/data" `
        -Method POST `
        -Body ($body | ConvertTo-Json) `
        -ContentType "application/json"
}
