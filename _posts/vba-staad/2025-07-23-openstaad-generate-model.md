---
title: Automate STAAD model from Excel using OpenSTAAD
description: Use OpenSTAAD API to generate/modify staad models
date: 23-07-2025
categories: [VBA, VBA-STAAD]
tag: [excel, staad, vba, openstaad, how to]
image: /assets/images/staad/excel-vba-staad-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to generate or modify a STAAD model using Excel VBA and OpenSTAAD
- What is OpenSTAAD?
  - It's a STAAD API library which allows you to access STAAD internal functions using VBA/C#/Python.
- Why OpenSTAAD API?
  - You can read data from the active model and modify it
  - Quick visual feedback - you will be able to see or verify all changes live
  - It's very hard to manipulate *.std files for complex models. OpenSTAAD allows us to break automation into multiple parts, allowing users to make minor adjustments as per project requirements 
- I am assuming that:
  - You have basic knowledge of VBA and know how to add modules and create new subs.

## Setup
- STAAD Model
  - For this tutorial, we're just going to generate a single-span fixed beam
  - You're free to use any model you like but make sure that you can verify output results to simplify your testing.
- Excel 
  - Create a macro-enabled Excel file.

## Generate New STAAD Model

#### Create New Model
- Make sure that your STAAD Application is open before running this macro
- The code below basically creates a new `Model.std` file in the active Excel sheet folder with specified units
- Additionally, we also need to close any existing STAAD file if a model is already open

```visualbasic
Sub GenerateModel()

    'Create OpenStaad Object
    Dim objOpenSTAAD As Object
    Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")
    
    'Check if model is open
    Dim stdFilePath As String
    objOpenSTAAD.GetSTAADFile stdFilePath, True
    
    'If model is open close model
    If stdFilePath <> "" Then
        objOpenSTAAD.CloseSTAADFile
    End If
 
    'Create New model
    stdFilePath = ThisWorkbook.Path & "\Model.std"
 
    '(0- Inch, 1- Feet, 2- Feet, 3- Centimeter, 4- Meter, 5- Millimeter, 6- Decimeter, 7 � Kilometer)
    Dim intInputUnitForLength As Integer
    intInputUnitForLength = 4                    ' 4 for meters

    '(0- Kilopound, 1- Pound, 2- Kilogram, 3- Metric Ton, 4- Newton, 5- Kilonewton, 6- Meganewton, 7- Decanewton)
    Dim intInputUnitForForce As Integer
    intInputUnitForForce = 3                     ' 3 for Metric Ton

    objOpenSTAAD.NewSTAADFile stdFilePath, intInputUnitForLength, intInputUnitForForce

    'Wait for 3 seconds for staad to create new model
    'modify this as per your system or staad version
    Dim waitTime As Double
    waitTime = Timer + 3
    Do While Timer < waitTime
        DoEvents
    Loop
    
    '<<< Add your remaining model code here >>>

    'Save model without any user prompt
    objOpenSTAAD.SaveModel 1
End Sub
```
#### Add Nodes and Beams
```visualbasic
'Add Nodes with node id 1 and 2
objOpenSTAAD.Geometry.CreateNode 1, 0, 0, 0
objOpenSTAAD.Geometry.CreateNode 2, 3#, 0#, 0#

'Add Beam with id 1 connecting the node 1 and 2
objOpenSTAAD.Geometry.CreateBeam 1, 1, 2
```
#### Add Material Properties
- This code will only work with the Connect Edition
- I can't find an API for the older version

```visualbasic
'Create material concrete
Dim materialName As String
Dim elasticity As Double
Dim poissonRatio As Double
Dim shearModulus As Double
Dim density As Double
Dim alpha As Double
Dim criticalDamp As Double
Dim fcu As Double
Dim bPhysical As Integer
materialName = "CONCRETE"
elasticity = 2214670
poissonRatio = 0.17
shearModulus = 0.06
density = 2.40262
alpha = 5e-05
criticalDamp = 0.05
fcu= 2812.28
bPhysical = 0
objOpenStaad.Property.CreateIsotropicMaterialConcrete  materialName, elasticity, poissonRatio, shearModulus, density, alpha, criticalDamp, fcu, bPhysical
```

