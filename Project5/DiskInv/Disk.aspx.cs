using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/*
 *************************
*CHANGE DATE        USER            DETAILS
*--------------------------------------------
*   11/9/2018      BRIAN JENKS     First instantiation
*   11/16/2018     BRIAN JENKS     Added access, and insert/update/delete functions
*   12/5/2018      BRIAN JENKS     Added error messages to insert/edit/delete functions
*************************
*/

public partial class Disk : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /**************** Start error messages ********************/
    private string DatabaseErrorMessage(string errorMsg)
    {
        return $"<b>A database error has occurred:</b> {errorMsg}";
    }

    private string DeleteErrorMessage()
    {
        return "There was an issue with deleting the item. Please check other tables for references.";
    }

    private void clearGVError()
    {
        lblErrorGV.Text = "";
    }

    protected void dvInsertInventory_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
        }
        else
            dvInsertInventory.DataBind();
    }

    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblErrorGV.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
        }
        else if (e.AffectedRows == 0)
        {
            lblErrorGV.Text = DeleteErrorMessage();
        }
    }

    protected void GridView1_Changed(object sender, EventArgs e)
    {
        clearGVError();
    }

    /**************** End error messages ********************/
}