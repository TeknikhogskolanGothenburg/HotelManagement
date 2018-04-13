using System;
using System.Collections.Generic;
using System.Text;
using HotelCaseManagment.Domain.Domains;
using HotelCaseManagment.DataSource;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;

namespace HotelCaseManagment.DataRepository
{
   public class UserLoginObjecs : IUserLoginObjecs
    {
        public bool CreateNewUser(object userLogin)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                    try
                    {
                        if (null != userLogin)
                        {
                            switch (userLogin)
                            {
                                case Manager e:

                                    e.Person.Password = GetHashedPass(e.Person.Password);

                                    db.Add(userLogin);
                                    
                                    break;
                                case User e:
                                    e.Person.Password = GetHashedPass(e.Person.Password);
                                    db.Add(userLogin);
                                    break;
                                default:
                                    throw new Exception("ResursenObject du skickade in är Felaktig ");

                            }
                            return db.SaveChanges() > 0;

                        }
                        else
                        {

                            throw new Exception("ResursenObject du skickade in är null ");

                        }
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<Manager> GetAllManagers(int TopList)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                    return db.Manager.Take(TopList)
                        .Include(b => b.Person)
                        .ToList();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Manager GetManger(Manager Userobject)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                   return (from x in db.Manager where x == Userobject  select x).Include(p => p.Person).FirstOrDefault();
                

                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public User GetUser(User Userobject)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.User where x == Userobject select x).Include(p => p.Person).FirstOrDefault();


                }
            }
            catch (Exception e)
            {
                throw e;
            }
        
    }

        public User GetUserByID(int ID)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.User where x.ID == ID select x).Include(p => p.Person).FirstOrDefault();


                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public User GetUserByID(string Email)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.User where x.Person.Email == Email select x).Include(p => p.Person).FirstOrDefault();

                    
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public Manager GetManagerByID(int ID)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.Manager where x.ID == ID select x).Include(p => p.Person).FirstOrDefault();


                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Manager GetManagerByID(string Email)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.Manager where x.Person.Email == Email select x).Include(p => p.Person).FirstOrDefault();


                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public bool RemoveUser(object UserOrManger)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                    try
                    {
                        if (null != UserOrManger)
                        {
                            switch (UserOrManger)
                            {
                                case Manager e:
                                    db.Remove(UserOrManger);
                                    break;
                                case User e:
                                    db.Remove(UserOrManger);
                                    break;
                                default:
                                    throw new Exception("ResursenObject du skickade in är Felaktig ");

                            }
                            return db.SaveChanges() > 0;

                        }
                        else
                        {

                            throw new Exception("ResursenObject du skickade in är null ");

                        }
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public List<Manager> SearchManger(string querry)
        {
            try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.Manager where  x.Person.Name.Contains(querry) || x.Person.SecondName.Contains(querry) || x.Person.Email.Contains(querry) select x).Include(p => p.Person).ToList();


                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public List<User> SearchUser(string querry)
        { try
            {
                using (DataContext db = new DataContext())
                {

                    return (from x in db.User where x.Person.Name.Contains(querry) || x.Person.SecondName.Contains(querry) || x.Person.Email.Contains(querry) select x).Include(p => p.Person).ToList();


                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public bool UpdateUser(object userLogin)
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                    try
                    {
                        if (null != userLogin)
                        {
                            switch (userLogin)
                            {
                                case Manager e:
                                    db.Update(userLogin);

                                    break;
                                case User e:
                                    db.Update(userLogin);
                                    break;
                                default:
                                    throw new Exception("ResursenObject du skickade in är Felaktig ");

                            }
                            return db.SaveChanges() > 0;

                        }
                        else
                        {

                            throw new Exception("ResursenObject du skickade in är null ");

                        }
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

      public List<User> GetAllUsers( int TopList )
        {
            try
            {
                using (DataContext db = new DataContext())
                {
                    return db.User.Take(TopList)
                        .Include(b => b.Person)
                        .ToList();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
       
        public string GetHashedPass( string password)
        {
            var provider = new SHA1CryptoServiceProvider();
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            return  Convert.ToBase64String(provider.ComputeHash(bytes));

        }

        public bool CheckLogin(Manager manager)
        {
            try
            {
                using(DataContext db = new DataContext())
                {

                }
            }
            catch (Exception e)
            {

            }
            return false;
        }

        public bool CheckLogin(User user)
        {

            try
            {
                using (DataContext db = new DataContext())
                {

                }
            }
            catch (Exception e)
            {

            }
            return false;
        }
    }
}












    