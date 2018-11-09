using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Borrower : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (IsValid)
        { //Store the stuff in the session state on submit
            CreateBorrower newBor = new CreateBorrower();

            newBor.FirstName = txtFName.Text;
            newBor.LastName = txtLName.Text;
            newBor.PhoneNumber = txtPhone.Text;

            Session["Borrower"] = newBor;

            //Display session to ensure it stored
            CreateBorrower check = (CreateBorrower)Session["Borrower"];
            lblTest.Text = "First Name: " + check.FirstName +
                "<br />Last Name: " + check.LastName +
                "<br />Phone: " + check.PhoneNumber;
     
        }
    }

    protected void Clear_Click(object sender, EventArgs e)
    {
        txtFName.Text = "";
        txtLName.Text = "";
        txtPhone.Text = "";
        lblTest.Text = "";
    }
}