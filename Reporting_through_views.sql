Use farm1
CREATE VIEW DenormalizedAnimalsView AS
SELECT
    AnimalID,
    AnimalName,
    BirthDate,
    Gravid,
    FoodGroupName,
    TagName,
    ItemName,
    ItemQuantity,
    PricePerUnit,
    TotalMilkSold,
    TotalEarning,
    TotalDailyExpense,
    Profit
FROM DenormalizedAnimals;

SELECT * FROM DenormalizedAnimalsView


CREATE VIEW AnimalDetailsReport AS
SELECT AnimalID, AnimalName, BirthDate, Gravid, FoodGroupName, TagName
FROM DenormalizedAnimals;


CREATE VIEW FinancialSummaryReport AS
SELECT AnimalID, AnimalName, TotalEarning, TotalDailyExpense, Profit
FROM DenormalizedAnimals;


CREATE VIEW InventoryStatusReport AS
SELECT AnimalID, AnimalName, ItemName, ItemQuantity, PricePerUnit
FROM DenormalizedAnimals;


CREATE VIEW MilkProductionReport AS
SELECT AnimalID, AnimalName, TotalMilkSold
FROM DenormalizedAnimals;



CREATE VIEW AnimalStatisticsReportSS AS
SELECT AnimalID, AnimalName, BirthDate, Gravid
FROM DenormalizedAnimals;


CREATE VIEW TagGroupingReport AS
SELECT TagName, COUNT(AnimalID) AS TotalAnimals
FROM DenormalizedAnimals
GROUP BY TagName;


CREATE VIEW FoodGroupDetailsReport AS
SELECT FoodGroupName, COUNT(AnimalID) AS TotalAnimals
FROM DenormalizedAnimals
GROUP BY FoodGroupName;

CREATE VIEW AnimalStatistics AS
SELECT
    COUNT(AnimalID) AS TotalAnimals,
    AVG(ItemQuantity) AS AvgItemQuantity,
    SUM(TotalMilkSold) AS TotalMilkSold,
    SUM(TotalEarning) AS TotalEarning,
    SUM(TotalDailyExpense) AS TotalDailyExpense,
    SUM(Profit) AS TotalProfit
FROM DenormalizedAnimals;
CREATE VIEW AnimalAnalytics AS
SELECT 
    AnimalID, 
    AnimalName, 
    BirthDate, 
    Gravid, 
    FoodGroupName, 
    TagName, 
    ItemName, 
    ItemQuantity, 
    PricePerUnit, 
    TotalMilkSold, 
    TotalEarning, 
    TotalDailyExpense, 
    Profit
FROM DenormalizedAnimals;


------------------------------
SELECT * FROM AnimalAnalytics
SELECT * FROM AnimalStatistics