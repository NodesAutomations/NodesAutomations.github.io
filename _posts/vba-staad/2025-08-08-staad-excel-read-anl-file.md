---
title: How to read STAAD Analysis (*.ANL) file using Excel VBA
description: Extract data from STAAD (*.ANL) file using VBA
date: 08-08-2025
categories: [VBA, VBA-STAAD]
tag: [excel, staad, vba, openstaad, how to]
image: /assets/images/staad/excel-vba-staad-anl.webp
---

## Overview
- In this tutorial, I'll show you how to extract data from a STAAD Analysis file using Excel VBA.
- Why?
  - It's the only way to extract design data from STAAD.
  - You can also extract model info or analysis results if you don't want to use OPENSTAAD.
- I am assuming that:
  - You have basic knowledge of VBA and know how to add modules and create new subs.
  - You know how to generate a STAAD Analysis (*.ANL) file and are familiar with its layout.

## Setup
- You'll need an ANL file that contains design data.
- For this setup, I am putting the ANL file in the same folder as the Excel file, with the name "Model.ANL".
- Use a macro-enabled Excel file with:
  - Sheet named "Column" with first row headers: Column No, Length, Breadth, Depth, Concrete Grade, Steel Grade, Reinforcement Area

    | ColumnNo | Length | Breadth | Depth | Concrete Grade | Steel Grade | Reinforcement Area |
    | --- | --- | --- | --- | --- | --- | --- |
    |   |   |   |   |   |   |   |
    |   |   |   |   |   |   |   |
    |   |   |   |   |   |   |   |

  - Sheet named "Beam" with first row headers: Beam No, Length, Breadth, Depth, Concrete Grade, Steel Grade, T@0, T@0.25, T@0.5, T@0.75, T@1, B@0, B@0.25, B@0.5, B@0.75, B@1

    | BeamNo | Length | Breadth | Depth | Concrete Grade | Steel Grade | T@0 | T@0.25 | T@0.5 | T@0.75 | T@1 | B@0 | B@0.25 | B@0.5 | B@0.75 | B@1 |
    | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

  - Create a new module and add the ExtractData method:

    ```visualbasic
    Sub ExtractData()
    'Add your code here
    End Sub
    ```

> I am using STAAD Connect Edition to generate my ANL file. If your ANL file structure is a bit different or you're trying to extract different values, you will need to make some adjustments, specifically with line numbers.
{: .prompt-info }

## Extract Data from ANL File
- We can divide this task into multiple sub-tasks:
  - Reading data from the ANL file and storing it for further processing.
  - Finding the line number for a specific section as per our requirement.
  - Extracting data from lines that contain the required data.

#### Load Data from ANL file
- The ANL file is just a text file with a custom file extension.
- So we can read it like a text file using VBA.
- Here we are storing data in a string collection, line by line, for easier access to each line.
- For the file path, we are going to use `ThisWorkbook.Path & "\Model.ANL"`.

```visualbasic
Sub ExtractData()
    'Read ANL file into a collection
    Dim data As Collection
    Set data = ReadANL(ThisWorkbook.Path & "\Model.ANL")
End Sub
```
```visualbasic
Function ReadANL(filePath As String) As Collection

    'Create new collection to store lines from the ANL file
    Dim data As Collection
    Set data = New Collection

    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Read ANL file line by line and load it to data collection
    Dim textStream As Object
    Dim line As String
    If fso.FileExists(filePath) Then
        Set textStream = fso.OpenTextFile(filePath, 1) ' ForReading = 1
        Do While Not textStream.AtEndOfStream
            line = textStream.ReadLine
            data.Add line
        Loop
        textStream.Close
    End If

    Set ReadANL = data
End Function
```
#### Find ANL file from Folder
- This part is only required if you don't use a fixed name for your STAAD model.
- If you don't know the ANL file name in advance, you have to write additional code to automatically find the ANL file from the folder.

```visualbasic
Sub ExtractData()
    Dim filePath As String
    filePath = GetAnlFilePath()

    If filePath = "" Then
        MsgBox "No .ANL file found in the folder.", vbExclamation
        Exit Sub
    End If

    'Read ANL file into a collection
    Dim data As Collection
    Set data = ReadANL(filePath)
End Sub
```
```visualbasic
Public Function GetAnlFilePath() As String
    
    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Get the folder containing the workbook
    Dim folder As Object
    Set folder = fso.GetFolder(ThisWorkbook.Path)

    'Loop through all files in folder and find .ANL file
    Dim file As Object
    For Each file In folder.Files
        If LCase(fso.GetExtensionName(file.Name)) = "anl" Then
            GetAnlFilePath = file.Path
            Exit Function
        End If
    Next

    GetAnlFilePath = ""
End Function
```

#### Find row with specific section
- You have to adjust this part depending on which data you need to extract from the ANL file.
- I've added sample code for extracting Column and Beam Design data.
- Here we're just looping through all lines and finding rows that match our criteria.

