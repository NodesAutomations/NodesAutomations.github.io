---
title: Bat files for Developers
description : Bat files for Excel VBA Projects, Visual Studio Code, Visual Studio
date: 28-12-2024
categories: [Scripts,Bat Files]
tag: [bat file, automation, script, how to]
image: /assets/images/batfiles/bat_developer.webp
---

### Overview
- This Post contains bat files that I am using to help with development
- If you don't know about what is bat files then read this [post](/posts/bat-files-introduction/) first.

### Open Current folder in Visual Studio Code
- This is single line script for Visual Studio Code users
- This script will open active folder in visual studio code
- I have this file added to all of my VBA or python projects with version control 

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Make sure to copy that `.` at end
{: .prompt-info }
<!-- markdownlint-restore -->

```bat
start "" "C:\Users\Ryzen2600x\AppData\Local\Programs\Microsoft VS Code\Code.exe" .
```
if you're planning to use it on multiple desktops
```bat
start "" "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\Code.exe" .
```
### Clear VBA Project Files
- If you use version control for VBA Projects then use this script to remove older files

```bat
del /q "*.bas"
del /q "*.cls"
del /q "*.doccls"
del /q "*.frm"
del /q "*.frx"
```

### Clear Visual Studio C# Project
- This script will clean up your visual studio C# project
- This is really useful when you need to share your project with client or other developers

```bat
set BIN_DIR=bin
set OBJ_DIR=obj
set GIT_DIR=.git
set VS_DIR=.vs

for /d /r %%i in (%BIN_DIR%) do if exist "%%i" rd /s /q "%%i"
for /d /r %%i in (%OBJ_DIR%) do if exist "%%i" rd /s /q "%%i"
for /d /r %%i in (%GIT_DIR%) do if exist "%%i" rd /s /q "%%i"
for /d /r %%i in (%VS_DIR%) do if exist "%%i" rd /s /q "%%i"
```