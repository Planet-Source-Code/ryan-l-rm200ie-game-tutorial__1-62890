VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "PokemonPC"
   ClientHeight    =   2415
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3600
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMain.frx":0000
   ScaleHeight     =   161
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   240
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox picBuffer2 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   1740
      Left            =   7560
      Picture         =   "frmMain.frx":8742
      ScaleHeight     =   112
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   104
      TabIndex        =   4
      Top             =   0
      Visible         =   0   'False
      Width           =   1620
   End
   Begin VB.PictureBox picMap 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000007&
      BeginProperty Font 
         Name            =   "Pokemon RS"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2415
      Left            =   0
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   239
      TabIndex        =   0
      Top             =   0
      Width           =   3615
      Begin VB.Timer tmrKeys 
         Interval        =   1
         Left            =   3120
         Top             =   1920
      End
   End
   Begin VB.PictureBox picPlayer 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1290
      Left            =   5880
      Picture         =   "frmMain.frx":9759
      ScaleHeight     =   84
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   64
      TabIndex        =   3
      Top             =   1800
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.PictureBox picBuffer 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   1740
      Left            =   5880
      Picture         =   "frmMain.frx":D69B
      ScaleHeight     =   112
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   104
      TabIndex        =   2
      Top             =   0
      Visible         =   0   'False
      Width           =   1620
   End
   Begin VB.PictureBox picTiles 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   89040
      Left            =   3720
      Picture         =   "frmMain.frx":E6B2
      ScaleHeight     =   5936
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   128
      TabIndex        =   1
      Top             =   0
      Visible         =   0   'False
      Width           =   1920
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*******************************************************************************
' FORM NAME:    frmMain
' FILENAME:     frmMain.frm
' AUTHOR:       Ryan Lamvohee
' CREATED:      15-Oct-2005
' COPYRIGHT:    None at all, all i ask is that you credit me if you use this for any of your games.
'
' DESCRIPTION:
' This is the main form which displays the game the game is
' Initialized here
'
'*******************************************************************************

Private Sub Form_Load()
    'some basic setup instructions lol
    Call InitSurfaces
    Call OpenMap(App.Path & "\Games\Sample\Test 1.PMX")
    PlayerX = 7 * 16
    PlayerY = 5 * 16
    Call DrawScreen(0, 0)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'this just makes sure the game shuts down properly
    GameEnd = True
    Call Destroy
End Sub

Private Sub tmrKeys_Timer()
    'handle the key preses
    Call HandleKeyPress
End Sub
