using System;
using System.Data;
using System.Data.SqlClient;
namespace Chapter13 {
  class PersistAdds {
    static void Main(string[] args) {
      // connection string
      string connString = @"
server = .\sqlexpress;
integrated security = true;
database = northwind
";
      // query
      string qry = @"select * from employees where country = 'UK'";
      // SQL to insert employees
      string ins = @" insert into employees
( firstname,
  lastname,
  titleofcourtesy,
  city,
  country)
values (
  @firstname,
  @lastname,
  @titleofcourtesy,
  @city,
  @country)";

      // create connection
      SqlConnection conn = new SqlConnection(connString);
      try {
        // create data adapter
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = new SqlCommand(qry, conn);
        // create and fill dataset
        DataSet ds = new DataSet();
        da.Fill(ds, "employees");
        // get data table reference
        DataTable dt = ds.Tables["employees"];
        // add a row
        DataRow newRow = dt.NewRow();
        newRow["firstname"] = "Roy";
        newRow["lastname"] = "Beatty";
        newRow["titleofcourtesy"] = "Sir";
        newRow["city"] = "Birmingham";
        newRow["country"] = "UK";
        dt.Rows.Add(newRow);
        // display rows
        foreach(DataRow row in dt.Rows) {
          Console.WriteLine(
                            "{0} {1} {2}",
                            row["firstname"].ToString().PadRight(15),
                            row["lastname"].ToString().PadLeft(25),
                            row["city"]);
        }
        // insert employees
        //
        // create command
        SqlCommand cmd = new SqlCommand(ins, conn);
        //
        // map parameters
        cmd.Parameters.Add("@firstname", SqlDbType.NVarChar, 10, "firstname");
        cmd.Parameters.Add("@lastname", SqlDbType.NVarChar, 20, "lastname");
        cmd.Parameters.Add("@titleofcourtesy", SqlDbType.NVarChar, 25, "titleofcourtesy");
        cmd.Parameters.Add("@city", SqlDbType.NVarChar, 15, "city");
        cmd.Parameters.Add("@country", SqlDbType.NVarChar, 15, "country");
        //
        // insert employees
        da.InsertCommand = cmd;
        da.Update(ds, "employees");
      } catch(Exception e) {
        Console.WriteLine("Error: " + e);
      } finally {
        // close connection
        conn.Close();
      }
    }
  }
}
