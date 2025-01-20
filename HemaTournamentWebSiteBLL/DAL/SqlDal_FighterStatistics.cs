using HemaTournamentWebSiteBLL.BusinessEntity.DAO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HemaTournamentWebSiteBLL.DAL
{
    static class SqlDal_FighterStatistics
    {
        private static string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public static List<RankingByYear> GetFighterRankingByCategory(int fighterId, int disciplineId)
        {
            List<RankingByYear> res = new List<RankingByYear>();

            SqlConnection c = null;

            try
            {
                c = new SqlConnection(_hemaConnectionString);

                String sqlText = "select * from RankingStorico rs join RankingFasi rf on rs.Fase = rf.Id " +
                                    "where IdAtleta = "+fighterId + " "+
                                    "and IdDisciplina = " + disciplineId + " " +
                                    "order by rs.Anno asc, rs.Fase asc";
                c.Open();

                SqlCommand command = new SqlCommand(sqlText, c);
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    res.Add(new RankingByYear
                    {
                        Punteggio = Convert.ToDouble(reader["Punteggio"].ToString()),
                        Anno = Convert.ToInt32(reader["Anno"].ToString()),
                        Fase = Convert.ToInt32(reader["Fase"].ToString()),
                        InsertedDate = Convert.ToDateTime(reader["DataInserimentoRanking"].ToString())
                    });
                }                    

                return res;
            }
            catch (Exception e)
            {
                return new List<RankingByYear>();
            }
            finally
            {
                c.Close();
            }
        }

    }
}
