# CNTLM and dealing with the corporate proxy

CNTLM acts as an intermediary, showing an HTTP/HTTPS proxy that actually goes through the NTLM corporate proxy. Here's how to configure it as a localhost-only non-authenticated HTTP proxy.


## Step 1: download and install CNTLM
You can grab it from [the official web page](http://cntlm.sourceforge.net) , the installation is pretty straightforward and shouldn't poste a problem

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

Now open CMD or powershell and go to the installation folder, and run this:
````
cntlm -c cntlm.ini -M http://www.example.com
````

The program will ask for your password, once you provide it you will get among some fluff two lines like this:
````
Auth            NTLMv2
PassNTLMv2      D5826E9C665C37C80B53397D5C07BBCB
````

You just need to copy those lines in hte config file, and configuration is done.

Ah, one last thing. You should have a line looking like this:
````
Listen		127.0.0.1:6666
````

It's important that the address there is `127.0.0.1` or `localhost` so nobody can use this from outside your computer. The number after the colon (`:6666`) is the port number cntlm will be listening on (I picked 6666 because it's most likely unused)

## Step 3: run it

You'll probably want to be able to run this without much issue, so here's the quick & dirty way:

1. create a couple of links to cntlm.exe
2. go to the properties of each one, and edit the "Target" value with these two respectively:
  a. `"C:\Program Files (x86)\Cntlm\cntlm.exe" -c cntlm.ini`
  b. `"C:\Program Files (x86)\Cntlm\cntlm.exe" -c cntlm.ini -f -v`

The first one will be for the day-to-day use, the second one leaves the cmd window open so you can see what's going on.