```visualbasic
Sub ExtractData()
    'Read ANL file into a collection
    Dim data As Collection
    Set data = ReadANL(ThisWorkbook.Path & "\Model.ANL")

    'Extract Column data
    ExtractColumnData data
    
    'Extract Beam data
    ExtractBeamData data
End Sub
```
```visualbasic
Private Sub ExtractColumnData(data As Collection)

    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Column")

    'Loop through all lines and print lines containing C O L U M N   N O.
    Dim i As Long, rowId As Long, columnNo As Long
    rowId = 2

    For i = 1 To data.Count
        If InStr(1, data(i), "C O L U M N   N O.", vbTextCompare) > 0 Then
           columnNo = GetNumber(data(i), 1)
           If columnNo > 0 Then
            ws.Cells(rowId, 1).Value = columnNo
            rowId = rowId + 1
           End If
        End If
    Next i
End Sub
```
```visualbasic
Private Sub ExtractBeamData(data As Collection)
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Beam")

    'Loop through all lines and print lines containing B E A M  N O.
    Dim i As Long, rowId As Long, beamNo As Long
    rowId = 2

    For i = 1 To data.Count
        If InStr(1, data(i), "B E A M  N O.", vbTextCompare) > 0 Then
           beamNo = GetNumber(data(i), 1)
           If beamNo > 0 Then
            ws.Cells(rowId, 1).Value = beamNo
            rowId = rowId + 1
           End If
        End If
    Next i
End Sub
```

#### Extract Data from line
- Once we find a line that contains the required results, we need code to extract specific results from that string.
- For this, we have 3 common functions which will extract a number, decimal, or string from a given string.
- Here, the numberIndex variable is used to specify which value to extract from the string:
  - numberIndex=1 means extract the first value from the string
  - numberIndex=2 means extract the second value from the string
  - numberIndex=3 means extract the third value from the string
- We can use these functions in combination with our find matching row code.

```visualbasic
Private Sub ExtractColumnData(data As Collection)

    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Column")

    'Loop through all lines and print lines containing C O L U M N   N O.
    Dim i As Long, rowId As Long, columnNo As Long
    rowId = 2

    For i = 1 To data.Count
        If InStr(1, data(i), "C O L U M N   N O.", vbTextCompare) > 0 Then
           columnNo = GetNumber(data(i), 1)
           If columnNo > 0 Then
            ws.Cells(rowId, 1).Value = columnNo 'Column No
            ws.Cells(rowId, 2).Value = GetDecimal(data(i + 4), 1) ' Length
            ws.Cells(rowId, 3).Value = GetDecimal(data(i + 4), 2) ' Breadth
            ws.Cells(rowId, 4).Value = GetDecimal(data(i + 4), 3) ' Depth
            ws.Cells(rowId, 5).Value = GetString(data(i + 2), 1) ' Concrete Grade
            ws.Cells(rowId, 6).Value = GetString(data(i + 2), 2) ' Steel Grade
            ws.Cells(rowId, 7).Value = GetDecimal(data(i + 9), 1) ' Reinforcement Area
            rowId = rowId + 1
           End If
        End If
    Next i
End Sub
```
```visualbasic
Function GetNumber(line As String, numberIndex As Long) As Long
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first number
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetNumber = CLng(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetNumber = 0
End Function
```
```visualbasic
Function GetDecimal(line As String, numberIndex As Long) As Double
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first number
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetDecimal = CDbl(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetDecimal = 0
End Function
```
```visualbasic
Function GetString(line As String, numberIndex As Long) As String
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first string
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If Len(Trim(parts(i))) > 0 And Not IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetString = CStr(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetString = ""
End Function
```
## Final Version
- This is the final version of the code, combining all functions to extract column and beam design data.
- Additionally, I've added the `ClearExistingDataFromSheet` method to clear existing data from the sheet before writing new data.

