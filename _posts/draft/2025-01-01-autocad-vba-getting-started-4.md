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
```vb
Sub DrawRectangleWithHatch()
 
    'Set polyline points
    'We are using 4 coordinate so size of points array = 2x4
    Dim points(0 To 7) As Double
    'first coordinate is 0,0
    points(0) = 0: points(1) = 0
    'second coordinate is 10,0
    points(2) = 10: points(3) = 0
    'third coordinate is 10,10
    points(4) = 10: points(5) = 10
    'third coordinate is 10,10
    points(6) = 0: points(7) = 10
        
    'Create new polyline
    Dim polyline As AcadLWPolyline
    Set polyline = ThisDrawing.ModelSpace.AddLightWeightPolyline(points)
    polyline.Closed = True
 
    'Store outerBoundary for hatch
    Dim objects(0 To 0) As AcadEntity
    Set objects(0) = polyline
        
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
```vb
Sub DrawRectangleAndCircleWithHatch()
 
    'Set polyline points
    'We are using 4 coordinate so size of points array = 2x4
    Dim points(0 To 7) As Double
    'first coordinate is 0,0
    points(0) = 0: points(1) = 0
    'second coordinate is 10,0
    points(2) = 10: points(3) = 0
    'third coordinate is 10,10
    points(4) = 10: points(5) = 10
    'third coordinate is 10,10
    points(6) = 0: points(7) = 10
        
    'Create new polyline
    Dim polyline As AcadLWPolyline
    Set polyline = ThisDrawing.ModelSpace.AddLightWeightPolyline(points)
    polyline.Closed = True
 
   
    'Circle center x,y,z coordinate
    Dim centerPoint(0 To 2) As Double
    centerPoint(0) = 3#: centerPoint(1) = 5#: centerPoint(2) = 0#
     
    'Circle radius
    Dim radius As Double
    radius = 1
     
    'Create circle object
    Dim cadCircle As AcadCircle, cadCircle2 As AcadCircle
    Set cadCircle = ThisDrawing.ModelSpace.AddCircle(centerPoint, radius)
    
    centerPoint(0) = 6#: centerPoint(1) = 5#: centerPoint(2) = 0#
    Set cadCircle2 = ThisDrawing.ModelSpace.AddCircle(centerPoint, radius)
     
    'Store outerBoundary for hatch
    Dim outerEntities(0 To 0) As AcadEntity
    Set outerEntities(0) = polyline
        
    'Store Inner Boundary for hatch
    Dim innerEntities(0 To 0) As AcadEntity
    Set innerEntities(0) = cadCircle
    
    Dim innerEntities2(0 To 0) As AcadEntity
    Set innerEntities2(0) = cadCircle2
    
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
    hatchObj.AppendOuterLoop outerEntities
    hatchObj.AppendInnerLoop innerEntities
    hatchObj.AppendInnerLoop innerEntities2
End Sub

```

#### ZWCAD

#### BricsCAD

#### GStarCAD




