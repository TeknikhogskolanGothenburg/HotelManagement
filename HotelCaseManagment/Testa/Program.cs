using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HotelCaseManagment.Domain;
using static System.Console;
using AutoMapper;
using HotelCaseManagment.DataSource.Repository;
using Unity;
using HotelCaseManagment.DataSource;
using HotelCaseManagment.Domain.PortableServices;
using HotelCaseManagment.Domain.Domains;

namespace Testa
{
    class Program
    {
        static void Main(string[] args)
        {

            InitializeComponent();


        }
       
        private static void InitializeComponent()
        {
            UnityContainer container = new UnityContainer();

            //container.RegisterType<ABC>();
            //container.RegisterType<InP,AB>();
            //var unitofwork = container.Resolve<InP>();


            container.RegisterType<DataContext>();
            container.RegisterType<IUnitofWork, UnitofWork>();
            container.RegisterType<IBookingService, BookingRepository>();
            container.RegisterType<IManagerService, ManagerRepository>();
            container.RegisterType<IUserService, UserRepository>();
           
            
            //container.RegisterType<Manager>();
            //container.RegisterType<Booking>();
            ////container.RegisterType<ManagerRepository>();
            ////container.RegisterType<IUnitofWork>();
            var unitofwork = container.Resolve<IUnitofWork>();


            //IManager E = new ManagerRepository(new DataContext());
            unitofwork.ManagerService.Insert(new Manager { IsAdmin = true, Person = new Person { Email = "TesJtya@wdsaxas.senj", Name = "tesla" } });

            unitofwork.ManagerService.CreDential("Testa@d.se", "123");
          
            unitofwork.Complete();
           
            ReadKey();
        }
    }
}
