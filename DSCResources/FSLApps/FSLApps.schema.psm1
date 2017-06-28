configuration FSLApps {
    param (
        ## Path to FSLogix application installation executable.
        [Parameter(Mandatory)]
        [System.String] $Path,

        ## FSLogix product/license key.
        [Parameter(Mandatory)]
        [System.String] $ProductKey,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    xPackage 'FSLogixApps' {
        Name      = 'FSLogix Apps';
        ProductId = '';
        Path      = $Path;
        Arguments = 'ProductKey={0} /quiet /norestart' -f $ProductKey;
        Ensure    = $Ensure;
    }

}
