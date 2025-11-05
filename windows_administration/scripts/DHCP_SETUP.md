## 🧰 Step-by-Step: Basic DHCP Setup via PowerShell

### 1. ✅ Install DHCP Role

```powershell
Install-WindowsFeature -Name DHCP -IncludeManagementTools
```

This installs the DHCP server role and its management tools.

---

### 2. 🔐 Add DHCP Security Groups

```powershell
netsh dhcp add securitygroups
```

This creates the necessary local groups for DHCP authorization.

---

### 3. 🧾 Authorize DHCP Server in Active Directory

If your server is part of a domain:

```powershell
Add-DhcpServerInDC -DnsName "YourServerName.YourDomain.com"
```

How to find DNS:

```
ipconfig /all
```

and look for DNS. Altenatively:

```
nslookup
```

```
Get-DnsClientServerAddress
```

Replace with your actual server and domain names.

---

### 4. 🧪 Create a DHCP Scope

```powershell
Add-DhcpServerv4Scope -Name "TestScope" -StartRange 192.168.1.100 -EndRange 192.168.1.200 -SubnetMask 255.255.255.0
```

This creates a scope named `TestScope` that assigns IPs from `.100` to `.200`.

---

### 5. ⚙️ Set Basic Options (e.g., Router/Gateway)

```powershell
Set-DhcpServerv4OptionValue -ScopeId 192.168.1.0 -Router 192.168.1.1
```

This sets the default gateway for clients.

---

### 6. 🔍 Verify DHCP Server Status

```powershell
Get-DhcpServerv4Scope
Get-DhcpServerInDC
```

These confirm your scope and authorization status.

---
