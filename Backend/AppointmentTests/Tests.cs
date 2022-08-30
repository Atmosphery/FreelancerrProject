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
        AppointmentDb _db;


        public Tests()
        {
            options = new DbContextOptionsBuilder<AppointmentDb>()
            .UseInMemoryDatabase(databaseName: "EmployeeDataBase")
            .Options;

            _db = new AppointmentDb(options);

        }


        [Fact]
        public async void TestGetAll()
        {
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 3, JobId = 2 });
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 4, JobId = 3 });
            _db.SaveChanges();
            AppointmentsController controller = new AppointmentsController(_db);

            var result = await controller.GetAllAppointments();

            var actual = (result.Result as OkObjectResult).Value as IEnumerable<Appointment>;
            Assert.NotNull(actual);
            Assert.Equal(3 , actual.Count());
            Assert.Equal(1 , actual.First().VendorId);
            Assert.Equal(2 , actual.First().CustomerId);    
            Assert.Equal(1 , actual.First().JobId);
            _db.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestGetAllUserAppointments()
        {
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            _db.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            _db.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 5, JobId = 4 });
            _db.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 5, JobId = 5 });
            _db.SaveChanges();
            AppointmentsController controller = new AppointmentsController(_db);

            var result = await controller.GetAllUserAppointments(1);
            var actual = (result.Result as OkObjectResult).Value as IEnumerable<Appointment>;

            Assert.NotNull(actual);
            Assert.True(actual.Count() == 3);
            _db.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestGetAppointent()
        {
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            _db.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            _db.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            _db.SaveChanges();
            AppointmentsController controller = new AppointmentsController(_db);

            var result = await controller.GetAppointment(3);
            var actual = (result.Result as OkObjectResult).Value as Appointment;

            Assert.NotNull(actual);
            Assert.True(actual.VendorId == 2);
            Assert.True(actual.CustomerId == 4);
            Assert.True(actual.JobId == 3);

            _db.Database.EnsureDeleted();
        }

        [Fact]
        public async void TestAddAppointment()
        {
            AppointmentsController controller = new AppointmentsController(_db);
            Appointment appt = new Appointment();
            appt.CustomerId = 1;
            appt.VendorId = 2;
            appt.JobId = 3;

            var result = await controller.AddAppointment(appt);
            Appointment actualResponse = (result.Result as CreatedAtActionResult).Value as Appointment;
            

            var fromDb = _db.Appointments.Find(1);

            Assert.NotNull(fromDb);
            Assert.Equal(actualResponse, fromDb);
            _db.Database.EnsureDeleted();
        }

        [Fact]
        public async void TestUpdateAppointment()
        {
            Appointment appt = new Appointment() { VendorId = 1, CustomerId = 2, JobId = 1 };
            
            _db.Appointments.Add(appt);
            _db.SaveChanges();
            AppointmentsController controller = new AppointmentsController(_db);

            appt.Status = Status.Declined;

            var response = controller.UpdateAppointment(appt);

            var updated =  _db.Appointments.Find(appt.Id);

            Assert.NotNull(updated);
            Assert.True(updated.Status == Status.Declined);
            _db.Database.EnsureDeleted();

        }

        [Fact]
        public async void TestDeleteAppointment()
        {
            _db.Appointments.Add(new Appointment { VendorId = 1, CustomerId = 2, JobId = 1 });
            _db.Appointments.Add(new Appointment { VendorId = 4, CustomerId = 1, JobId = 2 });
            _db.Appointments.Add(new Appointment { VendorId = 2, CustomerId = 4, JobId = 3 });
            _db.SaveChanges();
            AppointmentsController controller = new AppointmentsController(_db);

            Appointment appt = new Appointment() { Id = 3};

            var response = controller.DeleteAppointment(appt);

            var updated = _db.Appointments.Find(appt.Id);

            
            Assert.True(updated is null);
            _db.Database.EnsureDeleted();

        }
    }
}