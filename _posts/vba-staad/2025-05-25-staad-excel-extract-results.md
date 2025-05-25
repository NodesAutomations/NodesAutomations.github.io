---
title: How to Extract Results from STAAD to Excel Using VBA
description: Use OpenSTAAD API to extract results from a STAAD model
date: 25-05-2025
categories: [VBA, VBA-STAAD]
tag: [excel, staad, vba, openstaad, how to]
image: /assets/images/staad/excel-vba-staad-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to extract results from the active STAAD model to your Excel file.
- Why automate this process?
  - You can extract multiple results from different sections.
  - You can perform post-processing on original results to convert them into your desired format.
  - Integrate results extraction code with your design sheet for a simpler workflow.
- I am assuming that:
  - You have a basic knowledge of VBA and know how to add modules and create new subs.
  - You're familiar with STAAD and know how to check results manually to compare them with the code output.
- [OpenSTAAD Reference](https://docs.bentley.com/LiveContent/web/STAAD.Pro%20Help-v14/en/OpenSTAAD_HELP_HOME.html)
- If you're using STAAD CONNECT Edition, you can open `File > Help > OpenSTAAD Help`. These docs are better than the online version.

## Setup
- We are going to use two files:
- STAAD Model
  - For this tutorial, we're just going to use a single-span fixed beam. Just copy this [STAAD Model](#fixed-beam-staad-model).
  - You're free to use any model you like but make sure that you can verify output results to simplify your testing.
- Excel 
  - Create a macro-enabled Excel file.
  - We are going to print all results in the active sheet, column A.
  - Use the sample code below to print your output.

```visualbasic
Sub GetResults()
    'Clear All Previous Results
    ActiveSheet.Range("A1").CurrentRegion.ClearContents

    'You can print your output using GetNextCell() Function
    GetNextCell().Value = "Hello, My Name is Vivek"
    GetNextCell().Value = "This is a demo for STAAD OpenSTAAD API using Excel VBA"
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

#### Link Excel with STAAD using VBA
```visualbasic
Sub GetResults()
    'Clear All Previous Results
    ActiveSheet.Range("A1").CurrentRegion.ClearContents

    'Create OpenSTAAD Object
    Dim objOpenSTAAD As Object
    Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")

    'Commonly Used Variables
    'Using Long types instead of Integer to use this with OpenSTAAD
    Dim i As Long, j As Long 
    Dim nodeId As Long, beamId As Long, loadCaseId As Long

    '<<< Add Remaining Code Here >>>
End Sub
```

#### Support Reactions
```visualbasic
'Populate Support Reaction Array for Node 1 in Load Case 1
nodeId = 1
loadCaseId = 1
Dim supportReactions(6) As Double
objOpenSTAAD.Output.GetSupportReactions nodeId, loadCaseId, supportReactions

'Print Support Reactions in sequence of Fx, Fy, Fz, Mx, My, Mz
GetNextCell().Value = "Support Reactions for Node: " & nodeId & ", Load Case: " & loadCaseId
'Divide by 9.80665 to convert kN to MTon
GetNextCell().Value = supportReactions(0) / 9.80665 'Fx
GetNextCell().Value = supportReactions(1) / 9.80665 'Fy
GetNextCell().Value = supportReactions(2) / 9.80665 'Fz
GetNextCell().Value = supportReactions(3) / 9.80665 'Mx
GetNextCell().Value = supportReactions(4) / 9.80665 'My
GetNextCell().Value = supportReactions(5) / 9.80665 'Mz
```

#### Section Forces (Axial Force, Shear Force, Bending Moments)
```visualbasic
'Print Beam Length
Dim beamLength As Double
beamId = 1 
beamLength = objOpenSTAAD.Geometry.GetBeamLength(beamId)
GetNextCell().Value = "Beam Length: " & beamLength

'Calculate distance from Start of Beam
Dim distance As Double
distance = 0.5 * beamLength 'Mid-Span

'Print Beam Section Forces at Mid-Span
beamId = 1 
loadCaseId = 1
Dim sectionForces(6) As Double
objOpenSTAAD.Output.GetIntermediateMemberForcesAtDistance beamId, distance, loadCaseId, sectionForces

'Print Section Forces in sequence of Axial, Shear Y, Shear Z, Moment X, Moment Y, Moment Z
GetNextCell().Value = "Beam Section Forces at Mid-Span for Beam: " & beamId & ", Load Case: " & loadCaseId
'Divide by 9.80665 to convert kN to MTon
GetNextCell().Value = sectionForces(0) / 9.80665 'Axial
GetNextCell().Value = sectionForces(1) / 9.80665 'Shear Y
GetNextCell().Value = sectionForces(2) / 9.80665 'Shear Z
GetNextCell().Value = sectionForces(3) / 9.80665 'Moment X
GetNextCell().Value = sectionForces(4) / 9.80665 'Moment Y
GetNextCell().Value = sectionForces(5) / 9.80665 'Moment Z
```

- By default, STAAD divides each section into 12 parts, so it will show you section forces at 13 points for each load.
- If you need results in this format, use the sample code below.

```visualbasic
'Print Section Forces at 12 equally spaced points along the beam
GetNextCell().Value = "Beam Section Forces at 12 equally spaced points along the beam for Beam: " & beamId & ", Load Case: " & loadCaseId
For i = 0 To 12
    distance = i * beamLength / 12
    objOpenSTAAD.Output.GetIntermediateMemberForcesAtDistance beamId, distance, loadCaseId, sectionForces
    GetNextCell().Value = sectionForces(0) & "," & sectionForces(1) & "," & sectionForces(2) & "," & sectionForces(3) & "," & sectionForces(4) & "," & sectionForces(5)
Next
```

#### Plate Stresses and Moments
- Not relevant to this beam model, but here is sample code to extract plate stresses and moments.

```visualbasic
'Populate Plate Center Stresses and Moments for Plate 1 in Load Case 1
Dim plateId As Long
plateId = 1
loadCaseId = 1

Dim plateStresses(8) As Double
objOpenSTAAD.Output.GetAllPlateCenterStressesAndMoments plateId, loadCaseId, plateStresses
GetNextCell().Value = plateStresses(0) / 9.80665 'SQx
GetNextCell().Value = plateStresses(1) / 9.80665 'SQy
GetNextCell().Value = plateStresses(2) / 9.80665 'Mx
GetNextCell().Value = plateStresses(3) / 9.80665 'My
GetNextCell().Value = plateStresses(4) / 9.80665 'Mxy
GetNextCell().Value = plateStresses(5) / 9.80665 'Sx
GetNextCell().Value = plateStresses(6) / 9.80665 'Sy
GetNextCell().Value = plateStresses(7) / 9.80665 'Sz
```

#### Node Displacement
- Not relevant to this model, but deflection check is a common design requirement.

```visualbasic
'Populate Displacement Array for Node 1 in Load Case 1
nodeId = 1
loadCaseId = 1
Dim displacements(6) As Double
objOpenSTAAD.Output.GetNodeDisplacements nodeId, loadCaseId, displacements
GetNextCell().Value = "Node " & nodeId & " Displacements in Load Case " & loadCaseId
GetNextCell().Value = "Dx: " & displacements(0)
GetNextCell().Value = "Dy: " & displacements(1)
GetNextCell().Value = "Dz: " & displacements(2)
GetNextCell().Value = "Rx: " & displacements(3)
GetNextCell().Value = "Ry: " & displacements(4)
GetNextCell().Value = "Rz: " & displacements(5)
```

#### Get Model Unit
- Checking the model unit is not required in most cases since the user will already know the units of their model.
- Knowing model units may come in handy when you're working with a model from an external source or making a generalized tool.

```visualbasic
'Print Model Unit
'Return value (1 for English system, 2 for Metric system)
Dim baseUnit As String
baseUnit = objOpenSTAAD.GetBaseUnit
GetNextCell().Value = "Base Unit: " & baseUnit

'Print Length Unit for Length
'Return value  (0- Inch, 1- Feet, 2- Feet, 3- Centimeter, 4- Meter, 5- Millimeter, 6- Decimeter, 7 – Kilometer)
Dim lengthUnit As String
lengthUnit = objOpenSTAAD.GetInputUnitForLength
GetNextCell().Value = "Model Unit: " & lengthUnit

'Print Force Unit for Force
'Return value (0- Kilopound, 1- Pound, 2- Kilogram, 3- Metric Ton, 4- Newton, 5- Kilonewton, 6- Meganewton, 7- Decanewton)
Dim forceUnit As String
forceUnit = objOpenSTAAD.GetInputUnitForForce
GetNextCell().Value = "Force Unit: " & forceUnit
```

## Fixed Beam STAAD Model

```text
STAAD SPACE
START JOB INFORMATION
ENGINEER DATE 15-May-25
END JOB INFORMATION
INPUT WIDTH 79
UNIT METER MTON
JOINT COORDINATES
1 0 0 0; 2 3 0 0;
MEMBER INCIDENCES
1 1 2;
DEFINE MATERIAL START
ISOTROPIC CONCRETE
E 2.21467e+006
POISSON 0.17
DENSITY 2.40262
ALPHA 1e-005
DAMP 0.05
TYPE CONCRETE
STRENGTH FCU 2812.28
END DEFINE MATERIAL
MEMBER PROPERTY AMERICAN
1 PRIS YD 0.3 ZD 0.3
CONSTANTS
MATERIAL CONCRETE ALL
SUPPORTS
1 2 FIXED
LOAD 1 LOADTYPE None  TITLE DEAD LOAD
MEMBER LOAD
1 UNI GY -10
LOAD 2 LOADTYPE None  TITLE LIVE LOAD
MEMBER LOAD
1 CON GY -50 1.5 0
LOAD COMB 101 ULTIMATE LOAD
1 1.5 2 1.3 
PERFORM ANALYSIS
PERFORM ANALYSIS
FINISH
```

## Conclusion
- Using a VBA macro to extract results is one of the most popular use cases.
- There is no major downside to this automation.
- The only downside I can think of is that you'll need a good system to identify each element and loads.