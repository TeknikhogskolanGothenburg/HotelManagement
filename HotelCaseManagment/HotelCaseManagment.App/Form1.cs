using HotelCaseManagment.Domain.Domains;
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
using AutoMapper;
using HotelCaseManagment.App.Models;
using Unity;
using System.Runtime.CompilerServices;

namespace HotelCaseManagment.App
{
    public partial class Form1 : Form
    {
     
        private bool IsLogged = false;
        private Manager manager;
       
        // This is Our UnityContainer , DepenciResolver 
        private readonly IUnityContainer unityContainer;

        // We resolve this Dependenci in The ProgramClass in the Main Method 
        public Form1(IUnityContainer ResolverCon )
        {
            unityContainer = ResolverCon;

           
             var Login = new Login(this);
            Login.ShowDialog();
            




        }

        public bool ChekLogin(string Username, string Password)
        {

           /// The Unitofwork Should be Disposed Automatic 
            
               var Unitof= unityContainer.Resolve<IUnitofWork>();
               var cred=  Unitof.ManagerService.CreDential(Username, Password);
                if( cred == GetCreDentialKey.Sucess)
                {
                    IsLogged = true;
                     manager =  Unitof.ManagerService.GetUserByEmail(Username);
                    MapperConf();
                    InitializeComponent();
                    return true;
                }
                else
                {
                    return false;
                }
            
               
            
        }
        private void MapperConf()
        {
            // Here can you map your ModelClasses or Struct 
            Mapper.Initialize(cfg =>
            {
                cfg.CreateMap<Booking, BookingModel>();
                cfg.CreateMap<BookingModel, Booking>();

            });





        }
        // Async Metod 
        private async void Form1_Load(object sender, EventArgs e)
        {
            if (IsLogged)
            {
                /// You Can Test The Methods From Unitofwork Here
                /// This will dispose the Datacontext for you with using reference or with out it. 
                using (var DataService = unityContainer.Resolve<IUnitofWork>())
                {



                    var item = await DataService.BookingService.GetAllBookingWithIclude();

                    var DATA = Mapper.Map<List<BookingModel>>(item);
                    dataGridView1.DataSource = DATA;
                    // Here is all properties You can work with at the moment 
                    //DataService.UserService
                    //DataService.ManagerService
                    //DataService.RomService
                    //DataService.PersonService

                //Exampel:

                    //var person = new Person { Name = "wili ", Email = "wiliarias@telilito43445", Password = "123", SecondName = "ali", Addres = "Lön", BirthDate = DateTime.UtcNow };
                    //DataService.UserService.Insert(new User { LastesLogin = DateTime.Now, Person = person });
                    //var p = DataService.PersonService.GetAll();
                    //DataService.Complete();
                }

            }
            else
            {
                    this.Dispose();
            }

            
            
        }
    }
}

