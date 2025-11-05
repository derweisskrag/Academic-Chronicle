<div align="center">

# Labs Defense - Video
## Windows 11 Pro Administration Guide

<div>

| **Name**      | Sergei Ivanov          |
|---------------|------------------------|
| **Major**     | IT Systems Development |
| **Instructor**| Pavel Kodotsigov       |
| **University** | University of Tartu |
<div align="center">

<img src="https://github.com/derweisskrag/Academic-Chronicle/blob/main/windows_administration/windows_11_pro/windows_11_vm_logo.png?raw=true" alt="Windows 11 VM Logo" width="120"/>

</div>

</div>

**A comprehensive overview of Labs and their implementation.**

28.09.2025
</div>


## Table of Content


## Lab 1


### Starting steps

In order to get the first lab done, we have to install VMs and start them. This is very important because 
otherwise we cannot start working on lab 1 or lab 3. Please, read [here](../README.md). However, when recording
my video, I would have to explain my steps, so let us list them once again:

1. Install EduVPN (Check Downloads section in my main README.md).
2. Install OracleVM (check the same section!)
3. Through the VPN you connect to your university network.
4. Once connected, if university shares some files, you can connect and access them (please follow your university guide).
5. After, you can copy 2 ISO files (Windows 11 Pro, Windows Server 2022 Standard) and move them to your computer desktop (create folder).
6. Open up OracleVM and click to create new VM: choose your OS and boot up from ISO file. However, you may need to go to the BIOS and use the correct boot-up option. 
7. Windows handles everything for you. Please wait until installation is finished.
8. Similar to Windows 11, you can install Windows Server; however, be warned that it lacks UI - it uses PowerShell and Console-Line Interface, which means you do everything
with PowerShell unless you connect to UI/UX. I used PowerShell because it was simpler.

After all 1-8 steps done, you can see the two VMs installed. According to Lab 1, we must name them with out student ID. How do you get StudentID? Well, you 
have to login to your university website (that handles curriculum and your documents). Once logged in, you must navigate to your account profile or management. It is the place
where users manage their account. In my case, it was called "profile". 

To edit the name, you click on your VM and then choose "Settings". Then edit the name of VM in the corresponding field (name). It is the "General" tab and "VM Name" field. Please, 
enter your student ID and proceed. 

> NB! You cannot change name in one place. You have to change the name of VM details too using the appropriate command. Please, navigate to Name Setting

Once done, we have to proceed with other instructions. Even though it was the very first thing to do, we do it now: how do you PING your Windows Server VM from your Windows 11 Pro VM?
You can check 

```ps1
Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.IPAddress -notlike "169.*"} | Format-Table IPAddress, InterfaceAlias
```

Or

```bat
ipconfig
```

You will get IP addresses and you can try to Ping them:

> Windows 11 Pro Client performs the PING to Windows Server 2022 Standard.

You see that it either pings fast (pings itself) or the ping results into all 4 packets loss (100% loss). The second situation means that
it cannot find it - located in subnetworks. Hence, you use `Setting` of the VM and navigate to the `Network`:

![Network Configuration of the Windows 11 Pro VM](network_configuration.png)

The image show you what it must look like. NAT prevented your ping. Once both VMs set to "Bridged Adapter", they can find
each other in your network and ping each other. I will show the ping in my video.

![Pinging the Server](ping_the_server.png)

However, the ping can fail due to firewall. So, I will add steps on how to fix that. For example, when I just pinged the client from the server, I got request timed out error.
It means that my client firewall blocked the request. How do you fix it? You create a new FireWall Rule for that:

```ps1
New-NetFirewallRule -DisplayName "Allow Ping from Win11" -Direction Inbound -Protocol ICMPv4 -RemoteAddress 192.168.1.50 -Action Allow
```

If `192.168.1.50` is the IPv4 of the Windows Server 11 Pro. Please, check your IPv4 using the `ipconfig` command or the PowerShell command above (Get-NetIPAddress) - you ignore full command and just run it to get full details. Then:

```ps1
New-NetFirewallRule -DisplayName "Allow Ping from Win11" -Direction Inbound -Protocol ICMPv4 -RemoteAddress 192.168.1.49 -Action Allow
```

where `192.168.1.49` is the IP Adress of Server (Check yours: run the PowerShell command and find the command). You can also use my screenshot above to get those IPs. Now you can ping them.

![Server Pings the Client](server_pings_client.png)

This ends the Introduction - the very basic stuff. However, I can show to your the shared folder:

![Connect to your shared folder](login_to_shared_folder.png)

Please, enter your credentials for you Windows Server (not client credentials):

![Access the shared Folder](accessing_shared_folder.png)

This basically ends the introduction. We can access the shared folder; we can ping the server.

### Computer Name, Language

The Lab 1 wants us to modify languages of both VMs to include Estonian and possibly use the Estonian as main language. Let us proceed with Windows 11 Pro. To do so, we can click on `Windows Logo` and then navigate to corresponding settings:

![Changing language of Windows 11 to Estonian](change_lang_win_11.png)

Please, await the download and the instruction. Meanwhile I tried to pinged my server from Host OS and it worked, but client was not pinged probably due to Firewall configuration.

After I downloaded Estonian - I will create new user on my windows 11 pro vm and try to connect to my `Hello` folder. Notice that I can also access my folder from my MSI and Host OS too. That is, as long as my Firewall and SMB are configured correctly, I can share the resource (such as text files.)

