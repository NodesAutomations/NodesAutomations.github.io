---
title: How to draw polyline in AutoCAD from excel data using VBA
description : steps to create AutoCAD polyline using excel data
date: 17-11-2024
categories: [VBA, VBA-AutoCAD]
tag: [excel,autocad, vba, script, how to]
image: /assets/images/autocad/autocad-excel-vba.webp
---

### Overview
- Polyline generation in AutoCAD from excel data is very useful in daily routine to draw sections, create geometry or generate reinforcements
- In this tutorial, I’ll show you how to generate polyline using coordinate from excel sheet
- To simplify this tutorial, we will do this in multiple iteration
- i am assuming that you have basic knowledge of `VBA` and how to create new method or functions

> This Code requires a full version of AutoCAD. AutoCAD LT does not have support for VBA development.
{: .prompt-warning }

### Setup
- Create new macro-enable excel sheet with below data, change name of table to "CoordinateTable"

| X   | Y   |
| --- | --- |
| 0   | 0   |
| 0   | 300 |
| 200 | 300 |
| 200 | 0   |

- Open `VBA`, add reference to AutoCAD 
  
> In VBA Editor, Go to Tools > References > Check `AutoCAD 2015 Type Library`.
> I am using AutoCAD 2015, you have to choose your version library.
{: .prompt-tip }

### Version 1 : Creating polyline with specific coordinates
- Add new module to project and add sample code from below
- Also, open AutoCAD with blank drawing, keep it open
- this code will only  work with active AutoCAD drawing

```visualbasic
Sub CreatePolyline()
    'Get AutoCad App
    Dim cadApp As AcadApplication
    Set cadApp = GetObject(, "autocad.Application")
    
    'Get active AutoCAD Drawing
    Dim cadDoc As AcadDocument
    Set cadDoc = cadApp.ActiveDocument
    
    'Get model space
    Dim cadModel As AcadModelSpace
    Set cadModel = cadDoc.ModelSpace
    
    'Set polyline points
    'We are using 3 coordinate so size of points array = 2x3
    Dim points(0 To 5) As Double
    'first coordinate is 0,0
    points(0) = 0: points(1) = 0
    'second coordinate is 10,0
    points(2) = 10: points(3) = 0
    'third coordinate is 10,10
    points(4) = 10: points(5) = 10
        
    'Create new polyline
    Dim polyline As AcadLWPolyline
    Set polyline = cadModel.AddLightWeightPolyline(points)
    
End Sub
```
Output

![Output1](/assets/images/autocad/AutoCad-Polyine1.webp){: width="200"  }

- Congrats !🥳, we have our first working version of polyline generation code
- This sample code with use active [layer/color/linetype] as default property for polyline when nothing is specified
- now let's modify this code to use coordinates from our excel table

### Version 2 : Integration with excel data
```visualbasic
Sub CreatePolyline()

    'Get excel table
    Dim tbl As ListObject
    Set tbl = Sheet1.ListObjects("CoordinateTable")
    
    'Get AutoCad App
    Dim cadApp As AcadApplication
    Set cadApp = GetObject(, "autocad.Application")
    
    'Get active AutoCAD Drawing
    Dim cadDoc As AcadDocument
    Set cadDoc = cadApp.ActiveDocument
    
    'Get model space
    Dim cadModel As AcadModelSpace
    Set cadModel = cadDoc.ModelSpace
    
    'Set polyline points
    Dim points() As Double
    ReDim points(2 * tbl.DataBodyRange.Rows.Count - 1)
    
    Dim i As Integer, rowId As Integer
    rowId = 0
    For i = 1 To tbl.DataBodyRange.Rows.Count
        points(rowId) = tbl.DataBodyRange.Cells(i, 1)
        points(rowId + 1) = tbl.DataBodyRange.Cells(i, 2)
        rowId = rowId + 2
    Next
 
    'Create new polyline
    Dim polyline As AcadLWPolyline
    Set polyline = cadModel.AddLightWeightPolyline(points)
    
End Sub
```
Output

![Output1](/assets/images/autocad/AutoCad-Polyine2.webp){: width="200"  }

- so as we can see in output, we are generating polyline using excel data
- try to add new coordinate or change existing one to check if it's working as expected

### Version 3 : Formatting Adjustments
```visualbasic
Sub CreatePolyline()

    'Get excel table
    Dim tbl As ListObject
    Set tbl = Sheet1.ListObjects("CoordinateTable")
    
    'Get AutoCad App
    Dim cadApp As AcadApplication
    Set cadApp = GetObject(, "autocad.Application")
    
    'Get active AutoCAD Drawing
    Dim cadDoc As AcadDocument
    Set cadDoc = cadApp.ActiveDocument
    
    'Get model space
    Dim cadModel As AcadModelSpace
    Set cadModel = cadDoc.ModelSpace
    
    'Set polyline points
    Dim points() As Double
    ReDim points(2 * tbl.DataBodyRange.Rows.Count - 1)
    
    Dim i As Integer, rowId As Integer
    rowId = 0
    For i = 1 To tbl.DataBodyRange.Rows.Count
        points(rowId) = tbl.DataBodyRange.Cells(i, 1)
        points(rowId + 1) = tbl.DataBodyRange.Cells(i, 2)
        rowId = rowId + 2
    Next
 
    'Create new polyline
    Dim polyline As AcadLWPolyline
    Set polyline = cadModel.AddLightWeightPolyline(points)
    
    'Close polyline
    polyline.Closed = True
    
    'Format Polyline
    polyline.Color = acRed
    
    'Specify layer name
    polyline.Layer = "0"
    
    'Specify line scale
    polyline.LinetypeScale = 0.01
    
    'Add some thickness to polyline
    'this is required for reinforcements drawings
    polyline.ConstantWidth = 5
End Sub
```
Output

![Output1](/assets/images/autocad/AutoCad-Polyine3.webp){: width="200"  }

- Now In addition to version 2, we have specified few additional things here
  - setting polyline as closed polyline
  - Changing it's color (this will override layer color)
  - specified layer name (Just make sure that your layer is already added before using this)
  - changing linetypescale (if we have different type of line like dotted or hidden line)
  - constant width to add some thickness to polyline

### Future modifications
- Instead of using Excel table, it should work with selected or specified range
- Make this code works with multiple version of AutoCAD
- Add data validation or error handling when Invalid inputs are provided
- Add fillet to polyline for rounded corners for reinforcement bars

### Conclusion
- You can use this code to generate simple geometry for your FEM programs, or generate sections or reinforcement drawings

### References
- Excel file : [AutoCAD Polyline Sample Code](https://nodesauto-my.sharepoint.com/:f:/g/personal/vivek_nodesautomations_com/Ei7upzbveJ5HlPxMLCL6XNQBD7oUZzftheXVFJEM1GTAFw)
- YouTube Excel VBA Basics : [How to create or use excel macro Tutorial](https://www.youtube.com/watch?v=Tepc4iioSaA)


> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1iekq5x/how_to_draw_polyline_in_autocad_from_excel_data/)
{: .prompt-info }