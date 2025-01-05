
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HemaTournamentWebSite.DAL.Entity
{
    public class Tournament
    {
        public int Id { get; internal set; }
        public string Name { get; set; }
        public string Place { get; internal set; }
        public DateTime StartDate { get; internal set; }
        public DateTime EndDate { get; internal set; }
        public bool Active { get; set; }
    }
}