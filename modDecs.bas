Attribute VB_Name = "modDecs"
'*******************************************************************************
' MODULE:       modDecs
' FILENAME:     modDecs.bas
' AUTHOR:       Ryan Lamvohee
' CREATED:      15-Oct-2005
' COPYRIGHT:    None at all, all i ask is that you credit me if you use this for any of your games.
'
' DESCRIPTION:
' All the Declarations of important variables are stored here
'
' MODIFICATION HISTORY:
' 1.0       15-Oct-2005
'           Ryan Lamvohee
'           Changed from If VbKeycode = to GetAsyncKeyState
'           As it is much faster and makes smoother gameplay.
'*******************************************************************************

'Declarations
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function TransparentBlt Lib "msimg32.dll" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal crTransparent As Long) As Boolean
Public Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer

'Used to set the players view
Public CameraX As Integer
Public CameraY As Integer

'Is the game running
Public GameEnd As Boolean

'Variables for the surfaces
Public BufferDC As Long
Public TileDC As Long
Public Buffer2 As Long

'Max map sizes
Public Const MAPSIZEX = 27
Public Const MAPSIZEY = 24

'the map fileformat its self
Public Map(27, 24) As typeMap
Type typeMap
    L1X As Integer
    L1Y As Integer
    OBJX As Integer
    OBJY As Integer
    OBJ2X As Integer
    OBJ2Y As Integer
    SkyX As Integer
    SkyY As Integer
    Collision As Boolean
End Type

'Player things
Public PlayerX As Integer
Public PlayerY As Integer
Public PlayerFrame As Integer
Public PlayerDirection As Integer
