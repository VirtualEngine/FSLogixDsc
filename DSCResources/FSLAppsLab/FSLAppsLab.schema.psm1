configuration FSLAppsLab {
    param (
        ## Path to FSLogix application installation executables.
        [Parameter(Mandatory)]
        [System.String] $Path,

        ## Container UNC file path
        [Parameter(Mandatory)]
        [System.String] $VhdPath,

        ## FSLogix product/license key.
        [Parameter(Mandatory)]
        [System.String] $ProductKey,

        ## Enable FSLogix O365 container functionality.
        [Parameter()]
        [System.Boolean] $Enabled = $true,

        ## Flip Profile Directory Name.
        [Parameter()]
        [System.Boolean] $FlipProfileDirectoryName = $true,

        ## Roam Windows search index.
        [Parameter()]
        [System.Boolean] $RoamSearch = $true,

        ## Profile container virtual disk type.
        [Parameter()]
        [ValidateSet('VHD','VHDX')]
        [System.String] $VolumeType = 'VHD',

        ## Profile container VHD/X is dynamic.
        [Parameter()]
        [System.Boolean] $IsDynamic = $true,

        ## Profile container included domain access users/groups
        [Parameter()]
        [System.String] $ProfileContainerIncludeMembers,

        ## O365/OneDrive included container domain users/groups
        [Parameter()]
        [System.String] $O365ContainerIncludeMembers,

        ## Profile container excluded domain users/groups
        [Parameter()]
        [System.String] $ProfileContainerExcludeMembers,

        ## O365/OneDrive container excluded domain users/groups
        [Parameter()]
        [System.String] $O365ContainerExcludeMembers,

        ## Remove the \Everyone entry from the group.
        [Parameter()]
        [System.Boolean] $RemoveEveryone,

        ## Credential used to enumerate Active Directory groups.
        [Parameter()]
        [System.Management.Automation.PSCredential] $Credential,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    ## Avoid recursive FSLogixDsc module loading!
    Import-DscResource -Name FSLApps, FSLO365ContainerPolicy, FSLProfileContainerPolicy, FSLLocalGroup;

    FSLApps 'FSLAppsLab' {

        Path       = Join-Path -Path $Path -ChildPath 'FSLogixAppsSetup.exe';
        ProductKey = $ProductKey;
        Ensure     = $Ensure;

    }

    FSLO365ContainerPolicy 'FSLAppsLab' {

        VhdPath                  = $VhdPath;
        Enabled                  = $Enabled;
        FlipProfileDirectoryName = $FlipProfileDirectoryName;
        RoamSearch               = $RoamSearch;
        Ensure                   = $Ensure;
        DependsOn                = '[FSLApps]FSLAppsLab';

    }
    
    FSLProfileContainerPolicy 'FSLAppsLab' {

        VhdPath                  = $VhdPath;
        Enabled                  = $Enabled;
        FlipProfileDirectoryName = $FlipProfileDirectoryName;
        VolumeType               = $VolumeType;
        IsDynamic                = $IsDynamic;
        Ensure                   = $Ensure;
        DependsOn                = '[FSLApps]FSLAppsLab';

    }

    if ($PSBoundParameters.ContainsKey('ProfileContainerIncludeMembers')) {

        FSLLocalGroup 'ProfileContainerIncludeMembers' {

            GroupName        = 'FSLogix Profile Include List';
            MembersToInclude = $ProfileContainerIncludeMembers;
            RemoveEveryone   = $RemoveEveryone;
            Credential       = $Credential;
            Ensure           = $Ensure;
            DependsOn        = '[FSLApps]FSLAppsLab';

        }
    }

    if ($PSBoundParameters.ContainsKey('O365ContainerIncludeMembers')) {

        FSLLocalGroup 'O365ContainerIncludeMembers' {

            GroupName        = 'FSLogix ODFC Include List';
            MembersToInclude = $O365ContainerIncludeMembers;
            RemoveEveryone   = $RemoveEveryone;
            Credential       = $Credential;
            Ensure           = $Ensure;
            DependsOn        = '[FSLApps]FSLAppsLab';

        }
    }

    if ($PSBoundParameters.ContainsKey('ProfileContainerExcludeMembers')) {

        FSLLocalGroup 'ProfileContainerExcludeMembers' {

            GroupName        = 'FSLogix Profile Exclude List';
            MembersToInclude = $ProfileContainerExcludeMembers;
            RemoveEveryone   = $RemoveEveryone;
            Credential       = $Credential;
            Ensure           = $Ensure;
            DependsOn        = '[FSLApps]FSLAppsLab';

        }
    }

    if ($PSBoundParameters.ContainsKey('O365ContainerExcludeMembers')) {

        FSLLocalGroup 'O365ContainerExcludeMembers' {

            GroupName        = 'FSLogix ODFC Exclude List';
            MembersToInclude = $O365ContainerExcludeMembers;
            RemoveEveryone   = $RemoveEveryone;
            Credential       = $Credential;
            Ensure           = $Ensure;
            DependsOn        = '[FSLApps]FSLAppsLab';

        }
    }

}
