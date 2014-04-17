using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CS4244
{
    public partial class Form2 : Form
    {
        public Form2(string url)
        {
            InitializeComponent();
            webBrowser1.Navigate(url);
        }

        public void addElement(string value) {
                modulesTakenLBox.Items.Add(value);
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }
    }
}
