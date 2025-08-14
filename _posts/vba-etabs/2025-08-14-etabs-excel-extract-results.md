---
title: How to Extract Results from ETABS to Excel Using VBA
description: Learn to use the ETABS API to extract results to Excel
date: 14-08-2025
categories: [VBA, VBA-ETABS]
tag: [excel, etabs, vba, how to]
image: /assets/images/etabs/excel-vba-etabs-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to extract data from an ETABS model using Excel VBA.
- Why automate this process?
  - You can extract multiple results from different sections.
  - You can perform post-processing on the original results to convert them into your desired format.
  - Integrate the results extraction code with your design sheet for a simpler workflow.
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


## Extract Results

#### Link Excel with ETABS using VBA
- First, you have to add a reference for the ETABS API:
  - Open the VBA Editor > Tools > References Dialog.
  - Find `ETABS Application Programming Interface (API) v1` and make sure it's checked.

> I am using ETABS v22, but this code should work for ETABS version 18 and above.
> For older versions, you have to add the reference `ETABS v16 Application Programming Interface (API)` (version specific to your ETABS)
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
#### Support Reactions
```visualbasic
'Deselect all cases and combos
etModel.Results.Setup.DeselectAllCasesAndCombosForOutput

'Select Load Case
loadCaseName = "Dead"
etModel.Results.Setup.SetCaseSelectedForOutput loadCaseName

'Get joint reactions
Dim itemType As eItemTypeElm
Dim numberResults As Long
Dim objectIds() As String, elementIds() As String, loadCase() As String
Dim stepType() As String, stepNum() As Double
Dim fx() As Double, fy() As Double, fz() As Double, mx() As Double, my() As Double, mz() As Double

nodeId = 20
itemType = eItemTypeElm_Element
'This retrieves the reaction forces and moments at the specified joint for all selected load cases
etModel.Results.JointReact nodeId, itemType, numberResults, objectIds, elementIds, loadCase, stepType, stepNum, fx, fy, fz, mx, my, mz

'Print Joint Reactions
'Divide results by 1000 to convert N to KN
GetNextCell().Value = fx(0) / 1000
GetNextCell().Value = fy(0) / 1000
GetNextCell().Value = fz(0) / 1000
GetNextCell().Value = mx(0) / 1000
GetNextCell().Value = my(0) / 1000
GetNextCell().Value = mz(0) / 1000
```
#### Section Forces
```visualbasic
'Deselect all cases and combos
etModel.Results.Setup.DeselectAllCasesAndCombosForOutput

'Select Load Case
loadCaseName = "Dead"
etModel.Results.Setup.SetCaseSelectedForOutput loadCaseName
    
'Get beam section forces
Dim itemType As eItemTypeElm
Dim numberResults As Long
Dim objectIds() As String, objectDistances() As Double, elementIds() As String, elementDistances() As Double, loadCase() As String
Dim stepType() As String, stepNum() As Double
Dim p() As Double, v2() As Double, v3() As Double, t() As Double, m2() As Double, m3() As Double

beamId = 63
itemType = eItemTypeElm_Element

'This retrieves the section forces for the specified element and all selected load cases
etModel.Results.FrameForce beamId, itemType, numberResults, objectIds, objectDistances, elementIds, elementDistances, loadCase, stepType, stepNum, p, v2, v3, t, m2, m3

'Loop through All points and print results
For i = 0 To numberResults - 1
    'Location from Beam Start i
    GetNextCell().Value = "Location @ " & elementDistances(i) / 1000
    'Print the results for each beam
    GetNextCell().Value = p(i) / 1000    'Axial Force (kN)
    GetNextCell().Value = v2(i) / 1000   'Shear Force V2 (kN)
    GetNextCell().Value = v3(i) / 1000   'Shear Force V3 (kN)
    GetNextCell().Value = t(i) / 1000000    'Torsional Moment (kN-m)
    GetNextCell().Value = m2(i) / 1000000   'Bending Moment M2 (kN-m)
    GetNextCell().Value = m3(i) / 1000000   'Bending Moment M3 (kN-m)
Next
```
#### Node Displacement
```visualbasic
'Deselect all cases and combos
etModel.Results.Setup.DeselectAllCasesAndCombosForOutput

'Select Load Case
loadCaseName = "Dead"
etModel.Results.Setup.SetCaseSelectedForOutput loadCaseName
    
'Get Joint displacement
Dim itemType As eItemTypeElm
Dim numberResults As Long
Dim objectIds() As String, elementIds() As String, loadCase() As String
Dim stepType() As String, stepNum() As Double
Dim ux() As Double, uy() As Double, uz() As Double, rx() As Double, ry() As Double, rz() As Double

nodeId = 64
itemType = eItemTypeElm_Element
etModel.Results.JointDispl  nodeId, itemType, numberResults, objectIds, elementIds, loadCase, stepType, stepNum, ux, uy, uz, rx, ry, rz

'Print displacement in mm
GetNextCell().Value= ux(0)
GetNextCell().Value= uy(0)
GetNextCell().Value= uz(0)
GetNextCell().Value= rx(0)
GetNextCell().Value= ry(0)
GetNextCell().Value= rz(0)
```
## Conclusion
- Using a VBA macro to extract results is one of the most popular use cases.
- There is no major downside to this automation.
- The only downside I can think of is that you’ll need a good system to identify each element and load.