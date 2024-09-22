from product_script import LuxuryProduct


class Homedecor(LuxuryProduct):
    # Polymorphism
    pay_rate = 0.9

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


# # Instantiate by creating an Object
item1 = Homedecor("HomeDecor", "Kitchen", "Dinnerware_Set", 300, 8, 0)
print(item1._product_name)
print(item1.calculate_discount())
print(item1._category_name)
