---
title: Automate Excel with Python using xlwings
description: learn how to use xlwings package to automate excel file using python
date: 07-03-2025
categories: [Python, Libraries]
tag: [python, how to, library]
image: /assets/images/python/python-openpyxl.webp
published: false
---

## Overview
- Comtype is
  - open source so you can use it for free
  - only compatible with windows so only suitable for local apps
  - it's python Component Object Model library windows in simple terms it will allows you to use VBA API calls using python
  - for example i've added sample code to manipulate Excel and AutoCAD using Comtypes
  - But this should work with STAAD, ETABS, Word, Powerpoint 
  - In Active development
  - [Documentation](https://comtypes.readthedocs.io/en/stable/)
- Requirements
  - Python 3.8 or later
  - Windows OS


## Setup


## Excel API

## AutoCAD API
```python
import comtypes.client
import array

try:
    # Get active AutoCAD application
    acad = comtypes.client.GetActiveObject("AutoCAD.Application")
    # Get the active document
    doc = acad.ActiveDocument
    # Get the model space
    model_space = doc.ModelSpace
    # Create a new point 
    center_point = array.array('d', [0, 0, 0.0])
    # Create a new circle
    circle = model_space.AddCircle(center_point, 10)
except Exception as e:
    print(f"Error: {e}")
    print("Make sure AutoCAD is running with an active document")
```
