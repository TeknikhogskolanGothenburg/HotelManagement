using HotelCaseManagment.Domain.Domains;
using HotelCaseManagment.Domain.PortableServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.PortableServices
{
    public interface IBookingService : IRepository<Booking>
    {
        ICollection<Booking> GetToBookings(int Top);
        ICollection<Booking> GetBookingByTimeSpam(DateTime StartDate, DateTime EndDate);
        Task<ICollection<Booking>>GetAllBookingWithIclude();



    }
}
