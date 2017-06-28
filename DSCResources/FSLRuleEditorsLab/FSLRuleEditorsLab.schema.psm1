configuration FSLRuleEditorsLab {
    param (
        ## Path to FSLogix application installation executables.
        [Parameter(Mandatory)]
        [System.String] $Path,

        [Parameter()]
        [ValidateSet('Absent','Present')]
        [System.String] $Ensure = 'Present'
    )

    ## Avoid recursive FSLogixDsc module loading!
    Import-DscResource -Name FSLJavaRuleEditor, FSLRuleEditor;

    FSLJavaRuleEditor 'FSLRuleEditorsLab' {

        Path       = Join-Path -Path $Path -ChildPath 'FSLogixAppsJavaRuleEditorSetup.exe';
        Ensure     = $Ensure;

    }

    FSLRuleEditor 'FSLRuleEditorsLab' {

        Path       = Join-Path -Path $Path -ChildPath 'FSLogixAppsRuleEditorSetup.exe';
        Ensure     = $Ensure;

    }

}
