using BAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserRegistrationApp.Forms
{
    public partial class ShowData : System.Web.UI.Page
    {
        UserRegistrationBAL balOBj = new UserRegistrationBAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RefreshData();
            }
        }
        public void RefreshData()
        {
            GridView1.DataSource = balOBj.GetData();
            GridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Redirect("UserRegistration.aspx");
        }
    }
}