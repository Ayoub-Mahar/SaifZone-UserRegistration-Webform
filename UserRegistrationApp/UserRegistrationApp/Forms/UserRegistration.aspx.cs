using BAL;
using DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserRegistrationApp.Forms
{
    public partial class UserRegistration : System.Web.UI.Page
    {
        UserRegistrationBAL balOBj = new UserRegistrationBAL();
        UserRegistrationModel modelObj = new UserRegistrationModel();
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(enableSession: true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string InsertData(string firstName, string LastName,string Email,string PhoneNumber,string CreditCardNumber,string CVV,string ExpireDate)
        {
            string res = "";
            try
            {
                UserRegistrationBAL balOBj = new UserRegistrationBAL();
                UserRegistrationModel modelObj = new UserRegistrationModel();
                modelObj.FirstName = firstName.ToString();
                modelObj.LastName = LastName.ToString();
                modelObj.Email = Email.ToString();
                modelObj.PhoneNumber = PhoneNumber.ToString();
                modelObj.CreditCardNumber = CreditCardNumber;
                modelObj.CVV = CVV;
                modelObj.ExpireDate = ExpireDate.ToString();
                bool result = balOBj.RegistraionBLL(modelObj);
                if (result)
                {
                    res  = "Success";
                }
                else
                {
                    res = "Fail";
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
            return res;
        }
    }
}