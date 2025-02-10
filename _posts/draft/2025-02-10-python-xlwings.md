---
title: Automate Excel with Python using xlwings
description: discription
date: 10-02-2025
categories: [Python]
tag: [python, excel]
image: /assets/images/excel/excel-run-python.webp
published: false
---

### Overview

### Setup
- Run "xlwings quickstart myproject" to create a folder called "myproject" in the current directory with an Excel file and a Python file, ready to be used.
- Use the "--standalone" flag to embed all VBA code in the Excel file and make it work without the xlwings add-in.

### Read Excel file
```python
import xlwings as xw

# Get workbook
wb = xw.Book("sample.xlsx")

# Get worksheet
sheet = wb.sheets['Sheet1']

# Get Single Cell
print("Value of A1 cell : " + sheet["A1"].value)
print("Value of A1 cell : " + sheet[0,0].value)

# Get Table/Range
rng=sheet["A1:C5"]
print(f"Number of Cells in range {rng.address} : {rng.count}")

for i in range(0,rng.rows.count):
    for j in range(0,rng.columns.count):
         print(sheet[i,j].value)
```

### Read Name Range and table range
```python
import xlwings as xw

# Get workbook
wb = xw.Book("sample.xlsx")

# Get active worksheet
sheet = wb.sheets["Inputs"]

# Get Specific Name range
print(sheet["Category"].value)
print(sheet["Author"].value)

# Get Range using name
rng=sheet["BookTable"]

for i in range(0,rng.rows.count):
    for j in range(0,rng.columns.count):
         print(rng[i,j].value)

# Get Excel Table
table=sheet.tables["BookTable"]

# Print Table adddress
print(table.name)
print(table.range.address)
print(table.header_row_range.address)
print(table.data_body_range.address)
```
### Save and Close Workbook
```python
wb.save()
if len(wb.app.books)==1:
    wb.app.quit()
else:
    wb.close()
```
### Write Excel file
```python
import xlwings as xw

# Get workbook
wb = xw.Book()

# Get first worksheet
ws=wb.sheets[0]

# Write data to this sheet
ws["A1"].value="Hey this string  is comming from python"

#Save workbook
wb.save("output.xlsx")
```

### To Run excel macro from python
```python
wb=xw.Book("Sample.xlsx")

# Macro without input
macro=wb.macro("ModuleName.SubName")
macro()

# macro with input
macroWithInput=wb.macro("ModuleName.SubName2")
macroWithInput("InputPara")
```
