using System;
using System.Collections;

public class Circle
{
  // Add your code here
}

class CircleGroup : ICollection, IList
{
  // Add your code here
}

class Test
{
  static void Main()
  {
    CircleGroup cg = new CircleGroup(1.2, 2.4, 3.6, 4.8, 5.0);
    double sum = 0;
    foreach (Circle x in cg)
    {
      Console.WriteLine ("{0}", x.Area);
      sum += x.Area;
    }
    Console.WriteLine("Total Area: {0}", sum);
    Console.ReadLine();

    cg.Clear();

    cg.Add(new Circle(5));
    cg.Add(new Circle(3));
    cg.Insert(1, new Circle(7));
    Console.WriteLine ("There are {0} Circles.",Circle.TotalCircleNum);
    cg.RemoveAt(2);

    cg.Clear();
    cg.Enqueue (new Circle(20));
    cg.Enqueue (new Circle(15));
    Circle temp = cg.Dequeue();
    Console.WriteLine (temp.Area);
    Console.ReadLine();
  }
}

