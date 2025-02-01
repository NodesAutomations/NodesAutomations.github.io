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
- You can specifiy colors in autocad using two method
  - Using AutoCAD internal Variables AcColor
    - You can either specify color name or use layer color
    - acByLayer will automatically display entity in layor color
  - Color Index : predefine value of color in AutoCAD 

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
    
    'Change circle color using color name
    'acRed is autocad inbuilt varible part of AcColor Enum
    cadCircle.color = acRed

    'Change circle color using color index
    'Red color (Color index 1)
    cadCircle.color = 1
  
End Sub
```

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
- Layers are good way to group similar objects together
- By Default AutoCAD will put all newly added entity in active layer
- So there's two way to specify layer for each entitiy
  - You can specify layer name for each object in AutoCAD
  - You can set preferred layer as active layer, before generating your new objects

```vb
Sub CreateLayer()

    Dim layerName As String
    layerName = "Reinforcement"
    
    Dim layerColor As Integer
    ' Red color (Color index 1)
    layerColor = 1
    
    ' Check if the layer already exists
    Dim layer As AcadLayer
    On Error Resume Next
    'This line will throw error if our layer didn't exist in drawing
    'That's why we are usign Error Handler here
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
    
    ' Set the layer as active
    ThisDrawing.ActiveLayer = layer
    
End Sub
```
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
    
    'Change Circle Layer
    'You need to specify Name of layer
    'Make sure to check for your layer before using this
    'If you enter layer name which don't exist it will throw error
    cadCircle.layer = "0"
    'cadCircle.layer = "Reinforcement"
    
End Sub
```

### Set LineType for AutoCAD Objects
```vb
Sub CreateLineType()

    Dim lineName As String
    lineName = "CENTER2"
 
    ' Check if the lineType already exists
    Dim lineType As AcadLineType
    On Error Resume Next
    'This line will throw error if our LineType didn't exist in drawing
    'That's why we are usign Error Handler here
    Set lineType = ThisDrawing.Linetypes(lineName)
    On Error GoTo 0
    
    ' If the lineType does not exist, create it
    If lineType Is Nothing Then
        Set lineType = ThisDrawing.Linetypes.Add(lineName)
        MsgBox "LineType '" & lineName & "' loaded successfully.", vbInformation
    Else
        MsgBox "LineType '" & lineName & "' already exists.", vbExclamation
    End If
    
    ' Set the lineType as active
    ThisDrawing.ActiveLinetype = lineType 
End Sub
```
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
    
    
    cadCircle.lineType = "CENTER2"
    'cadCircle.lineType = "ZIGZAG"
    cadCircle.LinetypeScale = 20
    'Line weight is specified in mm
    'you can only use linewidth available in autocad
    cadCircle.Lineweight = 90
End Sub
```
### Set TextStyle for AutoCAD Objects



> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1if1rs3/getting_started_with_autocad_vba_5_set_colors/)
{: .prompt-info }
