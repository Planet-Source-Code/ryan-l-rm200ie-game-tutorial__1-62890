Attribute VB_Name = "modDraw"
'*******************************************************************************
' MODULE:       modDraw
' FILENAME:     modDraw.bas
' AUTHOR:       Ryan Lamvohee
' CREATED:      15-Oct-2005
' COPYRIGHT:    None at all, all i ask is that you credit me if you use this for any of your games.
'
' DESCRIPTION:
' Most of the bitblting is done here its drawn onto a buffer
' then put into the main picture box
'
' MODIFICATION HISTORY:
' 1.0       15-Oct-2005
'           Ryan Lamvohee
'           Changed tileset from 32x32 to 16x16 with a new draw sub
'           As it is much faster and makes smoother gameplay.
'*******************************************************************************

Sub DrawBuffer()
On Error Resume Next
Dim PX, PY As Integer

    'This gets the players X and Y cords
    PX = Int(PlayerX / 16)
    PY = Int(PlayerY / 16)
    
    'then displays them
    frmMain.Caption = PX & "," & PY

    'loop through all of the map
    For x = 0 To MAPSIZEX
        
        For y = 0 To MAPSIZEY
            
            'Do your bitblt things to draw onto the screen
            If Map(x, y).L1X = 0 And Map(x, y).L1Y = 0 Then
            Else
                BitBlt BufferDC, x * 16, y * 16, 16, 16, TileDC, Map(x, y).L1X * 16, Map(x, y).L1Y * 16, vbSrcCopy
            End If
            
            If Map(x, y).OBJX = 0 And Map(x, y).OBJY = 0 Then
            Else
                TransparentBlt BufferDC, x * 16, y * 16, 16, 16, TileDC, Map(x, y).OBJX * 16, Map(x, y).OBJY * 16, 16, 16, vbBlue
            End If

               
            If Map(x, y).OBJ2X = 0 And Map(x, y).OBJ2Y = 0 Then
            Else
                TransparentBlt BufferDC, x * 16, y * 16, 16, 16, TileDC, Map(x, y).OBJ2X * 16, Map(x, y).OBJ2Y * 16, 16, 16, vbBlue
            End If
            
            If Map(x, y).SkyX = 0 And Map(x, y).SkyY = 0 Then
            Else
                TransparentBlt BufferDC, x * 16, y * 16, 16, 16, TileDC, Map(x, y).SkyX * 16, Map(x, y).SkyY * 16, 16, 16, vbBlue
            End If
             
        Next y
    Next x

    'then draw our lovely hero in the center
    TransparentBlt BufferDC, PlayerX, PlayerY - 9, 16, 21, frmMain.picPlayer.hdc, PlayerFrame * 16, PlayerDirection * 21, 16, 21, vbBlue

End Sub

Sub DrawScreen(x As Integer, y As Integer)
    frmMain.picMap.Cls
        
    'Anything that changes do here
        
    'Allways draw buffer b4 blitting 2 screen 2 show anyupdates
    DrawBuffer
        
DrawTOWinD:
    '32x32
    'StretchBlt frmMain.picMap.hdc, 0, 0, 416, 352, Buffer2, 0, 0, 208, 176, vbSrcCopy
    '16x16 (classic GB Style)
    BitBlt frmMain.picMap.hdc, 0, 0, 240, 160, BufferDC, x, y, vbSrcCopy
    frmMain.picMap.Refresh
End Sub

Function PanCamera(x As Long, y As Long)
    Dim intLoop As Integer
    Dim lngOldTime As Long
    Dim intIncriment As Long
    
    'This is the distance the player moves e.g if it were 2 the player would move 2 pixels
    intIncriment = 1
    
    'We create a loop of 16
    For intLoop = 1 To 16
        lngOldTime = GetTickCount
        
        Do
        Loop Until (GetTickCount) >= lngOldTime
        
        Select Case x
            Case -1 'Left
                CameraX = CameraX - intIncriment
                PlayerX = PlayerX - intIncriment
                PlayerDirection = 1
            Case 1 'Right
                CameraX = CameraX + intIncriment
                PlayerX = PlayerX + intIncriment
                PlayerDirection = 3
        End Select
        
        Select Case y
            Case -1 'Up
                CameraY = CameraY - intIncriment
                PlayerY = PlayerY - intIncriment
                PlayerDirection = 0
            Case 1 'Down
                CameraY = CameraY + intIncriment
                PlayerY = PlayerY + intIncriment
                PlayerDirection = 2
        End Select
        
        'Animate the player
        DoAnimation (intLoop)
        'Update the screen
        DrawScreen CameraX, CameraY
    Next intLoop
    
End Function

Function PanPlayer(x As Long, y As Long)
    'This function is exactly the same as the one above except
    'i have removed the Camera Scrolling so when were neer the
    'Edge of a map it doesnt move the camera
    Dim intLoop As Integer
    Dim lngOldTime As Long
    Dim intIncriment As Long
    
    intIncriment = 1
    
    For intLoop = 1 To 16
        lngOldTime = GetTickCount
        
        Do
        Loop Until (GetTickCount) >= lngOldTime
        
        Select Case x
            Case -1
                PlayerX = PlayerX - intIncriment
                PlayerDirection = 1
            Case 1
                PlayerX = PlayerX + intIncriment
                PlayerDirection = 3
        End Select
        
        Select Case y
            Case -1
                PlayerY = PlayerY - intIncriment
                PlayerDirection = 0
            Case 1
                PlayerY = PlayerY + intIncriment
                PlayerDirection = 2
        End Select
        
        DoAnimation (intLoop)
        DrawScreen CameraX, CameraY
    Next intLoop
    
End Function

Sub DoAnimation(loopPos As Integer)
    'Fairly Understandable lol
    If PlayerFrame = 3 Then PlayerFrame = 0: Exit Sub
    
    If loopPos = 2 Then
        PlayerFrame = PlayerFrame + 1
    ElseIf loopPos = 4 Then
        'PlayerFrame = PlayerFrame + 1
    ElseIf loopPos = 6 Then
        PlayerFrame = PlayerFrame + 1
    ElseIf loopPos = 8 Then
        'PlayerFrame = PlayerFrame + 1
    End If
    
End Sub

Function CheckBlocked(x As Integer, y As Integer, PX As Integer, PY As Integer) As Boolean
        'check for collisions
        Select Case x
            Case -1
                If Map(PX - 1, PY).Collision = True Then CheckBlocked = True
            Case 1
                If Map(PX + 1, PY).Collision = True Then CheckBlocked = True
        End Select
        
        Select Case y
            Case -1
                If Map(PX, PY - 1).Collision = True Then CheckBlocked = True
            Case 1
                If Map(PX, PY + 1).Collision = True Then CheckBlocked = True
        End Select
    
End Function
