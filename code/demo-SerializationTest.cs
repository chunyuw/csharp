using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Runtime.Serialization.Formatters.Binary;


[Serializable]
class Circle
{
  public int R { get; set; }
  public Circle(int x) { this.R = x; }
  public override string ToString()
  {
    return "I'm Circle with Radius(" + this.R + ")";
  }
  public Circle next { get; set; }

}
class Program
{
  static Circle c;
  static void Main()
  {
    string action = Console.ReadLine();


    if (action == "save")
      {

	func1();
	FileStream f = new FileStream(@"d:\download\circle-list.bin", FileMode.OpenOrCreate);
	BinaryFormatter bf = new BinaryFormatter();
	bf.Serialize(f, c);
	//bf.Serialize(f, c.next.next);
	f.Close();
      }
    else if (action == "load")
      {
	Console.WriteLine("I'm going to read the list");
	FileStream r = new FileStream(@"d:\download\circle-list.bin", FileMode.Open);
	BinaryFormatter rbf = new BinaryFormatter();
	Circle s = (Circle)rbf.Deserialize(r);
	while (s != null)
	  {
	    Console.WriteLine("Read: " + s);
	    s = s.next;
	  }
	Console.WriteLine();

	r.Close();
      }

  }
  static void func1()
  {
    c = new Circle(5);
    Circle p = c;
    int[] list = { 10, 50, 30, 90 };
    foreach (int i in list)
      {
	p.next = new Circle(i);
	p = p.next;
      }
    p = c;
    while (p != null)
      {
	Console.WriteLine(p);
	p = p.next;
      }

  }

}
