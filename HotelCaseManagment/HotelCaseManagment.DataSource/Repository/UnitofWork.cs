using HotelCaseManagment.Domain.PortableServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.DataSource.Repository
{
 public class UnitofWork : IUnitofWork

    {
        public UnitofWork(DataContext context)
        {
            _dataContext = context;
            BookingService = new BookingRepository(context);
            ManagerService = new ManagerRepository(context);
            UserService = new UserRepository(context);
            RomService =  new RoomRepo(context);
            PersonService = new PersonRepository(context);


        }
        private readonly DataContext _dataContext;

        public IBookingService BookingService { get ; set ; }
        public IManagerService ManagerService { get; set; }
        public IUserService UserService { get; set; }
        public IRomService RomService { get; set; }
        public IPersonService PersonService { get; set; }

        public int Complete()
        {
            try
            {
                return _dataContext.SaveChanges();
            }
            catch
            {
                throw new Exception("Colud not Save");
            }
        }

        public void Dispose()
        {
            _dataContext.Dispose();
        }
    }
}
