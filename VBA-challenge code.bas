Attribute VB_Name = "Module1"
Sub multiyear()
'OMG I think this worked

Dim stock As String

Dim count_rows As Long
count_rows = Cells(Rows.Count, 1).End(xlUp).Row

Dim volume_sum As Double
volume_sum = 0

Dim summary_row As Integer
summary_row = 2

Dim open_price As Double
Dim close_price As Double
Dim net_change As Double
Dim percent_change As Double

Dim headers(4) As String
headers(0) = "Ticker"
headers(1) = "Yearly Change"
headers(2) = "Percent Change"
headers(3) = "Total Stock Volume"

Cells(1, 9).Value = headers(0)
Cells(1, 10).Value = headers(1)
Cells(1, 11).Value = headers(2)
Cells(1, 12).Value = headers(3)
Range("I1:L1").Font.Bold = True

    For i = 2 To count_rows
    
        If Cells(i, 1).Value <> Cells(i - 1, 1).Value Then
            
            stock = Cells(i, 1).Value
            open_price = Range("C" & i).Value
            volume_sum = Range("D" & i).Value
        
        ElseIf Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        
            close_price = Range("F" & i).Value
            net_change = close_price - open_price
            
                If open_price = 0 Then
                    percent_change = close_price - open_price
                ElseIf open_price <> 0 Then
                    percent_change = ((close_price - open_price) / open_price)
                End If
            
            Range("K:K").NumberFormat = "0.00%; [red]-0.00%"
            
            volume_sum = Round(volume_sum + Cells(i, 7).Value, 0)
        
            Range("I" & summary_row).Value = stock
            Range("J" & summary_row).Value = net_change
            Range("K" & summary_row).Value = percent_change
            Range("L" & summary_row).Value = volume_sum
            
            summary_row = summary_row + 1
                
            volume_sum = 0
            percent_change = 0
        
        Else
            
            volume_sum = Round(volume_sum + Cells(i, 7).Value, 0)
                   
        End If
        
        Next i

Dim cell As Range
Set NetChangeColor = Range("J:J")
            
    For Each cell In NetChangeColor
        If cell.Value < 0 Then
            cell.Interior.Color = RGB(255, 0, 0)
        ElseIf cell.Value > 0 Then
            cell.Interior.Color = RGB(0, 255, 0)
        End If
    Next
    
Columns("I:L").Select
Selection.EntireColumn.AutoFit

End Sub
