#!/usr/bin/env python3
import sqlite3
import json
import os
from typing import Dict, List, Any

# Food data structure based on the existing food_suggestions.dart
FOOD_DATA = [
    # Grains
    {"name": "Oats", "type": "grain", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/oats.png"},
    {"name": "Basmati Rice", "type": "grain", "vata": 5, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/basmati_rice.png"},
    {"name": "Quinoa", "type": "grain", "vata": 4, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/quinoa.png"},
    {"name": "Wheat", "type": "grain", "vata": 4, "pitta": 3, "kapha": 2, "image_asset": "assets/foods/wheat.png"},
    {"name": "Barley", "type": "grain", "vata": 2, "pitta": 4, "kapha": 5, "image_asset": "assets/foods/barley.png"},
    {"name": "Millet", "type": "grain", "vata": 2, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/millet.png"},
    {"name": "Brown Rice", "type": "grain", "vata": 1, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/brown_rice.png"},
    {"name": "Corn", "type": "grain", "vata": 2, "pitta": 2, "kapha": 4, "image_asset": "assets/foods/corn.png"},
    {"name": "Rye", "type": "grain", "vata": 2, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/rye.png"},
    {"name": "Rice Noodles", "type": "grain", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/rice_noodles.png"},

    # Fruits
    {"name": "Banana", "type": "fruit", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/banana.png"},
    {"name": "Mango", "type": "fruit", "vata": 5, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/mango.png"},
    {"name": "Apple (baked)", "type": "fruit", "vata": 4, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/apple.png"},
    {"name": "Grapes", "type": "fruit", "vata": 5, "pitta": 5, "kapha": 2, "image_asset": "assets/foods/grapes.png"},
    {"name": "Avocado", "type": "fruit", "vata": 5, "pitta": 3, "kapha": 1, "image_asset": "assets/foods/avocado.png"},
    {"name": "Coconut", "type": "fruit", "vata": 5, "pitta": 5, "kapha": 2, "image_asset": "assets/foods/coconut.png"},
    {"name": "Pomegranate", "type": "fruit", "vata": 3, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/pomegranate.png"},
    {"name": "Pear (baked)", "type": "fruit", "vata": 4, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/pear.png"},
    {"name": "Papaya", "type": "fruit", "vata": 5, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/papaya.png"},
    {"name": "Melon", "type": "fruit", "vata": 3, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/melon.png"},

    # Oils
    {"name": "Ghee", "type": "oil", "vata": 5, "pitta": 5, "kapha": 2, "image_asset": "assets/foods/ghee.png"},
    {"name": "Olive Oil", "type": "oil", "vata": 5, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/olive_oil.png"},
    {"name": "Coconut Oil", "type": "oil", "vata": 5, "pitta": 5, "kapha": 2, "image_asset": "assets/foods/coconut_oil.png"},
    {"name": "Sesame Oil", "type": "oil", "vata": 5, "pitta": 3, "kapha": 2, "image_asset": "assets/foods/sesame_oil.png"},
    {"name": "Sunflower Oil", "type": "oil", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/sunflower_oil.png"},
    {"name": "Flaxseed Oil", "type": "oil", "vata": 4, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/flaxseed_oil.png"},
    {"name": "Mustard Oil", "type": "oil", "vata": 2, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/mustard_oil.png"},
    {"name": "Almond Oil", "type": "oil", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/almond_oil.png"},
    {"name": "Avocado Oil", "type": "oil", "vata": 5, "pitta": 3, "kapha": 1, "image_asset": "assets/foods/avocado_oil.png"},
    {"name": "Canola Oil", "type": "oil", "vata": 3, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/canola_oil.png"},

    # Vegetables
    {"name": "Sweet Potato", "type": "vegetable", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/sweet_potato.png"},
    {"name": "Carrot", "type": "vegetable", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/carrot.png"},
    {"name": "Beetroot", "type": "vegetable", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/beetroot.png"},
    {"name": "Zucchini", "type": "vegetable", "vata": 4, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/zucchini.png"},
    {"name": "Spinach (cooked)", "type": "vegetable", "vata": 3, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/spinach.png"},
    {"name": "Broccoli (cooked)", "type": "vegetable", "vata": 2, "pitta": 4, "kapha": 5, "image_asset": "assets/foods/broccoli.png"},
    {"name": "Pumpkin", "type": "vegetable", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/pumpkin.png"},
    {"name": "Green Beans", "type": "vegetable", "vata": 4, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/green_beans.png"},
    {"name": "Cabbage (cooked)", "type": "vegetable", "vata": 2, "pitta": 4, "kapha": 5, "image_asset": "assets/foods/cabbage.png"},
    {"name": "Asparagus", "type": "vegetable", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/asparagus.png"},

    # Spices
    {"name": "Cinnamon", "type": "spice", "vata": 5, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/cinnamon.png"},
    {"name": "Cardamom", "type": "spice", "vata": 5, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/cardamom.png"},
    {"name": "Ginger", "type": "spice", "vata": 5, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/ginger.png"},
    {"name": "Cumin", "type": "spice", "vata": 5, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/cumin.png"},
    {"name": "Turmeric", "type": "spice", "vata": 4, "pitta": 5, "kapha": 5, "image_asset": "assets/foods/turmeric.png"},
    {"name": "Black Pepper", "type": "spice", "vata": 3, "pitta": 2, "kapha": 5, "image_asset": "assets/foods/black_pepper.png"},
    {"name": "Fennel", "type": "spice", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/fennel.png"},
    {"name": "Clove", "type": "spice", "vata": 4, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/clove.png"},
    {"name": "Mustard Seed", "type": "spice", "vata": 2, "pitta": 2, "kapha": 5, "image_asset": "assets/foods/mustard_seed.png"},
    {"name": "Hing (Asafoetida)", "type": "spice", "vata": 5, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/hing.png"},

    # Legumes & Beans
    {"name": "Moong Dal", "type": "legume", "vata": 5, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/moong_dal.png"},
    {"name": "Toor Dal", "type": "legume", "vata": 3, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/toor_dal.png"},
    {"name": "Masoor Dal", "type": "legume", "vata": 3, "pitta": 3, "kapha": 4, "image_asset": "assets/foods/masoor_dal.png"},
    {"name": "Chickpeas", "type": "legume", "vata": 2, "pitta": 4, "kapha": 5, "image_asset": "assets/foods/chickpeas.png"},
    {"name": "Kidney Beans", "type": "legume", "vata": 1, "pitta": 3, "kapha": 4, "image_asset": "assets/foods/kidney_beans.png"},

    # Dairy & Alternatives
    {"name": "Yogurt (fresh)", "type": "dairy", "vata": 3, "pitta": 3, "kapha": 2, "image_asset": "assets/foods/yogurt.png"},
    {"name": "Paneer", "type": "dairy", "vata": 4, "pitta": 3, "kapha": 1, "image_asset": "assets/foods/paneer.png"},
    {"name": "Buttermilk", "type": "dairy", "vata": 5, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/buttermilk.png"},
    {"name": "Almond Milk", "type": "dairy", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/almond_milk.png"},

    # Nuts & Seeds
    {"name": "Almonds (soaked)", "type": "nut", "vata": 5, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/almonds.png"},
    {"name": "Walnuts", "type": "nut", "vata": 5, "pitta": 3, "kapha": 2, "image_asset": "assets/foods/walnuts.png"},
    {"name": "Pumpkin Seeds", "type": "seed", "vata": 4, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/pumpkin_seeds.png"},
    {"name": "Sunflower Seeds", "type": "seed", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/sunflower_seeds.png"},
    {"name": "Chia Seeds", "type": "seed", "vata": 3, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/chia_seeds.png"},

    # Sweeteners
    {"name": "Jaggery", "type": "sweetener", "vata": 5, "pitta": 3, "kapha": 2, "image_asset": "assets/foods/jaggery.png"},
    {"name": "Honey (raw)", "type": "sweetener", "vata": 3, "pitta": 2, "kapha": 5, "image_asset": "assets/foods/honey.png"},
    {"name": "Maple Syrup", "type": "sweetener", "vata": 4, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/maple_syrup.png"},

    # Indian Dishes
    {"name": "Kitchari", "type": "dish", "vata": 5, "pitta": 5, "kapha": 4, "image_asset": "assets/foods/kitchari.png"},
    {"name": "Roti/Chapathi", "type": "dish", "vata": 4, "pitta": 4, "kapha": 2, "image_asset": "assets/foods/roti.png"},
    {"name": "Dosa", "type": "dish", "vata": 3, "pitta": 3, "kapha": 3, "image_asset": "assets/foods/dosa.png"},
    {"name": "Idli", "type": "dish", "vata": 4, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/idli.png"},
]

def create_sqlite_database():
    """Create SQLite database with proper indexing and constraints"""
    db_path = "assets/meta/foods.db"
    
    # Remove existing database if it exists
    if os.path.exists(db_path):
        os.remove(db_path)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create foods table with proper constraints and indexing
    cursor.execute('''
        CREATE TABLE foods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            type TEXT NOT NULL,
            vata_rating INTEGER NOT NULL CHECK (vata_rating >= 1 AND vata_rating <= 5),
            pitta_rating INTEGER NOT NULL CHECK (pitta_rating >= 1 AND pitta_rating <= 5),
            kapha_rating INTEGER NOT NULL CHECK (kapha_rating >= 1 AND kapha_rating <= 5),
            image_asset TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    # Create indexes for better performance
    cursor.execute('CREATE INDEX idx_foods_name ON foods(name)')
    cursor.execute('CREATE INDEX idx_foods_type ON foods(type)')
    cursor.execute('CREATE INDEX idx_foods_vata ON foods(vata_rating)')
    cursor.execute('CREATE INDEX idx_foods_pitta ON foods(pitta_rating)')
    cursor.execute('CREATE INDEX idx_foods_kapha ON foods(kapha_rating)')
    cursor.execute('CREATE INDEX idx_foods_dosha_ratings ON foods(vata_rating, pitta_rating, kapha_rating)')
    
    # Insert food data
    for food in FOOD_DATA:
        cursor.execute('''
            INSERT INTO foods (name, type, vata_rating, pitta_rating, kapha_rating, image_asset)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            food['name'],
            food['type'],
            food['vata'],
            food['pitta'],
            food['kapha'],
            food['image_asset']
        ))
    
    # Create trigger to update updated_at timestamp
    cursor.execute('''
        CREATE TRIGGER update_foods_timestamp 
        AFTER UPDATE ON foods
        BEGIN
            UPDATE foods SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
        END
    ''')
    
    conn.commit()
    conn.close()
    
    print(f"SQLite database created at {db_path}")
    print(f"Total foods inserted: {len(FOOD_DATA)}")

def create_structured_data_file():
    """Create a structured JSON data file for easy reading and updating"""
    data_structure = {
        "metadata": {
            "version": "1.0",
            "created_at": "2024-01-01",
            "description": "Ayurvedic food database with dosha ratings",
            "rating_scale": {
                "5": "Highly recommended",
                "4": "Good",
                "3": "Moderate",
                "2": "Reduce",
                "1": "Avoid"
            }
        },
        "food_categories": {
            "grain": "Grains and cereals",
            "fruit": "Fruits",
            "oil": "Oils and fats",
            "vegetable": "Vegetables",
            "spice": "Spices and herbs",
            "legume": "Legumes and beans",
            "dairy": "Dairy and alternatives",
            "nut": "Nuts",
            "seed": "Seeds",
            "sweetener": "Sweeteners",
            "dish": "Indian dishes"
        },
        "foods": FOOD_DATA
    }
    
    # Save as JSON
    json_path = "assets/meta/foods_data.json"
    with open(json_path, 'w') as f:
        json.dump(data_structure, f, indent=2)
    
    print(f"Structured data file created at {json_path}")

def create_dart_data_file():
    """Create a Dart class file for easy integration with Flutter"""
    dart_content = '''// Auto-generated food data class
// This file is generated from the database and should not be edited manually

class FoodDatabase {
  static const List<Map<String, dynamic>> foods = [
'''
    
    for food in FOOD_DATA:
        dart_content += f'''    {{
      "name": "{food['name']}",
      "type": "{food['type']}",
      "doshaRatings": {{
        "vata": {food['vata']},
        "pitta": {food['pitta']},
        "kapha": {food['kapha']}
      }},
      "imageAsset": "{food['image_asset']}"
    }},
'''
    
    dart_content += '''  ];
  
  static List<Map<String, dynamic>> getFoodsByType(String type) {
    return foods.where((food) => food['type'] == type).toList();
  }
  
  static List<Map<String, dynamic>> getFoodsByDosha(String dosha, {int minRating = 4}) {
    return foods.where((food) => food['doshaRatings'][dosha] >= minRating).toList();
  }
  
  static List<Map<String, dynamic>> getFoodsToAvoid(String dosha, {int maxRating = 2}) {
    return foods.where((food) => food['doshaRatings'][dosha] <= maxRating).toList();
  }
  
  static Map<String, dynamic>? getFoodByName(String name) {
    try {
      return foods.firstWhere((food) => food['name'].toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }
}
'''
    
    dart_path = "assets/meta/food_database.dart"
    with open(dart_path, 'w') as f:
        f.write(dart_content)
    
    print(f"Dart data file created at {dart_path}")

def create_database_schema_documentation():
    """Create documentation for the database schema"""
    doc_content = '''# Food Database Schema Documentation

## Database: foods.db

### Table: foods

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT | Unique identifier |
| name | TEXT | UNIQUE NOT NULL | Food name |
| type | TEXT | NOT NULL | Food category (grain, fruit, oil, etc.) |
| vata_rating | INTEGER | NOT NULL, CHECK (1-5) | Rating for Vata dosha |
| pitta_rating | INTEGER | NOT NULL, CHECK (1-5) | Rating for Pitta dosha |
| kapha_rating | INTEGER | NOT NULL, CHECK (1-5) | Rating for Kapha dosha |
| image_asset | TEXT | NULL | Path to food image |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Last update timestamp |

### Indexes

- `idx_foods_name`: Index on food name for fast lookups
- `idx_foods_type`: Index on food type for category queries
- `idx_foods_vata`: Index on Vata rating
- `idx_foods_pitta`: Index on Pitta rating
- `idx_foods_kapha`: Index on Kapha rating
- `idx_foods_dosha_ratings`: Composite index on all dosha ratings

### Rating Scale

- 5: Highly recommended
- 4: Good
- 3: Moderate
- 2: Reduce
- 1: Avoid

### Food Categories

- grain: Grains and cereals
- fruit: Fruits
- oil: Oils and fats
- vegetable: Vegetables
- spice: Spices and herbs
- legume: Legumes and beans
- dairy: Dairy and alternatives
- nut: Nuts
- seed: Seeds
- sweetener: Sweeteners
- dish: Indian dishes

### Usage Examples

```sql
-- Get all foods recommended for Vata dosha (rating >= 4)
SELECT * FROM foods WHERE vata_rating >= 4;

-- Get foods to avoid for Pitta dosha (rating <= 2)
SELECT * FROM foods WHERE pitta_rating <= 2;

-- Get all grains
SELECT * FROM foods WHERE type = 'grain';

-- Get foods good for all doshas (rating >= 4 for all)
SELECT * FROM foods WHERE vata_rating >= 4 AND pitta_rating >= 4 AND kapha_rating >= 4;
```
'''
    
    doc_path = "assets/meta/database_schema.md"
    with open(doc_path, 'w') as f:
        f.write(doc_content)
    
    print(f"Database documentation created at {doc_path}")

def main():
    """Main function to create all database and data files"""
    print("Creating food database and structured data files...")
    
    # Create assets/meta directory if it doesn't exist
    os.makedirs("assets/meta", exist_ok=True)
    
    # Create SQLite database
    create_sqlite_database()
    
    # Create structured data files
    create_structured_data_file()
    create_dart_data_file()
    create_database_schema_documentation()
    
    print("\nAll files created successfully!")
    print("Files created:")
    print("- assets/meta/foods.db (SQLite database)")
    print("- assets/meta/foods_data.json (Structured JSON data)")
    print("- assets/meta/food_database.dart (Dart class file)")
    print("- assets/meta/database_schema.md (Documentation)")

if __name__ == "__main__":
    main() 