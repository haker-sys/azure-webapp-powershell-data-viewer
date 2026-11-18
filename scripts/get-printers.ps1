# Get installed printers
$InstalledPrinters = Get-Printer

# Sort installed alphabetically
$InstalledPrinters = $InstalledPrinters | Sort-Object Application

foreach ($InstalledPrinter in $InstalledPrinters) {

	$body = [ordered]@{
		Computer = $env:COMPUTERNAME
		PrinterName     = $InstalledPrinter.Name
		Type       		= $InstalledPrinter.Type
		DriverName      = $InstalledPrinter.DriverName
		PortName    	= $InstalledPrinter.PortName
		Shared 			= $InstalledPrinter.Shared
		Published       = $InstalledPrinter.Published
	}

    Invoke-RestMethod `
        -Uri "<your webapp url>/data" `
        -Method POST `
        -Body ($body | ConvertTo-Json) `
        -ContentType "application/json"
}