#### Add Sections
Create Rectangular Section
```visualbasic
Dim width As Double, depth As Double
Dim beamNo as Long
Dim sectionPropertyNo as Long
width = 0.3  
depth = 0.3  
beamNo = 1
sectionPropertyNo = objOpenSTAAD.Property.CreatePrismaticRectangleProperty(depth, width) 
objOpenSTAAD.Property.AssignBeamProperty beamNo, sectionPropertyNo
```
Create Circular Section
```visualbasic
Dim sectionDia As Double
Dim beamNo As Long
Dim sectionPropertyNo As Long
sectionDia = 0.3
beamNo = 1
sectionPropertyNo = objOpenSTAAD.Property.CreatePrismaticCircleProperty(sectionDia)
objOpenSTAAD.Property.AssignBeamProperty beamNo, sectionPropertyNo
```
Create Prismatic Section
```visualbasic
Dim prismaticProperty(0 To 9) As Double
prismaticProperty(0) = 1.037 ' Ax
prismaticProperty(1) = 0#  ' Ay
prismaticProperty(2) = 0#  ' Az
prismaticProperty(3) = 0.102 ' Ix
prismaticProperty(4) = 0.041 ' Iy
prismaticProperty(5) = 0.25 ' Iz
prismaticProperty(6) = 0#  ' YD
prismaticProperty(7) = 0#  ' ZD
prismaticProperty(8) = 0#  ' YB
prismaticProperty(9) = 0#  ' ZB

Dim beamNo As Long
Dim sectionPropertyNo As Long
beamNo = 1
sectionPropertyNo = objOpenSTAAD.Property.CreatePrismaticGeneralProperty(prismaticProperty)
objOpenSTAAD.Property.AssignBeamProperty beamNo, sectionPropertyNo
```
#### Add Supports
Fixed Support
```visualbasic
Dim supportNo As Long
supportNo=objOpenSTAAD.Support.CreateSupportFixed

'Assign Support at node 1 and 2
objOpenSTAAD.Support.AssignSupportToNode 1, supportNo
objOpenSTAAD.Support.AssignSupportToNode 2, supportNo
```

Pinn Support
```visualbasic
supportNo=objOpenSTAAD.Support.CreateSupportPinned
```

Spring Support
```visualbasic
Dim release(5) As Double
release(0) = 0   'FX
release(1) = 0   'FY
release(2) = 0   'FZ
release(3) = 1   'MX
release(4) = 1   'MY
release(5) = 1   'MZ

Dim stiffness(5) As Double
stiffness(0) = 100'KFX
stiffness(1) = 200'KFY
stiffness(2) = 100'KFZ
stiffness(3) = 0'KMX
stiffness(4) = 0'KMY
stiffness(5) = 0'KMZ

Dim supportNo As Long
supportNo = objOpenSTAAD.Support.CreateSupportFixedBut(release, stiffness)
```

#### Add Loads
Create empty load case
```visualbasic
objOpenSTAAD.Load.CreateNewPrimaryLoad "Dead Load"

'<<Add your load code here>>
'<<You can use single load or multiple>>
```
Add UDL Load
```visualbasic
objOpenSTAAD.Load.CreateNewPrimaryLoad "UDL Load"
dim beamNo as Long
beamNo = 1
dim Direction as Integer
Direction = 5 ' 1 for Y direction
Dim udlForce As Double
udlForce = -2.0 ' use negative value for downward force
dim d1, d2, d3 as Double
d1 = 0.0
d2 = 0.0
d3 = 0.0
objOpenSTAAD.Load.AddMemberUniformForce beamNo, Direction, udlForce,d1, d2, d3
```

