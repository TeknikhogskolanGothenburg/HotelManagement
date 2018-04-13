
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.Domains
{
    public class Booking
    {
       [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid ID { get; set; }
        [ForeignKey("Room")]
        public Guid RoomID { get; set; }
        [ForeignKey("User")]
        public Guid UserID { get; set; }
        public DateTime BookingStart { get; set; }
        public DateTime BookingEnd { get; set; }
        public Double TotaltPrice { get; set; }
        public virtual User User { get; set; }
        public virtual Room Room { get; set; }






    }
}
