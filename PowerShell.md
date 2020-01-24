# Update environment vars 

    $cmap = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
    $cmap += ";C:\Program Files\MongoDB\Server\4.0\bin"
    [System.Environment]::SetEnvironmentVariable("PATH", $cmap, [System.EnvironmentVariableTarget]::Machine)
    
# Create PS credential
$cred = New-Object System.Management.Automation.PSCredential ("domain\user", (Get-Content -Path C:\credentials\password-encrypted.txt | ConvertTo-SecureString))
$psSession = New-PSSession -ComputerName hostname.fqdn -Credential $cred
