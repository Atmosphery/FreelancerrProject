using Microsoft.AspNetCore.Mvc;

using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("appointment")]
public class AppointmentsController : Controller 
{
    private readonly AppointmentDb _db;

    public AppointmentsController(AppointmentDb db)
    {
        _db = db;
    }

    //Crud Functions

    [HttpGet("all")]
    public async Task<ActionResult<List<Appointment>>> GetAllAppointments()
    {
        var list = await _db.Appointments.ToListAsync();
        return Ok(list);
    }



    //Get One Appointment
    [HttpGet("{id}")]
    public async Task<ActionResult<List<Appointment>>> GetAppointment(int id)
    {
        var todo = await _db.Appointments.FirstAsync(b => b.Id == id);
        if (todo == null)
        {
            return NotFound();
        }
        return Ok(todo);
    }

    //Create Appointment 
    [HttpPost]
    public async Task<ActionResult<Appointment>> AddAppointment(Appointment appt)
    {
        if(appt.VendorId != 0 || appt.CustomerId != 0 || appt.JobId != 0)
        {
            appt.Status = Status.Pending;
            appt.AppointmentDate = DateTime.Now;
            

            await _db.Appointments.AddAsync(appt);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetAppointment), new { id = appt.Id }, appt);
        }
        return BadRequest(); 
    }

    //Update Appointment
    [HttpPut]
    public async Task<ActionResult<Appointment>> UpdateAppointment(Appointment appt)
    {
        if (appt != null)
        {
            try
            {

                _db.Appointments.Update(appt);
                await _db.SaveChangesAsync();
            }
            catch (Exception)
            {

                throw;
            }
            
            return Ok(appt);
        }
        return BadRequest();
    }

    

    //Delete Appointment
    [HttpDelete]
    public async Task<ActionResult<Appointment>> DeleteAppointment(Appointment appt)
    {
        if (appt != null)
        {
            try
            {
                appt = await _db.Appointments.FindAsync(appt.Id);
                if(appt != null)
                {
                    _db.Appointments.Remove(appt);
                    await _db.SaveChangesAsync();
                }
            }
            catch (Exception)
            {

                throw;
            }
            return Ok(appt);
        }
        return BadRequest();
    }

    //delete by only id
    [HttpDelete("{id}")]
    public async Task<ActionResult<Appointment>> DeleteAppointmentById(int id)
    {
        Appointment appt;
        try
        {
            appt = await _db.Appointments.FindAsync(id);

            if (appt is null)
            {
                return BadRequest();
            }
            _db.Appointments.Remove(appt);
            await _db.SaveChangesAsync();

        }
        catch (Exception)
        {

            throw;
        }
        return Ok(appt);

    }
}
