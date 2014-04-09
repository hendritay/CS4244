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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            initModules();
        }

        string dbConnectionString = @"Data Source=C:\Users\User\Documents\Visual Studio 2010\Projects\CS4244\CS4244\CS4244.sqlite;Version=3;";

        private void initModules()
        {
            AutoCompleteStringCollection collection = new AutoCompleteStringCollection();
            SQLiteConnection con = new SQLiteConnection(dbConnectionString);

            try
            {
                con.Open();
                string query = "Select * from ModuleInformation";
                SQLiteCommand command = new SQLiteCommand(query, con);
                SQLiteDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string code = reader.GetString(0);
                    string name = reader.GetString(1);
                    modulesTakenBox.Items.Add(code + " " + name);
                    modulesInterestBox.Items.Add(code + " " + name);
                    modulesDislikeBox.Items.Add(code + " " + name);
                    comboBox5.Items.Add(code + " " + name);
                    comboBox6.Items.Add(code + " " + name);
                    comboBox7.Items.Add(code + " " + name);
                    comboBox8.Items.Add(code + " " + name);
                    comboBox9.Items.Add(code + " " + name);
                    collection.Add(code + " " + name);
                }

                query = "Select distinct Tag from ModuleTag";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string tag = reader.GetString(0);
                    preferenceBox.Items.Add(tag);
                }

                con.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            modulesTakenBox.AutoCompleteCustomSource = collection;
        }

        // Tab1
        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tabControl1.SelectedTab == tabControl1.TabPages["Personal Particulars"])
            {
                button2.Visible = false;
            }
        }
        // Modules like
        private void addButton2_Click(object sender, EventArgs e)
        {
            int index = modulesInterestBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesInterestBox.SelectedItem.ToString();
                modulesInterestLBox.Items.Add(value);
                modulesInterestBox.Items.Remove(value);
            }
        }

        private void delButton2_Click(object sender, EventArgs e)
        {
            int index = modulesInterestLBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesInterestLBox.SelectedItem.ToString();
                modulesInterestLBox.Items.RemoveAt(index);
                modulesInterestBox.Items.Add(value);
            }
        }
        // Modules Dislike
        private void addButton3_Click(object sender, EventArgs e)
        {
            int index = modulesDislikeBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesDislikeBox.SelectedItem.ToString();
                modulesDislikeLBox.Items.Add(value);
                modulesDislikeBox.Items.Remove(value);
            }
        }

        private void delButton3_Click(object sender, EventArgs e)
        {
            int index = modulesDislikeLBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesDislikeLBox.SelectedItem.ToString();
                modulesDislikeLBox.Items.RemoveAt(index);
                modulesDislikeBox.Items.Add(value);
            }
        }
        // Personal Preference
        private void addButton4_Click(object sender, EventArgs e)
        {
            int index = preferenceBox.SelectedIndex;
            if (index > -1)
            {
                string value = preferenceBox.SelectedItem.ToString();
                preferenceLBox.Items.Add(value);
                preferenceBox.Items.Remove(value);
            }
        }

        private void delButton4_Click(object sender, EventArgs e)
        {
            int index = preferenceLBox.SelectedIndex;
            if (index > -1)
            {
                string value = preferenceLBox.SelectedItem.ToString();
                preferenceLBox.Items.RemoveAt(index);
                preferenceBox.Items.Add(value);
            }
        }
        // Core
        private void addButton_Click(object sender, EventArgs e)
        {
            int index = modulesTakenBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesTakenBox.SelectedItem.ToString();
                modulesTakenLBox.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void delButton_Click(object sender, EventArgs e)
        {
            int index = modulesTakenLBox.SelectedIndex;
            if (index > -1)
            {
                string value = modulesTakenLBox.SelectedItem.ToString();
                modulesTakenLBox.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // Focus Area
        private void button4_Click(object sender, EventArgs e)
        {
            int index = comboBox5.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox5.SelectedItem.ToString();
                listBox1.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int index = listBox1.SelectedIndex;
            if (index > -1)
            {
                string value = listBox1.SelectedItem.ToString();
                listBox1.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // GEM
        private void button6_Click(object sender, EventArgs e)
        {
            int index = comboBox6.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox6.SelectedItem.ToString();
                listBox2.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            int index = listBox2.SelectedIndex;
            if (index > -1)
            {
                string value = listBox2.SelectedItem.ToString();
                listBox2.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // Breadth/SS
        private void button10_Click(object sender, EventArgs e)
        {
            int index = comboBox8.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox8.SelectedItem.ToString();
                listBox4.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            int index = listBox4.SelectedIndex;
            if (index > -1)
            {
                string value = listBox4.SelectedItem.ToString();
                listBox4.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // UE
        private void button8_Click(object sender, EventArgs e)
        {
            int index = comboBox7.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox7.SelectedItem.ToString();
                listBox3.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            int index = listBox3.SelectedIndex;
            if (index > -1)
            {
                string value = listBox3.SelectedItem.ToString();
                listBox3.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // Science Modules
        private void button12_Click(object sender, EventArgs e)
        {
            int index = comboBox9.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox9.SelectedItem.ToString();
                listBox5.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox5.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
            }
        }

        private void button11_Click(object sender, EventArgs e)
        {
            int index = listBox5.SelectedIndex;
            if (index > -1)
            {
                string value = listBox5.SelectedItem.ToString();
                listBox5.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox5.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // Tab1 Next
        private void button1_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index++;
            tabControl1.SelectTab(index);
        }
        // Tab2 Next
        private void button13_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index++;
            tabControl1.SelectTab(index);
        }
        // Tab2 Back
        private void button2_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index--;
            tabControl1.SelectTab(index);
        }
        // Tab3 Done
        private void button14_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index++;

            if (index == 3)
            {
                Form2 form2 = new Form2();
                form2.ShowDialog();
            }
        }
        // Tab3 Back
        private void button15_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index--;
            tabControl1.SelectTab(index);
        }
    }
}
