---
title: How to draw table in AutoCAD from excel data using VBA
description : steps to create AutoCAD table using excel data
date: 17-11-2024
categories: [VBA, AutoCAD]
tag: [excel,autocad, vba, script, how to]
image: /assets/images/autocad/autocad-excel-vba.webp
---

### Overview
- Generating AutoCAD table from excel data is common requirement for lot of tasks
- In this tutorial, I’ll show you how to set this up using excel `VBA`
- To simplify this tutorial, we'll do this in multiple iteration
- Also i am assuming that you have basic knowledge of `VBA` and how to create new method or functions

> This Code requires a full version of AutoCAD. AutoCAD LT do not have support for VBA development.
{: .prompt-warning }

### Setup
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

### Version 1 : creating basic AutoCAD table
- Add new module to project and add sample code from below
- Also, open AutoCAD with blank drawing, keep it open
- this code will only  work with active AutoCAD drawing

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
    
    'Create AutoCAD Table
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
![Output1](/assets/images/autocad/AutoCADTable1.webp)

- Congrats !🥳, we have our first working version of table generation code
- This codes normally uses whichever table styles is active as default.
- here we are using AutoCAD `Standard` table style since it's new blank drawing. so your version of table might looks different depending on that settings.
- we'll modify this code further to use excel data instead of fixed values

### Version 2 : Integration with excel data

```visualbasic
Sub CreateTable()

    'Get excel table
    Dim tbl As ListObject
    Set tbl = Sheet1.ListObjects("DataTable")
    
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
    Set table = cadDoc.ModelSpace.AddTable(basePoint, tbl.Range.Rows.Count, 3, 0.6, 2.4)
 
    With table
        'Unmerge Header row
        .UnmergeCells 0, 0, 0, 3
        
        'Header Row
        .SetText 0, 0, "BARID"
        .SetText 0, 1, "DIA"
        .SetText 0, 2, "LENGTH"
        
        Dim i As Integer
        For i = 1 To tbl.DataBodyRange.Rows.Count
            .SetText i, 0, tbl.DataBodyRange.Cells(i, 1)
            .SetText i, 1, tbl.DataBodyRange.Cells(i, 2)
            .SetText i, 2, tbl.DataBodyRange.Cells(i, 3)
        Next
    End With
    
End Sub
```
Output on AutoCAD
- this should be same as earlier version  only change is now you can change data in excel table
- try to add new row or change existing row data to check if it's working as expected

### Version 3 : Formatting Adjustments

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
    
    'Get excel table
    Dim tbl As ListObject
    Set tbl = Sheet1.ListObjects("DataTable")
    
    'Table Parameters
    '''Using 0,0 as table top left base point
    Dim basePoint(0 To 2) As Double
    basePoint(0) = 0: basePoint(1) = 0: basePoint(2) = 0
    
    '''Table Cell Size
    Dim rowHeight As Double
    Dim columnWidth As Double
    rowHeight = 2
    columnWidth = rowHeight * 4
    
    '''Table Text
    Dim textHeight As Double
    textHeight = rowHeight * 0.5
    
    'Create Autocad Table
    Dim table As AcadTable
    Set table = cadDoc.ModelSpace.AddTable(basePoint, tbl.Range.Rows.Count, 3, rowHeight, columnWidth)
 
    With table
        'Unmerge Header row
        .UnmergeCells 0, 0, 0, 3
        
        'Header Row
        .SetRowHeight 0, rowHeight * 1.3
        .SetText 0, 0, "BARID"
        .SetCellTextHeight 0, 0, textHeight * 1.3
         
        .SetText 0, 1, "DIA"
        .SetCellTextHeight 0, 1, textHeight * 1.3
         
        .SetText 0, 2, "LENGTH"
        .SetCellTextHeight 0, 2, textHeight * 1.3
        
        Dim i As Integer, j As Integer
        For i = 1 To tbl.DataBodyRange.Rows.Count
            .SetText i, 0, tbl.DataBodyRange.Cells(i, 1)
            .SetCellTextHeight i, 0, textHeight
            .SetCellAlignment i, 0, acMiddleCenter
            
            .SetText i, 1, tbl.DataBodyRange.Cells(i, 2)
            .SetCellTextHeight i, 1, textHeight
            .SetCellAlignment i, 1, acMiddleCenter
            
            .SetText i, 2, tbl.DataBodyRange.Cells(i, 3)
            .SetCellTextHeight i, 2, textHeight
            .SetCellAlignment i, 2, acMiddleCenter
        Next
        
    End With
    
End Sub

```
Output on AutoCAD

![Output3](/assets/images/autocad/AutoCADTable2.webp)

- Here I’ve just added 2 extra rows for testing 
- now we have our first working version of table generation code with custom Formatting
- we can further develop this to add more functionality, but this post is already too long
- I’ll try to add more version in future if there's readers are more interested in this kind of post

### Future Modifications you can try on your own
- Instead of using Excel table, it should work with selected or specified range
- Using Custom Table styles, text style, layer
- Make this code works with multiple version of AutoCAD
- Generate multiple tables from different sheets at specific coordinate
- Instead of using 0,0 coordinate as base, let user choose location of table on AutoCAD
- Add data validation or error handling when Invalid inputs are provided

### Conclusion
- This is good example how I develop all of  my programs via working in small iteration
- Each version doing small improvements on earlier version

### References
- Excel File : [AutoCAD Table Sample Code](https://nodesauto-my.sharepoint.com/personal/vivek_nodesautomations_com/_layouts/15/onedrive.aspx?ga=1&id=%2Fpersonal%2Fvivek%5Fnodesautomations%5Fcom%2FDocuments%2FShare%2F2024%2D11%2D17%20AutoCAD%20Table%20Generation%20Code)
- Youtube Project: [Generate AutoCAD table from Excel using VBA](https://www.youtube.com/watch?v=gw4nGZutEbY)
- Youtube Excel VBA Basics : [How to create or use excel macro Tutorial](https://www.youtube.com/watch?v=Tepc4iioSaA)