USE MediaLibrary
GO

/*
DROP PROC sp_CheckOut
GO
*/

CREATE PROC sp_CheckOut
	@BorrowedDate DATE,
	@BorrowerID INT,
	@ItemID INT
AS
BEGIN TRY
BEGIN TRAN
	--Check whether we have our necessary information
	IF (@BorrowedDate IS NOT NULL AND @BorrowerID IS NOT NULL AND @ItemID IS NOT NULL)
	BEGIN
		DECLARE @ReturnDate DATE
		--Make the ReturnDate 3 weeks later
		SET @ReturnDate = DATEADD(week, 3, @BorrowedDate)
		--Validate these two exist in their tables
		IF EXISTS(SELECT * FROM Borrower WHERE BorrowerID = @BorrowerID)
			IF EXISTS(SELECT * FROM Inventory WHERE ItemID = @ItemID)
			BEGIN
				--If the items exist, we're good to check it out
				INSERT BorrowedTimes
					(BorrowedDate, ExpectedReturnDate, BorrowerID, ItemID)
				VALUES (@BorrowedDate, @ReturnDate, @BorrowerID, @ItemID)
				--Modify the inventory item to say that it's checked out
				UPDATE Inventory 
					SET StatusCode = 2
				WHERE ItemID = @ItemID
			END
			ELSE
				THROW 50020, 'Item ID must exist', 1;
		ELSE
			THROW 50021, 'Borrower ID must exist', 1;
	END
	ELSE
		THROW 50022, 'Insert data not found', 1;
COMMIT TRAN
END TRY

BEGIN CATCH
	ROLLBACK TRAN;
	PRINT 'An error occurred.'
	PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
END CATCH
GO

GRANT EXEC ON sp_Checkout TO MediaManager
GO