# Azure Web App - PowerShell Data Viewer

Tool I developed for work to help build reports in Windows environments. Examples include pulling a list of installed applications, installed printers, or checking local administrators from multiple Windows endpoints.

**Blog post:** https://henryaker.com/blog/2026/November/ps_data_viewer_webapp.php

## Install Instructions

### Prerequisites
* Existing Azure Subscription

### 1. Create Azure Web App
Basics:
- Publish: Code
- Runtime Stack: Latest NodeJS version
- Pricing plan: F1, D1, or B1 depending on your requirements

Networking:
- Enable public access: On 

Everything else is up to you.

### 2. Edit configuration
1. Under the newly created web app,  go to **Settings > Configuration > Stack settings**
2. In the startup command box, enter:
```
node server.js
```
Then click **Apply**

### 3. Deploy code
1. Download the files from github, then extract them.
2. On the extracted files, open azure-webapp-powershell-data-viewer-main > azure-webapp-powershell-data-viewer-main
3. Select all files in this folder and zip them
4. In the web app, go to **Settings > Deployment > Deployment Center**
5. Select **Manual Deployment** then **Browse files** and choose the .zip we created in step 3. Then click **Deploy**