```visualbasic
Sub ExtractData()
    Dim filePath As String
    filePath = GetAnlFilePath()

    If filePath = "" Then
        MsgBox "No .ANL file found in the folder.", vbExclamation
        Exit Sub
    End If

    'Clear existing data
    ClearExistingDataFromSheet "Column"
    ClearExistingDataFromSheet "Beam"

    'Read ANL file into a collection
    Dim data As Collection
    Set data = ReadANL(filePath)

    'Extract Column data
    ExtractColumnData data
    
    'Extract Beam data
    ExtractBeamData data
End Sub

Public Function GetAnlFilePath() As String
    
    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Get the folder containing the workbook
    Dim folder As Object
    Set folder = fso.GetFolder(ThisWorkbook.Path)

    'Loop through all files in folder and find .ANL file
    Dim file As Object
    For Each file In folder.Files
        If LCase(fso.GetExtensionName(file.Name)) = "anl" Then
            GetAnlFilePath = file.Path
            Exit Function
        End If
    Next

    GetAnlFilePath = ""
End Function

Function ReadANL(filePath As String) As Collection

    'Create new collection to store lines from the ANL file
    Dim data As Collection
    Set data = New Collection

    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Read ANL file line by line and load it to data collection
    Dim textStream As Object
    Dim line As String
    If fso.FileExists(filePath) Then
        Set textStream = fso.OpenTextFile(filePath, 1) ' ForReading = 1
        Do While Not textStream.AtEndOfStream
            line = textStream.ReadLine
            data.Add line
        Loop
        textStream.Close
    End If

    Set ReadANL = data
End Function

Private Sub ClearExistingDataFromSheet(sheetName As String)
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets(sheetName)
    With ws.Range("A1").CurrentRegion
        If .Rows.Count > 1 Then
            .Offset(1, 0).Resize(.Rows.Count - 1).EntireRow.Delete
        End If
    End With
End Sub

Private Sub ExtractColumnData(data As Collection)

    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Column")

    'Loop through all lines and print lines containing C O L U M N   N O.
    Dim i As Long, rowId As Long, columnNo As Long
    rowId = 2

    For i = 1 To data.Count
        If InStr(1, data(i), "C O L U M N   N O.", vbTextCompare) > 0 Then
           columnNo = GetNumber(data(i), 1)
           If columnNo > 0 Then
            ws.Cells(rowId, 1).Value = columnNo 'Column No
            ws.Cells(rowId, 2).Value = GetDecimal(data(i + 4), 1) ' Length
            ws.Cells(rowId, 3).Value = GetDecimal(data(i + 4), 2) ' Breadth
            ws.Cells(rowId, 4).Value = GetDecimal(data(i + 4), 3) ' Depth
            ws.Cells(rowId, 5).Value = GetString(data(i + 2), 1) ' Concrete Grade
            ws.Cells(rowId, 6).Value = GetString(data(i + 2), 2) ' Steel Grade
            ws.Cells(rowId, 7).Value = GetDecimal(data(i + 9), 1) ' Reinforcement Area
            rowId = rowId + 1
           End If
        End If
    Next i
End Sub

Private Sub ExtractBeamData(data As Collection)

    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Beam")

    'Loop through all lines and print lines containing B E A M  N O.
    Dim i As Long, rowId As Long, beamNo As Long
    rowId = 2

    For i = 1 To data.Count
        If InStr(1, data(i), "B E A M  N O.", vbTextCompare) > 0 Then
           beamNo = GetNumber(data(i), 1)
           If beamNo > 0 Then
            ws.Cells(rowId, 1).Value = beamNo ' Beam No
            ws.Cells(rowId, 2).Value = GetDecimal(data(i + 4), 1) ' Length
            ws.Cells(rowId, 3).Value = GetDecimal(data(i + 4), 2) ' Breadth
            ws.Cells(rowId, 4).Value = GetDecimal(data(i + 4), 3) ' Depth
            ws.Cells(rowId, 5).Value = GetString(data(i + 2), 1) ' Concrete Grade
            ws.Cells(rowId, 6).Value = GetString(data(i + 2), 2) ' Steel Grade

            'Top Reinforcement
            ws.Cells(rowId, 7).Value = GetDecimal(data(i + 11), 1) 'Top Reinforcement Area @ 0Length
            ws.Cells(rowId, 8).Value = GetDecimal(data(i + 11), 2) 'Top Reinforcement Area @ 0.25Length
            ws.Cells(rowId, 9).Value = GetDecimal(data(i + 11), 3) 'Top Reinforcement Area @ 0.5Length
            ws.Cells(rowId, 10).Value = GetDecimal(data(i + 11), 4) 'Top Reinforcement Area @ 0.75Length
            ws.Cells(rowId, 11).Value = GetDecimal(data(i + 11), 5) 'Top Reinforcement Area @ 1Length

            'Bottom Reinforcement
            ws.Cells(rowId, 12).Value = GetDecimal(data(i + 14), 1) 'Bottom Reinforcement Area @ 0Length
            ws.Cells(rowId, 13).Value = GetDecimal(data(i + 14), 2) 'Bottom Reinforcement Area @ 0.25Length
            ws.Cells(rowId, 14).Value = GetDecimal(data(i + 14), 3) 'Bottom Reinforcement Area @ 0.5Length
            ws.Cells(rowId, 15).Value = GetDecimal(data(i + 14), 4) 'Bottom Reinforcement Area @ 0.75Length
            ws.Cells(rowId, 16).Value = GetDecimal(data(i + 14), 5) 'Bottom Reinforcement Area @ 1Length

            rowId = rowId + 1
           End If
        End If
    Next i
End Sub

Function GetNumber(line As String, numberIndex As Long) As Long
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first number
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetNumber = CLng(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetNumber = 0
End Function

Function GetDecimal(line As String, numberIndex As Long) As Double
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first number
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetDecimal = CDbl(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetDecimal = 0
End Function

Function GetString(line As String, numberIndex As Long) As String
    Dim parts() As String
    parts = Split(line, " ")
    'Loop through all parts and return the first string
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If Len(Trim(parts(i))) > 0 And Not IsNumeric(parts(i)) Then
            matchCount = matchCount + 1
            If matchCount = numberIndex Then
                GetString = CStr(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetString = ""
End Function
```
## Conclusion
- I've written this code so users can easily modify it as per their specific requirements.
- The current version of the code is written to be beginner-friendly and is not optimized for large models.
- You might need to do some optimization if you want to reduce execution time for large models.
