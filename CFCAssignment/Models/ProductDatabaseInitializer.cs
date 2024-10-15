using System.Collections.Generic;
using System.Data.Entity;

namespace CFCAssignment.Models
{
    public class ProductDatabaseInitializer : DropCreateDatabaseIfModelChanges<ProductContext>
    {
        protected override void Seed(ProductContext context)
        {
            GetCategories().ForEach(c => context.Categories.Add(c));
            GetProducts().ForEach(p => context.Products.Add(p));
        }

        private static List<Category> GetCategories()
        {
            var categories = new List<Category> {
                new Category
                {
                    CategoryID = 1,
                    CategoryName = "Box Meals"
                },
                new Category
                {
                    CategoryID = 2,
                    CategoryName = "Chicken"
                },
                new Category
                {
                    CategoryID = 3,
                    CategoryName = "Burger"
                },
                new Category
                {
                    CategoryID = 4,
                    CategoryName = "Add-On Slide"
                },
                new Category
                {
                    CategoryID = 5,
                    CategoryName = "Kids Meal"
                },
            };

            return categories;
        }

        private static List<Product> GetProducts()
        {
            var products = new List<Product> {
                new Product
                {
                    ProductID = 1,
                    ProductName = "Zinger Spicy BBQ Box Set",
                    Description = "1 Hot and Spicy Chicken" + " ,1 Zinger Spicy BBQ" + " ,1 Whipped Potato (4oz)"+" ,1 Cheezy Wedges (M)"+" ,1 Coca-Cola (M)",
                    ImagePath="1zingerBBQBox.png",
                    UnitPrice = 19.99,
                    CategoryID = 1
               },
                new Product
                {
                    ProductID = 2,
                    ProductName = "Dinner Plate Combo",
                    Description = "3 Hot and Spicy Chicken, 1 Whipped Potato (4oz), 1 Coleslaw (4oz), 1 Butterscotch Bun, 1 Coca-Cola (M)",
                    ImagePath="2dinnerplate.png",
                    UnitPrice = 22.99,
                     CategoryID = 2
               },
                new Product
                {
                    ProductID = 3,
                    ProductName = "Zinger Classic Combo",
                    Description = "1 Zinger Classic, 1 Fries (M), 1 Coca-Cola (M)",
                    ImagePath="3zingerclassic.png",
                    UnitPrice = 14.99,
                    CategoryID = 3
                },
                new Product
                {
                    ProductID = 4,
                    ProductName = "Cheezy Wedges (L)",
                    Description = "Potato with cheese sause!",
                    ImagePath="4cheezywedges.png",
                    UnitPrice = 7.99,
                    CategoryID = 4
                },
                new Product
                {
                    ProductID = 5,
                    ProductName = "Kids Meal Combo A",
                    Description = "1 Original Recipe Chicken, 1 Whipped Potato (4oz), 1 Heaven & Earth Ice Lemon Tea (S)",
                    ImagePath="5seta.png",
                    UnitPrice = 9.99,
                    CategoryID = 5
                }
            };

            return products;
        }
    }
}