﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HemaTournamentWebSiteBLL.BusinessEntity.Entity
{
    public class HemaRatingsFighterEntity
    {
        public int Id { get; set; }
        public int IdClub { get; set; }
        public string Name { get; set; }
        public string Nationality { get; set; }
    }
}
