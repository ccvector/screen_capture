#SingleInstance force

#c::
    IfNotExist images
        {
            FileCreateDir images
            Sleep 500
        }
    IfNotExist diff_output
        {
            FileCreateDir diff_output
            Sleep 500
        }
    Loop 2000
    {
        num = %A_Index%
        loopStringAddZeroes:
            if (StrLen(num) < 5)
            {
                num := "0" num
                Goto loopStringAddZeroes
            }
        current_file := "images\c" num ".jpg"
        Run CmdCaptureWin.exe -u 100 /f %current_file%
        Sleep 500
        Send {Right}
        Sleep 500
        if (A_Index > 1)
        {
            diff_output := "diff_output/diff" num ".txt"
            Run %comspec% /c diff %previous_file% %current_file% > %diff_output%
            Sleep 500
            FileGetSize, size, %diff_output%
            Sleep 500
            if size = 0
                Break
        }
        previous_file := current_file
        Sleep 500
    }
    Sleep 500
    MsgBox Done!!!
    Return

