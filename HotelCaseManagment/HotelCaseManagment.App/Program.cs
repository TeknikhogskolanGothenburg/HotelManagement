using HotelCaseManagment.DataSource;
using HotelCaseManagment.DataSource.Repository;
using HotelCaseManagment.Domain.PortableServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using System.Windows.Forms;
using Unity;

namespace HotelCaseManagment.App
{
    static class Program
    {
       
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        { 
         IUnityContainer Container  = new UnityContainer();
            Container.RegisterInstance<IUnityContainer>(Container);
            Container.RegisterType<Login>();
            Container.RegisterType<Form1>();
            Container.RegisterType<DataContext>();
            Container.RegisterType<IUnitofWork,UnitofWork >();


            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(Container.Resolve<Form1>());
        }
    }
}
