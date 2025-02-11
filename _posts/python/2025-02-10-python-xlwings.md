---
title: Automate Excel with Python using xlwings
description: learn how to use xlwings package to automate excel file using python
date: 10-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-xlwings.webp
---

### Overview
- xlwings is my favorite python library to automate excel file
- xlwings is open source and free to use

### Setup
- use `Pip install xlwings` to install xlwings package
- Create new excel file `sample.xlsx`
- Create python Script file `Sample.py`, in same folder of your excel file
- For our tutorial i am going to add some data to our excel file, refer Screenshot 1
- You can download excel file from this link 
  
![Screenshot 1](/assets/images/python/python-xlwings-1.webp)
_Screenshot 1 : Excel sheet with data_

### Read Data from Active Excel file
- To Read Data from any excel sheet first we need to get workbook and worksheet
- for workbook variable, I normally prefer to work with active workbook, so my script does not depend on name of excel workbook
- for worksheet variable, since multiple sheets are very common, I prefer to use sheet name instead of active sheet

```python
import xlwings as xw

# Get workbook
wb: xw.Book = xw.books.active

# Get worksheet
sheet: xw.Sheet = wb.sheets['Sheet1']

# Get value using cell address
print("Value of B1 cell : " + str(sheet["B1"].value))

# Get value using cell row and column
# Note: Indexing starts from 0, so A1=(0,0), B1=(0,1), C1=(0,2) and so on
print("Value of B1 cell : " + str(sheet[0, 1].value))

# Read range of cells
rng: xw.Range = sheet["B4:E7"]
print(f"Number of Cells in range {rng.address} : {rng.count}")

for i in range(0, rng.rows.count):
    for j in range(0, rng.columns.count):
        print(rng[i, j].value)
```

- If you have multiple excel sheet open at same time, you can specify name of excel sheet

```python
wb: xw.Book = xw.Book("sample.xlsx")
```

### Read Name Range and table range from active excel file
```python
import xlwings as xw

# Get workbook
wb: xw.Book = xw.books.active

# Get worksheet
sheet: xw.Sheet = wb.sheets['Sheet1']

# Get Specific Name range
rng: xw.Range = sheet["Area"]
print(f"Area Range Address is {rng.address} and Value is {rng.value}")

# Get Table Range
rng: xw.Range = sheet["ColumnDataTable"]
print(
    f"ColumnDataTable Range Address is {rng.address} and Value is {rng.value}")

for i in range(0, rng.rows.count):
    for j in range(0, rng.columns.count):
        print(rng[i, j].value)

# Get Table Object
table: xw.main.Table = sheet.tables["ColumnDataTable"]

print(table.name)
print(table.range.address)
print(table.header_row_range.address)
print(table.data_body_range.address)
```

### Write Data to excel file

```python
import xlwings as xw

# Create New Workbook
wb: xw.Book = xw.Book()

# Get first sheet from worksheet
ws: xw.Sheet = wb.sheets[0]

# Write data to this sheet
ws["A1"].value = "Hey this string  is comming from python"

# Save workbook to current directory of python script
wb.save("output.xlsx")

# Close workbook
if len(wb.app.books) == 1:
    # Close Excel App if only single sheet is open
    wb.app.quit()
else:
    # Close Open excel sheet is multiple sheets are open
    wb.close()
```