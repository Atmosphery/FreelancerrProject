using Microsoft.EntityFrameworkCore.InMemory;
using Microsoft.EntityFrameworkCore;

using System.Linq;
using Microsoft.AspNetCore.Mvc;

namespace JobTests
{
    public class Tests
    {
       
        
        DbContextOptions<JobDb> options;
        JobDb _db;


        public Tests()
        {
            options = new DbContextOptionsBuilder<JobDb>()
            .UseInMemoryDatabase(databaseName: "EmployeeDataBase")
            .Options;

            _db = new JobDb(options);

        }


        [Fact]
        public async void TestGetJobById()
        {
            _db.Jobs.Add(new Job { Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Contract Killer", Description = "I will murder anyone you need", UserId = 1, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 2, BasePrice = 99.99f });

            await _db.SaveChangesAsync();
            JobController controller = new JobController(_db);

            var result = await controller.GetJobById(2);

            var actual = (result.Result as OkObjectResult).Value as Job;
            Assert.NotNull(actual);
            Assert.True(actual.Title.Equals("Contract Killer"));
            await _db.Database.EnsureDeletedAsync();

        }

        [Fact]
        public async void TestGetUserJobs()
        {
            JobController controller = new JobController(_db);
            _db.Jobs.Add(new Job { Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Contract Killer", Description = "I will murder anyone you need", UserId = 2, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 2, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 2, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 3, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 4, BasePrice = 99.99f });
            await _db.SaveChangesAsync();

            var result = await controller.GetUserJobs(2);

            var actual = (result.Result as OkObjectResult).Value as IEnumerable<Job>;
            Assert.NotNull(actual);
            Assert.Equal(3, actual.Count());
            foreach (Job job in actual)
            {
                Assert.True(job.UserId == 2);
            }

            await _db.Database.EnsureDeletedAsync();

        }

        [Fact]
        public async void TestGetJobByObject()
        {
            JobController controller = new JobController(_db);

            

            _db.Jobs.Add(new Job { Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99f });
            _db.Jobs.Add(new Job { Title = "Contract Killer", Description = "I will murder anyone you need", UserId = 2, BasePrice = 99.99f });
            _db.Jobs.Add(new Job { Title = "Professional instagrammer", Description = "I will annoy the fuck out of you.", UserId = 2, BasePrice = 99.99f });
   
            await _db.SaveChangesAsync();

            Job expected = new Job { Id = 1, Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99f };
            var result = await controller.GetJobByObject(expected);

            var actual = (result.Result as OkObjectResult).Value as Job;
            Assert.NotNull(actual);
            Assert.Equal(expected.Title, actual.Title);
            Assert.Equal(expected.Description, actual.Description);
            Assert.Equal(expected.UserId, actual.UserId);
            Assert.Equal(expected.BasePrice, actual.BasePrice);
            await _db.Database.EnsureDeletedAsync();

        }

        [Fact]
        public async void TestAddJob()
        {
            JobController controller = new JobController(_db);

            Job expected = new Job { Id = 1, Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99f };
            var result = await controller.AddJob(expected);
            var actual = (result.Result as CreatedAtActionResult).Value as Job;

            Assert.NotNull(actual);
            Assert.True(expected.Equals(actual));
            await _db.Database.EnsureDeletedAsync();

        }

        [Fact]
        public async void TestUpdateJob()
        {
            JobController controller = new JobController(_db);

            Job expected = new Job { Id = 1, Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99f };
            await _db.Jobs.AddAsync(expected);
            await _db.SaveChangesAsync();

            expected.Title = "Desktop App Builder";
            expected.Description = "Fuck mobile apps";

            var result = await controller.UpdateJob(expected);
            var actual = (result.Result as OkObjectResult).Value as Job;

            Assert.NotNull(actual);
            Assert.True(expected.Equals(actual));
            await _db.Database.EnsureDeletedAsync();
        }

        [Fact]
        public async void TestDeleteJob()
        {
            JobController controller = new JobController(_db);

            Job expected = new Job { Id = 1, Title = "Mobile App builder", Description = "I will build app", UserId = 1, BasePrice = 99f };
            await _db.Jobs.AddAsync(expected);
            await _db.SaveChangesAsync();

            expected.Title = "Desktop App Builder";
            expected.Description = "Fuck mobile apps";

            var result = await controller.DeleteJob(expected);
            var actual = (result.Result as OkObjectResult).Value as Job;

            Assert.NotNull(actual);
            Assert.True(expected.Equals(actual));
            Assert.True(_db.Jobs.Count() == 0);
            await _db.Database.EnsureDeletedAsync();

        }


    }
}