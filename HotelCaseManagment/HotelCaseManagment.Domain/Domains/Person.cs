using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

 namespace HotelCaseManagment.Domain.Domains
{
// Determines a person in the Object in the database all Columns Are required to create this Object
    public class Person
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid ID { get; set; }
     
        public string Name { get; set; }
      
        public string SecondName { get; set; }

        public string Password { get; set; }

        public string Email { get; set; }

        public string Addres { get; set; }
       
        public DateTime BirthDate { get; set; }
        

        public virtual ICollection<User> Users { get; set; }
        public virtual ICollection<Manager> Managers { get; set; }
        public Person()
        {
            Users = new HashSet<User>();
            Managers = new HashSet<Manager>();
        }
    }
}
