using DAL;
using DTOs;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace BAL
{
    public class UserRegistrationBAL
    {

        #region Registration
        public bool RegistraionBLL(UserRegistrationModel objRegisBO) // passing Bussiness object Here  
        {
            try
            {
                UserRegistrationDAL registrationDALObj = new UserRegistrationDAL(); // Creating object of Dataccess  
                return registrationDALObj.Registration(objRegisBO); // calling Method of DataAccess  
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Get Data
        public DataTable GetData() // passing Bussiness object Here  
        {
            try
            {
                UserRegistrationDAL registrationDALObj = new UserRegistrationDAL(); // Creating object of Dataccess  
                return registrationDALObj.BindGrid(); // calling Method of DataAccess  
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}
