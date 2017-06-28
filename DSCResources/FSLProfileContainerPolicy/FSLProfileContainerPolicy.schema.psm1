configuration FSLProfileContainerPolicy {
    param (
        ## UNC Container file path
        [Parameter(Mandatory)]
        [System.String] $VhdPath,
        
        ## Enable FSLogix Profile container functionality.
        [Parameter()]
        [System.Boolean] $Enabled = $true,

        ## Flip Profile Directory Name.
        [Parameter()]
        [System.Boolean] $FlipProfileDirectoryName,

        ## Profile container virtual disk type.
        [Parameter()]
        [ValidateSet('VHD','VHDX')]
        [System.String] $VolumeType = 'VHD',

        ## Profile container VHD/X is dynamic.
        [Parameter()]
        [System.Boolean] $IsDynamic = $true,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    xRegistry 'FSLProfileContainerPolicyEnabled' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles';
        ValueName = 'Enabled';
        ValueType = 'DWord';
        ValueData = $Enabled -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLProfileContainerPolicyVHDLocations' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles';
        ValueName = 'VHDLocations';
        ValueType = 'MultiString';
        ValueData = $VhdPath;
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLProfileContainerPolicyFlipFlopProfileDirectoryName' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles';
        ValueName = 'FlipFlopProfileDirectoryName';
        ValueType = 'DWord';
        ValueData = $FlipProfileDirectoryName -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLProfileContainerPolicyVolumeType' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles';
        ValueName = 'IsDynamic';
        ValueType = 'DWord';
        ValueData = $IsDynamic -as [System.Int32];
        Force     = $true;
        Ensure    = $Ensure;
    }

    xRegistry 'FSLProfileContainerPolicyIsDynamic' {
        Key       = 'HKEY_LOCAL_MACHINE\SOFTWARE\FSLogix\Profiles';
        ValueName = 'VolumeType';
        ValueType = 'String';
        ValueData = $VolumeType;
        Force     = $true;
        Ensure    = $Ensure;
    }

}
