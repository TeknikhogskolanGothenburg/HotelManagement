using HotelCaseManagment.Domain;
using System;
using System.Collections.Generic;
using System.Text;
using HotelCaseManagment.DataSource;
using System.Linq;

namespace HotelCaseManagment.DataRepository
{
  static  public class LoginController
    {
      public  enum LogingStatus{ IncorrectLogin , Succes }

      
     public static LogingStatus CheckUserCredential(string UserEmail ,string passWord)
        {
            try
            {
                IUserLoginObjecs userLoginObjecs = new UserLoginObjecs();

                var user = userLoginObjecs.GetUser(new Domain.UserLoginObjects.User{ Person= new Domain.UserLoginObjects.Person { Email =UserEmail , Password = userLoginObjecs.GetHashedPass(passWord)} });
                if(null == user)
                {
                    return LogingStatus.IncorrectLogin;
                }
                else
                {
                    return LogingStatus.Succes;
                }

                    

            }
            catch
            {

            }
    

            return LogingStatus.Succes;
            
            
          
        }
    }
}
