# Craftvers — Flutter E-Commerce App

## Project Structure

```
lib/
├── main.dart                          ← Entry point
├── theme/
│   └── app_theme.dart                 ← Colors, fonts, button styles
├── models/
│   └── product.dart                   ← Product & Category models + dummy data
├── routes/
│   └── app_routes.dart                ← Navigation with smooth transitions
├── widgets/
│   └── product_card.dart              ← Reusable product card widget
└── screens/
    ├── auth/
    │   ├── login_screen.dart           ← Login with animation
    │   └── signup_screen.dart          ← Registration form
    ├── home/
    │   └── home_screen.dart            ← Dashboard with categories & products
    ├── catalog/
    │   └── catalog_screen.dart         ← Browse, filter, search products
    ├── product/
    │   └── product_details_screen.dart ← Full product details + buy
    └── payment/
        └── payment_screen.dart         ← Checkout with card/PayPal/Apple Pay
```

## Screens Overview

| Screen | Features |
|--------|----------|
| **Login** | Email/password, show/hide password, animated entry |
| **Sign Up** | Full registration, terms checkbox, validation |
| **Home** | Greeting, search, hero banner, categories, product grid, cart icon |
| **Catalog** | Category filter chips, search, sort (price/rating), product grid |
| **Product Details** | Image gallery, star rating, quantity picker, add to cart, buy now |
| **Payment** | Credit card / PayPal / Apple Pay, price breakdown, success dialog |

## Setup

```bash
# 1. Get dependencies
flutter pub get

# 2. Add Poppins fonts from Google Fonts to assets/fonts/
# OR remove font declarations from pubspec.yaml to use system font

# 3. Run
flutter run
```

## Design System

- **Primary Color:** `#1A1A2E` (deep navy)
- **Accent Color:** `#E94560` (vibrant red-pink)
- **Font:** Poppins
- **Border Radius:** 14px (inputs), 18px (cards), 20px (banners)
