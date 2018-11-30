using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Artist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private string DatabaseErrorMessage(string errorMsg)
    {
        return $"<b>A database error has occurred:</b> {errorMsg}";
    }

    private string ConcurrencyErrorMessage()
    {
        return "Another user may have updated that category. Please try again";
    }

    protected void dvInsertArtist_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {

        if (e.Exception != null)
        {
            lblError.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
        }
        else
            dvInsertArtist.DataBind();
        
    }


    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if(e.Exception != null)
            {
            lblError.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
        }
            else if (e.AffectedRows == 0)
        {
            lblError.Text = ConcurrencyErrorMessage();
        }
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else if (e.AffectedRows == 0)
        {
            lblError.Text = ConcurrencyErrorMessage();
        }
    }
}