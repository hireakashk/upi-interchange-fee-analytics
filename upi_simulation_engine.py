  # ==============================================================================
# PROJECT: UPI Interchange Fee Impact Simulation Engine
# AUTHOR: Akash Kumar
# TECH STACK: Python (Data Engineering), SQL, Advanced Excel
# DESCRIPTION: Simulates 5,000+ transactional data points to evaluate the financial 
#              impact of the new 1.1% UPI Interchange Fee policy on PPI Wallets.
# ==============================================================================

import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# 1. Configuration & Parameters Setup
NUM_ROWS = 5000
START_DATE = datetime(2026, 8, 1)

# Industry-standard market distributions for realistic data distribution
MERCHANT_CATEGORIES = ['Travel & Hospitality', 'Electronics & Gadgets', 'Groceries & Supermarkets', 'Food & Dining']
CATEGORY_WEIGHTS = [0.15, 0.25, 0.40, 0.20] # High transaction frequency in Groceries/Food

PAYMENT_MODES = ['Bank UPI (Direct)', 'PPI Wallet UPI', 'Credit Card on UPI']
MODE_WEIGHTS = [0.60, 0.25, 0.15] # Direct Bank UPI remains dominant in India

TRANSACTION_STATUSES = ['Success', 'Failed', 'Pending']
STATUS_WEIGHTS = [0.88, 0.08, 0.04] # Standard 88% digital payment success rate

print("[INFO] Initializing UPI Transaction Simulation Engine...")

# 2. Generative Data Simulation Loop
simulated_data = {
    'Transaction_ID': [f'TXN2026{100000 + i}' for i in range(NUM_ROWS)],
    'User_ID': [f'USR{random.randint(1000, 5000)}' for i in range(NUM_ROWS)],
    'Merchant_ID': [f'MER{random.randint(10, 50)}' for i in range(NUM_ROWS)],
    'Merchant_Category': [random.choices(MERCHANT_CATEGORIES, weights=CATEGORY_WEIGHTS)[0] for i in range(NUM_ROWS)],
    'Payment_Mode': [random.choices(PAYMENT_MODES, weights=MODE_WEIGHTS)[0] for i in range(NUM_ROWS)],
    'Transaction_Amount': [round(random.uniform(10.0, 15000.0), 2) for i in range(NUM_ROWS)],
    'Transaction_Status': [random.choices(TRANSACTION_STATUSES, weights=STATUS_WEIGHTS)[0] for i in range(NUM_ROWS)],
    'Timestamp': [(START_DATE + timedelta(days=random.randint(0, 45), hours=random.randint(0, 23), minutes=random.randint(0, 59))).strftime('%Y-%m-%d %H:%M:%S') for i in range(NUM_ROWS)]
}

# Convert raw dictionary to a structured Pandas DataFrame
df = pd.DataFrame(simulated_data)
print(f"[SUCCESS] Core dataset generated with {NUM_ROWS} transactional entries.")

# 3. Policy Rule Engine Implementation
# POLICY RULE: 1.1% Interchange Fee applies strictly to 'Success' transactions, 
#              processed via 'PPI Wallet UPI', where the amount exceeds INR 2000.
def apply_interchange_policy(row):
    if (row['Transaction_Status'] == 'Success' and 
        row['Payment_Mode'] == 'PPI Wallet UPI' and 
        row['Transaction_Amount'] > 2000.0):
        return round(row['Transaction_Amount'] * 0.011, 2)
    return 0.0

# Apply the functional policy logic to create the targeted vector
df['Interchange_Fee_INR'] = df.apply(apply_interchange_policy, axis=1)
print("[INFO] Policy rule engine applied. Interchange fees calculated successfully.")

# 4. Data Export & Diagnostics
OUTPUT_FILE = 'upi_trending_data.csv'
df.to_csv(OUTPUT_FILE, index=False)

print(f"\n========================================================")
print(f"📊 DATA SIMULATION DIAGNOSTIC SUMMARY")
print(f"========================================================")
print(f"✔ Target Filename: {OUTPUT_FILE}")
print(f"✔ Total Simulated Transactions: {len(df)}")
print(f"✔ Total Interchange Revenue Calculated: INR {df['Interchange_Fee_INR'].sum():,.2f}")
print(f"========================================================")


