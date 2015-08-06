# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
   
   # Exit from the current, unelevated, process
   exit
   }
 
# Run your code that needs to be elevated here

# Activate NoLockScreen
New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -PropertyType "DWord" 

# Remove 3DBuilder
Get-AppxPackage -AllUsers -Name Microsoft.3DBuilder | Remove-AppxPackage

# Remove MicrosoftOfficeHub
Get-AppxPackage -AllUsers -Name Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

# Remove OneNote
Get-AppxPackage -AllUsers -Name Microsoft.Office.OneNote | Remove-AppxPackage

# Remove SkypeApp
Get-AppxPackage -AllUsers -Name Microsoft.SkypeApp | Remove-AppxPackage

# Remove WindowsMaps
Get-AppxPackage -AllUsers -Name Microsoft.WindowsMaps | Remove-AppxPackage

# Remove BingWeather
Get-AppxPackage -AllUsers -Name Microsoft.BingWeather | Remove-AppxPackage

# Remove XboxApp
Get-AppxPackage -AllUsers -Name Microsoft.XboxApp | Remove-AppxPackage

# Remove ZuneMusic
Get-AppxPackage -AllUsers -Name Microsoft.ZuneMusic | Remove-AppxPackage

# Remove ZuneVideo
Get-AppxPackage -AllUsers -Name Microsoft.ZuneVideo | Remove-AppxPackage

# Remove BingSports
Get-AppxPackage -AllUsers -Name Microsoft.BingSports | Remove-AppxPackage

# Remove BingNews
Get-AppxPackage -AllUsers -Name Microsoft.BingNews | Remove-AppxPackage

# Remove WindowsPhone
Get-AppxPackage -AllUsers -Name Microsoft.WindowsPhone | Remove-AppxPackage

# Remove BingFinance
Get-AppxPackage -AllUsers -Name Microsoft.BingFinance | Remove-AppxPackage

# Remove Photos
Get-AppxPackage -AllUsers -Name Microsoft.Windows.Photos | Remove-AppxPackage

# Remove WindowsCamera
Get-AppxPackage -AllUsers -Name Microsoft.WindowsCamera | Remove-AppxPackage

# Remove WindowsAlarms
Get-AppxPackage -AllUsers -Name Microsoft.WindowsAlarms | Remove-AppxPackage

# Remove WindowsSoundRecorder
Get-AppxPackage -AllUsers -Name Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Remove People
Get-AppxPackage -AllUsers -Name Microsoft.People | Remove-AppxPackage

# Disable Cortana
New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -PropertyType "DWord"

# Disable tracking
sc delete DiagTrack
sc delete dmwappushservice
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType "DWord" 
