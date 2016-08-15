# WIP - Not yet found a way to set the fDenyTSConnections value to 0 using .NET
# I want to avoid using enter-pssession and set-itemproperty doesn't have a remote implementation yet.

function enable-remoteDesktop {

    param(
        [string]$computer
    )

    $RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $computer)
    $RegKey = $RegConnect.OpenSubKey("system\\currentcontrolset\\control\\terminal server")
    $RDPEnabledValue = $RegKey.GetValue("fDenyTSConnections")

    if ($RDPEnabledValue -eq 1) {

        $response = read-host "Remote Desktop is disabled. Do you want to enable it? (Yes or No)"

        while ("yes", "no", "y", "n" -notcontains $response) {

            $response = read-host "Remote Desktop is disabled. Do you want to enable it? (Yes or No)"

        }

        if ("yes", "y" -contains $response) {

            write-host "enabling remote desktop"

        } elseif ("no", "n" -contains $response) {

            write-host "doing nothing"

        } 
        
    } elseif ($RDPEnabledValue -eq 0) {

        write-host "Remote Desktop is already enabled"

    }

}