Add Nodal Load
```visualbasic
objOpenSTAAD.Load.CreateNewPrimaryLoad "Nodal Load"
dim nodeId as Long
nodeId = 1
dim fx as Double, fy as Double, fz as Double, mx as Double, my as Double, mz as Double
fx = 0.0
fy = -2.0
fz = 0.0
mx = 0.0
my = 0.0
mz = 0.0

objOpenSTAAD.Load.AddNodalLoad nodeId, fx, fy, fz,  mx, my, mz
```
#### Add Load Combinations
```visualbasic
Dim loadCombTitle as String
Dim loadCombNo as Long
loadCombTitle = "ULTIMATE LOAD"
loadCombNo = 101
objOpenSTAAD.Load.CreateNewLoadCombination loadCombTitle, loadCombNo

Dim loadCaseNo as Long
Dim loadFactor as Double
loadCaseNo = 1 ' Load Case ID for UDL Load
loadFactor = 1.5 ' Factor for UDL Load
'Add Load to Load Combination
objOpenSTAAD.Load.AddLoadAndFactorToCombination loadCombNo, loadCaseNo, loadFactor
loadCaseNo = 2 ' Load Case ID for Nodal Load
loadFactor = 1.2 ' Factor for Nodal Load
objOpenSTAAD.Load.AddLoadAndFactorToCombination loadCombNo, loadCaseNo, loadFactor
```

#### Optional code to check if STAAD Application is open
- This code is not essential but it will add a nice touch for new users
- This code will check if the STAAD Application is open before running the OpenSTAAD Macro
- This will prevent unnecessary confusion for new users

```visualbasic
Dim objShell As Object
Set objShell = CreateObject("WScript.Shell")

Dim isStaadRunning As Boolean
On Error Resume Next
isStaadRunning = objShell.AppActivate("STAAD.Pro") Or objShell.AppActivate("STAAD.Pro CONNECT Edition")
On Error GoTo 0

If Not isStaadRunning Then
    MsgBox "Please start STAAD.Pro before running this macro.", vbExclamation
    Exit Sub
End If
```

