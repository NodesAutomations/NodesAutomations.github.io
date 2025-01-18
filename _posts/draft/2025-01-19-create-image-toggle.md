---
title: How to create image toggle using excel VBA
description : VBA code to change image size on click
date: 18-01-2025
categories: [VBA, Excel]
tag: [excel, vba,howto]
image: /assets/images/excel/excel-image-dropdown.webp
published: false
---

### Overview
 

### Setup
 

### VBA Code
```vb
Sub ImageSizeToggle()
 
    On Error GoTo ErrorHandler
 
    'Get Shape that triggered the macro
    Dim shape As shape
    Set shape = ActiveSheet.Shapes(Application.Caller)
    
    'Lock Aspect Ration to adjust height automatically
    shape.LockAspectRatio = msoTrue
    
    'Get Shape Toggle Sizes
    Dim Sizes() As String
    Sizes = Split(shape.Name, "_")
    
    Dim width1 As Double, width2 As Double
    width1 = Application.CentimetersToPoints(CDbl(Sizes(1)))
    width2 = Application.CentimetersToPoints(CDbl(Sizes(2)))
        
    'Toggle width
    If Math.Abs(shape.Width - width1) > Math.Abs(shape.Width - width2) Then
        shape.Width = width1
    Else
        shape.Width = width2
    End If
 
Done:
    Exit Sub

ErrorHandler:
    MsgBox "Invalid Shape Name : " & shape.Name & vbNewLine & "Use ImageName_Size1_Size2 Format"

End Sub
```
 

### Future Modification
 

### Conclusion
 