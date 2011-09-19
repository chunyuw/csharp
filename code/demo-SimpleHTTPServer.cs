using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Net;
using System.Threading;

class Program
{
  static void Main()
  {
    new System.Threading.Thread(Listen).Start();
    Console.ReadLine();
    // Thread.Sleep(500);

    WebClient wc = new WebClient();
    Console.WriteLine(wc.DownloadString
		      ("http://localhost:51111/MyApp/Request.txt"));
  }
  static void Listen()
  {
    HttpListener listener = new HttpListener();
    listener.Prefixes.Add("http://localhost:51111/MyApp/"); // Listen on
    listener.Start(); // port 51111.

    Console.WriteLine("I'm Listening...");
    Console.WriteLine("Wait for a client request...");

    HttpListenerContext context = listener.GetContext();
    Console.WriteLine("Connected. Respond to the request...");

    string msg = "You asked for: " + context.Request.RawUrl;
    context.Response.ContentLength64 = Encoding.UTF8.GetByteCount(msg);
    context.Response.StatusCode = (int)HttpStatusCode.OK;
    using (Stream s = context.Response.OutputStream)
      using (StreamWriter writer = new StreamWriter(s))
	writer.Write(msg);
    listener.Stop();
    Console.WriteLine("Done. Listener stoped.");
  }
}
