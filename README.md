# magento2-install-using-shell-scrip-and--heck-mail-ssl
Magento 2 install using shell script and check mail and ssl

#### The command for your helper of this script is:
```
sh magento2_install.sh -h
```

```
sh magento2_install.sh --help
```
<br/>
Result:

```
options:
-h, 	  --help                                Show brief help
-r, 	  --run-instalation=DIR                 Run Instalation
-rs, 	  --run-instalation-sampledata=DIR      Run instalation with sampledata
-rce,     --run-extension-by-composer           Run composer to install extension"
-email,   --run-email                           Run for check email working or not"
-ssl,     --run-ssl                             Run for check ssl"
```

#### The command to installing Magento 2 without sample data is:
```
sh magento2_install.sh -r
```
```
sh magento2_install.sh --run-instalation
```

#### The command to installing Magento 2 with sample data is:
```
sh magento2_install.sh -rs
```
```
sh magento2_install.sh --run-instalation-sampledata
```

#### For create alias of script, view example:
```
alias magento2i="/your/sh/file/path/file.sh"
```

<br/>
After created alias of script, you can run next commands:

With sampledata:

```
magento2i -rs
```
```
magento2i --run-instalation-sampledata
```
<br/>

Without sampledata:

```
magento2i -r
```
```
magento2i --run-instalation
```
<br/>

Run composer to install extension:

```
magento2i -rce
```
```
magento2i --run-extension-by-composer
```
<br/>

Run for check email

```
magento2i -email
```
```
magento2i --run-email
```
<br/>

Run for check ssl

```
magento2i -ssl
```
```
magento2i --run-ssl
```