using HotelCaseManagment.Domain.Domains;
using HotelCaseManagment.Domain.PortableServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.DataSource.Repository
{
   public class PersonRepository : Repository<Person>, IPersonService
    {

        public PersonRepository(DataContext context)
            : base(context)
        {
        }

       

        public DataContext DataContext
        {
            get { return Context as DataContext; }
        }

        public ICollection<Person> GetTopMangersList(int Top)
        {
            return DataContext.Person.Take(Top).ToList();
        }
    }
}
   

