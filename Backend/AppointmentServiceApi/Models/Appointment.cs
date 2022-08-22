using System;

public class Appointment
{
    public int Id { get; set; }
    public DateOnly AppointmentDate { get; set; }

    public TimeOnly StartTime { get; set; }
    public TimeOnly EndTime { get; set; }

}