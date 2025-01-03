---
title: Bat files for windows tasks
description : Hide Folders, Open Current folder in VS Code
date: 11-11-2024
categories: [Scripts,Bat Files]
tag: [bat file, automation, script, how to]
image: /assets/images/batfiles/bat_windows.webp
---

### Overview
- This post has all bat files that I use on my regular basis
- If you don't know about what is bat files then read this [post](/posts/bat-files-introduction/) first.

### Bat File to Hide/Unhide folders
- This is very simple to script to hide your folders from another user who don't know this trick
- So, when you run this script for first time it will automatically generate new folder named `Secure`
- you can put your files into this folder to hide
- run this script again and it will hide this `Secure` folder
- run this for third time to unhide `Secure` folder
- Use cases
  - for office user to hide your project files or personal notes from your colleagues
  - for students who shares his/her computer with family or friends
  
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> When you rename your folder `Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}`,
> windows will scan it as  control panel item and hide it. that is why you won't be able to see that folder in windows explorer.
> you have to change its folder name again using command line to make it visible to windows explorer
{: .prompt-info }
<!-- markdownlint-restore -->

```bat
@ECHO OFF

:: Unhide folder if it exists
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
    attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
    ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Secure
    goto End
)

:: Create Secure folder if it doesn't exist
if NOT EXIST Secure (
    md Secure
    goto End
)

:: Hide Secure folder
ren Secure "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder locked

:End
```
