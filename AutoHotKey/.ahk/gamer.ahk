#HotIf WinActive("METAL GEAR SOLID V: THE PHANTOM PAIN")

XButton1:: {
    Send("{9 down}")
    KeyWait("XButton1")
    Send("{9 up}")
    return
}

XButton2:: {
    Send("{0 down}")
    KeyWait("XButton2")
    Send("{0 up}")
    return
}

!Tab:: Send "{Tab}"

!Space:: Send " "  ; Disable shortcut of PowerToys Run

#HotIf