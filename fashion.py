from product_script import LuxuryProduct


class Fashion(LuxuryProduct):
    # Polymorphism
    pay_rate = 0.7

    def __init__(
        self,
        category_name: str,
        sub_category_name: str,
        product_name: str,
        price: float,
        quantity: int = 0,
        limited_edition: bool = False,
    ) -> None:
        # Call to super function to have access to all attributes / methods
        super().__init__(
            category_name,
            sub_category_name,
            product_name,
            price,
            quantity,
            limited_edition,
        )

    def __str__(self):
        # Override __str__ to customize the string representation
        return f"{self.__class__.__name__}(Category_Name='{self._category_name}', Sub_Category_Name='{self._sub_category_name}', Product_Name='{self._product_name}', Price={self._price}, Quantity={self._quantity}, Limited_Edition={self._limited_edition})"


# Instantiate by creating an Object
item1 = Fashion("Men", "TopWear", "Tee", 1000, 10, 0)
print(item1._product_name)
print(item1.calculate_discount())
print(item1._category_name)
