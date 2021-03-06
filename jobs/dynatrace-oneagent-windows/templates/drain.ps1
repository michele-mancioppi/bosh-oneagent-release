'die' > /var/vcap/jobs/dynatrace-oneagent-windows/exit

$dynatraceServiceName = "Dynatrace OneAgent"

Start-Sleep -s 3

#wait for start.ps1 to uninstall Dynatrace OneAgent
do {
	Start-Sleep -s 3
	$output = Get-Service | Where-Object {$_.Name -match "$dynatraceServiceName"}
} while ($output.length -ne 0 -and $output.Status -eq 'Running')

Start-Sleep -s 15

If ((Get-Service dynatrace-oneagent-windows).Status -eq "Running") {
	[IO.File]::WriteAllLines('/var/vcap/sys/log/dynatrace-oneagent-windows/drain.log', 'failed')
} Else {
	[IO.File]::WriteAllLines('/var/vcap/sys/log/dynatrace-oneagent-windows/drain.log', 'success')
}

Write-Host 0
