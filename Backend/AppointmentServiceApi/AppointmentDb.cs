using Microsoft.EntityFrameworkCore;

public class AppointmentDb : DbContext 
{
    public AppointmentDb(DbContextOptions<AppointmentDb> options) : base(options) { }
    public DbSet<Appointment> Appointments { get; set; }


    

    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
     {

        /*modelBuilder.Entity<Appointment>()
            .HasOne(appt => appt.Vendor)
            .WithMany(ven => ven.Appointments);*/

       /* modelBuilder.Entity<Appointment>()
            .HasOne(appt => appt.Customer)
            .WithMany(cus => cus.Appointments);*/

        //modelBuilder.Entity<Item>().Property(item => item.Id).ValueGeneratedNever();

        /*modelBuilder.Entity<BasketItem>()

        modelBuilder.Entity<Basket>()
            .HasMany(basket => basket.Items)
            .WithMany(item => item.Baskets).UsingEntity(BasketItems.GetType());*/
    }
}