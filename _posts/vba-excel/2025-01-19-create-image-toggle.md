---
title: How to Zoom-In and Zoom-out of Image on Excel using VBA
description : VBA code to change image size on click
date: 19-01-2025
categories: [VBA, Excel]
tag: [excel, vba,howto]
image: /assets/images/excel/excel-image-toggle.webp
---

### Overview
- In this tutorial, I'll show you how to change Image size when you click on it
- This is effective way to save space for large images and make excel more interactive for user
- I am assuming that you have basic knowledge of `VBA` and how to create new modules
- If you don't know how to work with excel macro then watch this video first: [How to create or use excel macro Tutorial](https://www.youtube.com/watch?v=Tepc4iioSaA)

### Setup

![Output1](/assets/images/excel/excel-image-toggle-1.webp)
_Screenshot 1 : Excel sheet with selection pane_

- Open your Excel sheet, Insert New image in excel sheet (Place image over cells, this code won't work with in-cell images)
- Open Selection Pane using `ALT`+`F10` and change name of image to `ImageName_Size1_Size2` format refer Screenshot 1
  - `ImageName` is name of your image
  - `Size1` is Larger or Zoom In image width
  - `Size2` is default image width
  - Both sizes value are in centimeters
  - Don't forget to add underscore `_` as separator for ImageName, Size1, and Size2
  - You can also use smaller size first and larger second, sequence doesn't matter
- I am going to use `P1_6_3` Image name, where 6cm is Image Width when it's zoomed in and 3cm is Image Width when it's zoomed out
- Convert your excel file to macro unable file if it's regular excel file
- Create new module with VBA code from below and assign `ImageSizeToggle` macro to your image, refer Screenshot 2

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
![Output2](/assets/images/excel/excel-image-toggle-2.webp)
_Screenshot 2 : Assign Macro to your image_

### Conclusion
- Image toggles are simple way to save space and add some good visuals to excel sheets
- You can also use this code to toggle excel shapes and charts
- one downside of this method is that you'll lose your undo history, so you won't be able to undo your changes after running this macro