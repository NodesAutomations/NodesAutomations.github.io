---
title: Getting Started with AutoCAD VBA &#58 Drawing Objects
description : learn how to create AutoCAD Objects like line, circle, arc, rectangle using VBA
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

### Drawing Objects

#### Circle
```visualbasic
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
    
End Sub
```
#### Line
```visualbasic
Sub DrawLine()

    'Set start and end points
    Dim startPoint(0 To 2) As Double, endPoint(0 To 2) As Double
    startPoint(0) = 10#: startPoint(1) = 20#: startPoint(2) = 0#
    endPoint(0) = 20#: endPoint(1) = 30#: endPoint(2) = 0#
     
    'Create line object
    Dim cadLine As AcadLine
    Set cadLine = ThisDrawing.ModelSpace.AddLine(startPoint, endPoint)
     
End Sub
```
#### Polyline
```visualbasic
Sub DrawPolyline()

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
    Set polyline = ThisDrawing.ModelSpace.AddLightWeightPolyline(points)
    
End Sub
```
#### Rectangle
```visualbasic
Sub DrawRectangle()

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

End Sub
```
#### Point
```visualbasic
Sub DrawPoint()

    'Point x,y,z coordinate
    Dim point(0 To 2) As Double
    point(0) = 10#: point(1) = 20#: point(2) = 0#
    
    'Create Point object
    Dim cadPoint As AcadPoint
    Set cadPoint = ThisDrawing.ModelSpace.AddPoint(point)
    
End Sub
```
#### Arc
```visualbasic
Sub DrawArc()
    'Arc center x,y,z coordinate
    Dim centerPoint(0 To 2) As Double
    centerPoint(0) = 10#: centerPoint(1) = 20#: centerPoint(2) = 0#
     
    'Arc radius
    Dim radius As Double
    radius = 10#
     
    'Arc start and end angles
    Dim startAngleInDegree As Double, endAngleInDegree As Double
    startAngleInDegree = 0#
    endAngleInDegree = 270#
    
    Dim startAngleInRadian As Double, endAngleInRadian As Double
    startAngleInRadian = startAngleInDegree * 3.141592 / 180#
    endAngleInRadian = endAngleInDegree * 3.141592 / 180#

    'Create Arc object
    Dim cadArc As AcadArc
    Set cadArc = ThisDrawing.ModelSpace.AddArc(centerPoint, radius, startAngleInRadian, endAngleInRadian)

End Sub
```
#### Elipse
```visualbasic
Sub DrawEllipse()

    'Set Ellipse Parameter
    Dim majorRadius As Double
    Dim radiusRatio As Double
 
    majorRadius = 20
    radiusRatio = 0.75
    
    'Center Point Ellipse
    Dim centerPoint(0 To 2) As Double
    centerPoint(0) = 0: centerPoint(1) = 0#: centerPoint(2) = 0#

    
    'End Point of Major Axis
    'You can set angle of ellipse using this point
    Dim majorAxisEndPoint(0 To 2) As Double
    majorAxisEndPoint(0) = majorRadius#: majorAxisEndPoint(1) = 0#: majorAxisEndPoint(2) = 0#
    
    'Create new ellipse
    Dim ellipseObj As AcadEllipse
    Set ellipseObj = ThisDrawing.ModelSpace.AddEllipse(centerPoint, majorAxisEndPoint, radiusRatio)
    
End Sub
``` 