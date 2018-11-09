<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Borrower.aspx.cs" Inherits="Borrower" %>

<asp:Content runat="server" ContentPlaceHolderID="mainContent">
    <section>
        <%-- All fields are required to make a borrower in the DB --%>
        <p>First name: 
            <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFName" runat="server" ErrorMessage="First name is required" ControlToValidate="txtFName" CssClass="val"></asp:RequiredFieldValidator>
        </p>
        <p>Last name: 
            <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLName" runat="server" ErrorMessage="Last name is required" ControlToValidate="txtLName" CssClass="val"></asp:RequiredFieldValidator>
        </p>
        <p>Phone number: 
            <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Phone number is required" CssClass="val" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPhone" runat="server" ErrorMessage="Phone should be formatted as 888-888-8888" ControlToValidate="txtPhone" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}" CssClass="val"></asp:RegularExpressionValidator>
        </p>
        <p>
            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" />
            <asp:Button ID="Clear" runat="server" Text="Clear" CausesValidation="False" OnClick="Clear_Click" />
        </p>

        <%-- This label will be deleted later. It is only for testing purposes --%>
        <p>
            <asp:Label ID="lblTest" runat="server" Text=""></asp:Label>
        </p>

    </section>
</asp:Content>