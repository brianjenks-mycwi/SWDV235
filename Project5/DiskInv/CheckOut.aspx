<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="CheckOut.aspx.cs" Inherits="CheckOut" %>
<%--
*************************
*  CHANGE DATE      USER            DETAILS
*--------------------------------------------
*   11/29/2018      BRIAN JENKS     First instantiation
*   12/5/2018       BRIAN JENKS     Removed non-user data from view,
                                    Added names to borrower, and item
*************************
--%>
<asp:Content runat="server" ContentPlaceHolderID="mainContent">
    
    <section>
        <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-bordered table-condensed" AutoGenerateRows="False" DataKeyNames="InvoiceID"
            DataSourceID="SqlDSInsertDiskBorrowed" DefaultMode="Insert" HeaderText="To check out an item fill out the information below" OnItemInserted="DetailsView1_ItemInserted">
            <Fields>

                <asp:TemplateField HeaderText="Borrower" SortExpression="BorrowerID">

                    <InsertItemTemplate>
                        <%-- All borrowers will show up here --%>
                        <asp:DropDownList ID="ddlBorrower" runat="server" DataSourceID="SqlDSBorrowerID"
                            DataTextField="Name" DataValueField="BorrowerID" SelectedValue='<%# Bind("BorrowerID") %>'></asp:DropDownList>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item" SortExpression="ItemID">

                    <InsertItemTemplate>
                        <%-- Only items that have not been checked out will show up here --%>
                        <asp:DropDownList ID="ddlItem" runat="server" DataSourceID="SqlDSItemID"
                            DataTextField="ItemName" DataValueField="ItemID" SelectedValue='<%# Bind("ItemID") %>'></asp:DropDownList>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Borrowed Date" SortExpression="BorrowedDate">
                    <%-- The date they start borrowing must be today or before today --%>
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtBorrowDate" runat="server" Text='<%# Bind("BorrowedDate") %>' TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvBorrowDate" runat="server" ControlToValidate="txtBorrowDate" Text="*" ErrorMessage="Please add a date." CssClass="text-danger"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvBorrowedDate" runat="server" ErrorMessage="Borrow Date must be before today." ControlToValidate="txtBorrowDate" Type="Date" ValueToCompare='<%# DateTime.Today.ToString("d") %>' Operator="LessThanEqual" CssClass="text-danger">*</asp:CompareValidator>
                    </InsertItemTemplate>

                </asp:TemplateField>
                <%-- The expected return date will be automatically set to 3 weeks ahead --%>
                <asp:TemplateField ShowHeader="False">
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="Insert" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
        <asp:ValidationSummary ID="vsInsertBorrowedDisk" runat="server" CssClass="text-danger" HeaderText="Please correct these issues:" />
        <asp:SqlDataSource ID="SqlDSInsertDiskBorrowed" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" InsertCommand="sp_CheckOut" SelectCommand="SELECT BorrowerID, ItemID, BorrowedDate FROM BorrowedTimes" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="BorrowedDate" />
                <asp:Parameter Name="BorrowerID" />
                <asp:Parameter Name="ItemID" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSBorrowerID" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT [BorrowerID], [FirstName] +' ' + [LastName] AS Name FROM [Borrower] ORDER BY [FirstName], [LastName]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSItemID" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT [ItemID], [ItemName] FROM [Inventory] WHERE ([StatusCode] = @StatusCode) ORDER BY [ItemName]">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="StatusCode" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </section>
    <section>
        <h1>Checked out items</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="InvoiceID" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-condensed" AllowSorting="True" AllowPaging="True">
            <Columns>
                <%-- <asp:BoundField DataField="InvoiceID" HeaderText="InvoiceID" InsertVisible="False" ReadOnly="True" SortExpression="InvoiceID" />--%>
                <asp:BoundField DataField="BorrowerID" HeaderText="Borrower ID" SortExpression="BorrowerID" Visible="False" />
                <asp:TemplateField HeaderText="Borrower Name" SortExpression="FirstName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                        &nbsp;
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ItemID" HeaderText="Item ID" SortExpression="ItemID" Visible="False" />
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" SortExpression="ItemName" />
                <asp:BoundField DataField="BorrowedDate" HeaderText="Borrowed Date" SortExpression="BorrowedDate" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" SortExpression="ReturnDate" />
                <asp:BoundField DataField="ExpectedReturnDate" HeaderText="Expected Return Date" SortExpression="ExpectedReturnDate" />
            </Columns>
            <PagerSettings Position="Top" />
        </asp:GridView>
        <%-- Error label for our grid view --%>
        <asp:Label ID="lblErrorGV" runat="server" CssClass="text-danger"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT BorrowedTimes.InvoiceID, BorrowedTimes.BorrowerID, Borrower.FirstName, Borrower.LastName, BorrowedTimes.ItemID, Inventory.ItemName, BorrowedTimes.BorrowedDate, BorrowedTimes.ReturnDate, BorrowedTimes.ExpectedReturnDate FROM BorrowedTimes INNER JOIN Inventory ON BorrowedTimes.ItemID = Inventory.ItemID INNER JOIN Borrower ON BorrowedTimes.BorrowerID = Borrower.BorrowerID WHERE (BorrowedTimes.ReturnDate IS NULL)"></asp:SqlDataSource>
    </section>
</asp:Content>