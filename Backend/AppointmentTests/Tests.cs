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
            context.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestGetAllUserAppointments()
        {
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            context.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            context.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 5, JobId = 4 });
            context.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 5, JobId = 5 });
            context.SaveChanges();
            AppointmentsController controller = new AppointmentsController(context);

            var result = controller.GetAllUserAppointments(1);
            var actual = (result.Result as OkObjectResult).Value as IEnumerable<Appointment>;

            Assert.NotNull(actual);
            Assert.True(actual.Count() == 3);
            context.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestGetAppointent()
        {
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            context.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            context.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            context.SaveChanges();
            AppointmentsController controller = new AppointmentsController(context);

            var result = await controller.GetAppointment(3);
            var actual = (result.Result as OkObjectResult).Value as Appointment;

            Assert.NotNull(actual);
            Assert.True(actual.VendorId == 2);
            Assert.True(actual.CustomerId == 4);
            Assert.True(actual.JobId == 3);

            context.Database.EnsureDeleted();
        }

        [Fact]
        public async void TestAddAppointment()
        {
            AppointmentsController controller = new AppointmentsController(context);
            Appointment appt = new Appointment();
            appt.CustomerId = 1;
            appt.VendorId = 2;
            appt.JobId = 3;

            var result = await controller.AddAppointment(appt);
            Appointment actualResponse = (result.Result as CreatedAtActionResult).Value as Appointment;
            

            var fromDb = context.Appointments.Find(1);

            Assert.NotNull(fromDb);
            Assert.Equal(actualResponse, fromDb);
            context.Database.EnsureDeleted();
        }

        [Fact]
        public async void TestUpdateAppointment()
        {
            Appointment appt = new Appointment() { VendorId = 1, CustomerId = 2, JobId = 1 };
            
            context.Appointments.Add(appt);
            context.SaveChanges();
            AppointmentsController controller = new AppointmentsController(context);

            appt.Status = Status.Declined;

            var response = controller.UpdateAppointment(appt);

            var updated =  context.Appointments.Find(appt.Id);

            Assert.NotNull(updated);
            Assert.True(updated.Status == Status.Declined);
            context.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestDeleteAppointment()
        {
            context.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            context.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            context.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            context.SaveChanges();
            AppointmentsController controller = new AppointmentsController(context);

            Appointment appt = new Appointment() { Id = 3};

            var response = controller.DeleteAppointment(appt);

            var updated = context.Appointments.Find(appt.Id);

            
            Assert.True(updated is null);
            context.Database.EnsureDeleted();

        }
    }
}