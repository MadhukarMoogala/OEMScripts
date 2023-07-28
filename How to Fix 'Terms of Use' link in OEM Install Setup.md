# How to Fix 'Terms of Use' link in OEM Install Setup



### What's is the problem?


From AutoCAD OEM 2023 we have embraced a modern installation technology ODIS aka On Demand Installation Service which enable product teams to deliver more timely updates to our customers in continuous deployment model expected for SaaS businesses.

The installation technology currently defaults to Autodesk's ToU, which is true of all Autodesk products but not correct for OEM based products as these products are owned by their respective manufacturers and their ToU should govern it.

Here is a workaround to fix this.



### Requirements

- At least AutoCAD OEM 2023

- A custom OEM Product is stamped with OEMMakeWizard and packed with OEMInstallerWizard.





1. Go to your custom product install location and make a backup.
2. Copy `~install\ODIS\Setup\ui\resources\app.asar` , e.g.  `D:\oem\OEMWizInstallers\Rep2023Installer\install\ODIS\Setup\ui\resources\app.asar` to another location, e.g. `%temp%\app.asar`
3. Install NodeJS
4. In command line prompt window, execute:
   
   ```bash
   npm install -g asar
   asar extract %temp%\app.asar %temp%\app\
   ```
   
   
5. Use text editor to open `%temp%\app\ui\dist\bundle.js`, find and replace below text
      "https://www.autodesk.com/company/terms-of-use/"+t+"/general-terms"
   with
      "https://your-terms-of-use"
6. In command line prompt window, execute:
   
   ```bash
   asar pack %temp%\app\ %temp%\app.asar
   ```
7. Copy `%temp%\app.asar` to replace MASTER\ODIS\Setup\ui-plugins\dda\app.asar
8. Do install.



Note: Screenshot shows 'Terms of Use' link now directs to Google's ToU,  and, aslo before and after tweaking.


Before:

![](C:\Users\moogalm\AppData\Roaming\marktext\images\2023-07-28-16-02-55-image.png)

After:



![](C:\Users\moogalm\AppData\Roaming\marktext\images\2023-07-28-15-36-50-image.png)


