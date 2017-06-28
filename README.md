# FSLogixDsc

The FSLogixDsc module installs and configures FSLogix application and profile containers using the FSLApps, FSLJavaRuleEditor, FSLLocalGroup, FSLO365ContainerPolicy, FSLProfileContainerPolicy and FSLRuleEditor composite resources.

## Resources

* **FSLApps** installs the FSLogix container application.
* **FSLJavaRuleEditor** installs the FSLogix Java Rule Editor.
* **FSLLocalGroup** manages the local FSLogix application group(s).
* **FSLO365ContainerPolicy** configures FSLogix O365/OneDrive container policy registry settings.
* **FSLProfileContainerPolicy** configures FSLogix Profile container registry settings.
* **FSLRuleEditor** installs the FSLogix Rule Editor.
* **FSLAppsLab** deploys the FSLogix container application, groups and policies on a single lab host.
* **FSLEditorsLab** deploys the FSLogix rule and Java rule editor applications on a single lab host.

## Requirements

There are __dependencies__ on the following DSC resources:

* xPSDesiredStateConfiguration - https://github.com/Powershell/xPSDesiredStateConfiguration
