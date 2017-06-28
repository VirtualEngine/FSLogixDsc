configuration FSLRuleEditor {
    param (
        ## Path to FSLogix application installation executable.
        [Parameter(Mandatory)]
        [System.String] $Path,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    xPackage 'FSLRuleEditor' {
        Name      = 'FSLogix Apps RuleEditor';
        ProductId = '';
        Path      = $Path;
        Arguments = '/quiet /norestart';
        Ensure    = $Ensure;
    }

}
