using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

class Program
{
  static void Main()
  {
    
  }
  static void Main1()
  {
    FileStream f = new FileStream(@"d:\download\dotnet\fs-test.ext", FileMode.OpenOrCreate);
    f.WriteByte(20);
    f.WriteByte(32);
    f.WriteByte(0x99);
    f.Close();

  }
  static void Main2()
  {
    FileStream n = new FileStream(@"d:\download\dotnet\fs-test.ext", FileMode.Open);
    byte[] b = new byte[3];
    n.Read(b, 0, 3);
    n.Close();

    foreach (byte i in b)
      Console.WriteLine("{0} -- {0:x}", i, i);

  }
  static void Main3()
  {
    FileStream f = new FileStream(@"d:\download\dotnet\stream-writer.txt", FileMode.OpenOrCreate);
    StreamWriter w = new StreamWriter(f, Encoding.GetEncoding("big5"));
    w.WriteLine("<html><body><h1>123 ABC ¹þ –žI¹¤˜I´óŒW</h1></body></html>");
    w.Flush();
    w.Close();
    f.Close();
  }
        
        
  static void Main4()
  {
    BinaryWriter b = new BinaryWriter(File.Open(@"d:\download\dotnet\binary.dat", FileMode.OpenOrCreate));
    b.Write(0x1L);
    b.Close();
  }

  static void Main5()
  {
    string s = File.ReadAllText(@"d:\Download\dotnet\data\article.txt");
    //string s = File.ReadAllText(@"d:\Download\dotnet\text.txt",Encoding.GetEncoding("gbk"));

    Console.WriteLine(s);

  }

  static void Main6()
  {
    SortedDictionary<char, char> d = new SortedDictionary<char, char>();
    StreamReader dr = new StreamReader(@"d:\Download\dotnet\data\table.txt", Encoding.GetEncoding("gbk"));
    string s;
    while ((s = dr.ReadLine()) != null)
      {
	char[] kv = s.ToCharArray();
	d.Add(kv[0], kv[1]);
      }
    dr.Close();

    StreamReader r = new StreamReader(@"d:\Download\dotnet\data\Thor.2011.720p.BluRay.x264-Felony.big5.srt", Encoding.GetEncoding("big5"));
    StreamWriter w = new StreamWriter(@"d:\Download\dotnet\data\Thor.2011.720p.BluRay.x264-Felony.gbk.srt", false, Encoding.GetEncoding("gbk"));

    while ((s = r.ReadLine()) != null)
      {
	char[] ca = s.ToCharArray();
	for (int i = 0; i < ca.Length; i++)
	  {
	    //Console.Write(ca[i]);
	    ca[i] = d.ContainsKey(ca[i]) ? d[ca[i]] : ca[i];

	  }
	w.WriteLine(new string(ca));
      }
    r.Close();
    w.Close();
  }
  static void Main7(string[] args)
  {
    var w = new FileSystemWatcher(@"d:\download", "*.txt");
    w.Created += watcher;
    w.Deleted += watcher;
    w.Changed += watcher;
    w.Renamed += (s, e) => 
      Console.WriteLine("renamed " + e.OldName + "->" + e.Name);

    w.IncludeSubdirectories = true;
    w.EnableRaisingEvents = true;
    Console.WriteLine("Now I'm watching...");
    Console.ReadLine();
  }

  static void watcher(object sender, FileSystemEventArgs e)
  {
    Console.WriteLine("file " + e.ChangeType + ": " + e.FullPath);
  }
}
