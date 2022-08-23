using System;
using System.ComponentModel.DataAnnotations;

public class Appointment
{
   

    public int Id { get; set; }
    public Status Status { get; set; }

  
    public int? VendorId {get; set;}
  
    public int? CustomerId {get; set;}
  
    public int JobId { get; set; }

    
    public DateTime AppointmentDate { get; set; }

    

}

public enum Status 
{
    Pending,
    Accepted,
    Declined,
    Complete,
    Incomplete
}