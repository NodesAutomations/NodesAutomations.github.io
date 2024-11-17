---
title: Draw Table in AutoCAD from Excel data
description : Excel vba code to draw table AutoCAD
date: 17-11-2024
categories: [Software Tools, Bat Files]
tag: [bat file, automation, script, how to]
# image: /assets/images/batfiles/bat_windows.webp
published: false
---

### Overview



### Sample Code

```visualbasic
Sub Test()
    'Get AutoCad Objects
    Dim cadApp As AcadApplication
    Set cadApp = GetObject(, "autocad.Application")
    
    Dim cadDoc As AcadDocument
    Set cadDoc = cadApp.ActiveDocument
    
    Dim cadModel As AcadModelSpace
    Set cadModel = cadDoc.ModelSpace
    
    'Create Autocad Table
    
    Dim basePoint(0 To 2) As Double
    basePoint(0) = 0: basePoint(1) = 0: basePoint(2) = 0
    
    
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
        
        'Set row height
        '.SetRowHeight rowId, rowHeight
        '.SetColumnWidth columnId,columnWidth
        '.SetCellTextHeight rowId, columnId, textHeight
        '.SetCellAlignment  rowId, columnId, acMiddleCenter
    End With
End Sub
```