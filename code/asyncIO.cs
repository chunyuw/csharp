using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;

class asyncIO
{
  static NetworkStream n;
  static byte[] rbuf, wbuf;
  static AsyncCallback readCall, writeCall;
  static void Main()
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
	      n.BeginWrite(wbuf, 0, wbuf.Length, writeCall, null);
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
