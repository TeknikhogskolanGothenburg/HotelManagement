using HotelCaseManagment.Domain.Domains;
using HotelCaseManagment.Domain.PortableServices;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.DataSource.Repository
{
  public  class RoomRepo: Repository<Room>,IRomService
    { 

        public RoomRepo(DataContext context)
            : base(context)
    {
    }
        

    public DataContext DataContext
    {
        get { return Context as DataContext; }
    }


        public ICollection<Room> GetAllRoms()
        {
            
            return DataContext.Room.ToList(); 
        }
    }
  
}
