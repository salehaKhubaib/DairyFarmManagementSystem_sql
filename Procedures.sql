Use farm1
CREATE PROCEDURE GenerateAnimalDetailReport
AS
BEGIN
    -- Temporary table to store animal details
    CREATE TABLE #AnimalDetailReport (
        AnimalID INT,
        AnimalName VARCHAR(255),
        BirthDate DATE,
        TotalExpenses DECIMAL(10, 2),
        TotalSales DECIMAL(10, 2),
        TotalProfit DECIMAL(10, 2),
        TotalMilkSold DECIMAL(10, 2)
    );

    -- Insert animal details into the temporary table
    INSERT INTO #AnimalDetailReport (AnimalID, AnimalName, BirthDate)
    SELECT AnimalID, Name AS AnimalName, BirthDate
    FROM Animals;

    -- Calculate total expenses for each animal
    UPDATE #AnimalDetailReport
    SET TotalExpenses = ISNULL((
        SELECT SUM(ISNULL(Cost, 0))
        FROM Expenses
        WHERE Expenses.AnimalID = #AnimalDetailReport.AnimalID
    ), 0);

    -- Calculate total sales for each animal
    UPDATE #AnimalDetailReport
    SET TotalSales = ISNULL((
        SELECT SUM(ISNULL(Earning, 0))
        FROM Sales
        WHERE Sales.AnimalID = #AnimalDetailReport.AnimalID
    ), 0);

    -- Calculate total profit for each animal
    UPDATE #AnimalDetailReport
    SET TotalProfit = ISNULL(TotalSales, 0) - ISNULL(TotalExpenses, 0);

    -- Calculate total milk sold for each animal
    UPDATE #AnimalDetailReport
    SET TotalMilkSold = ISNULL((
        SELECT SUM(ISNULL(MilkSoldInLiters, 0))
        FROM Sales
        WHERE Sales.AnimalID = #AnimalDetailReport.AnimalID
    ), 0);

    -- Display the detailed report for each animal
    SELECT *
    FROM #AnimalDetailReport;

    -- Drop the temporary table
    DROP TABLE #AnimalDetailReport;
END;
exec GenerateAnimalDetailReport
DROP PROCEDURE GenerateAnimalDetailReport



CREATE PROCEDURE GenerateExpenseDetails
AS
BEGIN
    INSERT INTO Expenses (AnimalID, ExpenseType, Cost, DateRecorded)
    SELECT AnimalID, 'Auto-Generated Expense', ABS(CHECKSUM(NEWID()) % 100) + 1, GETDATE() -- Example expense generation logic
    FROM Animals;
END;
EXEC GenerateExpenseDetails
CREATE TRIGGER AutoGenerateExpenseDetailsOnReport
ON DailyReport
AFTER INSERT -- You might need to adjust the trigger event based on your schema/logic
AS
BEGIN
    EXEC GenerateExpenseDetails;
END;
