-- =======================================================================================================================================================================
-- PROJECT: UPI INTERCHANGE FEE & PPI WALLET IMPACT ANALYTICS
-- AUTHOR: AKASH KUMAR
-- TECH STACK: Python (Data Simulation), SQL (Data Analysis), Advanced Excel
-- DESCRIPTION: Structured SQL scripts to analyze the financial impact of the 
--              new 1.1% UPI interchange fee on PPI wallets across 5,000+ rows.
-- ====================================================================================================================================================================

-- STEP 1: DATABASE AND SCHEMA CREATION
CREATE DATABASE upi_payment_db;
USE upi_payment_db;

CREATE TABLE upi_transactions (
    Transaction_ID VARCHAR(50) PRIMARY KEY,
    User_ID VARCHAR(50),
    Merchant_ID VARCHAR(50),
    Merchant_Category VARCHAR(100),
    Payment_Mode VARCHAR(100),
    Transaction_Amount DECIMAL(10, 2),
    Transaction_Status VARCHAR(50),
    Timestamp DATETIME,
    Interchange_Fee_INR DECIMAL(10, 2)
);

-- Note: Import the 'upi_trending_data.csv' via the SQL Import Wizard before running queries below.

-- ====================================================================================================================================================================
-- BUSINESS CRITICAL CORE ANALYTICAL QUERIES
-- ====================================================================================================================================================================

-- QUERY 1: REVENUE LEAKAGE BY MERCHANT CATEGORY (TOP 5)
-- Evaluates which business industry incurs the highest platform cost under the new rule.
SELECT 
    Merchant_Category,
    COUNT(Transaction_ID) AS Total_Successful_Txns,
    SUM(Transaction_Amount) AS Total_Transaction_Volume_INR,
    SUM(Interchange_Fee_INR) AS Total_Interchange_Revenue_INR
FROM upi_transactions
WHERE Transaction_Status = 'Success'
GROUP BY Merchant_Category
ORDER BY Total_Interchange_Revenue_INR DESC
LIMIT 5;

-- QUERY 2: PAYMENT MODE SHARE & VOLUME DISTRIBUTION
-- Tracks customer preference trends between Direct Bank UPI, PPI Wallets, and Credit Cards.
SELECT 
    Payment_Mode,
    COUNT(Transaction_ID) AS Total_Transactions,
    ROUND((COUNT(Transaction_ID) * 100.0 / (SELECT COUNT(*) FROM upi_transactions)), 2) AS Share_Percentage,
    SUM(Transaction_Amount) AS Total_Amount_INR
FROM upi_transactions
GROUP BY Payment_Mode
ORDER BY Total_Amount_INR DESC;

-- QUERY 3: OPERATIONAL EFFICIENCY & TRANSACTION STATUS ANALYSIS
-- Investigates the failure/success metrics and assesses potential revenue blocked in system drops.
SELECT 
    Transaction_Status,
    COUNT(Transaction_ID) AS Transaction_Count,
    ROUND((COUNT(Transaction_ID) * 100.0 / (SELECT COUNT(*) FROM upi_transactions)), 2) AS Percentage_Status,
    SUM(Transaction_Amount) AS Total_Affected_Volume_INR
FROM upi_transactions
GROUP BY Transaction_Status;


-- QUERY 4: HIGH-VALUE REVENUE DRIVING MERCHANTS (WINDOW FUNCTION)
-- Identifies and ranks the top 3 specific merchants in each business category generating maximum platform revenue.
WITH RankedMerchants AS (
    SELECT 
        Merchant_Category,
        Merchant_ID,
        SUM(Interchange_Fee_INR) AS Merchant_Revenue_INR,
        DENSE_RANK() OVER (PARTITION BY Merchant_Category ORDER BY SUM(Interchange_Fee_INR) DESC) AS Revenue_Rank
    FROM upi_transactions
    WHERE Transaction_Status = 'Success'
    GROUP BY Merchant_Category, Merchant_ID
)
SELECT * 
FROM RankedMerchants
WHERE Revenue_Rank <= 3;


-- QUERY 5: HIGH-VALUE WALLET TRANSACTION DETECTION (COMPLEX FILTERING)
-- Tracks the behavior of premium users utilizing wallets for high-ticket purchases (> INR 10,000) that trigger the highest slab fees.
SELECT 
    Transaction_ID,
    User_ID,
    Merchant_ID,
    Transaction_Amount,
    Interchange_Fee_INR
FROM upi_transactions
WHERE Payment_Mode = 'PPI Wallet UPI' 
  AND Transaction_Status = 'Success'
  AND Transaction_Amount > 10000.00
ORDER BY Transaction_Amount DESC;

