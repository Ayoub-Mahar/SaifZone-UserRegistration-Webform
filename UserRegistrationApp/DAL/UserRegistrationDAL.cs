using DTOs;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class UserRegistrationDAL
    {
        SqlConnection con = null;
        SqlDataAdapter adpt = null;
        SqlCommand cmd = null;
        DataTable dt;
       
        // I'm tried to add connection string on DAL app.config, but geting refernce object problem so that's why I use here.

        string connectionString = @"Data Source=localhost\MSSQLSERVER01;Initial Catalog=UserRegistrationDB;Integrated Security=True;";
 
        public bool Registration(UserRegistrationModel ObjBO) // passing Bussiness object Here  
        {
            bool Ok = false;
            cmd = new SqlCommand();
            try
            {
                con = new SqlConnection();
                con.ConnectionString = connectionString;
                cmd.Connection = con;
                string query = "spUserRegistration";
                cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FirstName", ObjBO.FirstName);
                cmd.Parameters.AddWithValue("@LastName", ObjBO.LastName);
                cmd.Parameters.AddWithValue("@Email", ObjBO.Email);
                cmd.Parameters.AddWithValue("@PhoneNumber", ObjBO.PhoneNumber);
                cmd.Parameters.AddWithValue("@CreditCardNumber", AESEncryption.Encrypt(ObjBO.CreditCardNumber));
                cmd.Parameters.AddWithValue("@CVV", AESEncryption.Encrypt(ObjBO.CVV));
                cmd.Parameters.AddWithValue("@ExpireDate", ObjBO.ExpireDate);
                con.Open();
                int Result = cmd.ExecuteNonQuery();
                if (Result > 0)
                {
                    Ok = true;
                }
                else
                {
                    Ok = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                cmd.Dispose();
                cmd = null;
                con = null;
            }
            return Ok;
        }
        public DataTable BindGrid()
        {
            adpt = new SqlDataAdapter();
            cmd = new SqlCommand();
            try
            {
                con = new SqlConnection();
                con.ConnectionString = connectionString;
                cmd.Connection = con;
                if (con.State.Equals(ConnectionState.Closed))
                {
                    con.Open();
                }
                string query = "spGetAllData";
                cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                adpt = new SqlDataAdapter(cmd);
                dt = new DataTable();
                adpt.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Columns["CreditCardNumber"].ToString() == "CreditCardNumber")
                    {
                        AesManaged aes = new AesManaged();
                        string creditCN = dt.Rows[i]["CreditCardNumber"].ToString();
                        string cvv = dt.Rows[i]["CCV"].ToString();
                        string decryptedCCN =AESEncryption.Decrypt(creditCN);
                        string decryptedCCV =AESEncryption.Decrypt(cvv);
                        dt.Rows[i]["CreditCardNumber"] = decryptedCCN;
                        dt.Rows[i]["CCV"] = decryptedCCV;
                    }
                }
                con.Close();
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
            }
        }
    }
}