### Firewall

```ps1
Set-NetFirewallRule -DisplayGroup "File and Printer Sharing" -Enabled True -Profile Public
```

### Sharing the folder

I navigate to the root using 

```ps1
cd ../
```

command and then I execute:

```ps1
New-Item -Path C:\<StudentName><StudentID> -ItemType Directory
```

I am using my name and my student ID for the folder creation. Once created, I must server it via SMB:

![Folder Creation](creating_folder.png)

To create a new file, you can re-use the previous command and introduce the file and type:

```
New-Item -Path C:\<StudentName><StudentID>\data.txt -ItemType File
```

This will create the file. Let us modify it with notepad:

```
# As long as you are inside your folder:
notepad data.txt
```

This opens the file for you to work:

![Editing the file](editing_file.png)

To save changes, you usually use `CTRL + S` shortcut (keyboard!). Close the file and read the content of it:

```ps1
Get-Content data.txt # assuming we are in the same directory!
```

![Reading the file](reading_data_txt.png)

What is the next step? Let us try to share it. First of all, we must understand who we are. We are the Admnistrator. To access the folder, we entered the credentials for it, not the client credentials (because client did not share anything, instead it accessed). As such, we can create new user on server and configure it and set permissions. The command for basic is this

```powershell
New-SmbShare -Name "<StudentName><StudentID>" -Path "C:\<StudentName><StudentID>" -FullAccess "Everyone"
```

Run this command (for experimental purpose):

![Data.txt is shared](sharing_data_txt.png)

However, as you can see, we got full rights. We can do whatever we want:

![Creating new file and reading it on server](permission_check.png)

To mitigate this, we have to restrict permissions.

#### Creating new user on server

We can create a new user:

> You use your own name and password must be "StrongPassword123!" length

```ps1
New-LocalUser -Name "Sergei" -Password(ConvertTo-SecureString "StrongPassword123!" -AsPlainText -Force) -FullName "Sergei Ivanov" -Description "To access Sergei folder"
```

![Create new user](create_new_user.png)

Then we can restart the server and check if our user is added:

```ps1
SConfig
```

then

```ps1
13 # to restart
```

![Restart server](Restart.png)

#### Verifying the user

```ps1
Get-LocalUser | Format-Table Name, Enabled, Description
```

```ps1
Get-LocalGroupMember -Group "Users"
```

#### Check SMB shares

```ps1
Get-SmbShare | Format-Table Name, Path, Description, ShareState
```

```ps1
Revoke-SmbShareAccess -Name "Sergei136638" -AccountName "Everyone"
```

```ps1
Grant-SmbShareAccess -Name "Sergei136638" -AccountName "Sergei" -AccessRight Read -Force
```

![Revoke && Modify](Modify_smb_rule.png)

Now you enforce NTFS permissions:

```ps1
$acl = Get-Acl "C:\Sergei136638"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "Read", "Allow")
$acl.SetAccessRule($rule)
Set-Acl "C:\Sergei136638" $acl
```

![Setting NTFS](setting_ntfs.png)

#### Re-try accessing folder

Before attempting to access, I restarted my server. You may want to restart the client too to close all connections to server.

```bat
net use Z: \\192.168.1.49\Sergei136638 /user:Serger StrongPassword123! 
```

![Sergei folder](mouting_sergei_folder.png)

Try creating new file:

![Attempt to create new file](not_enough_rights_to_create_file.png)

This means that now the folder is secured.

#### If Sergei needs to Read & Admin access

Add permissions to Sergei:

```ps1
# Get the ACL for the folder
$path = "C:\Sergei136638"
$acl = Get-Acl $path

# 1. Keep Everyone:Read (as you already have)
# 2. Add Sergei:Modify (not FullControl unless needed)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Sergei", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)

# Apply updated ACL
Set-Acl $path $acl
```

Add permissions to System & Admin:

```ps1
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator","FullControl","ContainerInherit,ObjectInherit","None","Allow")))
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","FullControl","ContainerInherit,ObjectInherit","None","Allow")))
Set-Acl $path $acl
```

and then 

```ps1
Grant-SmbShareAccess -Name "Sergei136638" -AccountName "Sergei" -AccessRight Full -Force
```

#### Create John:

```ps1
New-LocalUser -Name "John" -Password (ConvertTo-SecureString "X9!vQz@2025Secure"
 -AsPlainText -Force) `
    -FullName "John Doe" -Description "Read-only user for SMB testing" -AccountNeverExpires

# Add him to standard Users group (not admin)
Add-LocalGroupMember -Group "Users" -Member "John"
```

```ps1
$path = "C:\Sergei136638"
$acl = Get-Acl $path

# Remove Everyone if present
$acl.Access | Where-Object { $_.IdentityReference -eq "Everyone" } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add Sergei full control (if missing)
$sergeiRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Sergei", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.AddAccessRule($sergeiRule)

# Add John read-only
$johnRule = New-Object System.Security.AccessControl.FileSystemAccessRule("John", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.AddAccessRule($johnRule)

# Apply the new ACL
Set-Acl -Path $path -AclObject $acl
```

## Lab 3


## How do you edit VM's name?

I avoided these commands because I focused on the practical implementation of lab (ship it first, then improve it - STRATEGY)


```
VBoxManage list vms
```

```
VBoxManage modifyvm "Old_VM_Name" --name "New_VM_Name"
```