## Final Version with Excel inputs
```visualbasic
Sub GenerateModel()

    'Check if staad is running
    Dim objShell As Object
    Set objShell = CreateObject("WScript.Shell")

    Dim isStaadRunning As Boolean
    On Error Resume Next
    isStaadRunning = objShell.AppActivate("STAAD.Pro") Or objShell.AppActivate("STAAD.Pro CONNECT Edition")
    On Error GoTo 0

    If Not isStaadRunning Then
        MsgBox "Please start STAAD.Pro before running this macro.", vbExclamation
        Exit Sub
    End If

    'Create OpenStaad Object
    Dim objOpenSTAAD As Object
    Set objOpenSTAAD = GetObject(, "StaadPro.OpenSTAAD")
    
    'Check if model is open
    Dim stdFilePath As String
    objOpenSTAAD.GetSTAADFile stdFilePath, True
    
    'If model is open close model
    If stdFilePath <> "" Then
        objOpenSTAAD.CloseSTAADFile
    End If
 
    'Create New model
    stdFilePath = ThisWorkbook.Path & "\Model.std"
 
    '(0- Inch, 1- Feet, 2- Feet, 3- Centimeter, 4- Meter, 5- Millimeter, 6- Decimeter, 7 ? Kilometer)
    Dim intInputUnitForLength As Integer
    intInputUnitForLength = 4                    ' 4 for meters

    '(0- Kilopound, 1- Pound, 2- Kilogram, 3- Metric Ton, 4- Newton, 5- Kilonewton, 6- Meganewton, 7- Decanewton)
    Dim intInputUnitForForce As Integer
    intInputUnitForForce = 3                     ' 3 for Metric Ton

    objOpenSTAAD.NewSTAADFile stdFilePath, intInputUnitForLength, intInputUnitForForce

    'Wait for 3 seconds for staad to create new model
    'modify this as per your system or staad version
    Dim waitTime As Double
    waitTime = Timer + 3
    Do While Timer < waitTime
        DoEvents
    Loop
    
    'Add Nodes with node id 1 and 2
    objOpenSTAAD.Geometry.CreateNode 1, 0, 0, 0
    objOpenSTAAD.Geometry.CreateNode 2, 3#, 0#, 0#

    'Add Beam with id 1 connecting the node 1 and 2
    objOpenSTAAD.Geometry.CreateBeam 1, 1, 2

    'Create material concrete
    Dim materialName As String
    Dim elasticity As Double
    Dim poissonRatio As Double
    Dim shearModulus As Double
    Dim density As Double
    Dim alpha As Double
    Dim criticalDamp As Double
    Dim fcu As Double
    Dim bPhysical As Integer
    materialName = "CONCRETE"
    elasticity = 2214670
    poissonRatio = 0.17
    shearModulus = 0.06
    density = 2.40262
    alpha = 0.00005
    criticalDamp = 0.05
    fcu = 2812.28
    bPhysical = 0
    objOpenSTAAD.Property.CreateIsotropicMaterialConcrete materialName, elasticity, poissonRatio, shearModulus, density, alpha, criticalDamp, fcu, bPhysical
    
    'Create Rectangular Section
    Dim width As Double, depth As Double
    Dim beamNo As Long
    Dim sectionPropertyNo As Long
    width = 0.3
    depth = 0.3
    beamNo = 1
    sectionPropertyNo = objOpenSTAAD.Property.CreatePrismaticRectangleProperty(depth, width)
    objOpenSTAAD.Property.AssignBeamProperty beamNo, sectionPropertyNo

    'Create Fixed Support
    Dim supportNo As Long
    supportNo = objOpenSTAAD.Support.CreateSupportFixed

    'Assign Support at node 1 and 2
    objOpenSTAAD.Support.AssignSupportToNode 1, supportNo
    objOpenSTAAD.Support.AssignSupportToNode 2, supportNo

    'Add Primary Loads

    'Add Nodal Load
    objOpenSTAAD.Load.CreateNewPrimaryLoad "Nodal Load"
    Dim nodeId As Long
    nodeId = 1
    Dim fx As Double, fy As Double, fz As Double, mx As Double, my As Double, mz As Double
    fx = 0#
    fy = -2#
    fz = 0#
    mx = 0#
    my = 0#
    mz = 0#
   
    objOpenSTAAD.Load.AddNodalLoad nodeId, fx, fy, fz, mx, my, mz

    'Add Member Load
    objOpenSTAAD.Load.CreateNewPrimaryLoad "UDL Load"
   
    beamNo = 1
    Dim Direction As Integer
    Direction = 5 ' 1 for Y direction
    Dim udlForce As Double
    udlForce = -2#  ' use negative value for downward force
    Dim d1, d2, d3 As Double
    d1 = 0#
    d2 = 0#
    d3 = 0#
    objOpenSTAAD.Load.AddMemberUniformForce beamNo, Direction, udlForce, d1, d2, d3

    objOpenSTAAD.Load.CreateNewPrimaryLoad "UVL Load"
     Direction = 2 ' X direction = 1, Y direction = 2, Z direction = 3.
     Dim uvlForce As Double
    objOpenSTAAD.Load.AddMemberLinearVari beamNo, Direction, 2#, 0#, 0#

    'AddLoad Combination
    Dim loadCombTitle As String
    Dim loadCombNo As Long
    loadCombTitle = "ULTIMATE LOAD"
    loadCombNo = 101
    objOpenSTAAD.Load.CreateNewLoadCombination loadCombTitle, loadCombNo

    Dim loadCaseNo As Long
    Dim loadFactor As Double
    loadCaseNo = 1 ' Load Case ID for UDL Load
    loadFactor = 1.5 ' Factor for UDL Load
    'Add Load to Load Combination
    objOpenSTAAD.Load.AddLoadAndFactorToCombination loadCombNo, loadCaseNo, loadFactor
    loadCaseNo = 2 ' Load Case ID for Nodal Load
    loadFactor = 1.2 ' Factor for Nodal Load
    objOpenSTAAD.Load.AddLoadAndFactorToCombination loadCombNo, loadCaseNo, loadFactor

    'Save model without any user prompt
    objOpenSTAAD.SaveModel 1
End Sub
```

## Conclusion
- This is more than enough to get you started with automating your STAAD model using OpenSTAAD
- I'll try to keep this updated with more samples, and also add sample code for models using plate elements
- This is just the most commonly used functions for OpenSTAAD; you'll need to read STAAD docs to find missing parts
- Also, you can automate this even further by linking all values with your design sheet, so you only have to enter all input in a single place