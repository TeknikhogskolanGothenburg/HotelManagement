using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            //// This is elements that hava to be on a starupMethod:
            //// The container Disposes all Elements when is not in use.
            //IUnityContainer Container = new UnityContainer();
            //Container.RegisterInstance<IUnityContainer>(Container);
            //Container.RegisterType<DataContext>();
            //Container.RegisterType<StartUp>();
            //Container.RegisterType<IUnitofWork, UnitofWork>();

            //var starup = Container.Resolve<StartUp>();
            //starup.WorkWithPersonMethods();

            //ReadKey();


        }
        private class StartUp
        {
            //private readonly IUnityContainer Coontainer;
            //public StartUp(IUnityContainer e)
            //{
            //    Coontainer = e;
            //}
            //public void WorkWithPersonMethods()
            //{
            //    using (var DataWorker = Coontainer.Resolve<IUnitofWork>())
            //    {
            //        //DataWorker.PersonService // Use this property to work with Person Objects.
            //        var person = DataWorker.PersonService.GetAll();
            //        if (null == person)
            //        {
            //            WriteLine("dont Work");
            //        }
            //        else
            //        {
            //            WriteLine("Work!");
            //        }
            //    }


            }
        }
    }




