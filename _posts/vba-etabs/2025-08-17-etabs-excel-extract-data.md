---
title: How to Extract Model Data from ETABS to Excel Using VBA
description: Learn to use the ETABS API to extract model data to Excel
date: 17-08-2025
categories: [VBA, VBA-ETABS]
tag: [excel, etabs, vba, how to]
image: /assets/images/etabs/excel-vba-etabs-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to extract data from an ETABS model using Excel VBA.
- Why automate this process?
  - You can use this approach together with your results extraction code or model generation.
  - Integrate your model with your design sheet.
- I am assuming that:
  - You have basic knowledge of VBA and know how to add modules and create new subs.
  - You’re familiar with ETABS and know how to check results manually to compare them with the code output.

## Setup
- We are going to use two files:
- ETABS Model:
  - Create a simple ETABS model with a 4x4 grid and 5m spacing, 4 stories.
  - Assign elements: Beam, Column, Slab, and supports.
  - Apply Loads and Load Combinations: Dead Load, Live Load, Floor Load, Wall Load.
- Excel:
  - Create a macro-enabled Excel file.
  - We are going to print all results in the active sheet, column A.
  - Use the sample code below to print your output.

    ```visualbasic
    Sub GetResults()
        'Clear All Previous Results
        ActiveSheet.Range("A1").CurrentRegion.ClearContents

        'You can print your output using GetNextCell() Function
        GetNextCell().Value = "Hello, My Name is Vivek"
        GetNextCell().Value = "This is a demo for ETABS API using Excel VBA"
    End Sub

    ' Function to get the next empty cell in column A
    Private Function GetNextCell() As Range
        If ActiveSheet.Range("A1").CurrentRegion.Rows.Count = 1 And IsEmpty(ActiveSheet.Range("A1")) Then
            Set GetNextCell = ActiveSheet.Range("A1")
        Else
            Set GetNextCell = ActiveSheet.Cells(ActiveSheet.Range("A1").CurrentRegion.Rows.Count + 1, 1)
        End If
    End Function
    ```

## Extract Model Data

#### Link Excel with ETABS using VBA
- First, you have to add a reference for the ETABS API:
  - Open the VBA Editor > Tools > References Dialog.
  - Find `ETABS Application Programming Interface (API) v1` and make sure it's checked.

> I am using ETABS v22, but this code should work for ETABS version 18 and above.
> For older versions, you have to add the reference `ETABS v16 Application Programming Interface (API)` (version specific to your ETABS).
{: .prompt-info }

```visualbasic
Sub GetResults()
    'Clear All Previous Results
    ActiveSheet.Range("A1").CurrentRegion.ClearContents

    'Get ETABS API Object
    Dim etApp As ETABSv1.cOAPI
    Set etApp = GetObject(, "CSI.ETABS.API.ETABSObject")

    'Get ETAB Model, this is also compatible with ETABS
    Dim etModel As ETABSv1.cSapModel
    Set etModel = etApp.sapModel

    'Commonly Used Variables
    'Using Long types instead of Integer to use this with OpenSTAAD
    Dim i As Long, j As Long
    Dim nodeId  As Long, beamId As Long, loadCaseName As String

    '<<< Add Remaining Code Here >>>
End Sub
```

#### Load Patterns
```visualbasic
'Get list of all load patterns
Dim numberOfLoadPatterns As Long, LoadPatterns() As String
etModel.LoadPatterns.GetNameList numberOfLoadPatterns, LoadPatterns

'Loop through all load patterns and print load pattern name
For i = 0 To numberOfLoadPatterns - 1
    GetNextCell().Value = LoadPatterns(i)
Next i
```
#### Load Combinations
```visualbasic
'Get list of all load combinations
Dim numberOfLoadCombinations As Long, LoadCombinations() As String
etModel.RespCombo.GetNameList numberOfLoadCombinations, LoadCombinations

'Loop through all load combinations and print load combination name
For i = 0 To numberOfLoadCombinations - 1
    GetNextCell().Value = LoadCombinations(i)
Next i
```

#### Story Data
Get the number and names of all stories:
```visualbasic
'Get All story data
Dim NumberOfStories As Long, StoryNames() As String
etModel.SapModel.GetStoryList NumberOfStories, StoryNames

'Loop through all stories and print story name
For i = 0 To NumberOfStories - 1
    GetNextCell().Value = StoryNames(i)
Next i
```
Get story data with each story name, elevation, and height
```visualbasic
'Get All story data
Dim BaseElevation As Double
Dim NumberStories As Long
Dim StoryNames() As String
Dim StoryElevations() As Double
Dim StoryHeights() As Double
Dim IsMasterStory() As Boolean
Dim SimilarToStory() As String
Dim SpliceAbove() As Boolean
Dim SpliceHeight() As Double
Dim color() As Long

etModel.Story.GetStories_2 BaseElevation, NumberStories, StoryNames, StoryElevations, StoryHeights, IsMasterStory, SimilarToStory, SpliceAbove, SpliceHeight, color

'Print all story data
For i = 0 To NumberStories - 1
    GetNextCell().Value = StoryNames(i) ' name
    GetNextCell().Value = StoryElevations(i) ' elevation
    GetNextCell().Value = StoryHeights(i) ' height
Next i
```
#### Joints
```visualbasic
'Get All Joint Node Id for Base Story
Dim NumberOfJointNodes As Long, JointNodeNames() As String
etModel.PointObj.GetNameListOnStory "Base", NumberOfJointNodes, JointNodeNames

'Loop through all joint nodes and print joint node name
For i = 0 To NumberOfJointNodes - 1
    GetNextCell().Value = JointNodeNames(i)
Next i
```
#### Frame Elements
Get all frame element IDs
```visualbasic
'Get All Frame Objects
Dim numberOfFrameElements As Long, frameElements() As String

'Get all frame object names
etModel.FrameObj.GetNameList numberOfFrameElements, frameElements

'Loop through all object and print their IDs
For i = 0 To numberOfFrameElements - 1
    GetNextCell().Value = frameElements(i)
Next i
```

