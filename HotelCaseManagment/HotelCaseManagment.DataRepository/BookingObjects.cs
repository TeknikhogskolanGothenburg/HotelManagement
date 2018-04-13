using HotelCaseManagment.DataSource;
using HotelCaseManagment.Domain.BookingObjects;
using HotelCaseManagment.Domain.UserLoginObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HotelCaseManagment.DataRepository
{
    public class BookingObjects : IBookingObjects
    {
        public bool CreateBooking(Booking bookingObject)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                   
                        if (null != bookingObject && bookingObject.BookingStart > bookingObject.BookingEnd)
                        {
                            db.Booking.Add(bookingObject);
                            return db.SaveChanges() > 0;
                        }
                        else
                        {
                            throw new Exception("ResursenObject du skickade in är null ");
                        }

                   
                    }
               
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public bool DeleteBooking(Booking bookingObject)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                   
                        if (null != bookingObject)
                        {
                            db.Booking.Remove(bookingObject);
                            return db.SaveChanges() > 0;
                        }
                        else
                        {
                            throw new Exception("ResursenObject du skickade in är null ");
                        }

                    }
       
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public bool DeleteBookings(List<Booking> bookingObject)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    if (null != bookingObject)
                    {
                        db.Booking.RemoveRange(bookingObject);
                        return db.SaveChanges() > 0;
                    }
                    else
                    {
                        throw new Exception("ResursenObject du skickade in är null ");
                    }

                }

            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public List<Booking> GetBookings(int TopList)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                  return  db.Booking.Take(TopList)
                           .Include(b => b.User.Person )
                           .Include(b => b.Room)
                           .ToList();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public List<Booking> GetBookingsByDateRange(DateTime Date1, DateTime Date2)
        {
            try
            {
                if (Date1 < Date2 || null != Date1 && null != Date2)
                {
                    using (DataContext db = new DataContext())
                    {
                        return (from X in db.Booking where X.BookingStart.Ticks >= Date1.Ticks && X.BookingEnd.Ticks <= Date2.Ticks select X).Include(u => u.User.Person).ToList();
                    }
                }
                else
                {
                    throw new Exception(" Date1 is greater than Date2 or The data was null"); 
                }
               
             }
            catch(Exception e)
            {
                throw e;
            }
            
        }

        public List<Booking> GetBookingsByDateRange(User UserObject, DateTime Date1, DateTime Date2)
        {
            try
            {
                if (Date1 < Date2 || null != Date1 && null != Date2)
                {
                    using (DataContext db = new DataContext())
                    {
                        return (from X in db.Booking where X.User == UserObject && X.BookingStart.Ticks >= Date1.Ticks && X.BookingEnd.Ticks <= Date2.Ticks select X).Include(u => u.User.Person).ToList();
                    }
                }
                else
                {
                    throw new Exception(" Date1 is greater than Date2 or The data was null");
                }

            }
            catch (Exception e)
            {
                throw e;
            }

        }

    }
 }
