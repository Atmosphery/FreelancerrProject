using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("basket")]
public class BasketsController : Controller 
{
    private readonly BasketDb _db;

    public BasketsController(ILogger<BasketsController> logger, BasketDb db)
    {
        _db = db;
    }

    [HttpGet]
    public async Task<ActionResult<List<Appointment>>>
}