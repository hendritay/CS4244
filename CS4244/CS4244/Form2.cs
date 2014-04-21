using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SQLite;

namespace CS4244
{
    public partial class Form2 : Form
    {
        public Form2(string url)
        {
            InitializeComponent();
            webBrowser1.Navigate(url);
        }

        public void addElement(string value)
        {
            string[] values = value.Split('|');
            string moduleCode = values[0];
            string moduleName = "";
            string dbConnectionString = @"Data Source=C:\Users\User\Documents\Visual Studio 2010\Projects\CS4244\CS4244\CS4244.sqlite;Version=3;";

            SQLiteConnection con = new SQLiteConnection(dbConnectionString);

            try
            {
                con.Open();
                string query = "Select ModuleName from ModuleInformation where ModuleCode = '" + moduleCode + "'";
                SQLiteCommand command = new SQLiteCommand(query, con);
                SQLiteDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    moduleName = reader.GetString(0);
                }

                con.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            dataGridView1.Rows.Add(values[0], moduleName, values[1], values[2]);
        }
    }
}
