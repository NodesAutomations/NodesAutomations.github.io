---
title: Getting Started with AutoCAD VBA 5 &#58 Set Colors, Layers, Text Style, LineTypes
description : learn to modify AutoCAD object properties
date: 01-02-2025
categories: [VBA, AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
---

### Overview
- In this tutorial I’ll show you how to use VBA to add hatch to your drawings
- I am assuming that 
  - you've already installed [AutoCAD VBA Module](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/3kxk0RyvfWTfSfAIrcmsLQ.html)
  - you have basic knowledge of `VBA` and how to create new method or functions
  - you already know how to draw basic objects , if not please go through this post first : [Getting Started with AutoCAD VBA 1 : Line, Polyline, Circle, Arc, Rectangle, Point](/posts/autocad-vba-getting-started-1/)

### Setup on AutoCAD
- Open blank AutoCAD file with default template, open Visual Basic Editor and Add new module
- Add any sample Code from below and just run it, try to change values like colors, lineTypes, Fonts and re-run it.
- Sample codes for each basic objects are given below. You can copy paste this code to `VBA` editor to directly run it without any inputs
- Current code is very simple, I'll try to add bit more details into this code in future, like code to modify it's different properties
- This is very basic code and self-explanatory, if you still need help then use AI tools like ChatGPT to understand this code, only contact me if everything else fail 😅

### Set Color for AutoCAD Objects
- This code should work with almost all autocad objects
- We are going to use circle object for this example, since it require least amout of code but you can use any object

```vb
Sub DrawCircle()
       
    'Circle center x,y,z coordinate
    Dim centerPoint(0 To 2) As Double
    centerPoint(0) = 10#: centerPoint(1) = 20#: centerPoint(2) = 0#
     
    'Circle radius
    Dim radius As Double
    radius = 10#
     
    'Create circle object
    Dim cadCircle As AcadCircle
    Set cadCircle = ThisDrawing.ModelSpace.AddCircle(centerPoint, radius)
    
    'Change Circle color using color name
    'acRed is autocad inbuilt varible part of AcColor Enum
    cadCircle.color = acRed

    'Red color (Color index 1)
    cadCircle.color = 1
  
End Sub
```
- You can specifiy colors in autocad using two method
  - Using AutoCAD internal Variables AcColor
    - You can either specify color name or use layer color
    - acByLayer will automatically display entity in layor color
  - Color Index : predefine value of color in integer

| Color Variable | Value |
| -------------- | ----- |
| acByBlock      | 0     |
| acRed          | 1     |
| acYellow       | 2     |
| acGreen        | 3     |
| acCyan         | 4     |
| acBlue         | 5     |
| acMagenta      | 6     |
| acWhite        | 7     |
| acDarkGray     | 8     |
| acLightGray    | 9     |
| acByLayer      | 256   |

![AutoCAD Color Picker](/assets/images/autocad/autocad-color-picker.webp)
_Screenshot 1 : AutoCAD Color Picker_

### Set Layer for AutoCAD Objects
```vb
Sub CreateLayer()

    Dim layerName As String
    layerName = "Reinforcement"
    
    Dim layerColor As Integer
    ' Red color (Color index 1)
    layerColor = 1                               
    
    ' Check if the layer already exists$$
    Dim layer As AcadLayer
    On Error Resume Next
    Set layer = ThisDrawing.Layers(layerName)
    On Error GoTo 0
    
    ' If the layer does not exist, create it
    If layer Is Nothing Then
        Set layer = ThisDrawing.Layers.Add(layerName)
        layer.color = layerColor
        MsgBox "Layer '" & layerName & "' created successfully with red color.", vbInformation
    Else
        MsgBox "Layer '" & layerName & "' already exists.", vbExclamation
    End If
    
End Sub
```
### Set LineSyle for AutoCAD Objects

### Set TextStyle for AutoCAD Objects