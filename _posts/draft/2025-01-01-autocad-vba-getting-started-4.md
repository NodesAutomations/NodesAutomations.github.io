---
title: Getting Started with AutoCAD VBA &#58 Create Hatch
description : learn how to modify your AutoCAD VBA code so it will work on ZWCAD, BricsCAD or GStarCAD
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


### Sample Code for hatch
```vb
Sub DrawCircleWithHatch()
       
    'Circle center x,y,z coordinate
    Dim centerPoint(0 To 2) As Double
    centerPoint(0) = 10#: centerPoint(1) = 20#: centerPoint(2) = 0#
     
    'Circle radius
    Dim radius As Double
    radius = 10#
     
    'Create circle object
    Dim cadCircle As AcadCircle
    Set cadCircle = ThisDrawing.ModelSpace.AddCircle(centerPoint, radius)
    
    'Store outerBoundary for hatch
    Dim objects(0 To 0) As AcadEntity
    Set objects(0) = cadCircle
        
    'Define the hatch
    Dim patternname As String
    Dim patterntype As Long
    Dim bassociativity As Boolean
        
    patternname = "SOLID"
    patterntype = acHatchPatternTypePreDefined
    bassociativity = True
    
    'Create Hatch
    Dim hatchObj As AcadHatch
    Set hatchObj = ThisDrawing.ModelSpace.AddHatch(patterntype, patternname, bassociativity)
      
    'Set the outer loop for hatch
    hatchObj.AppendOuterLoop objects
    
End Sub
```

#### ZWCAD

#### BricsCAD

#### GStarCAD




