using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Borrowers are instantiated in our database. The data should be formatted the
/// same as inside our database.
/// </summary>
public class CreateBorrower
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string PhoneNumber { get; set; }

    public CreateBorrower()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}