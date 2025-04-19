---
title: How to add notes with images on excel using VBA
description : VBA code to add note with image
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
  - Add some explanation for your data in the form of image 
  - for example,
    - Geometry or section drawings
    - Design Codes clause, tables, charts

## How to add image note manually
- Right click on any cell and select "New Note"
- Pick corner point of this new note and right click again and select "format comment"
- From Colors and line choose fill effects
- Set picture for background and click OK
- I also have YouTube short for this : [How to add image note in excel](https://youtube.com/shorts/suC2KHb9aSY)

## Insert note with image VBA code

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
- This is simple way to improve your excel documentation and reference 
- This won't take any extra space on your sheet and won't be visible when you print your sheet
- So, use
  -  Note with images when you don't want display in printout
  -  Insert Image option when you want to display in printout
 

 > If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1k2wmb2/how_to_add_notes_with_images_on_excel_using_vba/)
{: .prompt-info }