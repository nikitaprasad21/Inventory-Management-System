# Inventory Management System for LuxEmporium - A High-End Lifestyle Retailer

### Introduction: 

As a stakeholder at LuxEmporium, a prestigious lifestyle retailer known for its exclusive range of products, we are facing challenges in managing 
our diverse inventory efficiently. The need for an advanced Inventory Management System has become imperative to maintain the high standards of our brand and provide an exceptional shopping experience to our customers.

-- Products in the Inventory:

LuxEmporium deals with a wide range of luxury products, including fashion apparel, accessories, electronic gadgets, and home decor items. Each
product belongs to a specific category, such as "Fashion," "Electronics," or "Home Decor." Additionally, certain products may be part of 
limited-edition collections, warranting special attention and handling.

### Features and Requirements:

1. Inheritance:

Implement a class hierarchy that captures the essence of luxury retail. For example, create base classes like LuxuryProduct and ProductCategory 
and derive specific product and category classes from them.
Utilize inheritance to encapsulate common attributes and behaviors among luxury products and categories.

2. Encapsulation:

Ensure strict encapsulation of sensitive information related to luxury products, such as pricing strategies, supplier details, and limited-edition
status.
Utilize private attributes to protect critical data, allowing controlled access through well-defined methods.

3. Polymorphism:

Implement polymorphism to handle variations in luxury product behaviors. For instance, a method like calculate_discount() could exhibit 
polymorphic behavior, providing different discount calculations based on the luxury product type.
Allow for polymorphic behavior when updating stock levels, considering that limited-edition items may have unique restocking procedures.

4. Additional Concepts:

Abstraction: Abstract common functionalities into base classes, creating a streamlined and elegant interface for interaction.
Composition: Explore the composition of luxury categories within products, highlighting the synergy of different elements within our 
product range.

### Tools Used: 
Python 

### Work Process:
* ProductCategory Class:

Attributes: _category_name, _sub_category_name, _product_name
Encapsulation using property decorators and setters to control access to attributes.
Instances are added to the category_details list.

* LuxuryProduct Class (Inherits from ProductCategory):

Additional attributes: __price, quantity, __limited_edition, pay_rate
Constructor validates input and calls the superclass constructor.
Method calculate_discount applies a discount to the product price.
Method __repr__ provides a string representation of the object.

* Class method instantiate_from_csv reads data from a CSV file, creates instances, and adds them to the product_details list.
Usage:

The script instantiates LuxuryProduct objects from a CSV file using the instantiate_from_csv class method.
It then prints details of each product, applies a discount, and prints the updated details.
Access to attributes is demonstrated, including the use of name-mangling for the private attribute __limited_edition.

### Conclusion: 
In summary, the code addresses The ProductCategory and LuxuryProduct classes exemplify clean object-oriented design, incorporating encapsulation, inheritance, polymorphism and validation checks. The optimized script efficiently reads and processes data from a CSV file, demonstrating the flexibility of the classes. The result is a concise and well-structured implementation that adheres to Python best practices.
