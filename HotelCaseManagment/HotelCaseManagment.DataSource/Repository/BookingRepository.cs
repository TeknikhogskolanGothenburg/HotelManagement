using HotelCaseManagment.Domain.Domains;
using HotelCaseManagment.Domain.PortableServices;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace HotelCaseManagment.DataSource.Repository
{
    public class BookingRepository :  Repository<Booking>, IBookingService
    {
        
        public BookingRepository( DataContext context)
            : base(context)
        {
        }

        public ICollection<Booking> GetBookingByTimeSpam(DateTime StartDate, DateTime EndDate)
        {

            return DataContext.Booking.Where(x => x.BookingStart >= StartDate && x.BookingEnd <= EndDate).Include(x=> x.Room).Include(x=> x.User).ToList();
        }

        public ICollection<Booking> GetToBookings(int Top)
        {
            return DataContext.Booking.OrderByDescending(x => x.BookingStart).Take(Top).ToList();
        }


     public async Task<ICollection<Booking>> GetAllBookingWithIclude()
        {

            var Item = await Task.Run(() => DataContext.Booking.Include(x => x.User).ThenInclude(p => p.Person)
            
           .ToList());
           

            return Item.ToList();

        }

        public DataContext DataContext
        {
            get { return Context as DataContext; }
        }
    }
      
    }

