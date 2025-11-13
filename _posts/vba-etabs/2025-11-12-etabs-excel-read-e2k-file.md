---
title: How to read ETABS (*.e2k) file using Excel VBA
description: Extract data from ETABS (*.e2k) file
date: 12-11-2025
categories: [VBA, VBA-ETABS]
tag: [excel, etabs, vba, how to]
image: /assets/images/etabs/excel-vba-etabs-extract-results.webp
---

## Overview
- In this tutorial, I'll show you how to extract data from an ETABS *.e2k file using Excel VBA.
- Why?
- I am assuming that:
    - You have basic knowledge of VBA and know how to add modules and create new subs.
    - You know how to generate an ETABS E2K (*.e2k) file and are familiar with its layout.

## Setup
- You'll need an e2k file for testing.
- For this setup, I am putting the e2k file in the same folder as the Excel file, with the name "Model.e2k".
- Use a macro-enabled Excel file with:
  - Sheet Name `StoryData`
  - Sheet Name `SectionData`
  - Create a new module and add the ExtractData method:

  ```visualbasic
  Sub ExtractData()
  'Add your code here
  End Sub
  ```
> I am using ETABS version 22.5 to generate my e2k file. The e2k file structure doesn't change much between versions, but if that happens, adjust your code as per your e2k file structure.
{: .prompt-info }

## Extract Data from e2k file
- We can divide this task into multiple sub-tasks:
    - Reading data from the e2k file and storing it for further processing.
    - Finding the line number for a specific section as per our requirement.
    - Extracting data from lines that contain the required data.

#### Load Data from e2k file
- The e2k file is just a text file with a custom file extension.
- So, we can read it like a text file using VBA.
- Here, we are storing data in a string collection, line by line, for easier access to each line.
- For the file path, we are going to use `ThisWorkbook.Path & "\Model.e2k"`.

```visualbasic
Sub ExtractData()
    'Read E2K file into a collection
    Dim data As Collection
    Set data = ReadE2K(ThisWorkbook.Path & "\Model.e2k")
End Sub
```
```visualbasic
Function ReadE2K(filePath As String) As Collection

    'Create new collection to store lines from the E2K file
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

    Set ReadE2K = data
End Function
```
#### Find e2k file from Folder
- This part is only required if you don't use a fixed name for your ETABS model.
- If you don't know the e2k file name in advance, you have to write additional code to automatically find the e2k file in the folder.

```visualbasic
Sub ExtractData()
    Dim filePath As String
    filePath = GetE2KFilePath()

    If filePath = "" Then
        MsgBox "No .E2K file found in the folder.", vbExclamation
        Exit Sub
    End If

    'Read E2K file into a collection
    Dim data As Collection
    Set data = ReadE2K(filePath)
End Sub
```
```visualbasic
Public Function GetE2KFilePath() As String
    
    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Get the folder containing the workbook
    Dim folder As Object
    Set folder = fso.GetFolder(ThisWorkbook.Path)

    'Loop through all files in folder and find .ANL file
    Dim file As Object
    For Each file In folder.Files
        If LCase(fso.GetExtensionName(file.Name)) = "e2k" Then
            GetE2KFilePath = file.Path
            Exit Function
        End If
    Next

    GetE2KFilePath = ""
End Function
```

#### Find row with specific section
- You have to adjust this part depending on which data you need to extract from the e2k file.
- I've added sample code for extracting Story data and Section Data.
- Here, we're just looping through all lines and finding the section that matches our section name.
- After finding the specific section, a do while loop is added to loop until the end of the section.
- We're writing this data to the Excel file on the "StoryData" sheet, so make sure this sheet exists.

```visualbasic
Sub ExtractData()
    Dim filePath As String
    filePath = GetE2KFilePath()

    If filePath = "" Then
        MsgBox "No .E2K file found in the folder.", vbExclamation
        Exit Sub
    End If

    'Read E2K file into a collection
    Dim data As Collection
    Set data = ReadE2K(filePath)

    'Extract Story Data
    ExtractStoryData data
End Sub
```
```visualbasic
Public Sub ExtractStoryData(data As Collection)
    Dim ws As Worksheet,rowId As Long, colId As Long
    Set ws = ThisWorkbook.Sheets("StoryData")
    ws.Cells.Clear
    rowId = 1
    colId = 1

    'Find Story Data section
    Dim i As Long, j as Long,  line As String

    For i = 1 To data.Count
        If InStr(1, data(i), "$ STORIES", vbTextCompare) > 0 Then
            'Extract Story Data
            j = i + 1
            Do While j <= data.Count And data(j) <> ""
                line = data(j)
                ws.Cells(rowId, colId).Value = line
                rowId = rowId + 1
                j = j + 1
            Loop
            Exit For
        End If
    Next i
End Sub
```

