using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HemaTournamentWebSite.DAL.DAL.Entity
{
    public class Stats
    {
        //public int PoolId { get; set; }
        public int Pos { get; set; }
        public string Surname { get; set; }
        public string Name { get; set; }
        public int Victory { get; set; }
        public int Loss { get; set; }
        public int Hit { get; set; }
        public int Hitted { get; set; }
        public double Delta { get; set; }
        public double Ranking { get; set; }
    }
}