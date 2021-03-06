# CNTLM and dealing with the corporate proxy

CNTLM acts as an intermediary, offering an HTTP/HTTPS proxy that actually goes through the NTLM corporate proxy in the backend. Here's how to configure it as a localhost-only non-authenticated HTTP proxy. The "architecture" looks something like this:

````
[application] <---> CNTLM <---> corporate proxy <---> the internet
````

Why would you want to do this? Because not all apps know how to speak to a corporate proxy which authenticates via NTLM. Or perhaps you are required to change your password too often and it's better to do so for a single config than for seven different ones.

Examples of applications that benefit from this are Anaconda (the Python distribution), the official Git client for windows, and microsoft's own Azure Storage Explorer.


## Step 1: download and install CNTLM
You can grab it from [the official web page](http://cntlm.sourceforge.net) , the installation is pretty straightforward and shouldn't pose a problem.

## Step 2: configuration
By default it'll be installed in `C:\Program Files (x86)\Cntlm`, go there and open `cntlm.ini`. You will need `Username`, `Domain` and at least one line with `Proxy` (you can have more than one). Remember to comment any line with `Password` or `Pass{something}` (see example below).

````
Username	yourusername
Domain		MEGACORP
# Password     leave this parameter commented
# PassLM       leave this parameter commented
# PassNT       leave this parameter commented
# PassNTLMv2   leave this parameter commented

Proxy		proxy.megacorp.com:8443 # usual HTTP port
Proxy		proxy.megacorp.com:8080 $ usual HTTP port
````

Now open CMD or powershell, go to the installation folder, and run this:
````
cntlm -c cntlm.ini -M http://www.example.com
````

The program will ask for your password, once you provide it you will get something like this:
````
C:\Program Files (x86)\Cntlm>cntlm -c cntlm.ini -M http://www.example.com
Password:
Config profile  1/4... OK (HTTP code: 200)
----------------------------[ Profile  0 ]------
Auth            NTLMv2
PassNTLMv2      D5826E9C665C37C80B53397D5C07BBCB
------------------------------------------------
````

You just need to copy the lines between the `------` in the config file, and configuration is done.

Ah, one last thing. You should have a line looking like this:
````
Listen		127.0.0.1:6666
````

It's important that the address there is `127.0.0.1` or `localhost` so nobody can use this from outside your computer. The number after the colon (`:6666`) is the port number cntlm will be listening on (I picked 6666 because it's most likely unused)

## Step 3: run it

You'll probably want to be able to run this without much issue, so here's the quick & dirty way:

1. create a couple of links to cntlm.exe
2. go to the properties of each one, and edit the "Target" value with these two respectively:
  * `"C:\Program Files (x86)\Cntlm\cntlm.exe" -c cntlm.ini`
  * `"C:\Program Files (x86)\Cntlm\cntlm.exe" -c cntlm.ini -f -v`

The first one will be for the day-to-day use, the second one leaves the cmd window open so you can see what's going on.
