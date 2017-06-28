configuration FSLO365ContainerPolicy {
    param (
        ## UNC Container file path
        [Parameter(Mandatory)]
        [System.String] $VhdPath,
        
        ## Enable FSLogix O365 container functionality.
        [Parameter()]
        [System.Boolean] $Enabled = $true,

        ## Flip Profile Directory Name.
        [Parameter()]
        [System.Boolean] $FlipProfileDirectoryName,

        ## Roam Windows search index.
        [Parameter()]
        [System.Boolean] $RoamSearch,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    xRegistry 'FSLO365ContainerPolicyEnabled' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\FSLogix\ODFC';
        ValueName = 'Enabled';
        ValueType = 'DWord';
        ValueData = $Enabled -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLO365ContainerPolicyVHDLocations' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\FSLogix\ODFC';
        ValueName = 'VHDLocations';
        ValueType = 'String';
        ValueData = $VhdPath.Replace('\','\\');
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLO365ContainerPolicyFlipFlopProfileDirectoryName' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\FSLogix\ODFC';
        ValueName = 'FlipFlopProfileDirectoryName';
        ValueType = 'DWord';
        ValueData = $FlipProfileDirectoryName -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLO365ContainerPolicyRoamSearch' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\FSLogix\ODFC';
        ValueName = 'RoamSearch';
        ValueType = 'DWord';
        ValueData = $RoamSearch -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

}
