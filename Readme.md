# How To Manage OEM Program - Install and Uninstall Quietly



## INSTALL

This assumes that you are aware of building AutoCAD OEM from OEMMakeWizard and packaging a MSI through OEMInstallerWizard.

The tool `oeminstallerwizard.exe` available in the path `~\AutoCAD OEM 2023 - English\install\InstallWizard` generates few setup files like

```bash
3rdParty
buildlog.txt
Content
dlm.ini
manifest
ODIS
registry.txt
setup.exe
Setup.ini
setup.xml
SetupRes
x64
```

To install silently, the current `setup.exe` is not configured to silent install, so this is a workaround for now, use fake serial and prefix numbers.

```bash
setup.exe --silent --pf 123 --sn 12345678
```

To install to custom directory path, edit the setup.xnl and configure the path in `<DefaultInstallPath>%ProgramFiles%\FUN</DefaultInstallPath>`



### UnInstall

Run this script in powershell

```powershell
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { ($_.Publisher -match "FUN") -or ($_.Publisher -match "Autodesk") } | Select-Object -Property DisplayName, UninstallString | Format-Table -autosize | out-string -width 4096
```

Output:

```bash
DisplayName                                                  UninstallString
-----------                                                  ---------------
ADN Tool 2.0                                              C:\Program Files\Autodesk\AdODIS\V1\Installer.exe -i uninstall --trigger_point system -m C:\ProgramData\Autodesk\ODIS\metadata\{98D9FD88-540C-406B-B5BC-5546DE78F631}\bundleManifest.xml -x C:\ProgramData\Autodesk\ODIS\metadata\{98D9FD88-540C-406B-B5BC-5546DE78F631}\SetupRes\manifest.xsd
ADN Tool 2.0
Autodesk Interoperability Engine Manager                     MsiExec.exe /X{C4EFAB73-D98A-3676-A3F8-142FC78E0EF3}
Autodesk Inventor Interoperability 2023                      MsiExec.exe /X{E2B54F9E-FF26-47AE-9AE1-D7AFBC32DE0C}
Autodesk Material Library Base Resolution Image Library 2023 MsiExec.exe /X{3B564A94-BA47-4E42-ACD6-B5C35291210B}
Autodesk Material Library 2023                               MsiExec.exe /X{8E133591-B0FD-4DB0-B60E-FB593CAF72B0}


```

 Notes:

`$_.Publisher -match "FUN"`  `FUN` is the Company as defined in program xml and `ADN Tool` is the Product Name.

 For example OEM Program.xml

```xml
<?xml version="1.0"?>
<WizardData xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Version>1</Version>
  <Acbmp />
  <ProductName>ADN Tool</ProductName>
  <ProgramName>Rep</ProgramName>
  <CompanyName>FUN</CompanyName>
  <ReleaseNumber>2.0</ReleaseNumber>
  <RegistryNumber>27</RegistryNumber>
  <DrawingNumber>2018</DrawingNumber>
  <MainframeTitle>ADN Tool 2022 c</MainframeTitle>
  <BldDefault>32769</BldDefault>
  <BuildLocation>D:\oem\OEMMkBuilds\builds\</BuildLocation>
   <!--Removed the data between Tags for brevity-->
  <OemCmdArray/>
  <YourArxCmdArray/>
  <YourModArray/>
  <UserDefDestArray>
    <UserDefDestArrayVer>0</UserDefDestArrayVer>
  </UserDefDestArray>
  <SplashScrnAbtBoxArray>
    <SplashScrnAbtBoxVer>0</SplashScrnAbtBoxVer>
  </StatBarToolBarArray>
  <AoemFeatArray/>
  <FileExtArray>
    <FileExtArrayVer>0</FileExtArrayVer>
  </FileExtArray>
  <ChgIconArray/>
  <GuidArray/>
  <ManagedSnKey/>
</WizardData>
```

- Add the silent switch `-q` after `--trigger_point system` to make it silent:

- Use the Uninstall Strings to uninstall your products or create your custom script, refer UnInstall Silent Script.

#### UnInstall Silent Script

```batch
"%PROGRAMFILES%"\Autodesk\AdODIS\V1\Installer.exe -i uninstall --trigger_point -q system -m C:\ProgramData\Autodesk\ODIS\metadata\{98D9FD88-540C-406B-B5BC-5546DE78F631}\bundleManifest.xml -x C:\ProgramData\Autodesk\ODIS\metadata\{98D9FD88-540C-406B-B5BC-5546DE78F631}\SetupRes\manifest.xsd
MsiExec.exe /qn /X{C4EFAB73-D98A-3676-A3F8-142FC78E0EF3} /log %temp%\1.log
MsiExec.exe /qn /X{E2B54F9E-FF26-47AE-9AE1-D7AFBC32DE0C} /log %temp%\2.log
MsiExec.exe /qn /X{3B564A94-BA47-4E42-ACD6-B5C35291210B} /log %temp%\3.log
MsiExec.exe /qn /X{8E133591-B0FD-4DB0-B60E-FB593CAF72B0} /log %temp%\4.log

```

### License

This sample is licensed under the terms of the [MIT License](http://opensource.org/licenses/MIT). Please see the [LICENSE]([ReadDWG/LICENSE at master · MadhukarMoogala/ReadDWG · GitHub](https://github.com/MadhukarMoogala/ReadDWG/blob/master/LICENSE)) file for full details.

### Written by

Madhukar Moogala, [Forge Partner Development](http://forge.autodesk.com)  @galakar