#### Extract Data from line
- Once we find a line that contains the required results, we need code to extract specific results from that string.
- For this, we have 4 common functions which will extract a number, decimal, string, or quoted string from a given string.
- Here, the numberIndex variable is used to specify which value to extract from the string:
  - numberIndex=1 means extract the first value from the string
  - numberIndex=2 means extract the second value from the string
  - numberIndex=3 means extract the third value from the string
- We can use these functions in combination with our find matching row code.

```visualbasic
Public Sub ExtractStoryData(data As Collection)
    Dim ws As Worksheet,rowId As Long, colId As Long
    Set ws = ThisWorkbook.Sheets("StoryData")
    ws.Cells.Clear
    rowId = 1
    colId = 1

    ws.Cells(rowId, colId).Value = "Story Name"
    ws.Cells(rowId, colId+1).Value = "Height"
    rowId = rowId + 1

    'Find Story Data section
    Dim i As Long, j as Long,  line As String

    For i = 1 To data.Count
        If InStr(1, data(i), "$ STORIES", vbTextCompare) > 0 Then
            'Extract Story Data
            j = i + 1
            Do While j <= data.Count And data(j) <> ""
                line = data(j)
                ws.Cells(rowId, colId).Value = GetQuotedString(line, 1) 'Story Name
                ws.Cells(rowId, colId+1).Value = GetDecimal(line, 1) 'Height
                rowId = rowId + 1
                j = j + 1
            Loop
            Exit For
        End If
    Next i
End Sub
```
```visualbasic
Public Sub ExtractSectionData(data As Collection)
    Dim ws As Worksheet,rowId As Long, colId As Long
    Set ws = ThisWorkbook.Sheets("SectionData")
    ws.Cells.Clear
    rowId = 1
    colId = 1

    ws.Cells(rowId, colId).Value = "Section Name"
    ws.Cells(rowId, colId+1).Value = "Mateirial"
    ws.Cells(rowId, colId+2).Value = "Width"
    ws.Cells(rowId, colId+3).Value = "Depth"
    rowId = rowId + 1

    'Find Section Data section
    Dim i As Long, j as Long,  line As String,shpapeType As String

    For i = 1 To data.Count
        If InStr(1, data(i), "$ FRAME SECTIONS", vbTextCompare) > 0 Then
            'Extract Section Data
            j = i + 1
            Do While j <= data.Count And data(j) <> ""
                line = data(j)
                shpapeType = GetQuotedString(line, 3)
                If shpapeType = "Concrete Rectangular" Then
                    ws.Cells(rowId, colId).Value = GetQuotedString(line, 1) 'Section Name
                    ws.Cells(rowId, colId+1).Value = GetQuotedString(line, 2) 'Material
                    ws.Cells(rowId, colId+2).Value = GetDecimal(line, 2) 'Width
                    ws.Cells(rowId, colId+3).Value = GetDecimal(line, 1) 'Depth
                    rowId = rowId + 1
                End If
                j = j + 1
            Loop
            Exit For
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
```visualbasic
Function GetQuotedString(line As String, quoteIndex As Long) As String
    Dim parts() As String
    parts = Split(line, """")
    'Loop through all parts and return the quoted string
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If Len(Trim(parts(i))) > 0 Then
            matchCount = matchCount + 1
            If matchCount = quoteIndex * 2 Then 'Quoted strings are in even positions
                GetQuotedString = CStr(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetQuotedString = ""
End Function
```

## Final Version
- This is the final version of the code.
- This is just sample code to get you started; you still have to write separate code for each section.

```visualbasic
Sub ExtractData()
    Dim filePath As String
    filePath = GetE2KFilePath()

    If filePath = "" Then
        MsgBox "No .E2K file found in the folder.", vbExclamation
        Exit Sub
    End If

    'Read E2K file into a collection
    Dim data As Collection
    Set data = ReadE2K(filePath)

    'Extract Story Data
    ExtractStoryData data

    'Extract Section Data
    ExtractSectionData data
End Sub

Public Function GetE2KFilePath() As String
    
    'Using File system utility to work with files and folders
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    'Get the folder containing the workbook
    Dim folder As Object
    Set folder = fso.GetFolder(ThisWorkbook.Path)

    'Loop through all files in folder and find .ANL file
    Dim file As Object
    For Each file In folder.Files
        If LCase(fso.GetExtensionName(file.Name)) = "e2k" Then
            GetE2KFilePath = file.Path
            Exit Function
        End If
    Next

    GetE2KFilePath = ""
End Function

Function ReadE2K(filePath As String) As Collection

    'Create new collection to store lines from the E2K file
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

    Set ReadE2K = data
End Function

Public Sub ExtractStoryData(data As Collection)
    Dim ws As Worksheet,rowId As Long, colId As Long
    Set ws = ThisWorkbook.Sheets("StoryData")
    ws.Cells.Clear
    rowId = 1
    colId = 1

    ws.Cells(rowId, colId).Value = "Story Name"
    ws.Cells(rowId, colId+1).Value = "Height"
    rowId = rowId + 1

    'Find Story Data section
    Dim i As Long, j as Long,  line As String

    For i = 1 To data.Count
        If InStr(1, data(i), "$ STORIES", vbTextCompare) > 0 Then
            'Extract Story Data
            j = i + 1
            Do While j <= data.Count And data(j) <> ""
                line = data(j)
                ws.Cells(rowId, colId).Value = GetQuotedString(line, 1) 'Story Name
                ws.Cells(rowId, colId+1).Value = GetDecimal(line, 1) 'Height
                rowId = rowId + 1
                j = j + 1
            Loop
            Exit For
        End If
    Next i
End Sub

Public Sub ExtractSectionData(data As Collection)
    Dim ws As Worksheet,rowId As Long, colId As Long
    Set ws = ThisWorkbook.Sheets("SectionData")
    ws.Cells.Clear
    rowId = 1
    colId = 1

    ws.Cells(rowId, colId).Value = "Section Name"
    ws.Cells(rowId, colId+1).Value = "Mateirial"
    ws.Cells(rowId, colId+2).Value = "Width"
    ws.Cells(rowId, colId+3).Value = "Depth"
    rowId = rowId + 1

    'Find Section Data section
    Dim i As Long, j as Long,  line As String,shpapeType As String

    For i = 1 To data.Count
        If InStr(1, data(i), "$ FRAME SECTIONS", vbTextCompare) > 0 Then
            'Extract Section Data
            j = i + 1
            Do While j <= data.Count And data(j) <> ""
                line = data(j)
                shpapeType = GetQuotedString(line, 3)
                If shpapeType = "Concrete Rectangular" Then
                    ws.Cells(rowId, colId).Value = GetQuotedString(line, 1) 'Section Name
                    ws.Cells(rowId, colId+1).Value = GetQuotedString(line, 2) 'Material
                    ws.Cells(rowId, colId+2).Value = GetDecimal(line, 2) 'Width
                    ws.Cells(rowId, colId+3).Value = GetDecimal(line, 1) 'Depth
                    rowId = rowId + 1
                End If
                j = j + 1
            Loop
            Exit For
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

Function GetQuotedString(line As String, quoteIndex As Long) As String
    Dim parts() As String
    parts = Split(line, """")
    'Loop through all parts and return the quoted string
    Dim i As Long
    Dim matchCount As Integer
    For i = LBound(parts) To UBound(parts)
        If Len(Trim(parts(i))) > 0 Then
            matchCount = matchCount + 1
            If matchCount = quoteIndex * 2 Then 'Quoted strings are in even positions
                GetQuotedString = CStr(parts(i))
                Exit Function
            End If
        End If
    Next i
    GetQuotedString = ""
End Function
```
## Conclusion
- Reading data from an e2k file is one of the best ways to extract model info from ETABS, since you don't have to work with the ETABS API.
- This is just sample code to get you started; you still have to adjust your code as per each section's data pattern.
- You can also scan the model unit from the `$ CONTROLS` section to avoid any unit-related errors.
- The current version of the code is written to be beginner-friendly and is not optimized for large models.
- You might need to do some optimization if you want to reduce execution time for large models.
