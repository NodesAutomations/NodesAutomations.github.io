---
title: Automate AutoCAD with Python & pyautocad
description: learn how to use pyautocad package to automate your drawings
date: 24-02-2025
categories: [Python, Libraries]
tag: [python, autocad, how to, library,autocad-python]
image: /assets/images/python/python-pyautocad.webp
---

### Overview
- pyautocad is 
  - open source so you can use it for free
  - it uses ActiveX Automation to control AutoCAD, so it's basically a wrapper for AutoCAD VBA API
  - it's not in active development, last commit was in 2016
- Requirements
  - pyautocad required Full version of AutoCAD installed on your system
  - AutoCAD LT won't work with pyautocad

### Setup
- use `Pip install pyautocad` to install xlwings package


### Connect with AutoCAD 
- use `from pyautocad import Autocad` to import `Autocad` class
- This sample code just print "Hello, World" to your AutoCAD prompt
- Create New AutoCAD file

```python
cadApp = Autocad(create_if_not_exists=True)
cadApp.prompt("Hello,World\n")
```
- Use Existing AutoCAD file

```python
cadApp = Autocad()
cadApp.prompt("Hello,World\n")
```

### Create New Entity
- Since pyautocad uses AutoCAD VBA behind the scenes, you can create any AutoCAD entity using AutoCAD VBA API
- Only Difference is how we access our Document and modelspace
- I've addes sample code to create new circle in modelspace, you can follow this same process to create another object

#### Circle
- This code will create new circle in your active autocad document
- as you can see it's similar to AutoCAD VBA
- AutoCAD have lot of objects so i am not going to write sample code for all object only main ones
- you can visit [Getting Started with AutoCAD VBA](/posts/autocad-vba-getting-started-1/) to get access to VBA API
- Just use same method to generate autocad objects 

```python
cadApp = Autocad()
cadDoc = cadApp.ActiveDocument
cadModel = cadDoc.ModelSpace

centerPoint = APoint(0, 0)
radius = 10.0
cadCircle = cadModel.AddCircle(centerPoint, radius)
```

#### Document
- Active Document

```python
cadApp = Autocad()
cadDoc = cadApp.ActiveDocument
```

#### Modelspace

```python
cadApp = Autocad()
cadDoc = cadApp.ActiveDocument
cadModel = cadDoc.ModelSpace
```



### Conclusion
 