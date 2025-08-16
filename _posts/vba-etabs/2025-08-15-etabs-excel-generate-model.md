---
title: How to Automate ETABS Model Using Excel VBA
description: Learn to use the ETABS API with Excel VBA
date: 15-08-2025
categories: [VBA, VBA-ETABS]
tag: [excel, etabs, vba, how to]
image: /assets/images/etabs/excel-vba-etabs-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to automate an ETABS model using VBA.
- Why automate this process?
  - Speed up the modelling process.
  - Design optimization.
  - Integrate your model with your design sheet.
- I am assuming that:
  - You have basic knowledge of VBA and know how to add modules and create new subs.
  - You’re familiar with ETABS.

## Setup
- Excel:
  - Create a macro-enabled Excel file.
  - Add a reference for the ETABS API:
    - Open the VBA Editor > Tools > References Dialog.
    - Find `ETABS Application Programming Interface (API) v1` and make sure it's checked.
  - Create a new module and use the sample code below.
  ```visualbasic
  Sub GenerateModel()
  End Sub
  ```

> I am using ETABS v22, but this code should work for ETABS version 18 and above.
> For older versions, you have to add the reference `ETABS v16 Application Programming Interface (API)` (version specific to your ETABS).
{: .prompt-info }

## Generate New ETABS Model
- The code is written in the same sequence as when creating a manual model.

#### Create New Model
```visualbasic
Sub GenerateModel()

    'Create ETABS API Helper to crete new instance of ETABS App
    Dim etHelper As ETABSv1.cHelper
    Set etHelper = New ETABSv1.Helper

    'Create ETABS new App Object
    Dim etApp As ETABSv1.cOAPI
    Set etApp = etHelper.CreateObjectProgID("CSI.ETABS.API.ETABSObject")
    etApp.ApplicationStart
    
    'Create new ETAB Model
    Dim etModel As ETABSv1.cSapModel
    Set etModel = etApp.sapModel
    'Initialize new model with KN/m/C units
    etModel.InitializeNewModel (eUnits.eUnits_kN_m_C)
    'Set Concrete and Steel Design Codes
    etModel.DesignConcrete.SetCode ("IS 456:2000")
    etModel.DesignSteel.SetCode ("IS 800:2007")
    
    'Create new grid only model
    dim numberOfStories as Integer
    dim storyHeight as Double,bottomStoryHeight as Double
    dim numberOfLinesX As Integer,numberOfLinesY As Integer
    dim spacingX As Double,spacingY As Double

    numberOfStories = 4
    storyHeight = 3.0  'meter
    bottomStoryHeight = 3.0  'meter
    numberOfLinesX = 4
    numberOfLinesY = 4
    spacingX = 5.0  'meter
    spacingY = 5.0  'meter'

    etModel.File.NewGridOnly numberOfStories, storyHeight, bottomStoryHeight, numberOfLinesX, numberOfLinesY, spacingX, spacingY

    '<<< Add Remaining Code Here >>>
End Sub
```

#### Material Properties
```visualbasic
'Define Material Properties
Dim concreteGrade As String, steelGrade As String
concreteGrade = "M30"
steelGrade = "HYSD500"
etModel.PropMaterial.AddMaterial concreteGrade, eMatType_Concrete, "India", "Indian", concreteGrade
etModel.PropMaterial.AddMaterial steelGrade, eMatType_Rebar, "India", "Indian", "HYSD Grade 500"
```
#### Beam Sections
- Create a beam with 300 x 500.
- Concrete and steel grade variables are already defined in the Material Property code.

```visualbasic
'Create New Rectangular Beam section 
Dim beamSection as String
Dim beamWidth As Double, beamDepth As Double, beamCover as Double
beamSection= "B300X500"
beamDepth = 0.5 ' meters
beamWidth = 0.3 ' meters
beamCover = 0.04 ' meters

etModel.PropFrame.SetRectangle beamSection, concreteGrade, beamDepth, beamWidth

'Set reinforcement data
etModel.PropFrame.SetRebarBeam beamSection, steelGrade, steelGrade, beamCover, beamCover, 0, 0, 0, 0
```
#### Column Sections
- Create a column with 400 x 400.
- Concrete and steel grade variables are already defined in the Material Property code.

