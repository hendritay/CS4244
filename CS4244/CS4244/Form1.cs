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
                    //comboBox5.Items.Add(code + " " + name);
                    //comboBox6.Items.Add(code + " " + name);
                    comboBox7.Items.Add(code + " " + name);
                    comboBox8.Items.Add(code + " " + name);
                    comboBox9.Items.Add(code + " " + name);
                    collection.Add(code + " " + name);
                }

                query = "Select distinct ModuleTag from ModuleTag";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string tag = reader.GetString(0);
                    preferenceBox.Items.Add(tag);
                }

                // Init FocusArea
                query = "Select fa.[Primary], fa.Elective from FocusArea fa";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();
                string primary = "";
                string elective = "";

                while (reader.Read())
                {
                    primary = reader.GetString(0);
                    elective = reader.GetString(1);

                    string[] primarys = primary.Split(',');
                    string[] electives = elective.Split(',');

                    for (int i = 0; i < primarys.Count(); i++)
                    {
                        comboBox5.Items.Add(primarys[i]);
                    }

                    for (int i = 0; i < electives.Count(); i++)
                    {
                        comboBox5.Items.Add(electives[i]);
                    }
                }

                // Init GEM
                query = "Select ModuleCode, ModuleName from ModuleInformation where ModuleCode like 'GE%'";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string modules = reader.GetString(0);
                    string modulesName = reader.GetString(1);
                    comboBox6.Items.Add(modules + " " + modulesName);
                }

                // Init SS
                query = "Select ModuleCode, ModuleName from ModuleInformation where ModuleCode like 'SS%'";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string modules = reader.GetString(0);
                    string modulesName = reader.GetString(1);
                    comboBox11.Items.Add(modules + " " + modulesName);
                }

                // Init Others
                query = "Select ModuleCode, ModuleName from ModuleInformation where ModuleCode like 'CS4%' or ModuleCode like 'CS5%' or ModuleCode like 'CS6%'";
                command = new SQLiteCommand(query, con);
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string modules = reader.GetString(0);
                    string modulesName = reader.GetString(1);
                    comboBox10.Items.Add(modules + " " + modulesName);
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
                pictureBox9.Visible = true;
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

                if (modulesInterestLBox.Items.Count == 0)
                    pictureBox9.Visible = false;
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
                pictureBox10.Visible = true;
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

                if (modulesDislikeLBox.Items.Count == 0)
                    pictureBox10.Visible = false;
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
                pictureBox8.Visible = true;
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

                if (preferenceLBox.Items.Count == 0)
                    pictureBox8.Visible = false;
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
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // Breadth
        private void button10_Click(object sender, EventArgs e)
        {
            int index = comboBox8.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox8.SelectedItem.ToString();
                listBox4.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
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
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
            }
        }
        // SS
        private void button19_Click(object sender, EventArgs e)
        {
            int index = comboBox11.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox11.SelectedItem.ToString();
                listBox7.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
                comboBox11.Items.Remove(value);
            }
        }

        private void button18_Click(object sender, EventArgs e)
        {
            int index = listBox7.SelectedIndex;
            if (index > -1)
            {
                string value = listBox7.SelectedItem.ToString();
                listBox7.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
                comboBox11.Items.Add(value);
            }
        }
        // Others
        private void button17_Click(object sender, EventArgs e)
        {
            int index = comboBox10.SelectedIndex;
            if (index > -1)
            {
                string value = comboBox10.SelectedItem.ToString();
                listBox6.Items.Add(value);
                modulesTakenBox.Items.Remove(value);
                comboBox6.Items.Remove(value);
                comboBox7.Items.Remove(value);
                comboBox8.Items.Remove(value);
                comboBox9.Items.Remove(value);
                comboBox10.Items.Remove(value);
            }
        }

        private void button16_Click(object sender, EventArgs e)
        {
            int index = listBox6.SelectedIndex;
            if (index > -1)
            {
                string value = listBox6.SelectedItem.ToString();
                listBox6.Items.RemoveAt(index);
                modulesTakenBox.Items.Add(value);
                comboBox6.Items.Add(value);
                comboBox7.Items.Add(value);
                comboBox8.Items.Add(value);
                comboBox9.Items.Add(value);
                comboBox10.Items.Add(value);
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
        // Tab3 Back
        private void button15_Click(object sender, EventArgs e)
        {
            int index = tabControl1.SelectedIndex;
            index--;
            tabControl1.SelectTab(index);
        }
        // Tab3 Done
        private void button14_Click(object sender, EventArgs e)
        {
            User u = new User();

            List<string> fields = new List<string>();

            // Tab1 info
            if (nameTextBox.Text.Trim() == "")
                fields.Add("Name");

            if (matricBox.SelectedIndex < 0)
                fields.Add("Cohort");

            if (modsBox.SelectedIndex < 0)
                fields.Add("Min/Max Mods Per Sem");

            if (comboBox1.SelectedIndex < 0)
                fields.Add("FYP");

            if (comboBox2.SelectedIndex < 0)
                fields.Add("Focus Area");

            if (comboBox4.SelectedIndex < 0)
                fields.Add("JC/Poly");

            if (comboBox3.SelectedIndex < 0)
                fields.Add("Project Type");

            // Tab2 info
            // Core
            if (modulesTakenLBox.Items.Count != 0)
            {
                for (int i = 0; i < modulesTakenLBox.Items.Count; i++)
                {
                    u.setCore(modulesTakenLBox.Items[i].ToString());
                }
            }
            // Focus Areas
            if (listBox1.Items.Count != 0)
            {
                for (int i = 0; i < listBox1.Items.Count; i++)
                {
                    u.setFocusAreas(listBox1.Items[i].ToString());
                }
            }
            // GEM
            if (listBox2.Items.Count != 0)
            {
                for (int i = 0; i < listBox2.Items.Count; i++)
                {
                    u.setGem(listBox2.Items[i].ToString());
                }
            }
            // Breadth
            if (listBox4.Items.Count != 0)
            {
                for (int i = 0; i < listBox4.Items.Count; i++)
                {
                    u.setBreadth(listBox4.Items[i].ToString());
                }
            }
            // UE
            if (listBox3.Items.Count != 0)
            {
                for (int i = 0; i < listBox3.Items.Count; i++)
                {
                    u.setUe(listBox3.Items[i].ToString());
                }
            }
            // Science Modules
            if (listBox5.Items.Count != 0)
            {
                for (int i = 0; i < listBox5.Items.Count; i++)
                {
                    u.setScienceMods(listBox5.Items[i].ToString());
                }
            }
            // SS
            if (listBox7.Items.Count != 0)
            {
                for (int i = 0; i < listBox7.Items.Count; i++)
                {
                    u.setSS(listBox7.Items[i].ToString());
                }
            }
            // Others
            if (listBox6.Items.Count != 0)
            {
                for (int i = 0; i < listBox6.Items.Count; i++)
                {
                    u.setOthers(listBox6.Items[i].ToString());
                }
            }

            // Tab3 info
            if (preferenceLBox.Items.Count == 0)
                fields.Add("Personal Preference");

            // Checking all required fields
            if (fields.Count == 0)
            {
                // Tab 1
                u.setName(nameTextBox.Text);
                u.setCohort(matricBox.SelectedItem.ToString());
                u.setMinMax(modsBox.SelectedItem.ToString());
                u.setFYP(comboBox1.SelectedItem.ToString());
                u.setFocusArea(comboBox2.SelectedItem.ToString());
                u.setJCPoly(comboBox4.SelectedItem.ToString());
                u.setProjectType(comboBox3.SelectedItem.ToString());

                // Tab 2

                // Tab 3
                // Personal Preference
                for (int i = 0; i < preferenceLBox.Items.Count; i++)
                {
                    u.setPersonalPref(preferenceLBox.Items[i].ToString());
                }
                // Modules Like
                for (int i = 0; i < modulesInterestLBox.Items.Count; i++)
                {
                    u.setModulesLike(modulesInterestLBox.Items[i].ToString());
                }
                // Modules Dislike
                for (int i = 0; i < modulesDislikeLBox.Items.Count; i++)
                {
                    u.setModuleDislike(modulesDislikeLBox.Items[i].ToString());
                }

                u.createInterestModuleInstance();
                u.createDisInterestModuleInstance();
                u.createInterestTagInstance();
                u.createFocusAreaInstance();
                u.createModulesTakenInstance();
                u.createRequirementInstance();
                u.createRequiredModulesInstance();

                Form2 form2 = new Form2();
                form2.ShowDialog();
            }
            else
            {
                string field = "";

                for (int i = 0; i < fields.Count; i++)
                {
                    field += "\r\n" + fields[i];
                }
                MessageBox.Show("Please fill in the required fields:\r\n" + field);
                tabControl1.SelectTab(0);
            }
            u.OutputEverything();
        }

        private void nameTextBox_TextChanged(object sender, EventArgs e)
        {
            if (nameTextBox.Text != "")
                pictureBox1.Visible = true;
            else
                pictureBox1.Visible = false;
        }

        private void matricBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (matricBox.SelectedIndex > -1)
                pictureBox2.Visible = true;
            else
                pictureBox2.Visible = false;
        }

        private void modsBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modsBox.SelectedIndex > -1)
                pictureBox3.Visible = true;
            else
                pictureBox3.Visible = false;
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex > -1)
                pictureBox4.Visible = true;
            else
                pictureBox4.Visible = false;
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox2.SelectedIndex > -1)
                pictureBox5.Visible = true;
            else
                pictureBox5.Visible = false;

            string focusArea = comboBox2.SelectedItem.ToString();
            comboBox5.Items.Clear();

            AutoCompleteStringCollection collection = new AutoCompleteStringCollection();
            SQLiteConnection con = new SQLiteConnection(dbConnectionString);

            try
            {
                con.Open();
                string query = "Select fa.[Primary], fa.Elective from FocusArea fa where FocusArea = '" + focusArea + "'";
                SQLiteCommand command = new SQLiteCommand(query, con);
                SQLiteDataReader reader = command.ExecuteReader();

                string primary = "";
                string elective = "";

                while (reader.Read())
                {
                    primary = reader.GetString(0);
                    elective = reader.GetString(1);

                    string[] primarys = primary.Split(',');
                    string[] electives = elective.Split(',');

                    for (int i = 0; i < primarys.Count(); i++)
                    {
                        comboBox5.Items.Add(primarys[i]);
                    }

                    for (int i = 0; i < electives.Count(); i++)
                    {
                        comboBox5.Items.Add(electives[i]);
                    }
                }

                con.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void comboBox4_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox4.SelectedIndex > -1)
                pictureBox6.Visible = true;
            else
                pictureBox6.Visible = false;
        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox3.SelectedIndex > -1)
                pictureBox7.Visible = true;
            else
                pictureBox7.Visible = false;
        }
    }
}
