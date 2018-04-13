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
    public class ManagerRepository : Repository<Manager>, IManagerService
    {

        public ManagerRepository(DataContext context)
            : base(context)
        {
        }

        public GetCreDentialKey CreDential(Manager userOrManaGer)
        {
            var manager = DataContext.Manager.Find(userOrManaGer);
            if(null != manager)
            {
                return GetCreDentialKey.Sucess;
            }
            else
            {
                return GetCreDentialKey.NotFound;
            }
        }

       

        public Manager GetUserByEmail(string Email)
        {
            return DataContext.Manager.FirstOrDefault(x => x.Person.Email == Email);
        }

        public ICollection<Manager> GetTopMangersList(int Top)
        {
            return DataContext.Manager.Take(Top).OrderByDescending(X=> X.ID ).ToList();
        }

        public GetCreDentialKey CreDential(string Email, string Password)
        {
           var credentials = DataContext.Manager.Where(X => X.Person.Email == Email && X.Person.Password == Password).FirstOrDefault();
            if(null != credentials)
            {
                return GetCreDentialKey.Sucess;
            }
            else
            {
                return GetCreDentialKey.NotFound;
            }

        }

        public DataContext DataContext
        {
            get { return Context as DataContext; }
        }


    }
}
