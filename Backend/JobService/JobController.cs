using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

using Microsoft.EntityFrameworkCore;


[ApiController]
[Route("jobservice")]
public class JobController : Controller
{
    private readonly JobDb _db;

    public JobController(JobDb db)
    {
        _db = db;
    }

    [HttpGet("test")]
    public ActionResult<Job> Test()
    {
        Job job = new Job();

        return Ok(job);
    }

    [HttpGet("all/{userid}")]
    public async Task<ActionResult<List<Job>>> GetUserJobs(int userid)
    {
        if(userid == 0)
        {
            return BadRequest($"userid cannot be 0");
        }
        List<Job> jobs = await _db.Jobs.Where(j => j.UserId.Equals(userid)).ToListAsync();
        return Ok(jobs);
    }

    [HttpGet]
    public async Task<ActionResult<Job>> GetJobByObject(Job SearchItem)
    {
        Job Job = await _db.Jobs.FindAsync(SearchItem.Id);

        if (Job == null)
        {
            return new NotFoundObjectResult("This object was not found\n" + SearchItem);
        }

        return Ok(Job);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Job>> GetJobById(int id)
    {
        Job Job = await _db.Jobs.FindAsync(id);

        if (Job == null)
        {
            return new NotFoundObjectResult($"Job with id {id} was not found");
        }

        return Ok(Job);
    }

    [HttpPost]
    public async Task<ActionResult<Job>> AddJob(Job Job)
    {
        if (Job == null)
        {
            return new BadRequestObjectResult(Job);
        }

        await _db.Jobs.AddAsync(Job);
        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(GetJobById), new { id = Job.Id }, Job);
    }

    [HttpPut]
    public async Task<ActionResult<Job>> UpdateJob(Job job)
    {
        //Job dbJob = await _db.Jobs.FindAsync(job.Id);
        if (job == null)
        {
            return BadRequest();
        }

        try
        {


            _db.Jobs.Update(job);
            await _db.SaveChangesAsync();
        }
        catch (Exception)
        {

            throw;
        }

        return Ok(job);

    } 

    [HttpDelete]
    public async Task<ActionResult<Job>> DeleteJob(Job job)
    {
       //Job dbJob =  _db.Jobs.Find(job.Id);
        if (job == null)
        {
            return new BadRequestObjectResult(job);
        }
        try
        {
            _db.Jobs.Remove(job);
            await _db.SaveChangesAsync();
        }
        catch (System.Exception)
        {
            
            return new NotFoundResult();;
        }

        

        return Ok(job);
    }



}

