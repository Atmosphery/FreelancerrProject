using Microsoft.AspNetCore.Mvc;

using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("appointments")]
public class BasketsController : Controller 
{
    private readonly AppointmentDB _db;

    public BasketsController(ILogger<BasketsController> logger, AppointmentDB db)
    {
        _db = db;
    }
}