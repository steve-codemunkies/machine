# Windows configuration

It's recommended to run this in four steps.  
PowerShell must be launched as administrator.

# 0. Set execution policy

Launch PowerShell as administrator and run the following command.

```
> Set-ExecutionPolicy Unrestricted
```

# 1. Disable UAC and Windows Updates

On Windows 11 a reboot is required to disable UAC, so start by doing this.

```
> ./Install.ps1 -DisableUac
```


# 2. Install prereqs

There are some things that require a restart to work correctly,
so start by installing this.

```
> ./Install.ps1 -Prereqs
```

After everything have been done, restart the computer.
If the script ask you if you want to restart the computer, 
do that, and run the script again after reboot.

# 3. Install applications and/or Ubuntu

```
> ./Install.ps1 -Apps -Ubuntu
```

# 4. Re-enable UAC and Windows Updates

Because it's a good thing.

```
> ./Install.ps1 -EnableUac
```
