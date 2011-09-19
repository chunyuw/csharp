using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace demoGC
{
    class Circle {
        public int R = 10;
        public static int count = 0;
        int[] x = new int[40000];
        public Circle()
        {
            count++;
            Console.WriteLine("Circle: +  new instance created, total number: {0}", count);
        }
        ~Circle()
        {
            count--;
            Console.WriteLine("Circle:  - one instance deleted, now:{0}", count);
        }
    }
    
    class Program
    {
        static void Main(string[] args)
        {
            Circle c = new Circle();
            c = new Circle();
            c = new Circle();
            ConsoleKeyInfo k = Console.ReadKey(true);
            while (k.Key != ConsoleKey.Q)
            {
                switch (k.Key)
                {
                    case ConsoleKey.N:
                        c = new Circle();
                        break;
                    case ConsoleKey.C:
                        GC.Collect();
                        break;
                    case ConsoleKey.Spacebar:
                        Console.WriteLine("Now total number: {0}", Circle.count);
                        break;
                    default:
                        Console.WriteLine("Press N/Q/C/Spc key please!");
                        break;
                }
                k = Console.ReadKey(true);

            }

        }
    }
}
