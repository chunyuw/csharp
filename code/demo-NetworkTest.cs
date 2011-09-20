using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;

class Program
{
  static byte[] buf;
  static AsyncCallback read;
  static NetworkStream n;
  static void Main()
  {


    TcpClient c = new TcpClient();
    c.Connect("localhost", 4242);
    n = c.GetStream();

    buf = new byte[4];

    read += readfunc;
    n.BeginRead(buf, 0, buf.Length, read, null);
    // for write
    string s = Console.ReadLine();
    while (s != "quit")
      {
	byte[] ww = Encoding.GetEncoding("gbk").GetBytes(s+"\n");
	n.Write(ww, 0, ww.Length);
	s = Console.ReadLine();
      }
    n.Close();
    c.Close();

  }
  public static void readfunc(IAsyncResult ar)
  {
    int len = n.EndRead(ar);
    if (len > 0)
      {
	string ns = Encoding.GetEncoding("gbk").GetString(buf, 0, len);
	Console.Write(ns);
	//for read: buf
	n.BeginRead(buf, 0, buf.Length, read, null);
      }
  }
  static void Main7()
  {
    TcpListener server = new TcpListener(IPAddress.Any, 4343);
    server.Start();
    Console.WriteLine("listening....");
    while (true)
      using (TcpClient c = server.AcceptTcpClient())
	using (NetworkStream n = c.GetStream())
	  {
	    Console.WriteLine("accepted");
	    n.WriteByte(65);
	    n.WriteByte(66);
	    n.WriteByte(67);
	    BinaryWriter w = new BinaryWriter(n);
	    w.Write("Hello world~~~");
	    w.Flush(); // Must call Flush because we're not
	  } // disposing the writer.
    server.Stop();
  }
  static void Main6()
  {
    using (TcpClient client = new TcpClient("localhost", 4242))
      using (NetworkStream n = client.GetStream())
	{
	  BinaryWriter w = new BinaryWriter(n);
	  //BinaryReader r = new BinaryReader(n);
	  w.Write("Hello");
	  w.Flush();
	  //Console.WriteLine(r.ReadString());

	}
  }
  static void Main5()
  {
    WebClient w = new WebClient();
    w.DownloadFile("http://localhost:8000/aoe2.7z", "test.bin");

    string s = w.DownloadString("http://localhost:8000/text.txt");
    Console.WriteLine(s);
  }
}
