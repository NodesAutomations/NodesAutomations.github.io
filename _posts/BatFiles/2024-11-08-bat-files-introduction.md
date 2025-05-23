---
title: Bat File Introduction
description : Intro to Bat files for automation
date: 08-11-2024
categories: [Scripts,Bat Files]
tag: [bat file, automation, script, how to]
image: /assets/images/batfiles/bat_intro.webp
---

### What it is?
- It's a text file with `*.bat` extension. you can open bat file using `Notepad`
- It contains windows commands which we can run without user intervention

### How to open bat files
- Bat files are simple text files so you can directly open it via `Notepad`
- To open the BAT file in Notepad, right-click it and choose Show more options > Edit from the menu

### How to create new bat file
- you create new text file in notepad with commands for bat file 
- while saving that text file change file extension from `*.txt` to `*.bat`

### How to use it?
- bat files are supported by windows out of box, so you don't need any special program to run it
- Just double click on bat file to run its commands

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> While bat files are not inherently dangerous, they can be used maliciously. for example, script can delete some files or move files without your knowledge.
> so always review the contents of bat file before running it on your computer, 
> especially when you get bat file from untrusted source.
{: .prompt-danger }
<!-- markdownlint-restore -->

### Some basic use cases of bat files
- Running bat file to clean up extra files generated by FEM programs
- Running bat file to run multiple programs in sequence
- Create new folders 
- Hide folders
- basically, any task you can do via `Command Prompt`, you can automate it via bat file

### Sample Bat commands
- `del filepath` : deletes `file` file using given file path
- `del file.txt` : deletes `file.txt` file in active folder
- `del *.txt` : deletes all files with `*.txt` extensions

> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1iekjab/bat_file_introduction_nodes_automations/)
{: .prompt-info }
