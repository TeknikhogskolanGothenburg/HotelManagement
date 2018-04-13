using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.PortableServices
{
  public  interface IUnitofWork :IDisposable
    {
        IBookingService BookingService{get; set;}
        IManagerService ManagerService { get; set; }
        IUserService UserService { get; set; }
        IRomService RomService { get; set; }
        IPersonService PersonService { get; set; }
        int Complete();
    }
}
