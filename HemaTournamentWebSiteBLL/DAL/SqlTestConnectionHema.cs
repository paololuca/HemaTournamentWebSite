using HemaTournamentWebSiteBLL.DAL.DAL.Entity;
using HemaTournamentWebSiteBLL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;


namespace HemaTournamentWebSiteBLL.DAL
{
    public class SqlTestConnectionHema
    {
        string _hemaConnectionString = ConfigurationManager.AppSettings["HEMASITEDataSource"].ToString();

        public SqlTestConnectionHema()
        { }

        public string TestConmnection()
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

    }
}