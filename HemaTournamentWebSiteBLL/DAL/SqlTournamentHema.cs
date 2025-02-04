using HemaTournamentWebSiteBLL.DAL.DAL.Entity;
using HemaTournamentWebSiteBLL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;


namespace HemaTournamentWebSiteBLL.DAL
{
    public class SqlTournamentHema
    {
        string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public SqlTournamentHema()
        { }

        public List<Tournament> LoadTorunaments()
        {
            SqlConnection c = null;

            List<Tournament> res = new List<Tournament>();

            try
            {
                string commandText = "select * FROM [TOURNAMENT] WHERE Show = 1";
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

    }
}