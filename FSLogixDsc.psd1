@{
    ModuleVersion = '1.0.1';
    RootModule = 'FSLogixDsc.psm1';
    GUID = '95ec2ae9-1117-4463-9240-e8a78f5b4363';
    Author = 'Iain Brighton';
    CompanyName = 'Virtual Engine';
    Copyright = '(c) 2017 Virtual Engine Limited. All rights reserved.';
    Description = 'FSLogix Containers DSC Composite Resources.';
    PowerShellVersion = '4.0';
    CLRVersion = '4.0';
    RequiredModules = @('xPSDesiredStateConfiguration');
    PrivateData = @{
        PSData = @{  # Private data to pass to the module specified in RootModule/ModuleToProcess
            Tags = @('VirtualEngine','FSLogix','Profile','Container','Composite','DSC');
            LicenseUri = 'https://github.com/VirtualEngine/FSLogixDsc/blob/master/LICENSE';
            ProjectUri = 'https://github.com/VirtualEngine/FSLogixDsc';
            IconUri = 'https://raw.githubusercontent.com/VirtualEngine/FSLogixDsc/master/FSLogixLogo.jpg';
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
