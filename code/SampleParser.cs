using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

namespace ConsoleApplication4
{
    class Program
    {
        static void Main(string[] args)
        {
            SampleParser p = new SampleParser("DataSample.csv");
            p.ListAllData();
        }
    }
    public class SampleParser
    {
        public string Header;            // Header 

        public string DataSetName;       // Data Set Name

        public int InputsCount;          // the number of total inputs
        public string[] InputsName;      // Column 1
        public string[] InputsValue;     // Column 2
        public string[] InputsUnit;      // Column 3
        public List<string[]> InputsTable;

        public int DataColumnCount;      // the number of total columns in data table
        public string[] DataColumnName;  // the name of each column
        public string[] DataColumnUnit;  // the unit of each column, if enclosed in brackets, or empty string("")
        public List<string[]> DataTable;  // the data table

        public void ListAllData()
        {
            Console.WriteLine("文件头:    {0}", Header);
            Console.WriteLine("数据集名:  {0}", DataSetName);
   
            Console.WriteLine("输入个数: {0}\n分别为: ", InputsCount);
            for (int i = 0; i < InputsCount; i++)
                Console.WriteLine("{0,-20}{1,-10}{2}", InputsName[i], InputsValue[i], InputsUnit[i]);
            
            Console.WriteLine("数据表:");
            for (int i = 0; i < DataColumnCount; i++)
                Console.Write("{0,-5}", DataColumnName[i]);
            Console.WriteLine();
            foreach (string[] line in DataTable)
            {
                for (int i = 0; i < DataColumnCount ; i++)
                    Console.Write("{0,-8}", line[i]);
                Console.WriteLine();
            }
        }


        public SampleParser(string inputfilename)
        {
            string[] csvLines = File.ReadAllLines(inputfilename).Select(line => line.Trim()).ToArray<string>();

            var emptylines = Enumerable.Range(0, csvLines.Length).Where(i => Regex.IsMatch(csvLines[i], @"^[,\s]*$"));
            var sepLines = emptylines.Where(i => !(emptylines.Contains(i - 1))).ToArray<int>();

            var header = csvLines.Skip(0).Take(sepLines[0]).Where(line => !(Regex.IsMatch(line, @"^[,\s]*$")));
            var datset = csvLines.Skip(sepLines[0]).Take(sepLines[1] - sepLines[0]).Where(line => !(Regex.IsMatch(line, @"^[,\s]*$")));
            var inputs = csvLines.Skip(sepLines[1]).Take(sepLines[2] - sepLines[1]).Where(line => !(Regex.IsMatch(line, @"^[,\s]*$"))).Select(line => csvsplit(line));
            var tables = csvLines.Skip(sepLines[2]).Take(csvLines.Length - sepLines[2]).Where(line => !(Regex.IsMatch(line, @"^[,\s]*$")));
            var data = tables.Skip(1);

            Header = string.Join("\n", header.Select(w => w.TrimEnd(new char[] { ',' })));

            DataSetName = string.Join("", datset.Select(w => w.Trim(new char[] { ',', '[', ']' })));

            InputsCount = inputs.Count();
            InputsName = inputs.Select(w => w[0]).ToArray<string>();
            InputsValue = inputs.Select(w => w[1]).ToArray<string>();
            InputsUnit = inputs.Select(w => w[2]).ToArray<string>();
            InputsTable = inputs.ToList<string[]>();

            var tmp2 = tables.Take(1).ToArray<string>()[0].Split(new char[] { ',' });
            DataColumnUnit = tmp2.Select(w => Regex.Match(w, @"\[(?<u>.*?)\]").Groups["u"].Value).ToArray<string>();
            DataColumnName = Enumerable.Range(0, tmp2.Length).Select(i => tmp2[i].Replace("[" + DataColumnUnit[i] + "]", "")).ToArray<string>();
            DataColumnCount = DataColumnName.Length;

            DataTable = data.Select(w => csvsplit(w)).ToList<string[]>();
            //DataColumns = Enumerable.Range(0, DataColumnCount).Select(i => tmp3.Select(w => w[i]).ToArray<string>()).ToList<string[]>();

        }

        Regex re = new Regex("(?<q>\".*?\")");
        public string[] csvsplit(string line)
        {
            line = line.Replace("QUOTED", "QQUUOOTTEEDD");
            foreach (Match m in re.Matches(line))
                line = line.Replace(m.Value, m.Value.Replace(",", "QUOTED"));
            return line.Split(new char[] { ',' }).Select(w => w.Replace("QUOTED", ",").Replace("QQUUOOTTEEDD", "QUOTED")).ToArray<string>();
        }


    }
}
