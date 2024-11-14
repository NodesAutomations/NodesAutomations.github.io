---
layout: post
title: Bat files for STAAD PRO
description : Bat files for STAAD
date: 09-11-2024
categories: [Software Tools, Bat Files]
tag: [bat, programming, automation, script, STAAD]
image: /assets/images/batfiles/bat_staad.webp
---
### Overview
- In this tutorial we'll be using BAT file to automate some of STAAD task
- If you don't know about what is bat files then read this [post](/posts/bat-files-introduction/) first.

### STAAD Pro File Cleaner
- we are going to build bat file to clean up STAAD PRO files generated after analysis
- In Bat file we can use `del fileName.fileExtension` command to delete file in active folder .
- we can use this command to delete a single file which is not great when we have to delete lot of files. To solve this issue, we are going to use wild card instead of specifying file name
- so `del *.fileExtension` will delete all files with specified file extension
- additionally, we are adding `/s` option to repeat this same action in all sub folders and `/q` option to do this quietly without any windows popup to confirm the delete action
- our final command `del /s /q "*.ANL"` will delete all files with `*.ANL` extension in active folder as well as in sub folder
- now we can add all file extensions which want to remove after STAAD files. You can build your own version, but I've already done this for you
```bat
del /s /q "*.ANL"
del /s /q "*.log"
del /s /q "*.bmd"
del /s /q "*.CFR"
del /s /q "*.cod"
del /s /q "*.cut"
del /s /q "*.day"
del /s /q "*.dbi"
del /s /q "*.dbs"
del /s /q "*.dsp"
del /s /q "*.ecf"
del /s /q "*.ejt"
del /s /q "*.emf"
del /s /q "*.EQL"
del /s /q "*.est"
del /s /q "*.mov"
del /s /q "*.num"
del /s /q "*.png"
del /s /q "*.rea"
del /s /q "*.REI_SPRO_Auxilary_Data"
del /s /q "*.rsd"
del /s /q "*.sbk"
del /s /q "*.scn"
del /s /q "*.slg"
del /s /q "*.slv"
del /s /q "*.metadata"
del /s /q "*.UID"
```

### Run Analysis for multiple models in sequence
Command to run single model for STAAD V8i
```bat
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model.std"
```
Command to run single model for Connect Edition
```bat
"C:\Program Files\Bentley\Engineering\STAAD.Pro CONNECT Edition\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model.std"
```
> you have to modify STAAD program exe file path, if it's installed at some other location. Also update STAAD model file path in this command.
{: .prompt-info }

Now using this command, you can run as many models you like in sequence, may if your models are large enough take a nap 😴 or go out for refreshments 🍵. 
```bat
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model1.std"
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model2.std"
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model3.std"
```
> If you have very large models or models with lot of load combinations that each model might take few hours to run analysis then it's best to run this bat file at end of workday and leave computer running whole night. You can come back next morning to check out the completed analysis. 
{: .prompt-tip }