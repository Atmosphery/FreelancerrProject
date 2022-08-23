using Microsoft.EntityFrameworkCore;
public class AppointmentDB : DbContext
{

    public AppointmentDB(DbContextOptions<AppointmentDB> options) : base(options) { }
    public DbSet<User> Users => Set<User>();
    
    public AppointmentDB()
    {

    }
    
}
