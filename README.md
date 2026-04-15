📊 Analyzing E-Learning Platform Purchases using MySQL and Power BI
* In this project, I combined SQL and Power BI to transform raw data into meaningful insights 

🔍 Key Objectives:
* Built and managed the database using SQL (MySQL)
* Performed data cleaning and analysis using join, aggregations, and queries.
* Identified key metrics like revenue, top courses, and learner behavior
* Developed an interactive Power BI dashboard to visualize insights
* Analyzed trends such as monthly revenue, category performance, and customer engagement

🗂 Database Structure

👤 Learners Table
*  Stores learner details
*  Columns: learner_id, full_name, country
  
📚 Courses Table
*   Stores course information
*   Columns: course_id, course_name, category, unit_price
  
🛒 Purchases Table
*   Stores transaction data
*   Columns: purchase_id, learner_id, course_id, quantity, purchase_date
*   Uses foreign keys to connect learners and courses

📈 SQL Analysis Performed
*  Used INNER JOIN to combine learner, course, and purchase data
*  Calculated total revenue using SUM() and Formatted and organized results using ORDER BY
*  Calculated total spending per learner 
*  Identified most active learner
*  Found learners purchasing from multiple categories
*  Identified top 3 most purchased courses
*  Found highest & lowest revenue generating courses
*  Detected courses with no purchases
*  Calculated total revenue by category and counted unique learners per cat.
*  Analyzed monthly revenue trends 
* Used MONTH() function for time grouping

📈 Power BI Visualization Analysis
*  Created interactive dashboard with key KPIs (Revenue, Learners, Courses)
*  Visualized monthly revenue trends and category performance
*   Identified top courses and top learners
*   Used slicers for dynamic filtering and better insights

📈 Key Insights
*  IT category contributes the highest revenue (~30%) 
*   Data Analytics is the second-highest revenue category 
*   Marketing category generates the lowest revenue share 
*   Revenue shows a steady increase with a peak towards the end of the year 
*   September–October period records the highest revenue spike 
*   Top learners contribute significantly higher revenue than others 
*   Course enrollments are unevenly distributed across categories 
*   With only 87 courses sold generating 282K revenue, the platform shows high revenue
*   The dashboard shows strong performance in technical domains (IT & Analytics)
