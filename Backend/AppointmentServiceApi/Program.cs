using Microsoft.EntityFrameworkCore;
using Steeltoe.Common.Discovery;
using Steeltoe.Discovery.Eureka;
using Steeltoe.Discovery.Client;
using Steeltoe.Discovery;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDiscoveryClient(builder.Configuration);
builder.Services.AddControllers();//This line finds the controller we built
builder.Services.AddControllersWithViews().AddNewtonsoftJson(options =>
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
);
//builder.Services.AddDbContext<TodoDb>(opt => opt.UseInMemoryDatabase("TodoList"));//gives connection to db
builder.Services.AddDbContext<AppointmentDb>(opt => opt.UseSqlServer(builder.Configuration.GetConnectionString("docker_db1")));//gives up the database handle
var app = builder.Build();

app.UseCors(builder => builder
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());



using (var serviceScope = app.Services.CreateScope())
{
    var context = serviceScope.ServiceProvider.GetRequiredService<AppointmentDb>();
    context.Database.Migrate();
}

app.MapControllers();

app.MapGet("/", () => "Hello World!");

app.Run();