```visualbasic
'Create new rectangular column section
Dim columnSection As String
Dim columnWidth As Double, columnDepth As Double, columnCover As Double
columnSection = "C400X400"
columnDepth = 0.4 ' meters
columnWidth = 0.4 ' meters
columnCover = 0.04 ' meters

etModel.PropFrame.SetRectangle columnSection, concreteGrade, columnDepth, columnWidth

'Set reinforcement data
etModel.PropFrame.SetRebarColumn columnSection, steelGrade, steelGrade, 1, 1, columnCover, 0, 3, 3, "20", "10", 0.2, 3, 3, True
```

#### Slab Sections
```visualbasic
'Create new Slab with 125 mm
Dim slabSection As String
Dim slabThickness As Double
Dim slabType As eSlabType, shellType As eShellType
slabSection = "S125"
slabThickness = 0.125 ' meters
slabType = eSlabType_Slab
shellType = eShellType_ShellThin

etModel.PropArea.SetSlab slabSection, slabType, shellType, concreteGrade, slabThickness
```

#### Assign Frame Elements
```visualbasic
'Assign C1 Column At point 0,0,0 to 0,0,3
etModel.FrameObj.AddByCoord 0, 0, 0, 0, 0, 3, "", columnSection
```
```visualbasic
'Assign Beam at points 0,0,3 to 5,0,3
etModel.FrameObj.AddByCoord 0, 0, 3, 5, 0, 3, "", beamSection
```
#### Assign Slab Element
```visualbasic
'Assign Slab
Dim x() As Double, y() As Double, z() As Double
ReDim x(3), y(3), z(3)
x(0) = 0: y(0) = 0: z(0) = bottomStoryHeight
x(1) = spacingX: y(1) = 0: z(1) = bottomStoryHeight
x(2) = spacingX: y(2) = spacingY: z(2) = bottomStoryHeight
x(3) = 0: y(3) = spacingY: z(3) = bottomStoryHeight

etModel.AreaObj.AddByCoord 4, x, y, z, "", slabSection
```
#### Add Supports
```visualbasic
'Assign Supports
Dim restrains() As Boolean
ReDim restrains(5)
For i = 0 To 5
    restrains(i) = True
Next i
'Assign Fix Supports to Joint 1
etModel.PointObj.SetRestraint "1", restrains
```
#### Add Load Patterns
```visualbasic
'Assign load Patterns
Dim loadPatternName As String
Dim loadPatternType As eLoadPatternType
Dim selfWeightMultiplier As Double
loadPatternName = "FF+CP"'Floor Finish + Ceiling Plaster
loadPatternType = eLoadPatternType_SuperDead
selfWeightMultiplier = 0
etModel.LoadPatterns.Add loadPatternName, loadPatternType, selfWeightMultiplier
```
#### Add Shell Loads
```visualbasic
'Add uniform shell load of 2 kN/m² for "Live" loadcase on Slab id 1
Dim slabId As String
Dim slabLoadPatternName As String
Dim slabLoad As Double
Dim slabLoadDir As Integer
Dim slabIsReplaceExisting As Boolean
Dim ret As Integer
slabId = "1" 
slabLoadPatternName = "Live"
slabLoad = 2
slabLoadDir = 10 '10 for downward direction Gravity
slabIsReplaceExisting = True
etModel.AreaObj.SetLoadUniform slabId, slabLoadPatternName, slabLoad, slabLoadDir, slabIsReplaceExisting
```

If you want to assign slab load to all slabs:
```visualbasic
slabLoadPatternName = "Live"
slabLoad = 2
slabLoadDir = 10 '10 for downward direction Gravity
slabIsReplaceExisting = True
etModel.AreaObj.SetLoadUniform "ALL", slabLoadPatternName, slabLoad, slabLoadDir, slabIsReplaceExisting,"Global", eItemType_Group
```

