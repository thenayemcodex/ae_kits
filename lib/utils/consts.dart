import 'package:ae_kits/pages/home/model/product_model.dart';

class Consts {
  static final webApiKey = "AIzaSyCUKGOAfz0c2PmL6cmbNy9OLwaI8l6i_aU";
  static final projectId = "aims-smart-attend";

  static final permission_url =
      "https://raw.githubusercontent.com/thenayemcodex/Noob-Hacker71/refs/heads/main/authentication.json";

  static List<String> latestCollection = [
    "https://images.unsplash.com/photo-1577212017184-80cc0da11082?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vdGJhbGwlMjBqZXJzZXl8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1552066379-e7bfd22155c5?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vdGJhbGwlMjBqZXJzZXl8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1671016233693-53162078ca1c?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb3RiYWxsJTIwamVyc2V5fGVufDB8fDB8fHww",
    "https://plus.unsplash.com/premium_photo-1664297943340-e7fcb94726bb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Zm9vdGJhbGwlMjBqZXJzZXl8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1752673510841-275144e92ed3?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG1lc3NpJTIwamVyc2V5fGVufDB8fDB8fHww",
    "https://media.istockphoto.com/id/1425934456/photo/brazilian-sports-fans-watching-match-at-a-bar.webp?a=1&b=1&s=612x612&w=0&k=20&c=t01EJuy-EggLmawQfgdfznp6ojU_wkzAz54uhQhhndo=",
  ];

  static List<String> gameCategories = [
    "All",
    "Football",
    "Cricket",
    "Basketball",
    "Volleyball",
    "Baseball",
    "MMA",
    "Tennis",
    "Badminton",
    "Table Tennis",
    "Anime",
    "Electronics",
    "Smart Home Devices",
    "Apparel",
    "Footwear",
    "Accessories",
    "Fitness",
    "Sports & Outdoors",
    "Beauty & Personal Care",
    "Health & Wellness",
    "Home & Kitchen",
    "Pet Supplies",
  ];

