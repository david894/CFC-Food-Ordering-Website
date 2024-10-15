<%@ Page Title="CFC Malaysia" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="CFCAssignment.home"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');
        
        .carousel-container {
            position: relative;
            max-width: 100%;
            margin: 0 auto;
            overflow: hidden;
        }
        .carousel-slide {
            display: none;
            width: 100%;
        }
        .carousel-slide img {
            width: 100%;
            height: auto;
        }
        .active-slide {
            display: block;
        }
        .carousel-control {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: #333;
            font-weight: bold;
            font-size: 18px;
            border-radius: 0 3px 3px 0;
            user-select: none;
            z-index: 1;
        }
        .carousel-control.right {
            right: 0;
            border-radius: 3px 0 0 3px;
        }
        .Cat-container, .about-us {
            background-color: #ffffff;
            padding: 40px 0;
            margin: 40px auto;
            max-width: 1200px;
        }
        .Cat {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .Cat {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            padding: 20px;
        }

        .Cat .category {
            display: flex;
            align-items: center;
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .Cat .category:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.2);
        }
        .Cat img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            margin-right: 20px;
            transition: transform 0.2s;
        }
        .Cat .category:hover img {
            transform: scale(1.1);
        }
        .category-title {
            font-size: 1.5em;
            margin: 0;
            color: #333;
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
        }
        .category-price {
            font-size: 1.2em;
            color: #28a745;
            margin-top: 5px;
            font-family: 'Roboto', sans-serif;
        }
        .order-now {
            display: flex;
            align-items: center;
            margin-top: 10px;
            color: #007bff;
            cursor: pointer;
            transition: color 0.2s;
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
        }
        .order-now img {
            width: 24px;
            height: 24px;
            margin-right: 5px;
        }
        .order-now:hover {
            color: #0056b3;
        }
        .categories-title {
            text-align: center;
            font-size: 2.5em;
            margin-top: 20px;
            margin-bottom: 20px;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            background-color: #ffffff;
            padding: 20px 0;
        }
        .about-us {
            text-align: center;
            padding: 40px 20px;
            background-color: #f1f1f1;
        }
        .about-us-title {
            margin-left:45%;
            margin-bottom:10%;
        }
        .about-us-text {
            font-size: 1.2em;
            color: #555;
            font-family: 'Roboto', sans-serif;
        }
        .home {
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            padding:2%;
        }
        .aboutimg {
            float:left;
            width:40%;
            height:26%;
        }
        #leftbtn,#rightbtn{
            background-color:rgba(0, 0, 0, 0.2);
        } 
        #leftbtn:hover,#rightbtn:hover{
            background-color:rgba(0, 0, 0, 0.6);
            color:#FFFFFF;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="home">
        <div class="carousel-container">
        <div class="carousel-slide active-slide">
            <a href="menu.aspx"><img src="Image/Advertisement/appexclusive4refresh-guest-d-1x.png"/></a>
        </div>
        <div class="carousel-slide">
            <a href="menu.aspx"><img src="Image/Advertisement/bucketsemua-guest-d-1x.png"/></a>
        </div>
        <div class="carousel-slide">
            <a href="menu.aspx"><img src="Image/Advertisement/meetthezingers-guest-d-1x.png"/></a>
        </div>
        <div class="carousel-slide">
            <a href="menu.aspx"><img src="Image/Advertisement/ondetart-guest-d-1x_1.png"/></a>
        </div>

        <!-- Left and right controls -->
        <span class="carousel-control left" onclick="moveSlides(-1)" id="leftbtn">&#10094;</span>
        <span class="carousel-control right" onclick="moveSlides(1)" id="rightbtn">&#10095;</span>
    </div>

    <div class="Cat-container">
        <div class="categories-title">Our Categories</div>
        <div class="Cat">
            <div class="category">
                <img src="Image/1zingerBBQBox.png" alt="Box Meal" />
                <div>
                    <div class="category-title">Box Meal</div>
                    <div class="category-price">20% Off</div>
                    <div class="order-now">
                        <img src="Image/cart-icon.png" alt="Cart Icon" />
                        <a href="menu.aspx?id=1"><span>Order Now</span></a>
                    </div>
                </div>
            </div>
            <div class="category">
                <img src="Image/2dinnerplate.png" alt="Chicken" />
                <div>
                    <div class="category-title">Chicken</div>
                    <div class="category-price">20% Off</div>
                    <div class="order-now">
                        <img src="Image/cart-icon.png" alt="Cart Icon" />
                        <a href="menu.aspx?id=2"><span>Order Now</span></a>
                    </div>
                </div>
            </div>
            <div class="category">
                <img src="Image/3zingerclassic.png" alt="Burger" />
                <div>
                    <div class="category-title">Burger</div>
                    <div class="category-price">20% Off</div>
                    <div class="order-now">
                        <img src="Image/cart-icon.png" alt="Cart Icon" />
                        <a href="menu.aspx?id=3"><span>Order Now</span></a>
                    </div>
                </div>
            </div>
            <div class="category">
                <img src="Image/4cheezywedges.png" alt="Add-On" />
                <div>
                    <div class="category-title">Add-On</div>
                    <div class="category-price">20% Off</div>
                    <div class="order-now">
                        <img src="Image/cart-icon.png" alt="Cart Icon" />
                        <a href="menu.aspx?id=4"><span>Order Now</span></a>
                    </div>
                </div>
            </div>
            <div class="category">
                <img src="Image/5seta.png" alt="Kids Meal" />
                <div>
                    <div class="category-title">Kids Meal</div>
                    <div class="category-price">20% Off</div>
                    <div class="order-now">
                        <img src="Image/cart-icon.png" alt="Cart Icon" />
                        <a href="menu.aspx?id=5"><span>Order Now</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- About Us Banner -->
    <div class="about-us">
        <div class="about-us-text">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Image/Home/about.png"  CssClass="aboutimg"/>
            <div class="about-us-title">
                <h2>About Us</h2>
                <p>
                Welcome to CFC (Crispy Fried Chicken), where we bring the irresistible taste of crispy fried chicken and mouthwatering burgers to the heart of Kuala Lumpur, Malaysia. Inspired by global fast-food giants but deeply rooted in the flavors and culinary traditions of our homeland, CFC is not just another fried chicken joint—it's a celebration of good food, local pride, and a passion for perfection.
                </p>
            </div>
        </div>
        <div class="about-us-text">
            <asp:Image ID="Image2" runat="server" ImageUrl="~/Image/Home/story.png"  CssClass="aboutimg"/>
            <div class="about-us-title">
                <h2>Our Story</h2>
                <p>
                CFC was born out of a simple idea: to create a unique brand that offers Malaysians the ultimate fried chicken experience, right here in the bustling streets of Kuala Lumpur. Founded by a group of local food enthusiasts, CFC opened its doors with a mission to serve high-quality, delicious, and affordable meals that everyone can enjoy. We may have started with just one outlet, but our commitment to excellence and innovation sets us apart.            
                </p>
            </div>
        </div>
        <div class="about-us-text">
        <asp:Image ID="Image3" runat="server" ImageUrl="~/Image/Home/what.png"  CssClass="aboutimg"/>
        <div class="about-us-title">
            <h2>What We Offer</h2>
            <p>
                At CFC, we specialize in crispy, golden-brown fried chicken that's bursting with flavor in every bite. Our signature fried chicken is seasoned with a blend of spices, ensuring a perfect balance of taste and crunch. But that's not all—we also serve a variety of juicy burgers that are just as satisfying. Whether you're in the mood for a classic chicken burger, a spicy delight, or something with a local twist, we've got you covered.            </p>
    </div>
</div>
    </div>
</div>
    
</asp:Content>
