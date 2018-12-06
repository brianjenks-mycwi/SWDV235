<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Artist.aspx.cs" Inherits="Artist" %>
<%--
*************************
*CHANGE DATE        USER            DETAILS
*--------------------------------------------
*   11/9/2018      BRIAN JENKS     First instantiation
*   11/16/2018     BRIAN JENKS     Added access, and insert/update/delete functions
*   12/4/2018      BRIAN JENKS     Disabled unused text boxes
*   12/5/2018      BRIAN JENKS     Made artist type readable, made table sortable
*   12/6/2018      BRIAN JENKS     Changed Artist type to eval instead of bind its data on an update
*************************
--%>
<asp:Content runat="server" ContentPlaceHolderID="mainContent">
    <section>
        <%-- Allow for inserting items --%>
        <asp:DetailsView ID="dvInsertArtist" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Insert"
            AutoGenerateRows="False" CssClass="table table-bordered table-condensed" DataKeyNames="ArtistID" HeaderText="Insert an artist here"
            >
            <Fields>
                <asp:BoundField DataField="ArtistID" HeaderText="Artist ID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID" />
                <asp:TemplateField HeaderText="Artist Type ID" SortExpression="ArtistTypeID">
                    
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlArtistType" runat="server" DataSourceID="SqlDataSource2" DataTextField="Description" DataValueField="ArtistTypeID"
                             SelectedValue='<%# Bind("ArtistTypeID") %>' OnSelectedIndexChanged="ddlArtistType_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                    </InsertItemTemplate>

                    <ItemTemplate>
                        <asp:DropDownList ID="ddlArtistType" runat="server" DataSourceID="SqlDataSource2" DataTextField="Description" DataValueField="ArtistTypeID" OnSelectedIndexChanged="ddlArtistType_SelectedIndexChanged" SelectedValue='<%# Bind("ArtistTypeID") %>'>
                        </asp:DropDownList>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Group Name" SortExpression="GroupName">

                    <InsertItemTemplate>
                        <asp:TextBox ID="txtGroupName" runat="server" Text='<%# Bind("GroupName") %>' Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" Text="Only enter a group name if band is selected."></asp:Label>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">

                    <InsertItemTemplate>
                        <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" Text="Otherwise, enter a First and Last name."></asp:Label>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">

                    <InsertItemTemplate>
                        <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
        <br />
        
        
        
        <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
    </section>
    <section>
        <%-- Error label for our grid view --%>
        <asp:Label ID="lblErrorGV" runat="server" CssClass="text-danger"></asp:Label>
        <%-- The grid view for seeing our artist data --%>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ArtistID" DataSourceID="SqlDataSource3"
            OnRowDeleted="GridView1_RowDeleted" OnRowDataBound="GridView1_RowDataBound"
             OnPageIndexChanged="GridView1_Changed" OnRowEditing="GridView1_Changed" OnRowDeleting="GridView1_Changed"
             OnRowUpdated="GridView1_RowUpdated" CssClass="table table-bordered table-condensed" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="ArtistID" HeaderText="Artist ID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID" Visible="False" />
                <asp:TemplateField HeaderText="Group Name" SortExpression="GroupName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditGN" runat="server" Text='<%# Bind("GroupName") %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditFN" runat="server" Text='<%# Bind("FirstName") %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditLN" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Artist Type" SortExpression="ArtistTypeID">
                    <EditItemTemplate>
                        
                        <asp:Label ID="lblArtistType" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblArtistType" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Artist Type ID" SortExpression="ArtistTypeID" Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="lblArtistTypeID" runat="server" Text='<%# Eval("ArtistTypeID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblArtistTypeID" runat="server" Text='<%# Bind("ArtistTypeID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
            <PagerSettings Position="Top" />
        </asp:GridView>
        
        <%-- Needed this third data source because it kept wigging out on me --%>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" DeleteCommand="sp_DeleteArtist" DeleteCommandType="StoredProcedure" SelectCommand="SELECT Artist.ArtistID, Artist.GroupName, Artist.FirstName, Artist.LastName, Artist.ArtistTypeID, ArtistType.Description FROM Artist INNER JOIN ArtistType ON Artist.ArtistTypeID = ArtistType.ArtistTypeID" UpdateCommand="sp_UpdateArtistName" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ArtistID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="ArtistID" Type="Int32" />
                <asp:Parameter Name="GroupName" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <%-- This is to show what the typeID values mean --%>
        
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" DeleteCommand="sp_DeleteArtist" DeleteCommandType="StoredProcedure" InsertCommand="sp_InsertArtist" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [Artist]" UpdateCommand="sp_UpdateArtistName" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ArtistID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ArtistTypeID" Type="Int32" />
                <asp:Parameter Name="GroupName" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ArtistID" Type="Int32" />
                <asp:Parameter Name="GroupName" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT [ArtistTypeID], [Description] FROM [ArtistType] ORDER BY [Description]"></asp:SqlDataSource>
    </section>
</asp:Content>