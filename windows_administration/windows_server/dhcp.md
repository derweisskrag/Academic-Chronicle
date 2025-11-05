---
# 1. Define your metadata (This is necessary!)
# title: "A Comprehensive Overview of 'I Love You' Malware"
# author: "Sergei Ivanov"

# 2. Tell Pandoc to generate a Table of Contents
toc: false

# 3. Tell Pandoc to use a title page
title-page: false 
---


\begin{titlepage}
    \centering % Center everything on the page

    % --- Title Section ---
    \vspace*{3cm} % Push content down
    \Huge\textbf{Dynamic Host Configuration Protocol}\par % Main Title
    \vspace{1cm}
    \Large Comprehensive overview of DHCP - Windows Administration 2025\par % Subtitle

    \vspace{3cm} % Space between title and author info

    % --- Author/Affiliation Section ---
    \large\textbf{Sergei Ivanov}\par % Author Name
    \vspace{0.3cm}
    \textit{IT Systems Development, University of Tartu}\par % Affiliation
    
    \vspace{2cm} % Space between author and instructor info
    
    % --- Instructor/Date Section ---
    \large\par
    \textbf{Instructor: Pavel Kodotšigov}\par % Instructor Name
    \vspace{0.3cm}
    \today\par % Date
    
    % You can also use the variable from YAML if you prefer the static date:
    % \large 15.10.2025\par 
    
    % --- Bottom of Page Space ---
    \vfill % Push remaining content to the bottom (optional)

\end{titlepage}

\tableofcontents
\clearpage

## Overview

DHCP is a technology used along side with DNS by routers or servers. The easiest example that one can find is 
their router:

1. Make sure that your router is functional, plugged-in, works (check using phone: if Wi-Fi works?)
2. Open up browser on your device (PC)
3. Go to 192.168.1.1
4. You will see the login page. If you do not know credentials: manufactures specifies them in the package where router was; or your `Internet Provider` leaves a manual where they specify the credentials. 
5. Once you log in, please do not do anything (Without knowledge, it is highly recommended to refrain from making changes). Navigate to Configuration Tab and find DHCP. You may see the `Network` tab and then you will see `DHCP`. Go to DHCP and you will see details about it, configuration and users list (devices in the Wi-Fi network: your devices or someone's else if they logged in to your Wi-Fi).

This demonstrates that most users have DHCP pre-installed on their routers device in 2025. 

\clearpage

## Purpose

In the tab, you could see the IP and device name. It is very important. When you connect to the Wi-Fi, your device gets the IP address within the network (local). Having connected to the local network managed by your router, they communicate between each other. For example, if you run `ipconfig` on your Windows Machine (using `CMD`; open up search button and type `cmd` and then click `ok` - it will open up the command-line interface where you run commands like `echo Hello, world!`), you will see your Ethernet adapters, including the one named `Wireless`. On my machine, I had three adapters: Ethernet 1, Ethernet 2 and Wireless. One may ask as to why we need three adapters. 

First of all, the machine can have physical hardware that already uses those adapters; and then network does the rest, which means computer uses adapter to connect to the Internet. In my video, I showed that `Deno task dev` (NextJS application: please, refer to `https://www.nextjs.org`) runs the web server on your machine and in the terminal, you would see two addressed:

1. localhost:3000
2. 192.168.x.x:3000 

The first one is expected; it is trivial way to check your web-page in the browser in the local environment. For production environment, developers usually deploy their NextJS web application to Vercel, which is a platform specifically designed for NextJS in production-like environment. As an alternative to deployment to Vercel, developers can fall back on AWS; yet, it may be expensive solution because AWS can charge the client for web-application hosting even in the case when they accessed free-tier resources (so be warned!). The other IP is more interesting. You can open it up on your phone and you will see your web application running. What is actually happening? What happens is that NextJS re-uses your IP address to host the web application across your home network. In my video, I talked about this. We even tried `curl 192.168.x.x:3000` and it worked as long as firewall was configured to allow.

On AWS, you will have to configure the firewall. You are the one who configures how to treat incoming traffic to your web-server deployed on AWS in the Docker container. IP address assigned to your app will not be `192.168.x.x` in AWS; instead, it will be complex like `DNS Name: app-lb-1234567890.us-west-2.elb.amazonaws.com` (Amazon Elastic Container Service (ECS) with Fargate, fronted by an Application Load Balancer (ALB)). It is quite different from what you already saw. You can use DNS to get the IP address of that long string (domain). However, it is not important: the IP address in your private network is `192.168.x.x` but in AWS, it will be much different. As long as you configure AWS environment correctly, users will be able to access your web application remotely, so would Google's DNS. 

In the showed examples (My video: https://youtu.be/3LGpeg9f7EM), we used the Wireless adapter too and we could ping the Windows 11 Pro VM and the Windows Server VM (if and only if the firewall is correctly configured; and if your network adapter is not NAT, but, for example: bridged adapter, because NAT would isolate them and your VMs would not ping each other! To use NAT, you would have to configure DNS, DHCP and AD DS).

So, returning back to our topic, the IP address that you saw is used by DNS and then by DHCP. How does it work? We already saw that DNS uses `Mafia bosses`, it knows how to find the IP address of a web application (in domain): `example.abrdns.com` is the domain and the IP address was my IP address of my router (not `192.168.x.x`!). Please, do NOT reveal your own router's address (public one), and keep it private for security purposes! That was DNS work. When deploying our application (e.g., ExpressJS web server) using NGINX server (or Apache), we used our host machine IP address (Linux course). To do so, we modified the `host` file (which can be found by `File Explorer` if you know the location) and included the `example.com` and its IP Address; and then we could open up the website in our browser. In my video, I used slightly more complex approach: my router configuration and port forwarding. I had to obtain my domain name (usually by buying, but I used the free one in `CloudDNS`). One can imagine that instead of 

```
curl 192.168.x.x:8100
```

they could `curl example.local:8100`; or if they had to use DNS specifically: `nslookup example.local dns.local`. This is the DNS work in action. However, DHCP table in router page contained your list of devices connected to your Wi-Fi and their IPs. DHCP could allocate IPs to your devices once they connect and through configuration, you can preserver the static IP address for some of your devices (which DHCP keeps track of). That is the major difference. DHCP allocates IP address to my network, while DNS resolves the domain name and returns the IP so client can navigate to the given resource (server); AD DS is the abbreviature for `Active Directory Domain Services`.

In order to complete this manual, it was sufficient to explain the homer router DHCP, explain everything in detail and that will close the question.

\clearpage

## Sources of Information

1. Microsoft. (2025). How multiple adapters on the same network are expected to behave. Retrieved October 15, 2025, from  https://support.microsoft.com/en-us/topic/how-multiple-adapters-on-the-same-network-are-expected-to-behave-e21cb201-2ae1-462a-1f47-1f2307a4d47a.

2. Wikipedia. (2025). Dynamic Host Configuration Protocol. Retrieved October 15, 2025, from https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol.
