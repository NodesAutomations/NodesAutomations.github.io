---
title: Getting Started with AutoCAD VBA &#58 Annotations, Dimensions, Leader
description : learn how to create AutoCAD Objects like Text, Mtext, Dimensions, Leaders using VBA
date: 26-11-2024
categories: [VBA, AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
published: false
---

### Overview
- In this tutorial i'll show you how to use VBA to generate drawings inside autocad
- I am assuming that 
  - you've already installed [AutoCAD VBA Module](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/3kxk0RyvfWTfSfAIrcmsLQ.html)
  - you have basic knowledge of `VBA` and how to create new method or functions

> Bydefault AutoCad don't include vba installation with main installer. You have to install `VBA` module seperately.
> Download your vba module from here : [AutoCAD VBA Module](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/3kxk0RyvfWTfSfAIrcmsLQ.html)
{: .prompt-tip }

> AutoCAD LT don't have support for VBA, you have to use full version of AutoCAD to run `VBA` code.
{: .prompt-warning }

### Setup on AutoCAD
-

### How to run your first code
 
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
```

#### Aligned Dimension
```visualbasic
Sub DrawAlignDimensions()

    'Set start and end points
    Dim startPoint(0 To 2) As Double, endPoint(0 To 2) As Double
    startPoint(0) = 10#: startPoint(1) = 10#: startPoint(2) = 0#
    endPoint(0) = 20#: endPoint(1) = 10#: endPoint(2) = 0#
        
    'insertion Point x,y,z coordinate
    Dim insertionPoint(0 To 2) As Double
    insertionPoint(0) = 15#: insertionPoint(1) = 12#: insertionPoint(2) = 0#
 
    ' creates Aligned Dim
    Dim cadDim As AcadDimAligned
    Set cadDim = ThisDrawing.ModelSpace.AddDimAligned(startPoint, endPoint, insertionPoint)
    cadDim.TextOverride = "Length = <>"

End Sub
```

#### Angular Dimension
```visualbasic
```

### Leaders


#### Leader
```visualbasic
```

#### MLeader
```visualbasic
```

### Get Input From user



### Modifications for ZWCAD, BricsCAD

