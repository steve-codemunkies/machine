##########################################################################
# Running in Windows Sandbox?
##########################################################################

if ($env:UserName -eq "WDAGUtilityAccount") {
    Write-Host "Sorry, can't install Ubuntu in a Windows Sandbox.";
    Return;
}

##########################################################################
# Install Ubuntu
##########################################################################

# Make sure WSL 2 is the default architecture
wsl --set-default-version 2

# Install Ubuntu
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile ~/Downloads/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Downloads/Ubuntu.appx
RefreshEnv

# Update Ubuntu
Ubuntu2004 install --root
Ubuntu2004 run apt-get update -y
Ubuntu2004 run apt-get upgrade -y
