# DNS Lookup Findings

## 1. Querying NS Records for youtube.com Using a Root Server

**Command:**
```
nslookup -type=NS youtube.com g.gtld-servers.net
```

**Result:**
The root server (`g.gtld-servers.net`) returns a list of root DNS servers:

- a.root-servers.net
- b.root-servers.net
- c.root-servers.net
- d.root-servers.net
- e.root-servers.net
- f.root-servers.net
- g.root-servers.net
- h.root-servers.net
- i.root-servers.net
- j.root-servers.net
- k.root-servers.net
- l.root-servers.net
- m.root-servers.net

**Note:** This response shows the delegation from the root servers, not the authoritative NS records for youtube.com.

---

## 2. Querying NS Records for google.com Using Google Public DNS

**Command:**
```
nslookup -type=NS google.com 8.8.8.8
```

**Result:**
```
google.com      nameserver = ns1.google.com
google.com      nameserver = ns2.google.com
google.com      nameserver = ns3.google.com
google.com      nameserver = ns4.google.com
```
*Response from: dns.google (8.8.8.8)*

---

## 3. Querying A/AAAA Records for google.com Using Its Own Nameserver

**Command:**
```
nslookup google.com ns1.google.com
```

**Result:**
```
google.com
Addresses: 216.58.210.142
           2a00:1450:4026:804::200e
```
*Response from: ns1.google.com (216.239.32.10)*

---

## 4. Querying A/AAAA Records for youtube.com Using Google Public DNS

**Command:**
```
nslookup youtube.com 8.8.8.8
```

**Result:**
```
youtube.com
Addresses: 216.58.209.174
           2a00:1450:4026:802::200e
```
*Response from: dns.google (8.8.8.8)*

---

## 5. Querying A/AAAA Records for youtube.com Using Its Own Nameserver

**Command:**
```
nslookup youtube.com ns1.google.com
```

**Result:**
```
youtube.com
Addresses: 216.58.210.174
           2a00:1450:4026:805::200e
```
*Response from: ns1.google.com (216.239.32.10)*

---


## 6. Using Google DNS for academy.networkchuck.com

**Command:**
```
nslookup academy.networkchuck.com 8.8.8.8
```

**Result:**
The query for `academy.networkchuck.com` using Google Public DNS (8.8.8.8) returns a CNAME chain, ultimately resolving to two IPv4 addresses:

- `academy.networkchuck.com` is a CNAME for `cname.learnworlds.com`
- `cname.learnworlds.com` is a CNAME for `cname.learnworlds.com.cdn.cloudflare.net`
- `cname.learnworlds.com.cdn.cloudflare.net` resolves to:
    - 162.159.142.17
    - 172.66.2.13

*Response from: 2a06:98c1:56:1:45a3:de4a:6ca2:c6fd (Cloudflare CDN)*

```json
{
  "Status": 0 /* NOERROR */,
  "TC": false,
  "RD": true,
  "RA": true,
  "AD": false,
  "CD": false,
  "Question": [
    {
      "name": "academy.networkchuck.com.",
      "type": 1 /* A */
    }
  ],
  "Answer": [
    {
      "name": "academy.networkchuck.com.",
      "type": 5 /* CNAME */,
      "TTL": 300,
      "data": "cname.learnworlds.com."
    },
    {
      "name": "cname.learnworlds.com.",
      "type": 5 /* CNAME */,
      "TTL": 60,
      "data": "cname.learnworlds.com.cdn.cloudflare.net."
    },
    {
      "name": "cname.learnworlds.com.cdn.cloudflare.net.",
      "type": 1 /* A */,
      "TTL": 300,
      "data": "162.159.142.17"
    },
    {
      "name": "cname.learnworlds.com.cdn.cloudflare.net.",
      "type": 1 /* A */,
      "TTL": 300,
      "data": "172.66.2.13"
    }
  ],
  "Comment": "Response from 2a06:98c1:56:1:45a3:de4a:6ca2:c6fd."
}
```

## Summary

- **Root servers** provide referrals to TLD servers, not direct answers for domain NS records.
- **Google Public DNS (8.8.8.8)** returns authoritative NS records for google.com and resolves A/AAAA records for both google.com and youtube.com.
- **Authoritative nameservers** (like ns1.google.com) provide direct A/AAAA records for their domains.
