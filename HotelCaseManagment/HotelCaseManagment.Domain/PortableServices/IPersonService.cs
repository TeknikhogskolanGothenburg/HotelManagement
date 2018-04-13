using HotelCaseManagment.Domain.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.PortableServices
{
   public interface IPersonService : IRepository<Person>
    {
        ICollection<Person> GetTopMangersList(int Top);
    }
}
