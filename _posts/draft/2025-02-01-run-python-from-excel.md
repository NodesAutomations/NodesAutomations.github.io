---
title: Run python script directly from excel file
description : use excel vba to run python script
date: 01-01-2025
categories: [Python]
tag: [python, vba,excel]
image: /assets/images/autocad/autocad-getting-started.webp
published: false
---

### Overview

### Setup

### Version 1
```python

```

### Version 2
```python
Sub CalculateArea()
    Dim objShell As Object
    Set objShell = VBA.CreateObject("Wscript.Shell")
        
    Dim PythonExePath As String
    PythonExePath = """C:\Users\Ryzen2600x\AppData\Local\Programs\Python\Python311\python.exe"""

    Dim PythonScriptPath As String
    PythonScriptPath = """" & ThisWorkbook.Path & "\Sample.py"""
     
    objShell.Run PythonExePath & " " & PythonScriptPath, 0
End Sub
```