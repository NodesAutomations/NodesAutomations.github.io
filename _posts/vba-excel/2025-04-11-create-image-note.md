---
title: How to Add Image Note on Excel using VBA
description : VBA code to add image note
date: 11-04-2025
categories: [VBA, VBA-Excel]
tag: [excel, vba,howto]
image: /assets/images/excel/excel-image-note.webp
---

## Overview
- In this tutorial, I'll show you how to add image notes to excel
- What is excel image note?
  - when you right click on any cell, you'll have option to add "New Note"
  - It's good way to add some text information to your excel sheet
  - But for image note instead of adding text we add image via small hack
- Why?
  - Add some explaination for your data in form of image 
  - for example 
    - Geometry or section drawings
    - Design Codes clause, tables, charts

## How to add image note manually


## Setup

```vb
Sub InsertComment()

    'Select Image to Insert
    Dim imagePath As String
    With Application.FileDialog(msoFileDialogFilePicker)
        .Title = "Select an Image"
        .Filters.Add "Images", "*.jpg; *.jpeg; *.png; *.gif; *.bmp"
        .AllowMultiSelect = False
        
        'If user selects a file and clicks OK
        If .Show = -1 Then
            imagePath = .SelectedItems(1)
        Else
            'User cancelled the dialog
            MsgBox "No image was selected. Operation cancelled.", vbInformation
            Exit Sub
        End If
    End With
    
    'Get active Cell
    Dim rng As range
    Set rng = ActiveCell
 
    ' Clear any existing note/comment in the active cell
    If Not rng.Comment Is Nothing Then
        rng.Comment.Delete
    End If
    
    ' Add a new note to the active cell with the text "New Note"
    Dim note As Comment
    Set note = rng.AddComment
    
    'Update Note Text
    note.Text Text:=""
    
    'Set Background Fill
    With note.shape
        .Fill.UserPicture imagePath
        .Width = 200
        .Height = 100
    End With

End Sub
```

## Conclusion
 