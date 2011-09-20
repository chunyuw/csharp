using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;

class Program
{
  static void Main1()
  {
    WebClient w = new WebClient();
    w.DownloadFile("http://localhost:8000/data/article.txt", "file.txt");
  }
  static void Main2()
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
  static void Main3()
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

  static NetworkStream n;
  static byte[] rbuf, wbuf;
  static AsyncCallback readCall, writeCall;
  static void Main4()
  {
    rbuf = new byte[10];
    readCall += readFunc;
    writeCall += r => n.EndWrite(r);

    using (TcpClient client = new TcpClient("localhost", 4242))
      using (n = client.GetStream())
	{
	  n.BeginRead(rbuf, 0, rbuf.Length, readCall, null);
	  while (true)
	    {
	      string s = Console.ReadLine();
	      wbuf = Encoding.GetEncoding("gb18030").GetBytes(s + "\n");
	      n.Write(wbuf, 0, wbuf.Length);
	      //n.BeginWrite(wbuf, 0, wbuf.Length, writeCall, null);
	    }
	}

  }
  static void readFunc(IAsyncResult r)
  {
    int len = n.EndRead(r);
    if (len > 0)
      {
	string s = Encoding.GetEncoding("gb18030").GetString(rbuf, 0, len);
	Console.Write(s);
	n.BeginRead(rbuf, 0, rbuf.Length, readCall, null);
      }

  }

}
