<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">
    protected void submitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (email.Text == confirmEmail.Text)
            {
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
                comm = new SqlCommand("EXEC addNewsSignup @emailTextBox", conn);
                comm.Parameters.Add("@emailTextBox", System.Data.SqlDbType.NVarChar, 200);
                comm.Parameters["@emailTextBox"].Value = email.Text;

                // Enclose database code in Try-Catch-Finally
                try
                {
                    // Open the connection
                    conn.Open();
                    // Execute the command
                    comm.ExecuteNonQuery();
                    // Reload page if the query executed successfully
                    Response.Redirect("applied.html");
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
            }
            else
            { //If we don't have matching emails...
                dbErrorMessage.Text = "Both emails must be the same!";
            }
        }//End if isValid
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">


<head runat="server">
    <title>Math- Newsletter</title>
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
    <script src="js/newsVal.js"></script>
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
                        <li class="active"><a href="newsletter.aspx">Newsletter</a></li>
                        <li><a href="contact.aspx">Contact</a></li>
                        <li><a href="classes.html">Classes</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

    <main>
        <div id="main-container" class="background-fade">
            <h1>Allow us to send you information and updates!</h1>
            <p>If you sign up for our newsletter, we'll send you an email when the site gets an update, or for when classes are available!</p>

            <form id="contact" class="newsletter" runat="server">
                <p><label for="email">Email:</label> 
                <asp:TextBox ID="email" runat="server" /><%-- This is our textbox for information being sent to the server  --%>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email required" ForeColor="Red" ControlToValidate="email"></asp:RequiredFieldValidator>
                </p>

                <p><label for="confirmEmail">Confirm Email:</label>
                <asp:TextBox ID="confirmEmail" runat="server" />
                <asp:RequiredFieldValidator ID="rfvConfirmEmail" runat="server" ErrorMessage="Confirm Email Required" ControlToValidate="confirmEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                </p>
                
                <asp:Button ID="submitButton" runat="server"
                     Text="Submit" onclick="submitButton_Click" />
                <br />
                <asp:Label ID="dbErrorMessage" runat="server" ForeColor="Red"></asp:Label>

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