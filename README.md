# coherence-grabber

*How to grab extra domestic sites for Xray (ProjectX)*

1. Configure [XRay](https://xtls.github.io/en/) client to include `geosite` and domestic domains in routing and switch `.log.loglevel` to
   `"info"`. See [easy-xray](https://github.com/EvgenyNerush/easy-xray) client config for reference. Set wrong ip address or port of the
   server to cause connection error if client tries to connect. Let `congig_client.json`contains the following:
```
  "log": {
    "access": "none",
    "error": "",
    "loglevel": "info",
    "dnsLog": false
  },
  ...
            "address": "1.2.3.4",
            "port": 444,
  ...
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "domain": [
          "geosite:cn",
          "domain:cn",
          "domain:ru",
          "domain:by",
          "domain:ir"
        ],
        "outboundTag": "direct"
      },
  ...
```

2. Run `sudo xray -c config_client.json` and use it to connect to some site for that direct connection is expected (like baidu dot com or vk
   dot com). Websites get its components from a number of addresses, some of them are out of the current `geosite.dat` Xray file. In this
   case Xray client tries to fetch content through the Xray server and causes a connection error and breaks the site coherence. To see names
   of sites from which content delivery failed, filter warnings then filter sniffed name some lines before the warnings:
```
sudo xray -c config_client.json | grep -B 15 Warning | grep sniffed
```

3. Running the command above with browser connected to Xray socks proxy, go to domestic sites. Check the resulting list for false hits and
   with some `whois` service, then add websites to `data/coherence-extra` file.

4. Convert the file to format acceptable by Xray with [this utility](https://github.com/v2fly/domain-list-community), say to
   `customgeo.dat`.

5. Use the obtained `.dat` file in Xray: `sudo cp customgeo.dat /usr/local/share/xray/`, and in `config_client.json`:
```
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "domain": [
          "geosite:cn",
          "domain:cn",
          ...
          "ext:customgeo.dat:coherence-extra"
        ],
        ...
```

6. To use this list in clients (for instance, in Hiddify's `Settings/Routing/Custom rules/Direct URL`), they can be transformed with
   scripts:
```
    ./4hiddify.sh data/coherence-extra > comma-and-newline-separated-list.txt # also fit for V2Ray
    ./4nekoray.sh data/coherence-extra > newline-separated-list.txt
```

