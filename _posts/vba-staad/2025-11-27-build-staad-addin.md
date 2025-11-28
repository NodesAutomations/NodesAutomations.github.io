---
title: Build STAAD Addin using Visual basic script
description: Use STAAD User Tools to extend STAAD functionality using Visual Basic script
date: 27-11-2025
categories: [VBA, VBA-STAAD]
tag: [staad, vba, openstaad, how to]
image: /assets/images/staad/build-staad-addin.webp
---

## Overview
- In this tutorial, I'll show you how to use Visual Basic script to create a STAAD addin
- What is User Tools?
  - STAAD User Tools allows you to extend STAAD functionality using Visual Basic script
  - You can access it from Utilities > User Tools
- Why use this method?
  - Doesn't require any setup or external tools; it's built into STAAD
  - Better workflow, since you can't directly run your script from STAAD
  - It's older technology with limited functionality, making it more LLM friendly
- I am assuming that:
  - You have basic knowledge of Visual Basic script and know how to create new subs and functions
  - Keep in mind that Visual Basic script is a bit different from Excel VBA; syntax is similar, but VBA has much more functionality

## Setup
- Create a new text file with *.vbs extension
- For this tutorial, I am creating `Test.vbs` file
- Add the sample code below and save the file
- Open any STAAD model, go to Utilities > User Tools > Configure
- Add a new menu item, name it "Test VBS", and in the command input, select the `Test.vbs` file and click OK to save
- Now you can run this code from Utilities > User Tools > User Tools > `Test VBS`

```vb
Sub Main
    MsgBox "Test.vbs is running successfully!", vbInformation, "Test Script"
End Sub
```
![1](../assets/images/staad/build-staad-addin-1.webp)


## Get Inputs

### Input Box
- You can use an input box to get single inputs from the user
- By default, it will return a string, so you have to convert it to double or integer as per your requirements
  
```vb
Sub Main()
    Dim inputValue As String
    inputValue = InputBox("Text", "Input Box")

    MsgBox inputValue, vbInformation, "Input Received"
End Sub
```

