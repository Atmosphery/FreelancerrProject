using Microsoft.EntityFrameworkCore;



public class JobDb : DbContext
{
    public JobDb(DbContextOptions<JobDb> options) : base(options) { }
    public DbSet<Job> Jobs { get; set; }
}

