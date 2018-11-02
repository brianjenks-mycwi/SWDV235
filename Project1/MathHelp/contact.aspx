<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">
    protected void submitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (ddlReason.SelectedValue == "1")
            {//If they haven't selected a reason, let them know
                dbErrorMessage.Text = "Please select a reason for contact!";
            }
            else
            {//Otherwise, submit the data
                // Code that uses the data entered by the user
                // Define data objects
                SqlConnection conn;
                SqlCommand comm;
                // Read the connection string from Web.config
                string connectionString =
                    ConfigurationManager.ConnectionStrings[
                    "Math"].ConnectionString;
                // Initialize connection
                conn = new SqlConnection(connectionString);
                // Create command 
                comm = new SqlCommand("EXEC addContact @fName, @lName, @email, @phone, @reason, @msg", conn);
                comm.Parameters.Add("@fName", System.Data.SqlDbType.NVarChar, 50);
                comm.Parameters["@fName"].Value = fName.Text;
                comm.Parameters.Add("@lName", System.Data.SqlDbType.NVarChar, 50);
                comm.Parameters["@lName"].Value = lName.Text;
                comm.Parameters.Add("@email", System.Data.SqlDbType.NVarChar, 200);
                comm.Parameters["@email"].Value = email.Text;
                comm.Parameters.Add("@phone", System.Data.SqlDbType.Char, 10);
                comm.Parameters["@phone"].Value = phone.Text;
                comm.Parameters.Add("@reason", System.Data.SqlDbType.Int); //We need to make sure the value is an int
                comm.Parameters["@reason"].Value = Convert.ToInt32(ddlReason.SelectedValue);
                comm.Parameters.Add("@msg", System.Data.SqlDbType.NVarChar, 500);
                comm.Parameters["@msg"].Value = info.Text;

                // Enclose database code in Try-Catch-Finally
                try
                {
                    // Open the connection
                    conn.Open();
                    // Execute the command
                    comm.ExecuteNonQuery();
                    // Reload page if the query executed successfully
                    Response.Redirect("thanks.html");
                }
                catch (SqlException ex)
                {
                    // Display error message
                    dbErrorMessage.Text =
                       "Error submitting the data!" + ex.Message.ToString();

                }
                finally
                {
                    // Close the connection
                    conn.Close();
                }
            }//End else
        }//end IsValid
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">


<head runat="server">
    <title>Math- Contact</title>
    <meta charset="utf-8"/>
    <!-- Minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Personalized styles -->
    <link rel="stylesheet" href="css/reset.css"/>
    <link rel="stylesheet" href="css/styles.css"/>

    <!-- Personalized JavaScript -->
    <script src="js/contactVal.js"></script>
    <!-- See footer for one more reference -->

</head>

<body class="index">
    <header></header>

    <div class="container">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <ul class="nav navbar-nav">
                        <li>
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </li>
                        <li><a class="navbar-brand" href="index.html"><img class="brand" src="images/calculator.png" alt="calculator brand"/></a></li>
                    </ul>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="calculator.html">Calculator</a></li>
                        <li><a href="faq.html">FAQ</a></li>
                        <li><a href="newsletter.aspx">Newsletter</a></li>
                        <li class="active"><a href="contact.aspx">Contact</a></li>
                        <li><a href="classes.html">Classes</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

    <main>
        <div id="main-container">
            <h1>Contact us!</h1>
            <p>Enter your information below. All information is required.</p>
            <form id="contact" class="contact" runat="server">
                <%-- Here's the table's start --%>
                <label for="fName">First Name:</label>
                <asp:TextBox ID="fName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvFName" runat="server"
                    ErrorMessage="First name is a required field" ControlToValidate="fName"
                    ForeColor="Red"></asp:RequiredFieldValidator>

                <label for="lName">Last Name:</label>
                <asp:TextBox ID="lName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvLName" runat="server"
                    ErrorMessage="Last Name is a required field." ControlToValidate="lName"
                    ForeColor="Red"></asp:RequiredFieldValidator>

                <label for="email">Email:</label>
                <asp:TextBox ID="email" runat="server" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ErrorMessage="Email is a required field" ControlToValidate="email"
                    ForeColor="Red"></asp:RequiredFieldValidator>

                <label for="phone">Phone: (10 digit, no dash or parentheses)</label>
                <asp:TextBox ID="phone" runat="server" />
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                    ErrorMessage="Phone number is a required field." ControlToValidate="phone"
                    ForeColor="Red"></asp:RequiredFieldValidator>

                <label for="contact-reason">Reason for contact:</label>
                <asp:DropDownList ID="ddlReason" runat="server">
                    <asp:ListItem Value="1">Select a Value</asp:ListItem>
                    <asp:ListItem Value="2">Recommendation</asp:ListItem>
                    <asp:ListItem Value="3">Criticism</asp:ListItem>
                    <asp:ListItem Value="4">Questions</asp:ListItem>
                    <asp:ListItem Value="5">Other</asp:ListItem>
                </asp:DropDownList>

                <label for="info">Let us know the reason below!</label>
                <asp:TextBox ID="info" runat="server" />
                <asp:RequiredFieldValidator ID="rfvInfo" runat="server"
                    ErrorMessage="Give us your comments!" ControlToValidate="info"></asp:RequiredFieldValidator>
                <br />

                <asp:Button ID="submitButton" runat="server"
                        Text="Submit" onclick="submitButton_Click" />
                <br />
                <asp:Label ID="dbErrorMessage" runat="server"></asp:Label>
            </form>

            <p id="thanks"></p>
        </div>
    </main>

    <footer>
        <script src="js/date.js"></script>
        <noscript><p>Current year: 2018</p></noscript>
        <p>Created by: Brian Jenks</p>
    </footer>

</body>
</html>