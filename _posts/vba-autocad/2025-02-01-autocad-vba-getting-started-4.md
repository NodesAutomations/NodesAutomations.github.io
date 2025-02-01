---
title: Getting Started with AutoCAD VBA 4 &#58 Create Hatch
description : learn how to create hatch using VBA
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
- Add any sample Code from below and just run it, try to change values like size or coordinates re-run it.
- Sample codes for each basic objects are given below. You can copy paste this code to `VBA` editor to directly run it without any inputs
- Current code is very simple, I'll try to add bit more details into this code in future, like code to modify it's different properties
- This is very basic code and self-explanatory, if you still need help then use AI tools like ChatGPT to understand this code, only contact me if everything else fail 😅
  
### Create solid hatch for circle
```vb
Sub DrawCircleWithSolidHatch()
       
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
### Create pattern hatch for circle
For Solid pattern scale of pattern doesn't matter but for other patterns you need to set scale
```vb
Sub DrawCircleWithPatternHatch()
       
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
        
    patternname = "GRAVEL"
    patterntype = acHatchPatternTypePreDefined
    bassociativity = True
    
    'Create Hatch
    Dim hatchObj As AcadHatch
    Set hatchObj = ThisDrawing.ModelSpace.AddHatch(patterntype, patternname, bassociativity)
    hatchObj.PatternScale = 4
    'Set the outer loop for hatch
    hatchObj.AppendOuterLoop objects
    
End Sub
```
### Create solid hatch for closed polyline
- Closed polyline is most used object to create hatch area
- You can create hatch of any shape using closed polylines
- If you want to create only hatch without any other object, erase polyline after creating hatch

```vb
Sub DrawRectangleWithSolidHatch()
 
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
### Create hatch in specific area
- Assume that we have rectangle with circle inside
- Now if we add hatch to rectangle, it will hatch entire area including inner circle, but we don't want to hatch inner circle    
- To solve this issue, we have to specify inner regions for hatch

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

> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1if0iou/getting_started_with_autocad_vba_4_create_hatch/)
{: .prompt-info }


