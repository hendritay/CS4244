   Dim p As New Process()
        p.StartInfo.UseShellExecute = False

        p.StartInfo.RedirectStandardInput = True
        p.StartInfo.RedirectStandardOutput = True

        p.StartInfo.FileName = "C:\Study\CS4244\CLIPS.exe"

        p.Start()




        Dim pWrite As System.IO.StreamWriter = p.StandardInput
        Dim pOuput As System.IO.StreamReader = p.StandardOutput


        pWrite.WriteLine("(l)")
        pWrite.WriteLine("(watch facts)")
        pWrite.WriteLine("(assert (haha))")
        Console.Write(pOuput.Read())

        Console.Write(pOuput.ReadLine())
        Console.Write(pOuput.ReadLine())
        Console.Write(pOuput.ReadLine())
        Console.Write(pOuput.ReadLine())
        Console.Write(pOuput.ReadLine())