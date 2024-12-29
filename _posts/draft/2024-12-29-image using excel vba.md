---
title: How to create image dropdown using excel vba
description : learn how to create image,shape,chart,formula dropdown using Excel VBA
date: 29-12-2024
categories: [VBA, Excel]
tag: [excel, vba,howto]
image: /assets/images/excel/excel-image-dropdown.webp
published: false
---

### Overview
- Creating image dropdown is most comman requirement Amoung engineers who uses excel on daily basis
- Using image dropdown you can
  - Display different geomerty/sections for your design sheets
  - Display formula for different calculation
  - Display bar shapes for bbs
  - Display different charts for visuals or summary
- It's also usefull when you don't have enough space for multiple images on sheet. Using dropdown you can place multiple images at same location and switch between different image as requirement
- In this tuturial i'll teach you how to setup image dropdown using VBA
- If you don't know how to work with excel macro then watch this video first: [How to create or use excel macro Tutorial](https://www.youtube.com/watch?v=Tepc4iioSaA)

### Setup
- Create new macro-enable excel sheet
- Import your Images to excel file

### VBA code to update image shape
```vb
Public Sub UpdateActiveShape()
    Call UpdateShape(ActiveCell)
End Sub

Public Sub UpdateShape(inputCell As Range)
    Dim i As Integer
    Dim shape As shape
    Dim shapeData() As String
 
    'Check if active cell contain data validation
    If HasDataValidation(inputCell) Then
        'Get list of shapes to loop through
        shapeData = Split(inputCell.Validation.Formula1, ",")
        For i = LBound(shapeData) To UBound(shapeData)
            
            Set shape = activeSheet.shapes(shapeData(i))
            If shapeData(i) = inputCell.Value2 Then
                shape.Visible = msoTrue
            Else
                shape.Visible = msoFalse
            End If
        Next i
    End If
    
End Sub

Private Function HasDataValidation(cell As Range) As Boolean
    On Error GoTo ErrorHandler
    
    Dim formula As String
    formula = cell.Validation.Formula1
    
Done:
    HasDataValidation = True
    Exit Function
ErrorHandler:
    HasDataValidation = False
End Function
```

### Excel cell value change event
```vb
Private Sub Worksheet_Change(ByVal Target As Range)
    If Not Intersect(Target, Me.Range("BarDropDown")) Is Nothing Then
        Call ShapeDropdown.UpdateActiveShape
    End If
End Sub
```

### Future Modification
- Instead of manually entering items in your dropdown, you can use Indirect function take inputs from Range or Table
- Instead of updating single group of images, you can update images at multiple locations using single dropdown

### Conclusion

