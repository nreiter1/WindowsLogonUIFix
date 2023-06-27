$ErrorActionPreference = "Stop"

$timer = new-timespan -Days 5 
#In case users lock their computers when they leave for day and if gone for few days, the login UI will still work without rebooting and potentially losing work.

$clock = [diagnostics.stopwatch]::StartNew()
Start-Sleep -Seconds 60
while ($clock.elapsed -lt $timer)
{
    try
    {
        $logonuiprocess = $null
        $logonuiprocess = Get-Process -Name "LogonUI" #Checks to see if LogonUI is running. If Get-Process errors due to not finding a process, it will be catched and then exit the script.
        if($logonuiprocess -ne $null)
        {
            Stop-Process -Name "LogonUI"
        }
    }
    catch #Once Get-Process can't find LogonUI, catch will run to end the script.
    {
        Write-Host "LogonUI is not open!"
        exit 
    }

start-sleep -Seconds 60
}