#### Add Frame Loads
```visualbasic
'Add UDL load to frame 65
Dim frameId As Long
Dim frameLoadPatternName As String
Dim frameLoad As Double
Dim frameLoadDir As Integer

frameId = 65
frameLoadPatternName = "Wall Load"
frameLoad = 8
frameLoadDir = 10 '10 for downward direction Gravity

etModel.FrameObj.SetLoadDistributed frameId, frameLoadPatternName, 1, frameLoadDir, 0, 1, frameLoad, frameLoad
```

#### Add Load Combinations
```visualbasic
'Add Load combinations
Dim comboName As String
Dim comboType As Long
Dim comboLoadType As eCNameType

comboName = "DL+LL+SIDL"
comboType = 0 'Linear
comboLoadType = eCNameType.eCNameType_LoadCase
etModel.RespCombo.Add comboName, comboType

'Add All load cases to combination with load factor 1
etModel.RespCombo.SetCaseList comboName, comboLoadType, "Dead", 1
etModel.RespCombo.SetCaseList comboName, comboLoadType, "Live", 1
etModel.RespCombo.SetCaseList comboName, comboLoadType, "FF+CP", 1
etModel.RespCombo.SetCaseList comboName, comboLoadType, "Wall Load", 1
```

#### Save Model
- This code will:
  - Create an ETABS folder in the same folder as the Excel sheet.
  - Save the file at `ExcelSheetFolder\Etabs\Model.EDB`.
  - Run analysis.
  - Close ETABS.

