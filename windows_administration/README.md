# Windows Administration course in University of Tartu 2025


## Table of Content

- [Overview](#overview)
- [Helpful Articles](#helpful-articles)
   - [Client Server](#client-server)
   - [Network Issues](#network-issues)
- [Manuals: Tracert & DHCP](#manuals)
- [Labs](#labs)
- [Sources of Information](#sources-of-information)

## Overview

The course (see Linux one too) focuses on Windows. The most important remark is 
the course does not allow us to use Windows 10 or Windows 11 on bought device. That is,
if you bought a laptop at $1000 (≈1000 EUR), you cannot fulfill the goal of course, while
using the host OS (Windows 10 or Window 11 of the bought device).

### Objective

What do you need to do that makes it possible for you to pass the course? How to get EAP and
crush the course? It turns out that you must install `Virtual Box`. In my case, I used 
`Oracle Virtual Box`. 

#### Problem you might face

In order to install the `Windows 11 Pro` and `Windows Server 2022 Standard`, which courses uses as lab
environments for you to do the tasks; you must find *ISO files* and install those from those ISOs. Obviously,
the problem lies behind the word ***How to***. 

#### Solution to your problem

So, one might question oneself of how to solve that problem that we just discussed. In 2025, the solution is somewhat 
simplified. To put simply, one must install `EduVPN` software and then maintain the connection to their university; 
once connected, they can copy ISO files from the `network` to their computer or laptop, where they store their personal files.
The finilizing action is to pass those ISOs to the Virtual Box and instantiate the OS. After, the studen is expected to set up their tools
and fulfill labs.

If a student fails to use the remote approach to the problem, then the only solution is the on-site one. They must attend the college class,
bring their USB storage and copy 2 ISO files from college machine (PC) to their USB. It leverages **READ ONLY + COPY** permissions set by the college.
In other words, the student *CANNOT* delete ISOs from the college server. However, I would advise against trying to do so, since the student is only obliged
to copy ISOs from college PC to their host OS and then instantiate the two OSs inside VM environment.

If you installed `Windows 11 Pro` and see your OS working, you can enjoy your successful execution of the most important task of the entire course. 
It is setting up your OSs in your `Virtual Box` environments. The `Windows Server 2022 Standard` OS is different from Windows 10 by the fact that 
you may not have all the features. For example: MSYS2 tool is only for *Windows 10/11*, but the `Windows Server` lacks such software. It means that 
in order to install Rust and use `GNU C++ Compiler`, you must install those from zipped distribution. That is, the student must understand that OS difference 
persists and you must set your environment accordingly. 

> IMPORTANT: One box per OS. It means that you create two boxes where you install 1 OS. You have to name them accordingly. 

### Two written tasks

In order to complete the course, a student must not only overcome the initial struggles of setting up the necessary environment, but they also must write 2 manuals:

- 1 for Windows 11 Pro, running inside the `Virtual Box` environment (you cannot show external, someone's else screenshots, you must perform all tasks using your VM!)
- 1 for Windows Server 2022 Standard

The reason why they cannot use external screenshots is plagiasm. If they are forced to use one screenshot, then they must site it accordingly. However, the course uses 
specific tasks that do not require external sources of information beyond trivial Wikipedia pages or YouTube videos (which they can only site in case those fulfill Academic purpose). In no way can any student refer to a TikTok video; it is prohibited. 

Students may also read other students works (of their group) and review. For completed review, they get extra points. It is not mandatory.

#### What topics did I choose?

In this section, I briefly mention what topics I chose for my written manuals:

1. Tracert. This is a simple yet complex topic. You can use WireShark as extra tool to debug `Network issues` (See Network Issue). I chose it for *Windows 11 Pro VM*;
2. DHCP. This is for *Windows Server 2022 Standard*. I will research the `Dora` and `DHCProto` crates (libraries) in **Rust** and try to showcase them inside my `Windows Server VM`.


### Labs or practical tasks

To pass the course, a student must meet the condition:

> Minimum 2 labs performed to 100%. Total labs number is 4. 

I will briefly explain the labs involved in the course (2025):

- Lab 1 is about CRUD and SMB protocol. We must share one folder on server and handle users. You must configure everything, firewall, SMB, permissions, etc.
- Lab 2 is about AD SD (Active Directory Service Domain). It is more complex than the previous in that you must handle group, not just a user. An organization. 
- Lab 3 is about IIS and server. You must configure a server and use ***Host Machine IP*** to see your website (hosted by IIS and tools used: PHP + HTML + CSS + JS). I asked the teacher about using Rust, so I will leverage Deno and Rust potentiall for such role.
- Lab 4 is about DHCP. You can also notice how it goes on top of the previous one (similar to lab 1 - 2). 

Notice that lab 1, 2 are for *Windows 11 Pro VM* and labs 3, 4 - *Windows Server VM*. 

For the course, I chose the lab 1, lab 3 as they are the easiest to do first and if I have time, I will research the rest. I have already explored Rust libraries to try those tasks.


### Conclusion

To complete the course, a student must write 2 manuals; of them, one is designed for `Windows 11 Pro VM` and the other one for `Windows Server VM`. They can also review their co-students work and get extra points for that. In addition to these two manuals, the student must finish and defend at least 2 labs of 4. 

## Helpful articles

In this section, I will cite my extra articles that provide explanation to the topic:

- Client Server: Explains how it works.
- Network Issues: Explains what issues I faced when I tried Deno Client to Rust gRCP + TLS 1.3 server (why Python, Rust clients worked, but Rust client? Not quite).

They are not mandatory. They just add value to my overall understanding of the course.

### [Client Server](../../docs/client-server/README.md)

- [ ] **TODO**: Overview of the Client Server

### [Network Issues](../../docs/network-issues/README.md)

- [ ] **TODO**: Overview of the Network Issues

### Navigation

You can find my documentation material in the [Docs](../../docs/README.md). From there, you can navigate to those articles:

- Client & Server: [Client Server Article](../../docs/client-server/README.md)
- Network Issues: [Network Issues Article](../../docs/network-issues/README.md)


## Manuals 

This sections contains my manuals for the course.

### Task & Questions

During my manuals, I must show how it works and answer the following questions:

- [ ] What is it?
- [ ] How to use it?
- [ ] Where to use it?
- [ ] Why was it invented?

Below you find overviews of the both topics, and then you find links. You can also click at the heading if you
want to go to the full article of the corresponding topic.

### [Tracert](windows_11_pro/tracert.md)

- [ ] **TODO**: Write overview!

### [DHCP](windows_server/dhcp.md)

- [ ] **TODO**: Write Overview!

### Where you can find those manuals?

You achieve this by a few ways:

1. Click on the heading. It will lead you to the full article.
2. Navigate to them here.


Navigation:

- Tracert: [Tracert Full Article](windows_11_pro/tracert.md)
- DHCP: [DHCP Full Article](windows_server/dhcp.md)

For tracking my Issues: [Issues](https://github.com/derweisskrag/automatic-computing-machine/issues/2)


## Labs

Since I chose Lab 1 and 3 to do for the course, I will feature them only for now.

### TODO LIST

- [ ] **Lab 1**: CRUD
- [ ] **Lab 3**: IIS + Axum Rust 


### Lab 1

Coming soon...

### Lab 3

Coming soon...

### Navigation

As before, this section serves the purpose of navigation, so reader can find my material. Please, refer to the Labs directory, which you can find [here](labs/README.md).

- Lab 1: [Lab 1 Documentation](labs/lab_1.md)
- Lab 3: [Lab 3 Documentation](labs/lab_3.md)


## Downloads

If you feel insecure about clicking (because security is always priority 1!!!), you can use Google or Bing search to navigate to these and download the software.

> Little comment: https means that they use certain certificate which requires your PC datetime to be aligned with the website server time. I had my laptop time
of June and it couldnt update its datetime to "today" without me actually triggering the update, and hence I could not visit the YouTube. It may be pointless information
for you, but it was fun to learn! No, it does not mean that certificate only uses datetime; no! It means that valid datetime is one of requirements (or else handshake between client and server fails). 

1. You can download EduVPN here (official): https://www.eduvpn.org/client-apps/
2. To download Oracle VM go here: https://www.virtualbox.org/

## Sources of Information
