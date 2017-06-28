configuration FSLJavaRuleEditor {
    param (
        ## Path to FSLogix application installation executable.
        [Parameter(Mandatory)]
        [System.String] $Path,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration;

    xPackage 'FSLJavaRuleEditor' {
        Name      = 'FSLogix Apps Java RuleEditor';
        ProductId = '';
        Path      = $Path;
        Arguments = '/quiet /norestart';
        Ensure    = $Ensure;
    }

}
