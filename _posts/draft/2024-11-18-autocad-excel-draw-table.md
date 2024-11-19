---
title: How to draw table in AutoCAD from excel data using VBA
description : steps to create autocad table usign excel data
date: 17-11-2024
categories: [Software Tools, Bat Files]
tag: [bat file, automation, script, how to]
image: /assets/images/autocad/autocad-excel-vba.webp
# published: false
---

### Overview
- Generating AutoCAD table from excel data is comman requirement for lot of tasks
- In this tutorial, i'll show you how to set this up usign excel vba
- To simplify this tutorial we'll do this in multiple iteration

### Setup on Excel
- Create new macro-enable excel sheet with below data, change name of table to "DataTable"
  
| BarID | Dia | Length |
| ----- | --- | ------ |
| 1     | 10  | 5      |
| 2     | 12  | 10     |
| 3     | 16  | 15     |

- Open `VBA`, add reference to AutoCAD 
  
> In VBA Editor, Go to Tools > References > Check `AutoCAD 2015 Type Library`.
> I am using AutoCAD 2015, you have to choose your version library.
{: .prompt-tip }


### Version 1 : creating basic autocad table

```visualbasic
Sub CreateTable()
    'Get AutoCad App
    Dim cadApp As AcadApplication
    Set cadApp = GetObject(, "autocad.Application")
    
    'Get active AutoCAD Drawing
    Dim cadDoc As AcadDocument
    Set cadDoc = cadApp.ActiveDocument
    
    'Get model space
    Dim cadModel As AcadModelSpace
    Set cadModel = cadDoc.ModelSpace
    
    'Using 0,0 as table top left base point
    Dim basePoint(0 To 2) As Double
    basePoint(0) = 0: basePoint(1) = 0: basePoint(2) = 0
    
    'Create Autocad Table
    Dim table As AcadTable
    Set table = cadDoc.ModelSpace.AddTable(basePoint, 4, 3, 0.6, 2.4)
 
    With table
        'Unmerge Header row
        .UnmergeCells 0, 0, 0, 3
        
        'Header Row
        .SetText 0, 0, "BARID"
        .SetText 0, 1, "DIA"
        .SetText 0, 2, "LENGTH"
        
        'Row 1
        .SetText 1, 0, "1"
        .SetText 1, 1, "10"
        .SetText 1, 2, "5"
     
        'Row 2
        .SetText 2, 0, "2"
        .SetText 2, 1, "12"
        .SetText 2, 2, "10"
        
        'Row 3
        .SetText 3, 0, "3"
        .SetText 3, 1, "16"
        .SetText 3, 2, "15"
    End With
    
End Sub

```
Output on AutoCAD
![alt text](/assets/images/autocad/AutoCADTable1.webp)

- Congrats !🥳, we have our first working version
- we'll modify this code further to use excel data instead of fixed values

### Version 2 : Integration with excel data


### Version 3 : Formatting Adjustments

