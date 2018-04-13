using HotelCaseManagment.Domain.UserLoginObjects;
using System;
using System.Collections.Generic;
using System.Text;

namespace HotelCaseManagment.DataRepository
{
  public interface IUserLoginObjecs
    {
       
        // User Methods 
        /// <summary>
        /// Get a list of existing Users in the Database (HotelMangmentDB)
        /// </summary>
        /// <returns> Returns a list of users</returns>
        List<User> GetAllUsers(int TopList);
        /// <summary>
        /// This method find and returns a User from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a User = null.
        /// </summary>
        /// <param name="ID"> Gets a user by ID (Int)object</param>
        /// <returns>Returns a User</returns>
        User GetUserByID(int ID);
        /// <summary>
        /// This method find and returns a User from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a User = null.
        /// </summary>
        /// <param name="Email"> Gets a User by Email (string)object </param>
        /// <returns>Returns a User</returns>
        User GetUserByID(string Email);
        /// <summary>
        /// This method find and returns a User from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a User = null.
        /// </summary>
        /// <param name="Userobject"> Get a User by the Obejct by matching the Object (User)Object</param>
        /// <returns> Returns a User </returns>
        User GetUser(User Userobject);
        /// <summary>
        /// This method find and returns a list of Users from the database (HotelmanagementDB)
        /// It will send a Empty list if there is not match.
        /// </summary>
        /// <param name="querry">Use this to search </param>
        /// <returns> Returns a List Of Users</returns>
        List<User>SearchUser(string querry);
        /// <summary>
        /// This method find and returns a Manger from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a Manager = null.
        /// </summary>
        /// <param name="ID"> Gets a user by ID (Int)object</param>
        /// <returns> Manager </returns>
        Manager GetManagerByID(int ID);
        /// <summary>
        /// This method find and returns a Manger from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a Manager = null.
        /// </summary>
        /// <param name="Email">Gets a user by Email (string)object</param>
        /// <returns>Manager</returns>
        Manager GetManagerByID(string Email);
        /// <summary>
        /// This method find and returns a Manager from the database (HotelmanagementDB)
        /// If the user is not found, the method will return a Manager = null.
        /// </summary>
        /// <param name="Userobject"> Get a Manager by the Obejct by matching the Object (Manager)Object</param>
        /// <returns> Returns a Manager </returns>
        Manager GetManger(Manager Userobject);
        /// <summary>
        /// This method find and returns a list of Managers from the database (HotelmanagementDB)
        /// It will send a Empty list if there is not match.
        /// </summary>
        /// <param name="querry">Use this to search </param>
        /// <returns> Returns a List Of Managers</returns>
        List<Manager> SearchManger(string querry);
        /// <summary>
        /// Get a list of existing Managers in the Database (HotelMangmentDB)
        /// </summary>
        /// <returns> Returns a list of Managers</returns>
        List<Manager> GetAllManagers(int TopList);
        /// <summary>
        /// This method Creates a new user in our system and you need to send a UserLoginObject object as parameter but this object must match our database model
        /// Be aware you need to inplement our Domain clases if you want this to work.
        ///This is the to clases you can send to this method <see cref="Manager"/> and <see cref="Manager"/>
        /// </summary>
        ///<param name="user">The type of Object needs to be a <see cref="Manager"/> or <see cref="Manager"/>,(Not Null!).</param>
        /// <returns> Returns True or false if the object was insert to the database. </returns>
        bool CreateNewUser(object user);
        /// <summary>
        /// This Method Removes a UserLoginObeject 
        /// Be aware you need to inplement our Domain clases if you want this to work.
        ///This is the to clases you can send to this method <see cref="Manager"/> and <see cref="Manager"/>
        /// </summary>
        /// <param name="objectToDatabase"> The type of Object needs to be a <see cref="Manager"/> or <see cref="Manager"/>,(Not Null!).</param>
        /// <returns> Returns True or false if the object was Removed From the database </returns>
        bool RemoveUser(object objectToDatabase);
        /// <summary>
        /// This Method Updates a UserLoginObeject 
        /// Be aware you need to inplement our Domain clases if you want this to work.
        ///This is the to clases you can send to this method <see cref="Manager"/> and <see cref="Manager"/>
        /// </summary>
        /// <param name="objectToDatabase"> The type of Object needs to be a <see cref="Manager"/> or <see cref="Manager"/>,(Not Null!).</param>
        /// <returns> Returns True or false if the object was Updated in the database </returns>
        bool UpdateUser(object objectToDatabase);
        string GetHashedPass(string password);
        bool CheckLogin(Manager manager);
        bool CheckLogin(User user);

        //End Of User Methods 
        /*************************************************************************/



    }
}
