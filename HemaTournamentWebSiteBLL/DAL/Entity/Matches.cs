using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HemaTournamentWebSiteBLL.DAL.DAL.Entity
{
    public class Matches
    {
        public int Pool { get; set; }
        public string Fighter1 { get; set; }
        public int Fighter1_Hit { get; set; }
        public bool Double { get; set; }
        public int Fighter2_Hit { get; set; }
        public string Fighter2 { get; set;}
    }
}