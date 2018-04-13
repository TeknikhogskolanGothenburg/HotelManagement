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
    public class UserRepository : Repository<User>, IUserService
    {

        public UserRepository(DataContext context)
            : base(context)
        {
        }


        public DataContext DataContext
        {
            get { return Context as DataContext; }
        }

        public GetCreDentialKey CreDential(User userOrManaGer)
        {
            var user = DataContext.User.Find(userOrManaGer);
            if (null != user)
            {
                return GetCreDentialKey.Sucess;
            }
            else
            {
                return GetCreDentialKey.NotFound;
            }
        }

        public GetCreDentialKey CreDential(string Email, string Password)
        {
            var credentials = DataContext.User.Where(X => X.Person.Email == Email && X.Person.Password == Password).FirstOrDefault();
            if (null != credentials)
            {
                return GetCreDentialKey.Sucess;
            }
            else
            {
                return GetCreDentialKey.NotFound;
            }
        }

        public ICollection<User> GetTopListUsers(int Top)
        {
            return DataContext.User.Take(Top).OrderByDescending(X => X.Id).ToList();
        }

        public User GetUserByEmail(string Email)
        {
            return DataContext.User.FirstOrDefault(x => x.Person.Email == Email);
        }
    }
}