Get column elements
```visualbasic
'Get All Frame Objects
Dim numberOfFrameElements As Long, frameElements() As String
Dim frameType As eFrameDesignOrientation

'Get all frame object names
etModel.FrameObj.GetNameList numberOfFrameElements, frameElements

'Loop through all object and print their IDs if it's column
For i = 0 To numberOfFrameElements - 1
    'Get frame type to check if it's a column
    etModel.FrameObj.GetDesignOrientation frameElements(i), frameType

    'Check if frame is vertical (column)
    If frameType = eFrameDesignOrientation.eFrameDesignOrientation_Column Then
        GetNextCell().Value = frameElements(i)
    End If
Next i
```

Get beam elements
```visualbasic
'Get All Frame Objects
Dim numberOfFrameElements As Long, frameElements() As String
Dim frameType As eFrameDesignOrientation

'Get all frame object names
etModel.FrameObj.GetNameList numberOfFrameElements, frameElements

'Loop through all object and print their IDs if it's beam
For i = 0 To numberOfFrameElements - 1
    'Get frame type to check if it's a column
    etModel.FrameObj.GetDesignOrientation frameElements(i), frameType

    'Check if frame is beam
    If frameType = eFrameDesignOrientation.eFrameDesignOrientation_Beam Then
        GetNextCell().Value = frameElements(i)
    End If
Next i
```
#### Shell Elements
```visualbasic
'Get all shell element names
etModel.AreaObj.GetNameList numberOfSlabs, SlabNames

'Loop through all shell elements and write their names/IDs
For i = 0 To numberOfSlabs - 1
    GetNextCell().Value = SlabNames(i)
Next i
```
#### Selected objects
```visualbasic
'Get selected frame objects
Dim numberOfSelectedObjects As Long
Dim ObjectType() As Long, ObjectName() As String

' Get all selected objects
etModel.SelectObj.GetSelected numberOfSelectedObjects, ObjectType, ObjectName

'Loop through all joint objects in the model
GetNextCell().Value = "Joint Objects"
For i = 0 To numberOfSelectedObjects - 1
    If ObjectType(i) = 1 Then ' 1 = Joint object 
        GetNextCell().Value = ObjectName(i)
    End If
Next i

' Loop through all selected objects and filter for frame objects
GetNextCell().Value = "Frame Objects"
For i = 0 To numberOfSelectedObjects - 1
    If ObjectType(i) = 2 Then ' 2 = Frame object
        GetNextCell().Value = ObjectName(i)
    End If
Next i

' Loop through all selected objects and filter for slab objects
GetNextCell().Value = "Slab Objects"
For i = 0 To numberOfSelectedObjects - 1
    If ObjectType(i) = 5 Then ' 5 = Slab object
        GetNextCell().Value = ObjectName(i)
    End If
Next i
```

#### Section Data
```visualbasic
'Extract Section Data
Dim elementID As Long, sectionName As String, materialName As String

elementID = 1
GetNextCell().Value = elementID

'Get section name from elementID
etModel.FrameObj.GetSection elementID, sectionName, ""
GetNextCell().Value = sectionName

'Get material name from section
etModel.PropFrame.GetMaterial sectionName, materialName
GetNextCell().Value = materialName'Material

'Section Type and Size
Dim sectionType As eFramePropType, sectionSize As String
Dim t3 As Double, t2 As Double, Color As Long, Notes As String, GUID As String

'Get Section Type
etModel.PropFrame.GetTypeOAPI sectionName, sectionType

'If rectangular section then width and depth
If sectionType = eFramePropType.eFramePropType_Rectangular Then
    'Get rectangle section size
    etModel.PropFrame.GetRectangle sectionName, "", materialName, t3, t2, Color, Notes, GUID
    GetNextCell().Value = t2'Width
    GetNextCell().Value = t3'Depth

    'Get rectangle frame length
    Dim elementLength As Double
    Dim iNode As String, jNode As String
    Dim x1 As Double, y1 As Double, z1 As Double
    Dim x2 As Double, y2 As Double, z2 As Double

    'Get element end nodes
    etModel.FrameObj.GetPoints elementID, iNode, jNode

    'Get coordinates of frame end points
    etModel.PointObj.GetCoordCartesian iNode, x1, y1, z1
    etModel.PointObj.GetCoordCartesian jNode, x2, y2, z2

    'Calculate length using distance formula
    elementLength = Sqr((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
    GetNextCell().Value = elementLength 'Element Length
End If
```

## Conclusion
- Extracting data from ETABS is a perfect way to integrate your model with your design sheet.
- Additionally, this approach works perfectly with code for extracting results.