
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.Domains
{
    public class Manager
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid ID { get; set; }
        [ForeignKey("Person")]
        public Guid PersonID { get; set; }
        public bool IsAdmin { get; set; }
        public DateTime LastesLogin { get; set; }
        public virtual ICollection<ManagmentLog> ManagmentLogs { get; set; }
        public virtual ICollection<ManagerErrorLog> ManagerErrorLogs { get; set; }
        public virtual Person Person { get; set; }
        public Manager()
        {
           
            ManagmentLogs = new HashSet<ManagmentLog>();
            ManagerErrorLogs = new HashSet<ManagerErrorLog>();
        }



    }
}
