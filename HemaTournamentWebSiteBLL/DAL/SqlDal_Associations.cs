using HemaTournamentWebSiteBLL.BusinessEntity.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace HemaTournamentWebSiteBLL.DAL
{
    public static class SqlDal_Associations
    {
        private static string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public static string Place { get; private set; }

        public static List<AsdEntity> GetAllAsd(bool onlyList)
        {
            String commandText = "SELECT * FROM Asd ORDER BY Nome_ASD";

            List<AsdEntity> asd = new List<AsdEntity>();
            SqlConnection c = null;

            try
            {
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                SqlDataReader reader = command.ExecuteReader();

                if (!onlyList)
                    asd.Add(new AsdEntity() { Id = 0, NomeAsd = "" });

                while (reader.Read())
                {
                    asd.Add(new AsdEntity()
                    {
                        Id = (int)reader["Id"],
                        NomeAsd = Convert.ToString(reader["Nome_ASD"])
                    }
                    );
                }
                if (asd.Count > 0)
                    return asd;
                else
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
        public static List<AsdEntity> GetAllAsdWithMembersNumber()
        {
            String commandText = "SELECT asd.Id, asd.Nome_ASD, Place, asd.Email, count(*) as members " +
                                    "FROM Asd asd join Atleti a on asd.Id = a.IdASD " +
                                    "GROUP BY asd.ID, asd.Nome_ASD, Place, asd.Email " +
                                    "order by Nome_ASD";

            List<AsdEntity> asd = new List<AsdEntity>();
            SqlConnection c = null;

            try
            {
                c = new SqlConnection(_hemaConnectionString);

                c.Open();

                SqlCommand command = new SqlCommand(commandText, c);
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    asd.Add(new AsdEntity()
                    {
                        Id = (int)reader["Id"],
                        NomeAsd = Convert.ToString(reader["Nome_ASD"]),
                        Email = Convert.ToString(reader["Email"]),
                        Place = Convert.ToString(reader["Place"]),
                        AtletiAssociativi = (int)reader["members"]
                    }
                    );
                }
                if (asd.Count > 0)
                    return asd;
                else
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
