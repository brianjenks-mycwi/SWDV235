<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Borrower.aspx.cs" Inherits="Borrower" %>
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
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="BorrowerID" DataSourceID="SqlDataSource1" AllowSorting="True" CssClass="table table-bordered table-condensed">
            <Columns>
                <asp:BoundField DataField="BorrowerID" HeaderText="BorrowerID" InsertVisible="False" ReadOnly="True" SortExpression="BorrowerID" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <%-- Phone number cannot be changed due to the sp disallowing it --%>
                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" ReadOnly="True" />
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
            <PagerSettings Position="Top" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" DeleteCommand="sp_DeleteBorrower" DeleteCommandType="StoredProcedure" InsertCommand="sp_InsertBorrower" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [Borrower]" UpdateCommand="sp_UpdateBorrowerName" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="BorrowerID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="PhoneNumber" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="BorrowerID" Type="Int32" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </section>
    <section>
        <asp:DetailsView ID="dvBorrower" runat="server" AutoGenerateRows="False"
            DataSourceID="SqlDataSource1" DefaultMode="Insert" CssClass="table table-bordered table-condensed"
             OnItemInserted="dvBorrower_ItemInserted">
            <Fields>
                <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                    
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="First Name is a required field" Text="*"
                            ControlToValidate="TextBox1" CssClass="text-danger" ValidationGroup="InsertBorrower"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                    
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="Last Name is a required field" Text="*"
                            ControlToValidate="TextBox2" CssClass="text-danger" ValidationGroup="InsertBorrower"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PhoneNumber" SortExpression="PhoneNumber">
                    
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PhoneNumber") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ErrorMessage="Phone Number is a required field" Text="*"
                            ControlToValidate="TextBox3" CssClass="text-danger" ValidationGroup="InsertBorrower"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ErrorMessage="Phone number must be in this format: 5555555555"
                            Text="*" ControlToValidate="TextBox3" ValidationExpression="\d{10}" ValidationGroup="InsertBorrower" CssClass="text-danger"></asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowInsertButton="True" ValidationGroup="InsertBorrower" />
            </Fields>
            <HeaderTemplate>
                To create a new borrower, enter the information and click Insert
            </HeaderTemplate>
        </asp:DetailsView>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="InsertBorrower"
             CssClass="text-danger" HeaderText="Please correct the following issues: "/>
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
    </section>
</asp:Content>