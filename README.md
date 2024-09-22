# Inventory Management System for Posh Palette - Lifestyle Retailer

## Project Background

Posh Palette, a leading lifestyle retailer, offers a wide range of fashion products and accessories. As the company expands, managing inventory efficiently has become a challenge. The goal of this project was to implement a reliable inventory management system that reduces holding costs, prevents stockouts, and maximizes revenue without losing customers. The project used SQL to analyze inventory and sales data, helping the company make informed decisions to improve profitability and streamline operations.


## Dataset Structure and Data Scheme
The dataset used for this analysis consists of five key tables: Products, Orders, Suppliers, Procurement, and Historical Pricing. These tables are connected through primary and foreign key relationships to enable a comprehensive analysis of inventory management, procurement, sales, revenue, and supplier performance.

![image](https://github.com/user-attachments/assets/d0bb7161-e268-4a39-8a01-d5ec76a58757)

The detailed data schema can be found [here](https://github.com/nikitaprasad21/Inventory-Management-System/blob/main/data/data-schema.txt).


## Executive Summary
This project aimed to improve Posh Palette's inventory management system by analyzing product performance, pricing analysis, order-fullfillment efficiency, sales performance and revenue trends, and supplier relationships and performance. Using SQL, the analysis helped identify never-ordered products, determine optimal stock levels, sales and revenue, calculate running total sales, and forecast future sales. Key recommendations were made to implement dynamic inventory replenishment strategies and improve relationships with key suppliers to ensure timely deliveries and competitive pricing.

Key findings revealed that certain products were overstocked, while others were prone to stockouts, impacting customer satisfaction. Additionally, a large portion of revenue came from a few high-margin products (such as Kurtas from Category Indian Wear, Top and Skirt from Category Western Wear, Sling Bags aand Clutch from Handbags Category and Earrings, Anklets and Rings From Jewellery Category) indicating a need for focused marketing efforts.

## Codes
* Targed SQL queries regarding various business questions can be found [here](https://github.com/nikitaprasad21/Inventory-Management-System/blob/main/sql-analysis/Inventory-Management-Analysis.sql).

## Tools Used: 
**SQL** for querying and manipulating the inventory and sales data.

## Work Process:
 The key tasks included tracking inventory levels, analyzing sales trends, identifying slow-moving items, calculating reorder points, and generating forecasts based on historical data.

* **Inventory Analysis**: Determined the total number of items in stock for each product by subtracting shipped quantities from starting inventory.
* **Supplier Relationships**: Identified products along with their respective supplier names by joining Products with Procurement and Suppliers tables.
* **Sales Analysis**: Calculated running total sales, identified top-selling products, and ranked products based on sales volume.
* **Profitability Analysis**: Calculated profit margins and impact on overall profitability for products.
* **Forecasting**: Generated sales forecasts for the next quarter based on historical sales trends.

## Insights
#### Category 1. Inventory Management:

   * Products with excess inventory were identified, leading to higher holding costs.
   * Products prone to stockouts were highlighted, which may have resulted in lost sales opportunities.
#### Category 2. Sales Trends:

   * The top-selling products were identified, which contributed significantly to the overall revenue.
   * Running total sales helped track product performance over time, revealing seasonal sales trends.
#### Category 3. Profitability:

   * High-margin products drove a large portion of profits, while slow-moving items contributed less to the bottom line.
   * Profit margins for each product were analyzed to optimize pricing strategies.
#### Category 4. Supplier Relations:

   * Key suppliers were identified, and relationships with them were analyzed to ensure competitive pricing and timely delivery.

## Recommendations
Based on the key observations, the following recommendations can be made to address the problem statement:


#### Category 1. Dynamic Inventory Replenishment:

   * Implement a dynamic strategy that ensures products with higher demand are restocked promptly to avoid stockouts.
   * Reduce holding costs by clearing excess inventory through targeted promotions or discounts on overstocked products.


#### Category 2. Sales Strategy:

   * Focus on promoting high-margin products that contribute the most to profitability.
   * Adjust pricing strategies for slow-moving products to increase their turnover and reduce inventory costs.

#### Category 3. Supplier Relations:

   * Strengthen relationships with key suppliers to ensure timely delivery and better pricing. Negotiate contracts that allow for flexible restocking based on real-time demand.
## Assumptions and Caveats
#### Assumptions:

   * The historical data accurately reflects customer demand patterns and supplier delivery timelines.
   * All product prices and inventory levels in the dataset are up to date and accurately recorded.
#### Caveats:

   * Future trends may deviate from historical data, especially during unexpected events (e.g., economic downturns, market shifts or any deadly disease eg. Covid-19).
   * Supplier performance may vary over time, impacting inventory levels and product availability.

## Conclusion
In conclusion, this project provided valuable insights into Posh Palette’s inventory management, pricing history and sales performance using **SQL analysis**. By implementing dynamic inventory strategies, promoting high-margin products, and optimizing supplier relationships, the company can reduce costs and increase profitability. By leveraging these insights, businesses can make informed decisions to optimize  operations and prevent potential stockouts, ultimately improving customer satisfaction and driving business growth.
