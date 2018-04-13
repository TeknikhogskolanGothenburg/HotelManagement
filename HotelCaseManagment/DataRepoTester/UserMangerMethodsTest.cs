using System;
using System.Collections.Generic;
using HotelCaseManagment.DataRepository;
using HotelCaseManagment.Domain.BookingObjects;
using HotelCaseManagment.Domain.UserLoginObjects;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DataRepoTester
{
    [TestClass]
    public class UserMangerMethodsTest
    {
        [TestMethod]
        public void CreateNewUserTest()
        {
            IUserLoginObjecs x = new UserLoginObjecs();
            bool test = false;
           
            try
            {
                object IsNullObject = null;
                object ISnotNullObject = new object();
           
                Manager e = null;
                User c = null;
                Booking f = new Booking
                {
                    User = new User
                    {
                        Person = new Person
                        {
                            Name = "test",
                            Email = "test@154545645.com",
                            
                        }
                    }

                };

             test = x.CreateNewUser(IsNullObject);
              test = x.CreateNewUser(e);
              test = x.CreateNewUser(c);
              test = x.CreateNewUser(f);

                Assert.Fail();
            }
            catch
            {
                Assert.IsFalse(test);
                
                
            }

        }

        [TestMethod]
        public void GetUserTestAndCreateUser()
        {
            Random F = new Random();

            IUserLoginObjecs x = new UserLoginObjecs();
            User TesUser = new User
            {

                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TEST@TEST" + F.Next(1, 1000).ToString() + F.Next(1, 10000).ToString() + ".COM",
                    Password = "TEST",
                    Name = "TESTANME",
                    SecondName = "TESTSECONDNAME"
                },

            };
            Assert.IsTrue(x.CreateNewUser(TesUser), "Det Gick inte att spara användaren, kontrellera testet en gång til! (Radera alla användare från Databasen innan testet)");
            var UsergerTest = x.GetUser(TesUser);
            Assert.IsNotNull(UsergerTest, "User Värdet på User får inte vara Null");
            Assert.AreEqual(UsergerTest.Person.Email, TesUser.Person.Email, "Mailet är inte samma");
            Assert.AreEqual(UsergerTest.Person.Name, TesUser.Person.Name, "Namnet är inte samma");
            Assert.AreEqual(UsergerTest.Person.Addres, TesUser.Person.Addres, "Addres är inte samma");
            Assert.AreEqual(UsergerTest.Person.SecondName, TesUser.Person.SecondName, "AndraNamn är inte samma");
            Assert.AreEqual(UsergerTest.Person.Password, TesUser.Person.Password, "Lösenord är inte samma");
            var User2 = x.GetUser(UsergerTest);
            Assert.AreEqual(TesUser.PersonID, User2.PersonID, "PersonID är inte samma");
            Assert.AreEqual(TesUser.ID, User2.ID, "ID är inte samma");

        }
        [TestMethod]
        public void GetUserByIDTest()
        {

            Random F = new Random();

            IUserLoginObjecs x = new UserLoginObjecs();
            User TestUser = new User
            {
           
                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TESTst@TEST" + F.Next(1, 1000).ToString() + F.Next(1, 100).ToString() + ".COM",
                    Password = "TEST",
                    Name = "TESTANME",
                    SecondName = "TESTSECONDNAME"
                },

            };
            x.CreateNewUser(TestUser);
            var UserTest = x.GetUser(TestUser);
            var UserTest3 = x.GetUserByID(UserTest.ID);
            var UserTest4 = x.GetUserByID(TestUser.Person.Email);
            Assert.IsNotNull(UserTest3);
            Assert.AreEqual(UserTest.ID, UserTest3.ID, "ID Strämmer inte överens");
            Assert.AreEqual(UserTest.Person.Email, UserTest3.Person.Email, "Email Strämmer inte överens");


        }

        [TestMethod]
        public void GetAllUsersTest()
        {

            List<User> UserTest = new List<User>();
            Random F = new Random();
            IUserLoginObjecs x = new UserLoginObjecs();

            char[] foo = new char[11] { 'A', 'B', 'C', 'E', 'R', 'Y', 'P', 'Z', 'T', 'M', 'P' };

            for (int i = 0; i < 10; i++)
            {


                User TesManager = new User
                {

                    LastesLogin = DateTime.Now,
                    Person = new Person
                    {
                        Addres = "Street1",
                        BirthDate = DateTime.Now,
                        Email = "TEST@TEST" + F.Next(1, 1000).ToString() + foo[F.Next(0, 11)] + F.Next(1, 100).ToString() + ".COM",
                        Password = "TEST",
                        Name = "TESTANME",
                        SecondName = "TESTSECONDNAME"
                    },

                };
                UserTest.Add(TesManager);

            }

            for (int i = 0; i < UserTest.Count; i++)
            {
                Assert.IsTrue(x.CreateNewUser(UserTest[i]), "Gick inte att spara användaren !");
            }

            Assert.AreEqual(UserTest.Count, x.GetAllUsers(10).Count, "Antal användare är olkia");

            try
            {

                Assert.AreEqual(x.GetAllUsers(0).Count, 0, "Värdet på GetallManager bör vara null när vi skickar in : 0");
                Assert.IsNotNull(x.GetAllUsers(10000000), "Värdet på GetallManager bör inte vara null när vi skickar in en siffra större än va det finns i databasen");

            }
            catch (Exception Ee)
            {
                Assert.Fail(Ee.ToString());

            }



        }

        [TestMethod]
        public void GetAllManagersTest()
        {
            List<Manager> MangersTest = new List<Manager>();
            Random F = new Random();
            IUserLoginObjecs x = new UserLoginObjecs();
           
            char[] foo = new char[11] { 'A', 'B', 'C', 'E', 'R', 'Y', 'P', 'Z', 'T', 'M', 'P' };
            
            for (int i = 0; i < 10; i++)
            {
              

                Manager TesManager = new Manager
                {
                    IsAdmin = true,
                    LastesLogin = DateTime.Now,
                    Person = new Person
                    {
                        Addres = "Street1",
                        BirthDate = DateTime.Now,
                        Email = "TEST@TEST" + F.Next(1, 1000).ToString()+foo[F.Next(0,11)]+ F.Next(1, 100).ToString() + ".COM",
                        Password = "TEST",
                        Name = "TESTANME",
                        SecondName = "TESTSECONDNAME"
                    },

                };
                MangersTest.Add(TesManager);

            }
           
            for( int i =0; i < MangersTest.Count; i++)
            {
                Assert.IsTrue(x.CreateNewUser(MangersTest[i]), "Gick inte att spara användaren !");
            }

          Assert.AreEqual(MangersTest.Count , x.GetAllManagers(10).Count,"Antal användare är olkia");


        }
       
        [TestMethod]
        public void GetMangerByIDTest()
        {
            Random F = new Random();

            IUserLoginObjecs x = new UserLoginObjecs();
            Manager TesManager = new Manager
            {
                IsAdmin = true,
                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TESTst@TEST" + F.Next(1, 1000).ToString() + F.Next(1, 100).ToString() + ".COM",
                    Password = "TEST",
                    Name = "TESTANME",
                    SecondName = "TESTSECONDNAME"
                },

            };
            x.CreateNewUser(TesManager);
            var MangerTes2 = x.GetManger(TesManager);
            var managerTest3 = x.GetManagerByID(MangerTes2.ID);
            var managerTest4 = x.GetManagerByID(TesManager.Person.Email);
            Assert.IsNotNull(managerTest3);
            Assert.AreEqual(MangerTes2.ID, managerTest3.ID, "ID Strämmer inte överens");
            Assert.AreEqual(MangerTes2.Person.Email, managerTest3.Person.Email, "Email Strämmer inte överens");


        }

        [TestMethod]
        public void GetMangerTestAndCreateManager()
        {
            Random F = new Random();

            IUserLoginObjecs x = new UserLoginObjecs();
            Manager TesManager = new Manager
            {
                IsAdmin = true,
                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TEST@TEST" + F.Next(1, 1000).ToString() + F.Next(1, 100).ToString() + ".COM",
                    Password = "TEST",
                    Name = "TESTANME",
                    SecondName = "TESTSECONDNAME"
                },

            };
            Assert.IsTrue(x.CreateNewUser(TesManager), "Det Gick inte att spara användaren, kontrellera testet en gång til! (Radera alla användare från Databasen innan testet)");
            var ManagerTest = x.GetManger(TesManager);
            Assert.IsNotNull(ManagerTest);
            Assert.AreEqual(ManagerTest.Person.Email, TesManager.Person.Email, "Mailet är inte samma");
            Assert.AreEqual(ManagerTest.Person.Name, TesManager.Person.Name, "Namnet är inte samma");
            Assert.AreEqual(ManagerTest.Person.Addres, TesManager.Person.Addres, "Addres är inte samma");
            Assert.AreEqual(ManagerTest.Person.SecondName, TesManager.Person.SecondName, "AndraNamn är inte samma");
            Assert.AreEqual(ManagerTest.Person.Password, TesManager.Person.Password, "Lösenord är inte samma");
            var Manager2 = x.GetManger(ManagerTest);
            Assert.AreEqual(TesManager.PersonID, Manager2.PersonID, "PersonID är inte samma");
            Assert.AreEqual(TesManager.ID, Manager2.ID, "ManagerID är inte samma");
        }

        [TestMethod]
        public void SearchMangerTest()
        {
            Random s = new Random();
            IUserLoginObjecs x = new UserLoginObjecs();

            Manager TesManager = new Manager
            {
                IsAdmin = true,
                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TEST@Wiliam"+s.Next(0,10000) +".COM",
                    Password = "TEST",
                    Name = "Wilmar",
                    SecondName = "TESTSECONDNAME"
                },

            };
          Assert.IsTrue(x.CreateNewUser(TesManager),"Det verkar som att användaren finns redan!");
            var Getmanager = x.GetManger(TesManager);
            var ManagerList =   x.SearchManger(Getmanager.Person.Name);
            var ManagerList2 = x.SearchManger(Getmanager.Person.Email);
            Assert.IsTrue( ManagerList.Exists(X=> X.Person.Name == Getmanager.Person.Name),"Sökaren fungerar inte som det ska");
            Assert.IsTrue(ManagerList.Exists(X => X.Person.Email == Getmanager.Person.Email), "Sökaren fungerar inte som det ska");


        }

        [TestMethod]
        public void SearchUserTest()
        {
            Random s = new Random();
            IUserLoginObjecs x = new UserLoginObjecs();

            User TestUser = new User
            {
             
                LastesLogin = DateTime.Now,
                Person = new Person
                {
                    Addres = "Street1",
                    BirthDate = DateTime.Now,
                    Email = "TEST@Wiliam" + s.Next(0, 10000) + ".COM",
                    Password = "TEST",
                    Name = "Wilmar",
                    SecondName = "TESTSECONDNAME"
                },

            };
            Assert.IsTrue(x.CreateNewUser(TestUser), "Det verkar som att användaren finns redan!");
            var Getuser = x.GetUser(TestUser);
            var UserList = x.SearchUser(Getuser.Person.Name);
            var usererList2 = x.SearchUser(Getuser.Person.Email);
            Assert.IsTrue(UserList.Exists(X => X.Person.Name == Getuser.Person.Name), "Sökaren fungerar inte som det ska");
            Assert.IsTrue(UserList.Exists(X => X.Person.Email == Getuser.Person.Email), "Sökaren fungerar inte som det ska");





        }





    }
}
