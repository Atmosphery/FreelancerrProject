using System;

public class Appointment
{
    public int Id { get; set; }
    public Status Status { get; set; }

    public User? Vendor {get; set;}
    public User? Customer {get; set;}
    
    public DateOnly AppointmentDate { get; set; }

    public TimeOnly StartTime { get; set; }
    public TimeOnly EndTime { get; set; }

}

public enum Status 
{
    Pending,
    Accepted,
    Declined,
    Closed

}