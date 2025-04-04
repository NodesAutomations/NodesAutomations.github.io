---
title: Getting Started with AutoCAD VBA 2 &#58 Annotations, Dimensions, Leader
description : AutoCAD VBA Code for Text, Mtext, Dimensions, Leaders
date: 02-01-2025
categories: [VBA, VBA-AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
---

### Overview
- In this tutorial I’ll show you how to use VBA to generate annotations like text, dimensions and leaders using VBA
- I am assuming that 
  - you've already installed [AutoCAD VBA Module](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/3kxk0RyvfWTfSfAIrcmsLQ.html)
  - you have basic knowledge of `VBA` and how to create new method or functions
  - you already know how to draw basic objects , if not please go through this post first : [Getting Started with AutoCAD VBA 1 : Line, Polyline, Circle, Arc, Rectangle, Point](/posts/autocad-vba-getting-started-1/)

### Setup on AutoCAD
- Open blank AutoCAD file with default template, open Visual Basic Editor and Add new module
- Add any sample Code from below and just run it, try to change values like text, text Height, coordinates re-run it.
- Sample codes for each basic objects are given below. You can copy paste this code to `VBA` editor to directly run it without any inputs
- Current code is very simple, I'll try to add bit more details into this code in future, like code to modify it's different properties
- This is very basic code and self-explanatory, if you still need help then use AI tools like ChatGPT to understand this code, only contact me if everything else fail 😅
 
### Text Annotations

#### Single Line Text
```visualbasic
Sub DrawSingleLineText()
       
    'insertion Point x,y,z coordinate
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 10#: insertionPoint(1) = 20#: insertionPoint(2) = 0#
     
    'Text properties
    Dim textString As String
    textString = "Hello World"
     
    Dim textHeight As Double
    textHeight = 2#
     
    'Create text object
    Dim cadText As AcadText
    Set cadText = ThisDrawing.ModelSpace.AddText(textString, insertionPoint, textHeight)
    
End Sub
```
#### MText
```visualbasic
Sub DrawMultilineText()

    'insertion Point x,y,z coordinate
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 10#: insertionPoint(1) = 20#: insertionPoint(2) = 0#
    
    'Text properties
    Dim textString As String
    textString = "Hello World"
     
    Dim textHeight As Double
    textHeight = 2#
    
    Dim textWidth As Double
    textWidth = 20#
    
    'create mtext object
    Dim cadMText As AcadMText
    Set cadMText = ThisDrawing.ModelSpace.AddMText(insertionPoint, textWidth, textString)
    cadMText.height = textHeight
    
End Sub
```
### Dimensions

#### Rotated Dimension
```visualbasic
Sub DrawRotatedDimensions()

    'Set start and end points
    Dim startPoint(0 To 2) As Double, endPoint(0 To 2) As Double
    startPoint(0) = 10#: startPoint(1) = 10#: startPoint(2) = 0#
    endPoint(0) = 20#: endPoint(1) = 11#: endPoint(2) = 0#
        
    'Insertion point for text
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 15#: insertionPoint(1) = 12#: insertionPoint(2) = 0#
 
    'rotation angle , multiply with  3.141592 / 180 to convert degree to radians
    Dim rotationAngle As Double
    rotationAngle = 0 * 3.141592 / 180#
    
    'Creates dim
    Dim cadDim As AcadDimRotated
    Set cadDim = ThisDrawing.ModelSpace.AddDimRotated(startPoint, endPoint, insertionPoint, rotationAngle)
    cadDim.TextOverride = "Length = <>"
    
End Sub
```

#### Aligned Dimension
```visualbasic
Sub DrawAlignDimensions()

    'Set start and end points
    Dim startPoint(0 To 2) As Double, endPoint(0 To 2) As Double
    startPoint(0) = 10#: startPoint(1) = 10#: startPoint(2) = 0#
    endPoint(0) = 20#: endPoint(1) = 10#: endPoint(2) = 0#
        
    'Insertion point for text
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 15#: insertionPoint(1) = 12#: insertionPoint(2) = 0#
 
    'Creates dim
    Dim cadDim As AcadDimAligned
    Set cadDim = ThisDrawing.ModelSpace.AddDimAligned(startPoint, endPoint, insertionPoint)
    cadDim.TextOverride = "Length = <>"

End Sub
```

#### Angular Dimension
```visualbasic
Sub DrawAngularDimensions()
    
    'Set origin point, center of arc
    Dim originPoint(0 To 2) As Double
    originPoint(0) = 0#: originPoint(1) = 0#: originPoint(2) = 0#
         
    'Set start and end points of arc
    Dim startPoint(0 To 2) As Double, endPoint(0 To 2) As Double
    startPoint(0) = 10#: startPoint(1) = 0#: startPoint(2) = 0#
    endPoint(0) = 0#: endPoint(1) = 10#: endPoint(2) = 0#
        
    'Insertion point for text
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 10#: insertionPoint(1) = 10#: insertionPoint(2) = 0#
 
    'Creates dim
    Dim cadDim As AcadDimAngular
    Set cadDim = ThisDrawing.ModelSpace.AddDimAngular(originPoint, startPoint, endPoint, insertionPoint)
    cadDim.TextOverride = "Length = <>"
    
End Sub
```

### Leaders


#### Leader
```visualbasic
Sub DrawLeader()

    'Insert point for mtext
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 7: insertionPoint(1) = 5#: insertionPoint(2) = 0#
 
    'create mtext object
    Dim cadMText As AcadMText
    Set cadMText = ThisDrawing.ModelSpace.AddMText(insertionPoint, 20, "Hello World")
 
    'points for leader
    Dim points(0 To 8) As Double
    points(0) = 0: points(1) = 0: points(2) = 0
    points(3) = 5: points(4) = 5: points(5) = 0
    points(6) = 7: points(7) = 5: points(8) = 0
 
    'create new leader
    Dim cadLeader As AcadLeader
    Set cadLeader = ThisDrawing.ModelSpace.AddLeader(points, cadMText, acLineWithArrow)
    
    'Adjust text height
    cadMText.Height = 0.5
    
End Sub
```

#### MLeader
```visualbasic
Sub DrawMeader()
 
    'points for leader
    Dim points(0 To 8) As Double
    points(0) = 0: points(1) = 0: points(2) = 0
    points(3) = 5: points(4) = 5: points(5) = 0
    points(6) = 7: points(7) = 5: points(8) = 0
 
    'create new MLeader
    Dim cadLeader As AcadMLeader
    Set cadLeader = ThisDrawing.ModelSpace.AddMLeader(points, 0)
    
    'Update  text
    cadLeader.textString = "Hello World"
    cadLeader.textHeight = 0.5
    
    'Update Leader properties
    cadLeader.leaderType = AcMLeaderType.acStraightLeader
    cadLeader.ArrowheadType = AcDimArrowheadType.acArrowClosed
    
End Sub
 
```

> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1iel3bb/getting_started_with_autocad_vba_2_annotations/)
{: .prompt-info }