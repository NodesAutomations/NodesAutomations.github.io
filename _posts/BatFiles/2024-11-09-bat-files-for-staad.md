---
layout: post
title: Bat files for STAAD PRO
description : Bat files for STAAD
date: 09-11-2024
categories: [Software Tools, Bat Files]
tag: [bat, programming, automation, script, STAAD]
image: /assets/images/batfiles/bat_staad.webp
---

### STAAD Pro File Cleaner
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

### Run Analysis
Connect Edition
```bat
"C:\Program Files\Bentley\Engineering\STAAD.Pro CONNECT Edition\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model.std"
```
STAAD V8i
```bat
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model.std"
```
Run Multiple Models
```bat
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model1.std"
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model2.std"
"C:\SProV8i SS6\STAAD\SProStaad\SProStaad.exe" /s STAAD "C:\Users\Ryzen2600x\Desktop\STAADModel\Model3.std"
```