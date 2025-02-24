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
- I've added sample code to create new circle in modelspace, you can follow this same process to create another object

#### Circle
- This code will create new circle in your active autocad document
- as you can see it's similar to AutoCAD VBA
- AutoCAD have lot of objects so i am not going to write sample code for all object only main ones
- you can visit [Getting Started with AutoCAD VBA](/posts/autocad-vba-getting-started-1/) to get access to VBA API
- Just use same method to generate autocad objects 

```python
from pyautocad import Autocad, APoint

cadApp = Autocad()
cadDoc = cadApp.ActiveDocument
cadModel = cadDoc.ModelSpace

# APoint is custom class for AutoCAD Point
# It's part of pyautocad library
centerPoint = APoint(0, 0)
radius = 10.0
cadCircle = cadModel.AddCircle(centerPoint, radius)
```

#### Line
```python
startPoint = APoint(10, 20)
endPoint = APoint(20, 30)
cadLine = cadModel.AddLine(startPoint, endPoint)
```

#### Polyline
- since polyline require multiple point, we can't use `APoint` class here
- we have to use array library to pass multiple points
- `import array` to use array library

```python
# Create 2D point array
points_2d = [0, 0, 10, 0, 10, 10, 0, 10]
points_double = array.array("d", points_2d)
cadModel.AddLightWeightPolyline(points_double)
```

- if you want to add one point at a time

```python
# Create 2D point array
points_2d = []

points_2d.append(0)
points_2d.append(0)

points_2d.append(10)
points_2d.append(0)

points_2d.append(10)
points_2d.append(10)

points_2d.append(0)
points_2d.append(10)

points_double = array.array("d", points_2d)
cadModel.AddLightWeightPolyline(points_double)
```

#### Text
```python
textString = "Hello World"
insertionPoint = APoint(0, 0)
textHeight = 2
cadText = cadModel.AddText(textString, insertionPoint, textHeight)
```

### Read Data from existing drawing
#### loop through specific objects in active drawing
- Loop through all text objects
- once you have access to the object, you can access its properties similar to AutoCAD VBA

```python
point = APoint(0, 0)
for text in cadApp.iter_objects('Text'):
    print('text: %s at: %s' % (text.TextString, text.InsertionPoint))
    text.InsertionPoint = APoint(text.InsertionPoint) + point
```
```python
for circle in cadApp.iter_objects('Circle'):
    print(circle.Center)
```
```python
for line in cadApp.iter_objects('Line'):
    print(line.StartPoint, line.EndPoint)
```

### Conclusion
- pyautocad is good option if you want to automate AutoCAD using python
