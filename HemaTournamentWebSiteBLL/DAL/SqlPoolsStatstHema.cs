using HemaTournamentWebSiteBLL.DAL.DAL.Entity;
using HemaTournamentWebSiteBLL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;


namespace HemaTournamentWebSiteBLL.DAL
{
    public class SqlPoolsStatstHema
    {
        string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public SqlPoolsStatstHema()
        { }

        public List<Stats> LoadStats(int idTorneo, int idDisciplina)
        {
            var result = new List<Stats>();

            SqlConnection c = null;

            try
            {
                string commandText = "select * FROM POOLS_STATS WHERE IdTorneo = " + idTorneo + " AND IdDisciplina = " + idDisciplina +
                    " order by Differenziale desc, Vittorie desc, PuntiFatti desc , PuntiSubiti asc, Ranking desc";
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new Stats()
                    {
                        //PoolId = Convert.ToInt32(reader["IdGirone"].ToString()),
                        Surname = reader["Cognome"].ToString(),
                        Name = reader["Nome"].ToString(),
                        Victory = Convert.ToInt32(reader["Vittorie"].ToString()),
                        Loss = Convert.ToInt32(reader["Sconfitte"].ToString()),
                        Hit = Convert.ToInt32(reader["PuntiFatti"].ToString()),
                        Hitted = Convert.ToInt32(reader["PuntiSubiti"].ToString()),
                        Delta = Convert.ToDouble(reader["Differenziale"].ToString()),
                        Ranking = Convert.ToDouble(reader["Ranking"].ToString())
                    }
                    );
                }
                return result;

            }
            catch (Exception e)
            {
                return result;
            }
            finally
            {
                c.Close();
            }
        }
    }
}