  static List<ProductModel> dummyProducts = [
    ProductModel(
      id: 'prod_001',
      category: 'Electronics',
      productCode: 'ELE-WHP-09',
      productName: 'AeroSound Wireless Headphones',
      productImages: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=60',
        'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#000000', '#FFFFFF', '#34495E'],
      unitValue: 129.99,
      offerValue: 99.99,
      productDescription:
          'High-fidelity wireless headphones with active noise cancellation and 40-hour battery life.',
      sizes: ['S', 'M', 'L', 'XL','2XL','3XL','4XL', 'Standard'],
      reviews: [
        {
          'userId': 'user_101',
          'rating': 5,
          'comment': 'Amazing sound quality!',
        },
        {
          'userId': 'user_102',
          'rating': 4,
          'comment': 'Very comfortable, but charging cable is short.',
        },
      ],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_002',
      category: 'Footwear',
      productCode: 'FTW-RNS-42',
      productName: 'StrideLite Running Shoes',
      productImages: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60',
        'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#FF5733', '#1ABC9C'],
      unitValue: 89.99,
      offerValue: 74.50,
      productDescription:
          'Lightweight and breathable running shoes designed for maximum comfort and arch support.',
      sizes: ['8', '9', '10', '11'],
      reviews: [
        {
          'userId': 'user_201',
          'rating': 5,
          'comment': 'Feels like walking on clouds.',
        },
      ],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_003',
      category: 'Apparel',
      productCode: 'APP-HD-03',
      productName: 'UrbanFit Fleece Hoodie',
      productImages: [
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500&auto=format&fit=crop&q=60',
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#7F8C8D', '#2C3E50'],
      unitValue: 55.00,
      offerValue: 45.00,
      productDescription:
          'Cozy, premium cotton blend fleece hoodie perfect for casual streetwear.',
      sizes: ['S', 'M', 'L', 'XL'],
      reviews: [],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_004',
      category: 'Electronics',
      productCode: 'ELE-SW-11',
      productName: 'Chronos Smartwatch v2',
      productImages: [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#212121', '#E0E0E0'],
      unitValue: 249.99,
      offerValue: 199.99,
      productDescription:
          'Track your fitness, heart rate, and notifications seamlessly with a 7-day battery life.',
      sizes: ['40mm', '44mm'],
      reviews: [
        {
          'userId': 'user_304',
          'rating': 4,
          'comment': 'Great features, but the sleep tracker is sometimes off.',
        },
      ],
      stock: "Stock Out",
    ),
    ProductModel(
      id: 'prod_005',
      category: 'Home & Kitchen',
      productCode: 'HOM-MK-88',
      productName: 'BrewMaster Coffee Maker',
      productImages: [
        'https://images.unsplash.com/photo-1517256064527-09c53b2d0c6f?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#D35400', '#2C3E50'],
      unitValue: 79.99,
      offerValue: 79.99,
      productDescription:
          'Programmable drip coffee maker with a thermal carafe to keep your brew hot for hours.',
      sizes: ['12-Cup'],
      reviews: [
        {
          'userId': 'user_401',
          'rating': 5,
          'comment': 'Best coffee maker I have ever owned.',
        },
        {
          'userId': 'user_402',
          'rating': 5,
          'comment': 'Easy to program and clean.',
        },
      ],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_006',
      category: 'Accessories',
      productCode: 'ACC-BP-05',
      productName: 'Nomad Waterproof Backpack',
      productImages: [
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#16A085', '#2C3E50'],
      unitValue: 65.00,
      offerValue: 52.00,
      productDescription:
          'Durable, weather-resistant backpack featuring a dedicated 15-inch laptop compartment.',
      sizes: ['25L'],
      reviews: [],
      stock: "Stock Out",
    ),
    ProductModel(
      id: 'prod_007',
      category: 'Fitness',
      productCode: 'FIT-YM-01',
      productName: 'FlexiCore Eco Yoga Mat',
      productImages: [
        'https://images.unsplash.com/photo-1592432678016-e910b452f9a2?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#8E44AD', '#27AE60'],
      unitValue: 35.00,
      offerValue: 29.99,
      productDescription:
          'Eco-friendly, non-slip 6mm thick yoga mat providing optimal cushioning for joints.',
      sizes: ['Standard'],
      reviews: [
        {
          'userId': 'user_501',
          'rating': 3,
          'comment': 'Good grip, but has a strong rubber smell initially.',
        },
      ],
      stock: "Stock Out",
    ),
    ProductModel(
      id: 'prod_008',
      category: 'Electronics',
      productCode: 'ELE-CHG-30',
      productName: 'VoltCharge 30W Wall Adapter',
      productImages: [
        'https://images.unsplash.com/photo-1622445262465-2481c4574875?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#FFFFFF', '#000000'],
      unitValue: 24.99,
      offerValue: 18.99,
      productDescription:
          'Compact USB-C power delivery wall charger supporting fast charging for smartphones and tablets.',
      sizes: ['US Plug', 'EU Plug'],
      reviews: [
        {
          'userId': 'user_601',
          'rating': 5,
          'comment': 'Charges my phone incredibly fast.',
        },
      ],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_009',
      category: 'Apparel',
      productCode: 'APP-ST-14',
      productName: 'BreezeFit Casual Sunglasses',
      productImages: [
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500&auto=format&fit=crop&q=60',
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#2980B9', '#2C3E50'],
      unitValue: 45.00,
      offerValue: 35.00,
      productDescription:
          'Classic style sunglasses featuring polarized lenses and a lightweight, durable frame.',
      sizes: ['Standard'],
      reviews: [],
      stock: "Sale",
    ),
    ProductModel(
      id: 'prod_010',
      category: 'Home & Kitchen',
      productCode: 'HOM-DL-02',
      productName: 'Lumina Touch Desk Lamp',
      productImages: [
        'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop&q=60',
        'https://images.unsplash.com/photo-1534224039826-c7a0dea0e66a?w=500&auto=format&fit=crop&q=60',
      ],
      productColors: ['#FFFFFF'],
      unitValue: 39.99,
      offerValue: 32.49,
      productDescription:
          'Modern LED desk lamp with 3 brightness levels and a built-in wireless smartphone charger.',
      sizes: ['Standard'],
      reviews: [
        {
          'userId': 'user_701',
          'rating': 4,
          'comment':
              'The wireless charger is a bit slow, but the lamp is sleek.',
        },
        {
          'userId': 'user_702',
          'rating': 5,
          'comment': 'Perfect addition to my nightstand.',
        },
      ],
      stock: "Stock Out",
    ),
  ];
}
