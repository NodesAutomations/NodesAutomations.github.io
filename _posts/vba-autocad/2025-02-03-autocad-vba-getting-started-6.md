---
title: Getting Started with AutoCAD VBA 6 &#58 Insert Blocks, Attributes, External References
description : learn how to create or update AutoCAD blocks
date: 03-02-2025
categories: [VBA, AutoCAD]
tag: [autocad, vba,howto]
image: /assets/images/autocad/autocad-getting-started.webp
---

### Overview
- In this tutorial I’ll show you how to use VBA to add hatch to your drawings
- I am assuming that 
  - you've already installed [AutoCAD VBA Module](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/3kxk0RyvfWTfSfAIrcmsLQ.html)
  - you have basic knowledge of `VBA` and how to create new methods or functions
  - you already know how to draw basic objects , if not please go through this post first : [Getting Started with AutoCAD VBA 1 : Line, Polyline, Circle, Arc, Rectangle, Point](/posts/autocad-vba-getting-started-1/)

### Setup on AutoCAD
- Open blank AutoCAD file with default template, Add some sample blocks for testing
- I have added block with  "Mark1" in my drawing for testing
- open Visual Basic Editor and Add new module
- Add any sample Code from below and just run it, try to change values like colors, layers and line Types and re-run it.
- Sample codes for each basic objects are given below. You can copy paste this code to `VBA` editor to directly run it without any inputs
- Current code is very simple, I'll try to add bit more details into this code in future, like code to modify it's different properties
- This is very basic code and self-explanatory, if you still need help then use AI tools like ChatGPT to understand this code, only contact me if everything else fail 😅

### Insert Existing Block
- This is sample to insert `Mark1` block reference
- Keep in mind that `Mark1` block defination already exist in my drawing template

```vb
Public Sub InsertBlock()
    Dim insertPoint(0 To 2) As Double
    insertPoint(0) = 10#: insertPoint(1) = 20#: insertPoint(2) = 0#
    
    'Get Block defination using block name
    Dim blockName As String
    blockName = "Mark1"
    
    ' Check if the block exists in the drawing
    On Error Resume Next
    Dim blockDef As AcadBlock
    Set blockDef = ThisDrawing.Blocks.Item(blockName)
    On Error GoTo 0
    
    If blockDef Is Nothing Then
        MsgBox "Block '" & blockName & "' does not exist in the drawing.", vbExclamation
        Exit Sub
    End If
    
    'Create New block reference
    Dim xScale As Double, yScale As Double, zScale As Double, rotationInRadian As Double
    xScale = 1: yScale = 1: zScale = 1
    rotationInRadian = 0
    
    Dim blockRef As AcadBlockReference
    Set blockRef = ThisDrawing.ModelSpace.InsertBlock(insertPoint, blockName, xScale, yScale, zScale, rotationInRadian)
End Sub

```

### Insert Block with Attributes
- In my drawing i have `Pole` Block with `TEST` Attribute
- This is sample code to insert `Pole` block reference with `TEST` Attribute set to `Hello World`

```vb
Public Sub InsertBlockWithAttributes()
 
    Dim insertPoint(0 To 2) As Double
    insertPoint(0) = 10#: insertPoint(1) = 20#: insertPoint(2) = 0#
    
    'Get Block defination using block name
    Dim blockName As String
    blockName = "Pole"
    
    ' Check if the block exists in the drawing
    On Error Resume Next
    Dim blockDef As AcadBlock
    Set blockDef = ThisDrawing.Blocks.Item(blockName)
    On Error GoTo 0
    
    If blockDef Is Nothing Then
        MsgBox "Block '" & blockName & "' does not exist in the drawing.", vbExclamation
        Exit Sub
    End If
    
    'Create New block reference
    Dim xScale As Double, yScale As Double, zScale As Double, rotationInRadian As Double
    xScale = 1: yScale = 1: zScale = 1
    rotationInRadian = 0
    
    Dim blockRef As AcadBlockReference
    Set blockRef = ThisDrawing.ModelSpace.InsertBlock(insertPoint, blockName, xScale, yScale, zScale, rotationInRadian)

    'Update attributes
    Dim ATTRIB_LIST  As Variant
    Dim attributeRef As AcadAttributeReference
    If blockRef.HasAttributes Then
        ATTRIB_LIST = blockRef.GetAttributes
        Set attributeRef = ATTRIB_LIST(0)
        If attributeRef.TagString = "TEST" Then
            attributeRef.TextString = "Hello World"
        End If
    End If
    
End Sub

```

### Create New Block
```vb
Public Sub CreateNewBlock()
    'block base point
    Dim basePoint(0 To 2) As Double
    basePoint(0) = 0#: basePoint(1) = 0#: basePoint(2) = 0#
    
    Dim blockName As String
    blockName = "Mark3"
    
    ' Check if the block exists in the drawing
    On Error Resume Next
    Dim blockDef As AcadBlock
    Set blockDef = ThisDrawing.Blocks.Item(blockName)
    On Error GoTo 0
    
    If Not blockDef Is Nothing Then
        MsgBox "Block '" & blockName & "' already exists.", vbExclamation
        Exit Sub
    End If
    
    'Create new block defination
    Set blockDef = ThisDrawing.Blocks.Add(basePoint, blockName)
    
    'Add new objects to block
    Dim circle1 As AcadCircle, circle2 As AcadCircle
    Dim radius1 As Double, radius2 As Double
    radius1 = 2: radius2 = 4
    
    Set circle1 = blockDef.AddCircle(basePoint, radius1)
    Set circle2 = blockDef.AddCircle(basePoint, radius2)

    'Create New block reference
    Dim xScale As Double, yScale As Double, zScale As Double, rotationInRadian As Double
    xScale = 1: yScale = 1: zScale = 1
    rotationInRadian = 0
    
    Dim blockRef As AcadBlockReference
    Set blockRef = ThisDrawing.ModelSpace.InsertBlock(basePoint, blockName, xScale, yScale, zScale, rotationInRadian)
End Sub
```

> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1ifcb51/getting_started_with_autocad_vba_6_insert_blocks/)
{: .prompt-info }





