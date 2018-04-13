using HotelCaseManagment.Domain.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.PortableServices
{
    public  interface ICredentials <TUserOrManaGer> where TUserOrManaGer : class
    {
        GetCreDentialKey CreDential(TUserOrManaGer userOrManaGer);
        TUserOrManaGer GetUserByEmail(string Email);
        GetCreDentialKey CreDential(string Email , string Password);

    }
}
