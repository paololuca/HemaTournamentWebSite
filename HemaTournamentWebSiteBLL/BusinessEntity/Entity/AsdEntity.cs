using System;

namespace HemaTournamentWebSiteBLL.BusinessEntity.Entity
{
    public class AsdEntity
    {
        public Int32 Id { get; set; }
        public String NomeAsd { get; set; }
        public string Email { get; internal set; }
        public string Place { get; internal set; }
        public Int32 AtletiAssociativi { get; set; }
    }
}
