using HotelCaseManagment.Domain.PortableServices;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Unity;

namespace HotelCaseManagment.App
{
    public partial class Login : Form
    {

        private string Username { get; set; }
        private string Password { get; set; }
       private readonly Form1 Mainform;

        public Login( Form1 e)
        {
            Mainform = e;
            InitializeComponent();


        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(TxtPass.Text) || string.IsNullOrEmpty(TxtUsername.Text))
            {
                MessageBox.Show("Fill All Colums");

            }
            else
            {
                CheckLogin();
            }

        }

       

        private  void CheckLogin()
        {

            Username = TxtUsername.Text;
            Password = TxtPass.Text;
               
                 switch (Mainform.ChekLogin(Username,Password))
                {
                    case true:

                        Mainform.Show();
                        this.Dispose();
                        break;

                    default:
                        MessageBox.Show("User Not Found!");
                        break;
                }

            

        }
    }
}
