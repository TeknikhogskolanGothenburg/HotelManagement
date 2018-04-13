using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HotelCaseManagment.DataRepository;
namespace HotelCaseMagment.Webbapp.Controllers
{
    public class HomeController : Controller
    {


        public ActionResult Login()
        {
            
            return View();
        }
        [HttpPost]
        public ActionResult Login(string UserName, string Password)
        {
          var Credential =  LoginController.CheckUserCredential(UserName, Password);
            switch (Credential)
            {
                case LoginController.LogingStatus.IncorrectLogin:
                  return  RedirectToAction("Login", "Home");
                 
                case LoginController.LogingStatus.Succes:
                  return  RedirectToAction("Index", "Home");

                default:
                    return new HttpStatusCodeResult(404);
            }
           
            

        }


     
        public ActionResult Index()
        {
            return View();
        }
    }
     
}