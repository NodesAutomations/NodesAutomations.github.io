---
title: Getting Started with AutoCAD VBA 3 &#58 Get input or send output
description : learn how to get inputs from user via using VBA
date: 03-01-2025
categories: [VBA, AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
published: false
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

### Send output to user

#### Send message via AutoCAD terminal

```vb
Sub SendMessage()
    'Added vbCrLf for new line
    ThisDrawing.Utility.Prompt "Hello World" & vbCrLf
End Sub
```
#### Send message using message box


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

#### Get Distance from user

#### Get Angle from user

#### Get Keyword from user

