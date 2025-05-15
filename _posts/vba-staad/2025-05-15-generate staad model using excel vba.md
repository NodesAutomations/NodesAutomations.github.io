---
title: How to generate STAAD model using Excel VBA
description: Generate *.std file without openstaad API
date: 15-05-2025
categories: [VBA, VBA-Excel]
tag: [excel,staad, vba, script, how to]
image: /assets/images/staad/excel-vba-staad-model.webp
---

## Overview
- In this tutorial, I'll show you how to generate a STAAD file using VBA without using the OpenSTAAD API.
- Generating STAAD models automatically frees you from a lot of manual labor, depending on the model size and the amount of iteration you want to do to optimize your design.
- This method is better because:
  - It doesn't require the OPENSTAAD API, so your code will work with all versions of STAAD, including really old ones.
  - You can generate multiple models. This is especially important for bridge structures, where you need to generate multiple models with different load combinations or checks.
  - Since we are doing this in Excel VBA, you can directly link your Excel geometry or load parameters with the VBA code. I normally keep my model generation code with my Excel design sheet so I can link all of my model parameters with my design and don't have to change inputs in multiple places.
  - No need to learn the OPENSTAAD API, since we're just using the STAAD command file, which most users are already familiar with.
- Cons:
  - If you need to modify or work with an existing model, then it's better to use the OPENSTAAD API.
- To simplify this tutorial, we will do this in multiple iterations.
- I am assuming that you have a basic knowledge of `VBA` and how to create new methods or functions


## Setup
- Create new macro enable excel file
- Add inputs for STAAD model
- To keep things simple, we're going to generate simple Fixed beam

![Output1](/assets/images/staad/generate-staad-file-1.webp)
_Screenshot 1 : Excel sheet with input parameters_

## Generate STAAD file

#### Create Blank STAAD file
- Create new Module and add below sample code to create blank STAAD file
- After creating your blank staad files you can start adding code for each element one by one as shown below

```visualbasic
Sub CreateModel()

' Create a new text file for the model at active workbook's path
Open ThisWorkbook.Path & "\Model.std" For Output As #1

' Write the model data to the file
Print #1, "STAAD SPACE"
Print #1, "START JOB INFORMATION"
Print #1, "ENGINEER DATE " & Format(Date, "dd-mmm-yy")
Print #1, "END JOB INFORMATION"
Print #1, "INPUT WIDTH 79"
Print #1, "UNIT METER MTON"

'<<< Add your remaining model code here >>>

' Specify End of STAAD file
Print #1, "FINISH"

' Close the file after writing to save model data
Close #1

'success message
MsgBox "Model successfully generated"

End Sub
```
#### Add Nodes and Beams
```visualbasic
' Add nodes
Print #1, "JOINT COORDINATES"
Print #1, "1 0 0 0;"
Print #1, "2 3.0 0 0;"

' Add Beam Elements
Print #1, "MEMBER INCIDENCES"
Print #1, "1 1 2;"
```

### Add Material and Section Properties
```visualbasic
' Define Material Properties
Print #1, "DEFINE MATERIAL START"
Print #1, "ISOTROPIC CONCRETE"
Print #1, "E 2.21467e+006"
Print #1, "POISSON 0.17"
Print #1, "DENSITY 2.40262"
Print #1, "ALPHA 1e-005"
Print #1, "DAMP 0.05"
Print #1, "TYPE CONCRETE"
Print #1, "STRENGTH FCU 2812.28"
Print #1, "END DEFINE MATERIAL"

' Define Section Properties
Print #1, "MEMBER PROPERTY AMERICAN"
Print #1, "1 PRIS YD 0.3 ZD 0.3"
Print #1, "CONSTANTS"
Print #1, "MATERIAL CONCRETE ALL"
```


### Add Supports
```visualbasic
' Define Support Conditions
Print #1, "SUPPORTS"
Print #1, "1 2 FIXED"
```

### Add Loads
```visualbasic
'Add Dead load
Print #1, "LOAD 1 LOADTYPE None TITLE DEAD LOAD"
Print #1, "MEMBER LOAD"
Print #1, "1 UNI GY -10"

'Add Live load
Print #1, "LOAD 2 LOADTYPE None TITLE LIVE LOAD"
Print #1, "MEMBER LOAD"
Print #1, "1 CON GY -50 1.5 0"
```

