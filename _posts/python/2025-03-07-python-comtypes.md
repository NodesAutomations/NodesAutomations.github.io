---
title: Automate Apps with VBA API using Python
description: learn how to use comtypes package to automate Apps with VBA API
date: 07-03-2025
categories: [Python, Libraries]
tag: [python, how to, library]
image: /assets/images/python/python-comtypes.webp
---

## Overview
- Comtype is
  - open source so you can use it for free
  - only compatible with windows so only suitable for local apps
  - it's python Component Object Model library for windows in simple terms it will allow you to use VBA API calls using python
  - for example i've added sample code to manipulate Excel and AutoCAD using Comtypes
  - But this should work with STAAD, ETABS, Word, Powerpoint 
  - In Active development
  - [Documentation](https://comtypes.readthedocs.io/en/stable/)
- Requirements
  - Python 3.8 or later
  - Windows OS

## Setup
- For Excel, make sure that you have Excel file open with some data in B1 Cell and NameRange named "Area"
- For AutoCAD, Just open any blank AutoCAD document

## Excel API
```python
import comtypes.client

# Get active Excel application
excel = comtypes.client.GetActiveObject("Excel.Application")
# Get active workbook
active_workbook = excel.ActiveWorkbook
print(active_workbook.Name)
# Get active sheet
active_sheet = excel.ActiveSheet
print(active_sheet.Name)
# Get cell value
cell_value = active_sheet.Range("B1").value2
print(cell_value)
# Get namerange value
nameRange_value = active_sheet.Range("Area").value2
print(nameRange_value)
```

## AutoCAD API
```python
import comtypes.client
import array

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
```

## Conclusion
- I don't recommend this since it's not officially supported
- If you're stuck with any error, you're on your own. no one going to help you with that.
- Only use this if you don't have any other option