
using HemaTournamentWebSite.DAL.DAL.Entity;
using HemaTournamentWebSite.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HemaTournamentWebSite.DAL
{
    public class SqlDalHema
    {
        string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public SqlDalHema()
        { }

        public List<Tournament> LoadTorunaments()
        {
            SqlConnection c = null;

            List<Tournament> res = new List<Tournament>();

            try
            {
                string commandText = "select * FROM [TOURNAMENT]";
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    res.Add(new Tournament()
                    {
                        Id = Convert.ToInt32(reader["IdTorneo"]),
                        Name = reader["NomeTorneo"].ToString(),
                        Place = reader["Luogo"].ToString(),
                        StartDate = Convert.ToDateTime(reader["DataInizio"].ToString()),
                        EndDate = Convert.ToDateTime(reader["DataFine"].ToString())
                    }); ;
                }
                return res;

            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                c.Close();
            }
        }

        internal string TestConmnection()
        {
            SqlConnection c = null;

            try
            {
                c = new SqlConnection(_hemaConnectionString);
                c.Open();

                return "Connection OK";

            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                c.Close();
            }
        }

        public Tournament LoadTorunamentsDesc(int idTorneo)
        {
            SqlConnection c = null;

            try
            {
                string commandText = "select * FROM [TOURNAMENT] WHERE IdTorneo = " + idTorneo;
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                var reader = command.ExecuteReader();

                while(reader.Read())
                {
                    return new Tournament()
                    {
                        Name = reader["NomeTorneo"].ToString(),
                        //Active = Convert.ToBoolean(reader["Active"])
                    };
                }
                return null;

            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                c.Close();
            }
        }

        public List<Matches> LoadPoolsMatches(int idTorneo, int idDisciplina)
        {
            var result = new List<Matches>();

            SqlConnection c = null;

            try
            {
                string commandText = "select * from [dbo].[POOLS_MATCHES] WHERE IdTorneo = " + idTorneo + " AND IdDisciplina = " + idDisciplina + " order by IdGirone";
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new Matches()
                    {
                        Pool = Convert.ToInt32(reader["IdGirone"].ToString()),
                        Fighter1 = reader["NomeAtletaRosso"].ToString(),
                        Fighter2 = reader["NomeAtletaBlu"].ToString(),
                        Fighter1_Hit = Convert.ToInt32(reader["PuntiRosso"].ToString()),
                        Fighter2_Hit = Convert.ToInt32(reader["PuntiBlu"].ToString()),
                        Double = Convert.ToBoolean(reader["DoppiaMorte"].ToString())
                    });
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