```visualbasic
'Save model
etModel.File.Save GetModelFilePath()

'Run analysis
etModel.Analyze.RunAnalysis

'Close ETABS
etApp.ApplicationExit (False)

'Clean up variables
Set etModel = Nothing
Set etApp = Nothing
```
```visualbasic
Public Function GetModelFilePath() As String
    'This function returns the path to the ETABS model file
    Dim etabsFolder As String
    etabsFolder = ThisWorkbook.Path & "\ETABS"
    If Dir(etabsFolder, vbDirectory) = "" Then
        MkDir etabsFolder
    End If
    GetModelFilePath = etabsFolder & "\Model.EDB"
End Function
```
## Final Version with Excel Inputs
```visualbasic
Sub GenerateModel()

    'Create ETABS API Helper to crete new instance of ETABS App
    Dim etHelper As ETABSv1.cHelper
    Set etHelper = New ETABSv1.Helper

    'Create ETABS new App Object
    Dim etApp As ETABSv1.cOAPI
    Set etApp = etHelper.CreateObjectProgID("CSI.ETABS.API.ETABSObject")
    etApp.ApplicationStart
    
    'Create new ETAB Model
    Dim etModel As ETABSv1.cSapModel
    Set etModel = etApp.sapModel
    'Initialize new model with KN/m/C units
    etModel.InitializeNewModel (eUnits.eUnits_kN_m_C)
    'Set Concrete and Steel Design Codes
    etModel.DesignConcrete.SetCode ("IS 456:2000")
    etModel.DesignSteel.SetCode ("IS 800:2007")

    'Create new grid only model
    dim numberOfStories as Integer
    dim storyHeight as Double,bottomStoryHeight as Double
    dim numberOfLinesX As Integer,numberOfLinesY As Integer
    dim spacingX As Double,spacingY As Double

    numberOfStories = 4
    storyHeight = 3.0  'meter
    bottomStoryHeight = 3.0  'meter
    numberOfLinesX = 4
    numberOfLinesY = 4
    spacingX = 5.0  'meter
    spacingY = 5.0  'meter'

    etModel.File.NewGridOnly numberOfStories, storyHeight, bottomStoryHeight, numberOfLinesX, numberOfLinesY, spacingX, spacingY

    'Define Material Properties
    Dim concreteGrade As String, steelGrade As String
    concreteGrade = "M30"
    steelGrade = "HYSD500"
    etModel.PropMaterial.AddMaterial concreteGrade, eMatType_Concrete, "India", "Indian", concreteGrade
    etModel.PropMaterial.AddMaterial steelGrade, eMatType_Rebar, "India", "Indian", "HYSD Grade 500"

    'Create New Rectangular Beam section 
    Dim beamSection as String
    Dim beamWidth As Double, beamDepth As Double, beamCover as Double
    beamSection= "B300X500"
    beamDepth = 0.5 ' meters
    beamWidth = 0.3 ' meters
    beamCover = 0.04 ' meters

    etModel.PropFrame.SetRectangle beamSection, concreteGrade, beamDepth, beamWidth

    'Set reinforcement data
    etModel.PropFrame.SetRebarBeam beamSection, steelGrade, steelGrade, beamCover, beamCover, 0, 0, 0, 0

    'Create new rectangular column section
    Dim columnSection As String
    Dim columnWidth As Double, columnDepth As Double, columnCover As Double
    columnSection = "C400X400"
    columnDepth = 0.4 ' meters
    columnWidth = 0.4 ' meters
    columnCover = 0.04 ' meters

    etModel.PropFrame.SetRectangle columnSection, concreteGrade, columnDepth, columnWidth

    'Set reinforcement data
    etModel.PropFrame.SetRebarColumn columnSection, steelGrade, steelGrade, 1, 1, columnCover, 0, 3, 3, "20", "10", 0.2, 3, 3, True

    'Create new Slab with 125 mm
    Dim slabSection As String
    Dim slabThickness As Double
    Dim slabType As eSlabType, shellType As eShellType
    slabSection = "S125"
    slabThickness = 0.125 ' meters
    slabType = eSlabType_Slab
    shellType = eShellType_ShellThin

    etModel.PropArea.SetSlab slabSection, slabType, shellType, concreteGrade, slabThickness

    Dim i As Integer, j As Integer, k As Integer
    Dim x1 As Double, y1 As Double, z1 As Double
    Dim x2 As Double, y2 As Double, z2 As Double

    'Assign All Columns
    x1 = 0: y1 = 0: z1 = 0
    x2 = 0: y2 = 0: z2 = bottomStoryHeight
    For i = 0 To numberOfStories - 1
        y1 = 0
        y2 = 0
        For k = 0 To numberOfLinesY - 1
            x1 = 0
            x2 = 0
            For j = 0 To numberOfLinesX - 1
                'Add columns at grid points
                etModel.FrameObj.AddByCoord x1, y1, z1, x2, y2, z2, "", columnSection
                x1 = x1 + spacingX
                x2 = x2 + spacingX
            Next j
            y1 = y1 + spacingY
            y2 = y2 + spacingY
        Next k
        If i = 0 Then
            z1 = z1 + bottomStoryHeight
        Else
            z1 = z1 + storyHeight
        End If
        z2 = z2 + storyHeight
    Next i

    'Assign All Beams in X Direction
    x1 = 0: y1 = 0: z1 = bottomStoryHeight
    x2 = spacingX: y2 = 0: z2 = bottomStoryHeight
    For i = 0 To numberOfStories - 1
        y1 = 0
        y2 = 0
        For k = 0 To numberOfLinesY - 1
            x1 = 0
            x2 = spacingX
            For j = 0 To numberOfLinesX - 2
                'Add columns at grid points
                etModel.FrameObj.AddByCoord x1, y1, z1, x2, y2, z2, "", beamSection
                x1 = x1 + spacingX
                x2 = x2 + spacingX
            Next j
            y1 = y1 + spacingY
            y2 = y2 + spacingY
        Next k
        z1 = z1 + storyHeight
        z2 = z2 + storyHeight
    Next i

    'Assign All beams in Y Direction
    x1 = 0: y1 = 0: z1 = bottomStoryHeight
    x2 = 0: y2 = spacingY: z2 = bottomStoryHeight
    For i = 0 To numberOfStories - 1
        y1 = 0
        y2 = spacingY
        For k = 0 To numberOfLinesY - 2
            x1 = 0
            x2 = 0
            For j = 0 To numberOfLinesX - 1
                'Add columns at grid points
                etModel.FrameObj.AddByCoord x1, y1, z1, x2, y2, z2, "", beamSection
                x1 = x1 + spacingX
                x2 = x2 + spacingX
            Next j
            y1 = y1 + spacingY
            y2 = y2 + spacingY
        Next k
        z1 = z1 + storyHeight
        z2 = z2 + storyHeight
    Next i

    'Assign Slab
    Dim x() As Double, y() As Double, z() As Double
    ReDim x(3), y(3), z(3)
    x(0) = 0: y(0) = 0: z(0) = bottomStoryHeight
    x(1) = spacingX: y(1) = 0: z(1) = bottomStoryHeight
    x(2) = spacingX: y(2) = spacingY: z(2) = bottomStoryHeight
    x(3) = 0: y(3) = spacingY: z(3) = bottomStoryHeight

    'etModel.AreaObj.AddByCoord 4, x, y, z, "", slabSection
     For i = 0 To numberOfStories - 1
            y(0) = 0
            y(1) = 0
            y(2) = spacingY
            y(3) = spacingY
        For k = 0 To numberOfLinesY - 2
            x(0)= 0
            x(1)= spacingX
            x(2)= spacingX
            x(3)= 0
            For j = 0 To numberOfLinesX - 2
                'Add columns at grid points
                etModel.AreaObj.AddByCoord 4, x, y, z, "", slabSection
                x(0)= x(0) + spacingX
                x(1)= x(1) + spacingX
                x(2)= x(2) + spacingX
                x(3)= x(3) + spacingX
            Next j
            y(0) = y(0) + spacingY
            y(1) = y(1) + spacingY
            y(2) = y(2) + spacingY
            y(3) = y(3) + spacingY
        Next k
        z(0) = z(0) + storyHeight
        z(1) = z(1) + storyHeight
        z(2) = z(2) + storyHeight
        z(3) = z(3) + storyHeight
    Next i

    'Assign Supports
    Dim restrains() As Boolean
    ReDim restrains(5)
    For i = 0 To 5
        restrains(i) = True
    Next i
    Dim totalSupports As Integer
    totalSupports = numberOfLinesX * numberOfLinesY

    For i = 0 To totalSupports - 1
        etModel.PointObj.SetRestraint i * 2 - 1, restrains
    Next i

    'Assign load Patterns
    Dim loadPatternName As String
    Dim loadPatternType As eLoadPatternType
    Dim selfWeightMultiplier As Double

    'Floor Finish + Ceiling Plaster
    loadPatternName = "FF+CP"
    loadPatternType = eLoadPatternType_SuperDead
    selfWeightMultiplier = 0
    etModel.LoadPatterns.Add loadPatternName, loadPatternType, selfWeightMultiplier

    'Wall Load
    loadPatternName = "Wall Load"
    loadPatternType = eLoadPatternType_SuperDead
    selfWeightMultiplier = 0
    etModel.LoadPatterns.Add loadPatternName, loadPatternType, selfWeightMultiplier

    'Add Live load to all slabs
    Dim slabId As String
    Dim slabLoadPatternName As String
    Dim slabLoad As Double
    Dim slabLoadDir As Integer
    Dim slabIsReplaceExisting As Boolean
    Dim ret As Integer
    slabId = "ALL" 
    slabLoadPatternName = "Live"
    slabLoad = 2
    slabLoadDir = 10 '10 for downward direction Gravity
    slabIsReplaceExisting = True
    etModel.AreaObj.SetLoadUniform slabId, slabLoadPatternName, slabLoad, slabLoadDir, slabIsReplaceExisting,"Global", eItemType_Group

    'Add Floor Finish + Ceiling Plaster to all slabs
    slabId = "ALL"
    slabLoadPatternName = "FF+CP"
    slabLoad = 1.5
    slabLoadDir = 10 '10 for downward direction Gravity
    slabIsReplaceExisting = True
    etModel.AreaObj.SetLoadUniform slabId, slabLoadPatternName, slabLoad, slabLoadDir, slabIsReplaceExisting,"Global", eItemType_Group

    'Assign Wall loads
    Dim frameId As Long
    Dim frameLoadPatternName As String
    Dim frameLoad As Double
    Dim frameLoadDir As Integer

    frameLoadPatternName = "Wall Load"
    frameLoad = 8
    frameLoadDir = 10 '10 for downward direction Gravity

    'Assign load in X direction beams
    frameId = 1 + numberOfLinesX * numberOfLinesY * numberOfStories
    For i = 0 To numberOfStories - 1
        For j = 0 To numberOfLinesX - 2
            etModel.FrameObj.SetLoadDistributed frameId, frameLoadPatternName, 1, frameLoadDir, 0, 1, frameLoad, frameLoad
            frameId = frameId + 1
        Next j
        'Skip Interior Beams
        frameId = frameId + (numberOfLinesX - 1) * (numberOfLinesY-2)
        For j = 0 To numberOfLinesX - 2
            etModel.FrameObj.SetLoadDistributed frameId, frameLoadPatternName, 1, frameLoadDir, 0, 1, frameLoad, frameLoad
            frameId = frameId + 1
        Next j
    Next i

    'Assign load in Y direction beams
    For i = 0 To numberOfStories - 1
        For j = 0 To numberOfLinesY - 2
            etModel.FrameObj.SetLoadDistributed frameId, frameLoadPatternName, 1, frameLoadDir, 0, 1, frameLoad, frameLoad
            frameId = frameId + (numberOfLinesX - 1)
            etModel.FrameObj.SetLoadDistributed frameId, frameLoadPatternName, 1, frameLoadDir, 0, 1, frameLoad, frameLoad
            frameId = frameId + 1
        Next j
    Next i

    'Add Load combinations
    Dim comboName As String
    Dim comboType As Long
    Dim comboLoadType As eCNameType

    comboName = "DL+LL+SIDL"
    comboType = 0 'Linear
    comboLoadType = eCNameType.eCNameType_LoadCase
    etModel.RespCombo.Add comboName, comboType
    
    'Add All load cases to combination with load factor 1
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Dead", 1
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Live", 1
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "FF+CP", 1
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Wall Load", 1


    comboName = "1.5(DL+LL+SIDL)"
    comboType = 0 'Linear
    comboLoadType = eCNameType.eCNameType_LoadCase
    etModel.RespCombo.Add comboName, comboType

    'Add All load cases to combination with load factor 1.5
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Dead", 1.5
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Live", 1.5
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "FF+CP", 1.5
    etModel.RespCombo.SetCaseList comboName, comboLoadType, "Wall Load", 1.5

        'Save model
    etModel.File.Save GetModelFilePath()

    'Run analysis
    etModel.Analyze.RunAnalysis

    'Close ETABS
    etApp.ApplicationExit (False)

    'Clean up variables
    Set etModel = Nothing
    Set etApp = Nothing
End Sub

Public Function GetModelFilePath() As String
    'This function returns the path to the ETABS model file
    Dim etabsFolder As String
    etabsFolder = ThisWorkbook.Path & "\ETABS"
    If Dir(etabsFolder, vbDirectory) = "" Then
        MkDir etabsFolder
    End If
    GetModelFilePath = etabsFolder & "\Model.EDB"
End Function
```

## Conclusion
- You can use the ETABS API to fully or partially automate your modelling process.
- This covers the most commonly used ETABS API features. You’ll need to read the ETABS API documentation to find any missing parts as per your needs.
- You can automate this even further by linking all values with your design sheet, so you only have to enter all inputs in a single place.