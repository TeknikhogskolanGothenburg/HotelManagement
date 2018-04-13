using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.App.Models
{
   public class BookingModel
    {
        public string ID { get; set; }
        public string RoomID { get; set; }
        public DateTime BookingStart { get; set; }
        public DateTime BookingEnd { get; set; }
        public Double TotaltPrice { get; set; }
        public virtual string UserID { get; set; }
        public virtual string PersonName { get; set; }


    }
}
