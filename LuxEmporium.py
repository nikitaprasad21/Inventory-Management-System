import csv


class ProductCategory:
    # Creating a list to track of every instance that has been created or made.

    category_details = []

    def __init__(
        self, category_name: str, sub_category_name: str, product_name: str
    ) -> None:
        self._category_name = category_name
        self._sub_category_name = sub_category_name
        self._product_name = product_name

        ProductCategory.category_details.append(self)

    # Property Decorator = Read-Only Attribute
    # Encapsulation 1
    @property
    def category_name_detail(self):
        return self._category_name

    @category_name_detail.setter
    def category_name_detail(self, value):
        if value >= 10:
            raise Exception("This Category Name is too long. Try Something Else.")

        else:
            self._category_name = value

    # Encapsulation 2
    @property
    def sub_category_name_detail(self):
        return self._sub_category_name

    @sub_category_name_detail.setter
    def sub_category_name_detail(self, value):
        if value >= 20:
            raise Exception("This Sub-Category Name is too long. Try Something Else.")

        else:
            self._sub_category_name = value

    # Encapsulation 3
    @property
    def product_name_detail(self):
        return self._product_name

    @product_name_detail.setter
    def product_detail(self, value):
        if value >= 20:
            raise Exception("This Product Name is too long. Try Something Else.")

        else:
            self._product_name = value


class LuxuryProduct(ProductCategory):
    # Defining the Standard payrate after discount (The pay rate after 20% discount)
    pay_rate = 0.8

    # Creating a list to track of every instance that has been created or made.
    product_details = []

    def __init__(
        self,
        category_name: str,
        sub_category_name: str,
        product_name: str,
        price: float,
        quantity: int = 0,
        limited_edition: bool = False,
    ) -> None:
        # Run validations to the received arguments and if not the required result than raise Assertion Error
        assert price >= 0, f"Price {price} should be greater than or equal to zero."
        assert (
            quantity >= 0
        ), f"Quantity {quantity} should be greater than or equal to zero."
        assert (
            limited_edition == 0 or limited_edition == 1
        ), f"Limited Edition {limited_edition} should be either 0 or 1."

        # Call to super function to have access to all attributes / methods
        super().__init__(category_name, sub_category_name, product_name)

        self.__price = price
        self.quantity = quantity
        self.__limited_edition = limited_edition

        LuxuryProduct.product_details.append(self)

    @property
    def product_price(self):
        return self.__price

    # Encapsulation 1
    def calculate_discount(self):
        self.__price = self.__price * self.pay_rate

    def __repr__(self):
        return (
            f"{self.__class__.__name__}("
            f"Category_Name='{self._category_name}', "
            f"Sub_Category_Name='{self._sub_category_name}', "
            f"Product_Name='{self._product_name}', "
            f"Price={self.__price}, "
            f"Quantity={self.quantity}, "
            f"Limited_Edition={self.__limited_edition})"
        )

    @classmethod
    def instantiate_from_csv(cls):
        # Create an empty list to store instances
        luxury_products_list = []

        with open(
            r"C:\Users\lenovo\OneDrive\Documents\Codes - VSCode\practice_codes\OOPs Codes\Retail\product_data.csv",
            "r",
            newline="",
        ) as f:
            reader = csv.DictReader(f)
            product_data = list(reader)

        for data in product_data:
            # Check for the presence of keys are present and has a non-None value before accessing them
            category_name = data.get(
                "Category_Name", ""
            )  # Provide a default value or handle the missing value scenario
            sub_category_name = data.get(
                "Sub_Category_Name", ""
            )  # Provide a default value or handle the missing value scenario
            product_name = data.get(
                "Product_Name", ""
            )  # Provide a default value or handle the missing value scenario
            price = float(
                data.get("Price", 0.0)
            )  # Provide a default value or handle the missing value scenario
            quantity = int(
                data.get("Quantity", 0)
            )  # Provide a default value or handle the missing value scenario
            limited_edition = bool(
                int(data.get("Limited_Edition", 0))
            )  # Provide a default value or handle the missing value scenario

            luxury_product = LuxuryProduct(
                category_name=category_name,
                sub_category_name=sub_category_name,
                product_name=product_name,
                price=price,
                quantity=quantity,
                limited_edition=limited_edition,
            )
            luxury_products_list.append(luxury_product)

        # Print the details of each luxury_product instance
        for luxury_product in luxury_products_list:
            print(luxury_product)

        # Optionally, assign the list to the class variable for later use
        cls.product_details = luxury_products_list


# Call the method to instantiate and get a list of instances from CSV
LuxuryProduct.instantiate_from_csv()

# Check if luxury_products is not None before iterating
if LuxuryProduct.product_details:
    for luxury_product in LuxuryProduct.product_details:
        print("Category:", luxury_product.category_name_detail)
        print("Sub-Category:", luxury_product.sub_category_name_detail)
        print("Product Name:", luxury_product.product_name_detail)
        print("Price:", luxury_product.product_price)
        luxury_product.calculate_discount()
        print("Discounted Price:", luxury_product.product_price)
        print("Quantity:", luxury_product.quantity)
        print("Limited Edition:", luxury_product._LuxuryProduct__limited_edition)

        """The use of _LuxuryProduct__limited_edition is accessing the name-mangled version of the attribute to ensure that it is 
        correctly referenced. This is necessary because the attribute was defined with double underscores (__limited_edition),
        and without name mangling, it might be accidentally overridden by a similarly named attribute in a subclass.

        """
        print("\n")
else:
    print("No luxury products found.")


# # Instantiate by creating an Object
# item1 = LuxuryProduct("Men", "TopWear", "Tee", 1000, 10, 0)
# print(item1._category_name)  # Protected Access Modifier
# print(item1._sub_category_name)  # Protected Access Modifier
# print(item1._product_name)  # Protected Access Modifier
# # print(item1.__price) # Price is a Private Access Modifiers
# # AttributeError: 'LuxuryProduct' object has no attribute '__price'
# print(item1.quantity)  # Public Access Modifier
# # print(item1.__limited_edition) # Limited Edition is a Private Access Modifiers
# # AttributeError: 'LuxuryProduct' object has no attribute '__limited_edition'
