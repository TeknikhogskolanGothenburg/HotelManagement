
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.Domains
{
   public class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid Id { get; set; }
        [ForeignKey("Person")]
        public Guid PersonID { get; set; }
        public DateTime LastesLogin { get; set; }
        public virtual ICollection<Booking> Bookings { get; set; }
        public virtual ICollection<UserErrorLog> UserErrorLogs { get; set; }
        public virtual Person Person { get; set; }
        public User()
        {
          
            Bookings = new HashSet<Booking>();
            UserErrorLogs = new HashSet<UserErrorLog>();
        }

    }
}
