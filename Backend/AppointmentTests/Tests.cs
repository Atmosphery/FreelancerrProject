using Microsoft.EntityFrameworkCore.InMemory;
using Microsoft.EntityFrameworkCore;
using AppointmentServiceApi;
using System.Linq;
using Microsoft.AspNetCore.Mvc;

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

            context = new AppointmentDb(options);

        }


        [Fact]
        public async void TestGetAll()
        {
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 3, JobId = 2 });
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 4, JobId = 3 });
            context.SaveChanges();
            AppointmentsController controller = new AppointmentsController(context);

            var result = await controller.GetAllAppointments();

            var actual = (result.Result as OkObjectResult).Value as IEnumerable<Appointment>;
            Assert.NotNull(actual);
            Assert.Equal(3 , actual.Count());
            Assert.Equal(1 , actual.First().VendorId);
            Assert.Equal(2 , actual.First().CustomerId);    
            Assert.Equal(1 , actual.First().JobId);

        }
    }
}