#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Singleinstance, Force

nothing := 0
_transparent := 0

global b := 0
global p := 0
global n := 0
t := b+p+n

global FILENAME := "GI.txt"

FileAppend,, %FILENAME%
FileRead, Contents, %FILENAME%

if Contents
    Loop, parse, Contents, `,
        if (A_Index == 1)
            b := A_LoopField
        else if (A_Index == 2)
            p := A_LoopField
        else if (A_Index == 3)
            n := A_LoopField

sHeight := A_ScreenHeight-220
sWidth := A_ScreenWidth-250

_P := "CB7CFE"
_B := "5F88C7"
_W := "FFFFFF"

xd := 30
yd := 40
wd := 100

Gui, Font, s32, Arial
Gui, Add, Text, c%_B% y0 x0, B
Gui, Add, Text, c%_P% yp+%yd%, P
if nothing
    Gui, Add, Text, c%_W% yp+%yd%, N
Gui, Add, Text, c%_W% yp+%yd%, T
Gui, Add, Text, Right vT11 c%_B% w%wd% xp+%xd% h40 y0, %b%
Gui, Add, Text, Right vT21 c%_P% w%wd% yp+%yd% h40, %p%
if nothing
    Gui, Add, Text, Right vT31 c%_W% w%wd% yp+%yd% h40, %n%
Gui, Add, Text, Right vT4  c%_W% w%wd% yp+%yd%, %t%
Gui, Add, Text, Right vT12 c%_B% w%wd% xp+%wd% y0 h40
Gui, Add, Text, Right vT22 c%_P% w%wd% yp+%yd% h40
if nothing
    Gui, Add, Text, Right vT32 c%_W% w%wd% yp+%yd% h40

Gui +LastFound +AlwaysOnTop +ToolWindow -Caption
Gui, Color, 000000
if _transparent
    WinSet, TransColor, 000000

hd := yd*(3+nothing)+5
wd := xd+wd*2
Gui, Show, w%wd% h%hd% x%sWidth% y%sHeight%
upd_purp(0)
upd_blue(0)
if nothing
    upd_nthg(0)

w2f()
{
    t := b+p+n
    GuiControl,, T4, %t%
    
    per := Floor(b / (b+p+n) * 100)
    GuiControl,, T12, %per%`%
    per := Floor(p / (b+p+n) * 100)
    GuiControl,, T22, %per%`%
    per := Floor(n / (b+p+n) * 100)
    GuiControl,, T32, %per%`%
    
    FileDelete, %FILENAME%
    s = %b%,%p%,%n%
    FileAppend, %s%, %FILENAME%
}

upd_blue(i)
{
    b := b + i
    GuiControl,, T11, %b%
    w2f()
}
upd_purp(i)
{
    p := p + i
    GuiControl,, T21, %p%
    w2f()
}
upd_nthg(i)
{
    n := n + i
    GuiControl,, T31, %n%
    w2f()
}

F1:: upd_blue(1)
+F1:: upd_blue(-1)
F2:: upd_purp(1)
+F2:: upd_purp(-1)
F3:: upd_nthg(1)
+F3:: upd_nthg(-1)
F4:: Gui, Minimize
+F4:: Gui, Restore
