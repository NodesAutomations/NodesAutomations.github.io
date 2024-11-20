---
layout: post
title: Bat files for ETABS
description : Clean up ETABS analysis files
date: 10-11-2024
categories: [Bat Files, ETABS]
tag: [bat file, automation, script, etabs, how to]
image: /assets/images/batfiles/bat_etabs.webp
---

### Overview
- In this tutorial we'll be using BAT file to automate some of ETABS task
- If you don't know about what is bat files then read this [post](/posts/bat-files-introduction/) first.

### ETABS File Cleaner
- we are going to build bat file to clean up ETABS files generated after analysis
- In Bat file we can use `del fileName.fileExtension` command to delete file in active folder .
- we can use this command to delete a single file which is not great when we have to delete lot of files. To solve this issue, we are going to use wild card instead of specifying file name
- so `del *.fileExtension` will delete all files with specified file extension
- additionally, we are adding `/s` option to repeat this same action in all sub folders and `/q` option to do this quietly without any windows popup to confirm the delete action
- our final command `del /s /q "*.Y0A"` will delete all files with `*.Y0A` extension in active folder as well as in sub folder
- now we can add all file extensions which want to remove after ETABS files. You can build your own version, but I've already done this for you
```bat
del /s /q "*.Y0A"
del /s /q "*.Y0B"
del /s /q "*.Y_"
del /s /q "*.K_0"
del /s /q "*.K_E"
del /s /q "*.K_G"
del /s /q "*.K_I"
del /s /q "*.K_J"
del /s /q "*.K_M"
del /s /q "*.msh"
del /s /q "*.OUT"
del /s /q "*.Y"
del /s /q "*.Y$$"
del /s /q "*.Y"
del /s /q "*.Y_1"
del /s /q "*.Y00"
del /s /q "*.YOA"
del /s /q "*.YOB"
del /s /q "*.Y01"
del /s /q "*.Y02"
del /s /q "*.Y03"
del /s /q "*.Y04"
del /s /q "*.Y05"
del /s /q "*.Y06"
del /s /q "*.Y07"
del /s /q "*.Y08"
del /s /q "*.Y09"
```
