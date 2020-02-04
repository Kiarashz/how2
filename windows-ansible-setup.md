# Script to enable WinRM over HTTPS + Kerberos
For more information have a look at the following links:
1. https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html
1. https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html
 
To start you need to have the host certificate/key signed by CA and imported into the server (into personal folder).
 
    ls cert: -Recurse | where { $_.Subject -like "*$(hostname)*" }
 
 
Next, set thumbprint variables as below:
 
    $thumbprint = "<value found from above command>"
 
and set the subject to FQDN of the server and set valueset and selectorset:
 
    $SubjectName = "<FQDN of the server all in upper case>"
 
    $valueset = @{
        Hostname = $SubjectName
        CertificateThumbprint = $thumbprint
    }
 
    $selectorset = @{
        Transport = "HTTPS"
        Address = "*"
    }
 
Finally configure WinRM with HTTPS
 
    New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset
 
In the Ansible inventory make sure to set the following for the host configured above.
 
    ansible_user: username@domain_name
    ansible_password: vault_password
    ansible_connection: winrm
    ansible_winrm_transport: kerberos
    #ansible_winrm_server_cert_validation: ignore
    ansible_winrm_ca_trust_path: <path to CA certificate and chain>
