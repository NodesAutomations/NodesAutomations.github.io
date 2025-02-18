---
title: Automate Excel with Python using OpenPyXL
description: learn how to use openpyxl package to automate excel file using python
date: 18-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-openpyxl.webp
---

### Overview
- In this tutorial, I'll show you how to use openpyxl package to automate excel file using python
- openpyxl is 
  - open source so you can use it for free
  - open souces does not require excel installation on your system so it's more suitable for web apps
- Reading and writing data from and to excel file is most common requirement for excel automation, so only going to focus on that part

### Setup
- use `Pip install openpyxl` to install xlwings package
- Create new excel file `sample.xlsx`
- Create python Script file `Sample.py`, in same folder of your excel file
- For our tutorial i am going to add some data to our excel file, refer Screenshot 1
  
![Screenshot 1](/assets/images/python/python-xlwings-1.webp)
_Screenshot 1 : Excel sheet with data_

### Read Data from Excel file
```python
 import openpyxl as op

wb: op.Workbook = op.load_workbook("Sample.xlsx", read_only=True)
ws = wb["Sheet1"]

# Get value using cell address
print(ws["B1"].value)
# Get value using cell row and column
# Note: Indexing starts from 0, so A1=(0,0), B1=(0,1), C1=(0,2) and so on
print(ws.cell(row=1, column=2).value)

# Read range of cells
rng = ws["B4:E7"]
for row in rng:
    for cell in row:
        print(cell.value, end=" ")
    print()
```

### Read Name Range and table range from active excel file
```python
import openpyxl as op

wb: op.Workbook = op.load_workbook("Sample.xlsx", read_only=True)
ws = wb["Sheet1"]

# Get Specific Name range
range_location = wb.defined_names.get("Area").attr_text
# Extract the sheet name and cell address
sheet_name, cell_range = range_location.split('!')
print(wb[sheet_name][cell_range].value)

# Get Table Range
# Yet to find working code for this
```

### Write Data to excel file

```python
from openpyxl import Workbook

# create new workbook
wb = Workbook()

# grab the active worksheet
ws = wb.active

# Data can be assigned directly to cells
ws['A1'] = "Hey this string  is comming from python"
# using row and column Id, Index starting from 0
ws.cell(row=2, column=1).value = "Index are better option when working with loops"

# Assign Data using list
data = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
rowStart: int = 5
colStart: int = 3
for i, row in enumerate(data, start=rowStart):
    for j, value in enumerate(row, start=colStart):
        ws.cell(row=i, column=j).value = value

# Save the file
wb.save("output.xlsx")
```

### Conclusion
- I mostly prefer xlwings over openpyxl due to its simple api
- But for webapps openpyxl is more suitable as it does not require excel installation