### User Form
- More suitable for multiple inputs
- You can refer to this video for more complex code: [Modelling Intze Tank Geometry using User Tool in STAAD.Pro](https://www.youtube.com/watch?v=Az1E9Qaq4UY)

```vb
Sub Main()

Begin Dialog ModelInputs 200,140,"Model Inputs" ' %GRID:10,7,1,1
    GroupBox 10,0,180,105,"Geometry Inputs",.GeometryInputsGroupBox
    Text 25,20,70,14,"Length"
    TextBox 100,20,70,14,.LengthTextBox
    Text 25,50,70,14,"Width"
    TextBox 100,50,70,14,.WidthTextBox
    Text 25,80,70,14,"Height"
    TextBox 100,80,70,14,.HeightTextBox
    OKButton 20,110,80,20,.OKButton
    CancelButton 110,110,80,20,.CancelButton
End Dialog

'Create new dialog instance
Dim dlg As ModelInputs
dlg.LengthTextBox = "10"
dlg.WidthTextBox = "5"
dlg.HeightTextBox = "3"

Dim result As Integer
result = Dialog (dlg)

Dim volume As Double
If result = -1 Then
    volume = CDbl(dlg.LengthTextBox) * CDbl(dlg.WidthTextBox) * CDbl(dlg.HeightTextBox)
    MsgBox "Length: " & dlg.LengthTextBox & vbCrLf & _
           "Width: " & dlg.WidthTextBox & vbCrLf & _
           "Height: " & dlg.HeightTextBox & vbCrLf & _
           "Volume: " & volume
End If

End Sub
```

## Generate Model
- You can use this post [Automate STAAD model from Excel using OpenSTAAD](/posts/openstaad-generate-model) for the full version

```vb
Sub Main
    'Create OpenSTAAD Object
    Dim objOpenSTAAD As Object
    Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")

    'Add nodes with node IDs 1 and 2
    objOpenSTAAD.Geometry.CreateNode 1, 0, 0, 0
    objOpenSTAAD.Geometry.CreateNode 2, 3#, 0#, 0#

    'Add beam with ID 1 connecting nodes 1 and 2
    objOpenSTAAD.Geometry.CreateBeam 1, 1, 2

    'Create rectangular section
    Dim width As Double, depth As Double
    Dim beamNo As Long
    Dim sectionPropertyNo As Long
    width = 0.3
    depth = 0.3
    beamNo = 1
    sectionPropertyNo = objOpenSTAAD.Property.CreatePrismaticRectangleProperty(depth, width)
    objOpenSTAAD.Property.AssignBeamProperty beamNo, sectionPropertyNo

    'Create fixed support
    Dim supportNo As Long
    supportNo = objOpenSTAAD.Support.CreateSupportFixed

    'Assign support at nodes 1 and 2
    objOpenSTAAD.Support.AssignSupportToNode 1, supportNo
    objOpenSTAAD.Support.AssignSupportToNode 2, supportNo

    ' Clean up
    Set objShell = Nothing
    Set objOpenSTAAD = Nothing
End Sub
```

## Extract Results
- This is sample code to display node results
- I am using fake data to display a report table
- You can use the OpenSTAAD API to extract results as per your requirements
- You can refer to this post for sample code on how to extract results using OpenSTAAD: [How to Extract Results from STAAD to Excel Using VBA](/posts/staad-excel-extract-results)

```vb
Sub Main()
'Create OpenSTAAD Object
Dim objOpenSTAAD As Object
Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")

Dim reportID As Long, tableID As Long, numRows As Long, numCols As Long

numRows = 5
numCols = 2

' Create report
reportID = objOpenSTAAD.Table.CreateReport("Reports")

' Add table to report
tableID = objOpenSTAAD.Table.AddTable(reportID, "Support Reactions", numRows, numCols)

' Set column headers
objOpenSTAAD.Table.SetColumnHeader reportID, tableID, 1, "Node No."
objOpenSTAAD.Table.SetColumnHeader reportID, tableID, 2, "FY (kN)"

' Fill table with data
Dim i As Long
For i = 1 To numRows
    objOpenSTAAD.Table.SetCellValue reportID, tableID, i, 1, CStr(i + 1)
    objOpenSTAAD.Table.SetCellValue reportID, tableID, i, 2, CStr(i * 10)
Next i

End Sub
```

## Run External Program from STAAD
- You can use this code to run your external program directly from STAAD
- If it's a Python script, convert it into an exe file and you can run it via STAAD

```vb
Sub Main

    'Create OpenSTAAD Object
    Dim objOpenSTAAD As Object
    Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")
  
    'Check if model is open
    Dim stdFilePath As String
    objOpenSTAAD.GetSTAADFile stdFilePath, True

    If stdFilePath = "" Then
        'Model is not open; exit sub
        MsgBox "No Active Model Found. Please open a STAAD model and retry.", vbExclamation, "No Active Model"
        Set objOpenSTAAD = Nothing
        Exit Sub
    End If
    
    'Create Shell object
    Dim objShell
    Set objShell = CreateObject("WScript.Shell")
    
    ' Get application path
    Dim applicationPath
    applicationPath = "C:\SampleApp\Console.exe"
 
    ' Construct the command to open the STAAD model
    Dim command
    command = """" & applicationPath & """ """ & stdFilePath & """"
    
    ' Execute the command to open STAAD.Pro with the specified model
    objShell.Run command, 1, False
    
    ' Clean up
    Set objShell = Nothing
    Set objOpenSTAAD = Nothing
    
End Sub
```

## Conclusion
- You can build small tools to assist with your regular tasks using STAAD Visual Basic script since it doesn't require any setup or admin permission
- I personally prefer not to code using Visual Basic script since it's quite old, so I usually just use it to call my exe file
- For large model generation or results extraction, running the script can be very slow, so my advice is to minimize STAAD while running your script to speed up execution
- I'll try to keep this updated with more variations and use cases

