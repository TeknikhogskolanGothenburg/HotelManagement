using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using HotelCaseManagment.Domain;
using HotelCaseManagment.Domain.Domains;
using Microsoft.EntityFrameworkCore;


namespace HotelCaseManagment.DataSource
{
  public  class DataContext : DbContext
    {
        public DbSet<Booking> Booking{ get; set;}
        public DbSet<Manager> Manager { get; set; }
        public DbSet<Person> Person { get; set; }
        public DbSet<Room> Room { get; set; }
        public DbSet<User> User { get; set; }
        public DbSet<UserErrorLog> UserErrorLog  { get; set; }
        public DbSet<ManagerErrorLog> ManagerErrorLog { get; set; }
        public DbSet<ManagmentLog> ManagmentLog { get; set; }
      

        public DataContext() 
        {

        }
       
        protected override void OnConfiguring (DbContextOptionsBuilder dbContextOptionsBuilder)
        {

            dbContextOptionsBuilder.UseSqlServer(@"Data Source=LAPTOP-6J4IQ728\SQLEXPRESS;Initial Catalog=HotelManagmentDB;Integrated Security=True");


            ///Funkar inte för tillfället...
            //dbContextOptionsBuilder.UseSqlServer(ConfigurationManager.ConnectionStrings["Connec"].ConnectionString);



        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            modelBuilder.Entity<Manager>().HasKey(x => x.ID);
             
            modelBuilder.Entity<Manager>().HasIndex(x => x.PersonID)
            .IsUnique();
            modelBuilder.Entity<Booking>().HasKey(x => x.ID);
            modelBuilder.Entity<User>().HasKey(x =>  x.Id );
            modelBuilder.Entity<User>().HasIndex(x => x.PersonID).IsUnique();
            modelBuilder.Entity<Person>().HasKey(x => x.ID);
            modelBuilder.Entity<Person>().HasIndex(x => x.Email).IsUnique();





            //modelBuilder.Entity<User>().HasMany

            //modelBuilder.Entity<ManagerErrorLog>().HasKey(t => new { t.ID });
            //modelBuilder.Entity<UserErrorLog>().HasKey(t => new { t.ID });
            //modelBuilder.Entity<Booking>().HasKey(x => new { x.BookingId });


            //modelBuilder.Entity<Person>().HasKey(x => new { x.PersonId });
            //modelBuilder.Entity<Room>().HasKey(x => new { x.RoomId });

            //modelBuilder.Entity<ManagmentLog>().HasKey(x => new { x.ManagmentLogId });
            //modelBuilder.Entity<UserCredential>().HasKey(t => new { t.UserCredentialId, t.UserId });
            //modelBuilder.Entity<ManagerCredential>().HasKey(t => new { t.ManagerCredentialId, t.ManagerId });





        }




    }
}
