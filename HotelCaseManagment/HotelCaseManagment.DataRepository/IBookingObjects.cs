using HotelCaseManagment.Domain.BookingObjects;
using HotelCaseManagment.Domain.UserLoginObjects;
using System;
using System.Collections.Generic;
using System.Text;

namespace HotelCaseManagment.DataRepository
{
    public interface IBookingObjects
    {
        bool CreateBooking(Booking bookingObject);
        bool DeleteBooking(Booking bookingObject);
        bool DeleteBookings(List<Booking> bookingObject);
        List<Booking> GetBookings(int TopList);
        List<Booking> GetBookingsByDateRange(DateTime Date1 , DateTime Date2);
        List<Booking> GetBookingsByDateRange(User UserObject,DateTime Date1, DateTime Date2);



    }
}
