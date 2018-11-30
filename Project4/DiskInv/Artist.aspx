<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Artist.aspx.cs" Inherits="Artist" %>
<%--
*************************
*CHANGE DATE        USER            DETAILS
*--------------------------------------------
*   11/9/2018      BRIAN JENKS     First instantiation
*   11/16/2018     BRIAN JENKS     Added access, and insert/update/delete functions
*************************
--%>
<asp:Content runat="server" ContentPlaceHolderID="mainContent">
    <section>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ArtistID" DataSourceID="SqlDataSource3"
            OnRowDeleted="GridView1_RowDeleted"
             OnRowUpdated="GridView1_RowUpdated" CssClass="table table-bordered table-condensed">
            <Columns>
                <asp:BoundField DataField="ArtistID" HeaderText="ArtistID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID" />
                <asp:BoundField DataField="GroupName" HeaderText="GroupName" SortExpression="GroupName" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="ArtistTypeID" HeaderText="ArtistTypeID" SortExpression="ArtistTypeID" ReadOnly="True" />
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <%-- Needed this third data source because it kept wigging out on me --%>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" DeleteCommand="sp_DeleteArtist" DeleteCommandType="StoredProcedure" SelectCommand="SELECT * FROM Artist" UpdateCommand="sp_UpdateArtistName" UpdateCommandType="StoredProcedure">
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
        <div id="key">
            <h3>Key</h3>
            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ArtistTypeID">
                <Columns>
                    <asp:BoundField DataField="ArtistTypeID" HeaderText="ArtistTypeID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistTypeID" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                </Columns>
            </asp:GridView>
        </div>
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
    <section>
        <%-- Allow for inserting items --%>
        <br />
        <asp:DetailsView ID="dvInsertArtist" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Insert" AutoGenerateRows="False" CssClass="table table-bordered table-condensed" DataKeyNames="ArtistID">
            <Fields>
                <asp:BoundField DataField="ArtistID" HeaderText="ArtistID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID" />
                <asp:TemplateField HeaderText="ArtistTypeID" SortExpression="ArtistTypeID">
                    
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlArtistType" runat="server" DataSourceID="SqlDataSource2" DataTextField="Description" DataValueField="ArtistTypeID"
                             SelectedValue='<%# Bind("ArtistTypeID") %>'></asp:DropDownList>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="GroupName" SortExpression="GroupName">

                    <InsertItemTemplate>
                        <asp:TextBox ID="txtGroupName" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" Text="Only enter a group name if band is selected."></asp:Label>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">

                    <InsertItemTemplate>
                        <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" Text="Otherwise, enter a First and Last name."></asp:Label>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastName" SortExpression="LastName">

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
        
        
        <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
    </section>
</asp:Content>