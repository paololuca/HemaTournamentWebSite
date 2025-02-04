using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace HemaTournamentWebSiteBLL.Helper
{
    public static  class ClubImageHelper
    {

        public static string GetImage(string nomeAsd, string absolutePath)
        {
            var name = Regex.Replace(nomeAsd, @"[^a-zA-Z]", "");

            if (File.Exists(absolutePath + name + ".png"))
                return name + ".png";
            else
                return "generic_club.png";
        }

    }
}
