Attribute VB_Name = "modInit"
'*******************************************************************************
' MODULE:       modInit
' FILENAME:     modInit.bas
' AUTHOR:       Ryan Lamvohee
' CREATED:      15-Oct-2005
' COPYRIGHT:    None at all, all i ask is that you credit me if you use this for any of your games.
'
' DESCRIPTION:
' This is the file in which the surfaces are generated and the map is loaded
'
' MODIFICATION HISTORY:
' 1.0       15-Oct-2005
'           Ryan Lamvohee
'           NO_MODS
'*******************************************************************************

Sub InitSurfaces()
    'Initialize the surfaces to draw onto
    BufferDC = CreateCompatibleDC(frmMain.hdc)
    SelectObject BufferDC, frmMain.picBuffer.Picture
    
    Buffer2 = CreateCompatibleDC(frmMain.hdc)
    SelectObject Buffer2, frmMain.picBuffer2.Picture
    
    TileDC = CreateCompatibleDC(frmMain.hdc)
    SelectObject TileDC, frmMain.picTiles.Picture

End Sub

Sub Destroy()
    'Destroy them
    DeleteDC BufferDC
    DeleteDC buffer
    DeleteDC TileDC
End Sub

Sub OpenMap(Path As String)
    'Open the map i made (the map is made in a special mapeditor that i use a fair bit so i am not relesing it
    On Error GoTo Err:

        Open Path For Binary As #1
            Get #1, , Map
        Close #1
        DrawBuffer
        
    Exit Sub
Err:
    MsgBox "Did not open.", vbCritical, "WHAT!"
End Sub
