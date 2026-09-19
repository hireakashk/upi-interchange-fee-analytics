 # UPI Interchange Fee & PPI Wallet Impact Analytics Engine

📊 **An End-to-End Data Analytics Project simulating and evaluating the financial impact of the new 1.1% UPI Interchange Charge policy on PPI Wallets using Python, Advanced SQL, and Microsoft Excel.**

---

## 🚀 Project Overview
With recent digital payment regulations introduced by the National Payments Corporation of India (NPCI), payment platforms levy a **1.1% interchange fee on merchants** for peer-to-merchant (P2M) transactions exceeding **₹2,000 processed via PPI (Prepaid Payment Instruments) Wallets**. 

This repository showcases a complete data infrastructure simulation and business intelligence engine built to track revenue generation, identify transactional failure bottlenecks, and evaluate the financial burden shifting across various industries (Travel, Retail, Food, and Electronics).

---

## 🛠️ Tech Stack & Architecture
*   **Data Engineering & Simulation:** Python (Pandas, NumPy, Random Distributions)
*   **Database Management & Analytics:** Advanced SQL (MySQL Server / PostgreSQL)
*   **Business Intelligence & Visualization:** Advanced Microsoft Excel (Dynamic Interactive Dashboards, Slicers, Pivot Architectures)

---

## 💡 Key Business Insights Discovered
1.  **Revenue Concentration:** High-ticket merchant segments such as **Travel & Hospitality** and **Electronics & Gadgets** generate over 65% of the platform's interchange revenue due to transaction ticket sizes frequently exceeding the ₹2,000 policy threshold.
2.  **Payment Mode Penetration:** While direct Bank-to-Bank UPI handles the highest daily volume frequency, PPI Wallets act as a major revenue optimization driver under the new transactional slab configurations.
3.  **Operational Performance Risk:** Detected an overall system success benchmark of **92.0%**, highlighting a specific volume leakage in failed/pending settlements that requires system infrastructure alignment to safeguard merchant retention.

---

## 📂 Repository File Structure
*   `upi_simulation_engine.py`: Python script engineered to simulate a randomized, probabilistic dataset of 5,000+ transaction data points following realistic market trends.
*   `upi_analytics_queries.sql`: SQL database optimization script containing schema setups and 5 strategic business analytical queries (utilizing Window Functions, CTEs, and conditional routing).
*   `upi_trending_data.csv`: The simulated primary operational dataset containing transactional records, payment indicators, timestamps, and computed fee models.
*   `README.md`: System portfolio documentation.

---

## 💻 Database Queries Implemented
The SQL analytics engine processes complex transactional inquiries including:
*   **Query 1:** Industry Sector Revenue Contribution Metrics
*   **Query 2:** Market Share Penetration of Payment Modes (Bank vs Wallet vs Credit Card)
*   **Query 3:** Operational Efficiency and Transaction Failure Impact Model
*   **Query 4:** High-Value Merchant Tracking using Analytical Window Functions (`DENSE_RANK()`)
*   **Query 5:** High-Ticket Wallet Premium Purchase Profiling (> ₹10,000)

---

## 🎨 Interactive Business Dashboard
*A high-fidelity dashboard built using Advanced Excel incorporates responsive KPI metrics cards, connected global cross-filters (Slicers), and visual trends mapping.*

### **KPI Cards Positioned:**
*   **Total Transaction Volume (INR):** Aggregate transaction flow processed.
*   **Total Interchange Revenue (INR):** Direct platform earnings generated from the 1.1% fee structure.
*   **Overall Success Rate (%):** System infrastructure reliability ratio.
*   **Average Ticket Size (INR):** Expected single consumer transaction average value.

---

## 🧑‍💻 About the Author
**Akash Kumar**  
📍 Data Analyst | Lucknow, Uttar Pradesh, India  
📧 [hire.akashk@gmail.com](mailto:hire.akashk@gmail.com)  
💼 [LinkedIn Profile](https://linkedin.com)  
💻 [GitHub Portfolio](https://github.com)

