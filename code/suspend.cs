
using System;
using System.Runtime.InteropServices;


class suspend
{
  [DllImport( "powrprof.dll", EntryPoint="SetSuspendState", CharSet=CharSet.Ansi )]
  private static extern int SetSuspendState(int Hibernate, int ForceCritical, int DisableWakeEvent);
  // [DllImport( "powrprof.dll", EntryPoint="IsPwrSuspendAllowed", CharSet=CharSet.Ansi )]
  // private static extern bool IsPwrSuspendAllowed();
  public static void Main(string[] args)
  {
    int ForceCritical = 0;
    int Hibernate = 1;
    
    foreach(string x in args)
    {
      if ("/f" == x)
	ForceCritical = 1;
      if (("/suspend" == x) || ("/sus" == x) || ("/s" == x))
	Hibernate = 0;
      if (("/?" == x) || ("/h" == x) || ("/help" == x))
      { Help(); return; }
      
    }
    // if (IsPwrSuspendAllowed())
    // {
    SetSuspendState(Hibernate, ForceCritical, 0);
    // }
  }

  public static void Help()
  {
    Console.WriteLine ("/f  --  Force Critical\n/s, /sus, /suspend  --  Suspend instead of hibernate\n");
  }
}
