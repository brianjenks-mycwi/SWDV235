<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Disk.aspx.cs" Inherits="Disk" %>
<%--
*************************
*CHANGE DATE        USER            DETAILS
*--------------------------------------------
*   11/9/2018      BRIAN JENKS     First instantiation
*   11/16/2018     BRIAN JENKS     Removed original insert, added view/insert/update/delete
*************************
--%>
<asp:Content runat="server" ContentPlaceHolderID="mainContent">
    <section>

        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="SqlDataSource1" AllowSorting="True" CssClass="table table-bordered table-condensed">
            <Columns>
                <asp:BoundField DataField="ItemID" HeaderText="ItemID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
                <asp:TemplateField HeaderText="ReleaseDate" SortExpression="ReleaseDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReleaseDate") %>' TextMode="Date"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("ReleaseDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TypeID" SortExpression="TypeID">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDSMediaType" DataTextField="Description" DataValueField="TypeID" SelectedValue='<%# Bind("TypeID") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TypeID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GenreID" SortExpression="GenreID">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDSMediaGenre" DataTextField="Description" DataValueField="GenreID" SelectedValue='<%# Bind("GenreID") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("GenreID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="StatusCode" SortExpression="StatusCode">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server"
                            DataSourceID="SqlDSMediaStatus" DataTextField="Description" DataValueField="StatusCode" SelectedValue='<%# Bind("StatusCode") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("StatusCode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
            <PagerSettings Position="Top" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>"
            DeleteCommand="sp_DeleteInventory" DeleteCommandType="StoredProcedure" InsertCommand="sp_InsertInventory" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [Inventory]" UpdateCommand="sp_UpdateInventory" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ItemID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ItemName" Type="String" />
                <asp:Parameter DbType="Date" Name="ReleaseDate" />
                <asp:Parameter Name="TypeID" Type="Int32" />
                <asp:Parameter Name="GenreID" Type="Int32" />
                <asp:Parameter Name="StatusCode" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ItemID" Type="Int32" />
                <asp:Parameter Name="ItemName" Type="String" />
                <asp:Parameter DbType="Date" Name="ReleaseDate" />
                <asp:Parameter Name="TypeID" Type="Int32" />
                <asp:Parameter Name="GenreID" Type="Int32" />
                <asp:Parameter Name="StatusCode" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSMediaType" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT * FROM [MediaType] ORDER BY [Description]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSMediaGenre" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT * FROM [MediaGenre] ORDER BY [Description]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSMediaStatus" runat="server" ConnectionString="<%$ ConnectionStrings:MediaLibraryConnection %>" SelectCommand="SELECT * FROM [MediaStatus] ORDER BY [Description]"></asp:SqlDataSource>

    </section>
    <section>
        <%-- Add ability to insert to the table --%>
        <asp:DetailsView ID="dvInsertInventory" runat="server" AutoGenerateRows="False"
            CssClass="table table-bordered table-condensed" DataSourceID="SqlDataSource1" DefaultMode="Insert"
            OnItemInserted="dvInsertInventory_ItemInserted">
            <Fields>
                <asp:TemplateField HeaderText="ItemName" SortExpression="ItemName">
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemName" runat="server"
                            ErrorMessage="Item name is a required field" Text="*" ControlToValidate="TextBox2" CssClass="text-danger" ValidationGroup="InsertDisk"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ReleaseDate" SortExpression="ReleaseDate">
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReleaseDate") %>' TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvReleaseDate" runat="server" ErrorMessage="Release Date is a required field" Text="*"
                            CssClass="text-danger" ControlToValidate="TextBox1" ValidationGroup="InsertDisk"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TypeID" SortExpression="TypeID">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDSMediaType" DataTextField="Description" DataValueField="TypeID" SelectedValue='<%# Bind("TypeID") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GenreID" SortExpression="GenreID">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDSMediaGenre" DataTextField="Description" DataValueField="GenreID" SelectedValue='<%# Bind("GenreID") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="StatusCode" SortExpression="StatusCode">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="SqlDSMediaStatus" DataTextField="Description" DataValueField="StatusCode" SelectedValue='<%# Bind("StatusCode") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowInsertButton="True" ValidationGroup="InsertDisk" />
            </Fields>
        </asp:DetailsView>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="InsertDisk"
             CssClass="text-danger" HeaderText="Please correct the following issues: " />
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
    </section>
</asp:Content>