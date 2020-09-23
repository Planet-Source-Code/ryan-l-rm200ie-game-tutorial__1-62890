Attribute VB_Name = "modKeys"
'*******************************************************************************
' MODULE:       modKeys
' FILENAME:     modKeys.bas
' AUTHOR:       Ryan Lamvohee
' CREATED:      15-Oct-2005
' COPYRIGHT:    None at all, all i ask is that you credit me if you use this for any of your games.
'
' DESCRIPTION:
' This file is for keypresses and Boundry checking
'
' MODIFICATION HISTORY:
' 1.0       15-Oct-2005
'           Ryan Lamvohee
'           GetAsyncKeyState now being used insted of if vbkey =
'*******************************************************************************

Sub HandleKeyPress()
'each one of these is fairly the same if key is pressed down check for a blocked tile infront of u
'if there is a blocked tile dont move lol if there isnt a blocked tile find out if we are going to
'scroll the camera or just move the player
    If GetAsyncKeyState(vbKeyRight) Then
        If CheckBlocked(1, 0, Int(PlayerX / 16), Int(PlayerY / 16)) Then Exit Sub
        If CheckToScroll(1, 0) = True Then
            PanCamera 1, 0
        Else
            PanPlayer 1, 0
        End If
    End If
    
    If GetAsyncKeyState(vbKeyLeft) Then
        If CheckBlocked(-1, 0, Int(PlayerX / 16), Int(PlayerY / 16)) Then Exit Sub
        If CheckToScroll(-1, 0) = True Then
            PanCamera -1, 0
        Else
            PanPlayer -1, 0
        End If
    End If
    
    If GetAsyncKeyState(vbKeyUp) Then
        If CheckBlocked(0, -1, Int(PlayerX / 16), Int(PlayerY / 16)) Then Exit Sub
        If CheckToScroll(0, -1) = True Then
            PanCamera 0, -1
        Else
            PanPlayer 0, -1
        End If
    End If
    
    If GetAsyncKeyState(vbKeyDown) Then
        If CheckBlocked(0, 1, Int(PlayerX / 16), Int(PlayerY / 16)) Then Exit Sub
        If CheckToScroll(0, 1) = True Then
            PanCamera 0, 1
        Else
            PanPlayer 0, 1
        End If
    End If
End Sub

Function CheckToScroll(x As Integer, y As Integer) As Boolean
'And this is the sub that checks if your character is neer the edge of a map
Dim PX, PY As Integer

    PX = Int(PlayerX / 16)
    PY = Int(PlayerY / 16)
    
        Select Case x
            Case -1
                If PX <= 7 Then CheckToScroll = False: Exit Function Else CheckToScroll = True
                If PX >= (MAPSIZEX - 6) Then CheckToScroll = False Else CheckToScroll = True
            Case 1
                If PX <= 6 Then CheckToScroll = False: Exit Function Else CheckToScroll = True
                If PX >= (MAPSIZEX - 7) Then CheckToScroll = False Else CheckToScroll = True
        End Select
        
        Select Case y
            Case -1 'U
                If PY <= 5 Then CheckToScroll = False: Exit Function Else CheckToScroll = True
                If PY >= (MAPSIZEY - 3) Then CheckToScroll = False Else CheckToScroll = True
            Case 1 'D
                If PY <= 4 Then CheckToScroll = False: Exit Function Else CheckToScroll = True
                If PY >= (MAPSIZEY - 4) Then CheckToScroll = False Else CheckToScroll = True
        End Select

End Function
