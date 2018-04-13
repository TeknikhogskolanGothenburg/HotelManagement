using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.Domains
{
  public class Room {

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid ID { get; set; }
        public int Sleeps { get; set; }
        public double Price { get; set; }
        public string RoomDescription { get; set; }
        public DateTime LastDayCleaned { get; set; }
        public ICollection<Booking> Bookings { get; set; }
        public Room()
        {
            Bookings = new HashSet<Booking>();
        }


    }
}
