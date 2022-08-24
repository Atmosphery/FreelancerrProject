using Microsoft.EntityFrameworkCore.InMemory;
using Microsoft.EntityFrameworkCore;
using AppointmentServiceApi;

namespace AppointmentTests
{
    public class Tests
    {
        DbContextOptions<AppointmentDb> options;
        AppointmentDb context;


        public Tests()
        {
            options = new DbContextOptionsBuilder<AppointmentDb>()
            .UseInMemoryDatabase(databaseName: "EmployeeDataBase")
            .Options;
            
            
        }


        [Fact]
        public async void TestGetAll()
        {
            using(context = new AppointmentDb(options))
            {
                context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
                context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 3, JobId = 2 });
                context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 4, JobId = 3 });
                context.SaveChanges();
            }

            AppointmentsController controller = new AppointmentsController(context);

            var appointments = await controller.GetAllAppointments();
            Assert.NotNull(appointments);

        }
    }
}