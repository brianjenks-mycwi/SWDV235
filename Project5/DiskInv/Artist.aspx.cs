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
*   12/4/2018      BRIAN JENKS     Created code to disable text boxes on insert
*   12/5/2018      BRIAN JENKS     Added code to disable text boxes on edit,
*                                  Added error messages to insert/edit/delete functions
*************************
*/

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

    private string DeleteErrorMessage()
    {
        return "There was an issue with deleting the item. Please check other tables for references.";
    }

    private void clearGVError()
    {
        lblErrorGV.Text = "";
    }

    /* START OF Ensure that database errors are handled. */
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
            lblErrorGV.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
        }
            else if (e.AffectedRows == 0)
        {
            lblErrorGV.Text = DeleteErrorMessage();
        }
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblErrorGV.Text = DatabaseErrorMessage(e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else if (e.AffectedRows == 0)
        {
            lblErrorGV.Text = ConcurrencyErrorMessage();
        }
    }
    /* END OF Ensure that database errors are handled. */

    /* Make our form disable certain text boxes on insert*/
    protected void ddlArtistType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlArtistType1 = (DropDownList)dvInsertArtist.FindControl("ddlArtistType");
        WebControl txtGN = dvInsertArtist.FindControl("txtGroupName") as WebControl;
        WebControl txtFN = dvInsertArtist.FindControl("txtFirstName") as WebControl;
        WebControl txtLN = dvInsertArtist.FindControl("txtLastName") as WebControl;
        //If our selected value is a band
        if (ddlArtistType1.SelectedValue == "2")
        {//Enable our group name, but disable everything else
            txtGN.Enabled = true;
            txtFN.Enabled = false;
            txtLN.Enabled = false;
        }
        else
        {//Otherwise, disable group name, enable everything else
            txtGN.Enabled = false;
            txtFN.Enabled = true;
            txtLN.Enabled = true;
        }
    }


    /* Disable text boxes inside the edit gridview that should not be filled */
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //The try is necessary, it binds both when first instantiated, and when opening an edit
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                Label lblTypeID = e.Row.FindControl("lblArtistTypeID") as Label;
                TextBox txtGN = e.Row.FindControl("txtEditGN") as TextBox;
                TextBox txtFN = e.Row.FindControl("txtEditFN") as TextBox;
                TextBox txtLN = e.Row.FindControl("txtEditLN") as TextBox;
                //If our artist type is a band...
                if (lblTypeID.Text == "2")
                {//Only have group name enabled
                    txtGN.Enabled = true;
                    txtFN.Enabled = false;
                    txtLN.Enabled = false;
                }
                else
                {//Otherwise, only have group name disabled
                    txtGN.Enabled = false;
                    txtFN.Enabled = true;
                    txtLN.Enabled = true;
                }
            }
        }
        catch { } //No error catching is necessary, as it should only succeed when editing a row
    }

    protected void GridView1_Changed(object sender, EventArgs e)
    {
        clearGVError();
    }
}
