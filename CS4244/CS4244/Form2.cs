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
        public Form2()
        {
            InitializeComponent();
            webBrowser1.Navigate("http://nusmods.com/2013-2014/sem2/v1/#MA2213=1B01&CS4244=81&CS2102=87&CS5232=21&MA2213=8T01&MA2213=2SL1&ST2334=8T1&ST2334=2SL2&CS4244=21&CS2102=21&MA2213=2SL1&ST2334=2SL2");
        }
    }
}