### Add Load Combinations
```visualbasic
'Add Load Combinations
Print #1, "LOAD COMB 101 ULTIMATE LOAD"
Print #1, "1 1.5 2 1.3"
```
### Add Analysis Command
```visualbasic
Print #1, "PERFORM ANALYSIS"
```
## STAAD FILE
- Your Generated STAAD file should look like this

```text
STAAD SPACE
START JOB INFORMATION
ENGINEER DATE 15-May-25
END JOB INFORMATION
INPUT WIDTH 79
UNIT METER MTON
JOINT COORDINATES
1 0 0 0;
2 3.0 0 0;
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
LOAD 1 LOADTYPE None TITLE DEAD LOAD
MEMBER LOAD
1 UNI GY -10
LOAD 2 LOADTYPE None TITLE LIVE LOAD
MEMBER LOAD
1 CON GY -50 1.5 0
LOAD COMB 101 ULTIMATE LOAD
1 1.5 2 1.3
PERFORM ANALYSIS
FINISH
```

## Link STAAD file input with excel
```visualbasic
Sub CreateModel()

' Inputs variables
Dim length As Double
Dim width As Double, depth As Double
Dim deadLoad As Double, liveLoad As Double

' Read inputs from the active sheet
length = CDbl(ActiveSheet.Range("B1").Value)
width = CDbl(ActiveSheet.Range("B2").Value)
depth = CDbl(ActiveSheet.Range("B3").Value)
deadLoad = -CDbl(ActiveSheet.Range("B4").Value)
liveLoad = -CDbl(ActiveSheet.Range("B5").Value)

' Create a new text file for the model at active workbook's path
Open ThisWorkbook.Path & "\Model.std" For Output As #1

' Write the model data to the file
Print #1, "STAAD SPACE"
Print #1, "START JOB INFORMATION"
Print #1, "ENGINEER DATE " & Format(Date, "dd-mmm-yy")
Print #1, "END JOB INFORMATION"
Print #1, "INPUT WIDTH 79"
Print #1, "UNIT METER MTON"

' Add nodes
Print #1, "JOINT COORDINATES"
Print #1, "1 0 0 0;"
Print #1, "2 " & length & " 0 0;"

' Add Beam Elements
Print #1, "MEMBER INCIDENCES"
Print #1, "1 1 2;"

' Define Material Properties
Print #1, "DEFINE MATERIAL START"
Print #1, "ISOTROPIC CONCRETE"
Print #1, "E 2.21467e+006"
Print #1, "POISSON 0.17"
Print #1, "DENSITY 2.40262"
Print #1, "ALPHA 1e-005"
Print #1, "DAMP 0.05"
Print #1, "TYPE CONCRETE"
Print #1, "STRENGTH FCU 2812.28"
Print #1, "END DEFINE MATERIAL"

' Define Section Properties
Print #1, "MEMBER PROPERTY AMERICAN"
Print #1, "1 PRIS YD " & depth & " ZD " & width
Print #1, "CONSTANTS"
Print #1, "MATERIAL CONCRETE ALL"

' Define Support Conditions
Print #1, "SUPPORTS"
Print #1, "1 2 FIXED"

'Add Dead load
Print #1, "LOAD 1 LOADTYPE None TITLE DEAD LOAD"
Print #1, "MEMBER LOAD"
Print #1, "1 UNI GY " & deadLoad

'Add Live load
Print #1, "LOAD 2 LOADTYPE None TITLE LIVE LOAD"
Print #1, "MEMBER LOAD"
Print #1, "1 CON GY " & liveLoad & " " & length / 2 & " 0"

'Add Load Combinations
Print #1, "LOAD COMB 101 ULTIMATE LOAD"
Print #1, "1 1.5 2 1.3"

Print #1, "PERFORM ANALYSIS"

' Specify End of STAAD file
Print #1, "FINISH"
' Close the file after writing to save model data
Close #1

'success message
MsgBox "Model successfully generated"

End Sub
```


## Conclusion
- This is my prefered method to generate STAAD models
- You can use Loops and Conditional statements in this code add more complex models
- If you're bit new to VBA then take help of AI like CHATGPT to undertand or modify specific parts of code
