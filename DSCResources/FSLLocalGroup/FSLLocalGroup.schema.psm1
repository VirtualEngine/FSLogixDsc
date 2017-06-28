configuration FSLLocalGroup {
    param (
        [Parameter(Mandatory)]
        [System.String] $GroupName,

        ## Enable FSLogix Profile container functionality.
        [Parameter(Mandatory)]
        [System.String[]] $MembersToInclude,

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

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    if ($RemoveEveryone) {

        Script "FSLGroup$($Name)Everyone" {
    
            GetScript = { 
            
                $adsiPath = 'WinNT://{0}/{1},group' -f [System.Environment]::MachineName, $using:GroupName;
                Write-Verbose -Message ("Querying ADSI path '{0}'." -f $adsiPath);
                $adsiGroup = [ADSI]($adsiPath);
                $hasEveryone = $adsiGroup.PSBase.Invoke('Members') | Foreach-Object { $groupName = $_.GetType().InvokeMember('Name', 'GetProperty', $null, $_, $null); if ($groupName -eq 'Everyone') { $true } };
                return @{ Result = $hasEveryone.ToString(); }

            }
            TestScript = {
            
                $adsiPath = 'WinNT://{0}/{1},group' -f [System.Environment]::MachineName, $using:GroupName;
                Write-Verbose -Message ("Querying ADSI path '{0}'." -f $adsiPath);
                $adsiGroup = [ADSI]($adsiPath);
                $hasEveryone = $adsiGroup.PSBase.Invoke('Members') | Foreach-Object { $groupName = $_.GetType().InvokeMember('Name', 'GetProperty', $null, $_, $null); if ($groupName -eq 'Everyone') { $true } };
                return (-not $hasEveryone);
            
            }
            SetScript = {

                $adsiPath = 'WinNT://{0}/{1},group' -f [System.Environment]::MachineName, $using:GroupName;
                Write-Verbose -Message ("Opening ADSI path '{0}'." -f $adsiPath);
                $adsiGroup = [ADSI]($adsiPath);
                Write-Verbose -Message ("Removing 'WinNT://NT AUTHORITY/Everyone'.");
                $adsiGroup.Remove('WinNT://NT AUTHORITY/Everyone');
            }
        }
    
    }

    if (($PSBoundParameters.ContainsKey('Credential')) -and
        ($PSBoundParameters.ContainsKey('Description'))) {

        xGroup "FSLGroup$GroupName" {
            GroupName        = $GroupName;
            MembersToInclude = $MembersToInclude;
            Credential       = $Credential;
            Ensure           = $Ensure;
            Description      = $Description;
        }

    }
    elseif ($PSBoundParameters.ContainsKey('Credential')) {

        xGroup "FSLGroup$GroupName" {
            GroupName        = $GroupName;
            MembersToInclude = $MembersToInclude;
            Credential       = $Credential;
            Ensure           = $Ensure;
        }

    }
    elseif ($PSBoundParameters.ContainsKey('Description')) {

        xGroup "FSLGroup$GroupName" {
            GroupName        = $GroupName;
            MembersToInclude = $MembersToInclude;
            Ensure           = $Ensure;
            Description      = $Description;
        }
    }
    else {

        xGroup "FSLGroup$GroupName" {
            GroupName        = $GroupName;
            MembersToInclude = $MembersToInclude;
            Ensure           = $Ensure;
        }

    }

}
