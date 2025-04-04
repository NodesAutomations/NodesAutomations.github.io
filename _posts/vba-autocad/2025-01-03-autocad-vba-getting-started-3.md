---
title: Getting Started with AutoCAD VBA 3 &#58 Get inputs from user and display output
description : learn how to get inputs from user via using VBA
date: 03-01-2025
categories: [VBA, VBA-AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
---

### Overview
- In this tutorial I’ll show you how to use VBA to get input from user
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

### Display output to user

#### AutoCAD terminal

```vb
Sub SendMessage()
    'Added vbCrLf for new line
    ThisDrawing.Utility.Prompt "Hello World" & vbCrLf
End Sub
```
```vb
Sub SendMessage()
    Dim radius As Double
    radius = 5
    ThisDrawing.Utility.Prompt "Radius=" & radius & vbCrLf
End Sub
```
#### Message box

```vb
Sub SendMessage()
    MsgBox ("Hello World")
End Sub
```

#### Send Command 

```vb
Sub SendCommand()
    ThisDrawing.SendCommand "_Circle" & vbCr & "0,0,0" & vbCr & "10" & vbCr
End Sub
```


### Get Inputs

#### Get value from AutoCAD terminal

```vb
Sub GetString()
    'Get string input
    Dim title As String
    title = ThisDrawing.Utility.GetString(True, "Enter Drawing Title : ")
    
    'Print title
    ThisDrawing.Utility.Prompt "Your New Drawing title is " & title  & vbCrLf
End Sub
```
```vb
Sub GetDecimalValue()
    Dim radius As Double
    radius = ThisDrawing.Utility.GetReal("Enter Circle Radius : ")
    
    ThisDrawing.Utility.Prompt "Your circle radius is " & radius & vbCrLf
End Sub
```
```vb
Sub GetDecimalValue()
    Dim count As Integer
    count = ThisDrawing.Utility.GetInteger("Enter Circle Count : ")
    
    ThisDrawing.Utility.Prompt "Your circle count is " & count & vbCrLf
End Sub
```


#### Get value using input box

```vb
Sub GetInputUsingInputBox()
    'Integer
    Dim count As Integer
    count = CDbl(InputBox("Enter the number of the circle:", "Circle Count"))
    
    'Double
    Dim radius As Double
    radius = CDbl(InputBox("Enter the radius of the circle:", "Circle Radius"))
    
    'String
    Dim title As String
    title = CStr(InputBox("Enter the drawing title:", "Drawing Title"))
End Sub
```

#### Get Point from user
```vb
Sub GetPointFromUser()
 Dim basePoint As Variant
 basePoint = ThisDrawing.Utility.GetPoint(, "Pick Base point : ")
 
 ThisDrawing.Utility.Prompt "Selected base point is: " & basePoint(0) & ", " & basePoint(1) & ", " & basePoint(2) & vbCrLf
End Sub
```

#### Get Distance from user
```vb
Sub GetDistanceFromUser()
    Dim distance As Double
    distance = ThisDrawing.Utility.GetDistance(, "Specify Distance:")
    
    ThisDrawing.Utility.Prompt distance & vbCrLf
End Sub
```
#### Get Angle from user
```vb
Sub GetAngleFromUser()
 Dim angle As Double
 angle = ThisDrawing.Utility.GetAngle(, "Specify Angle")
  
 ThisDrawing.Utility.Prompt "Angle in radian is : " & angle & vbCrLf
End Sub
```

#### Get Keywords from user to switch between different options
```vb
Sub GetAngleFromUser()
 'Set Keyword input
 ThisDrawing.Utility.InitializeUserInput 1, "Height Width Depth"

 Dim result As String
 result = ThisDrawing.Utility.GetKeyword("Enter a keyword [ Height/Width/Depth ]:")
  
 ThisDrawing.Utility.Prompt "You've selected: " & result & vbCrLf
End Sub
```


> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1iel3sw/getting_started_with_autocad_vba_3_get_inputs/)
{: .prompt-info }