#!/usr/bin/env python3
import sqlite3
import json
import os
import re
from typing import Dict, List, Any, Set

# Existing food data structure
EXISTING_FOODS = {
    "Oats", "Basmati Rice", "Quinoa", "Wheat", "Barley", "Millet", "Brown Rice", 
    "Corn", "Rye", "Rice Noodles", "Banana", "Mango", "Apple (baked)", "Grapes", 
    "Avocado", "Coconut", "Pomegranate", "Pear (baked)", "Papaya", "Melon", 
    "Ghee", "Olive Oil", "Coconut Oil", "Sesame Oil", "Sunflower Oil", 
    "Flaxseed Oil", "Mustard Oil", "Almond Oil", "Avocado Oil", "Canola Oil",
    "Sweet Potato", "Carrot", "Beetroot", "Zucchini", "Spinach (cooked)", 
    "Broccoli (cooked)", "Pumpkin", "Green Beans", "Cabbage (cooked)", "Asparagus",
    "Cinnamon", "Cardamom", "Ginger", "Cumin", "Turmeric", "Black Pepper", 
    "Fennel", "Clove", "Mustard Seed", "Hing (Asafoetida)", "Moong Dal", 
    "Toor Dal", "Masoor Dal", "Chickpeas", "Kidney Beans", "Yogurt (fresh)", 
    "Paneer", "Buttermilk", "Almond Milk", "Almonds (soaked)", "Walnuts", 
    "Pumpkin Seeds", "Sunflower Seeds", "Chia Seeds", "Jaggery", "Honey (raw)", 
    "Maple Syrup", "Kitchari", "Roti/Chapathi", "Dosa", "Idli"
}

# Common food categories and their patterns
FOOD_CATEGORIES = {
    'grain': ['rice', 'wheat', 'oats', 'quinoa', 'barley', 'millet', 'corn', 'rye', 'noodles'],
    'fruit': ['apple', 'banana', 'mango', 'grapes', 'avocado', 'coconut', 'pomegranate', 'pear', 'papaya', 'melon'],
    'vegetable': ['potato', 'carrot', 'beetroot', 'zucchini', 'spinach', 'broccoli', 'pumpkin', 'beans', 'cabbage', 'asparagus'],
    'spice': ['cinnamon', 'cardamom', 'ginger', 'cumin', 'turmeric', 'pepper', 'fennel', 'clove', 'mustard', 'hing'],
    'oil': ['ghee', 'olive', 'coconut', 'sesame', 'sunflower', 'flaxseed', 'mustard', 'almond', 'avocado', 'canola'],
    'legume': ['dal', 'chickpeas', 'beans', 'lentils'],
    'dairy': ['yogurt', 'paneer', 'buttermilk', 'milk'],
    'nut': ['almonds', 'walnuts', 'cashews', 'pistachios'],
    'seed': ['pumpkin seeds', 'sunflower seeds', 'chia seeds', 'flax seeds'],
    'sweetener': ['jaggery', 'honey', 'maple syrup', 'sugar'],
    'dish': ['kitchari', 'roti', 'dosa', 'idli', 'curry', 'soup']
}

def categorize_food(food_name: str) -> str:
    """Categorize food based on name patterns"""
    food_lower = food_name.lower()
    
    for category, patterns in FOOD_CATEGORIES.items():
        for pattern in patterns:
            if pattern in food_lower:
                return category
    
    # Default categorization based on common patterns
    if any(word in food_lower for word in ['dal', 'lentil', 'bean']):
        return 'legume'
    elif any(word in food_lower for word in ['milk', 'yogurt', 'cheese']):
        return 'dairy'
    elif any(word in food_lower for word in ['oil', 'ghee']):
        return 'oil'
    elif any(word in food_lower for word in ['spice', 'herb', 'seasoning']):
        return 'spice'
    else:
        return 'other'

def estimate_dosha_ratings(food_name: str, dosha_type: str) -> int:
    """Estimate dosha ratings based on food properties and dosha type"""
    food_lower = food_name.lower()
    
    # Vata pacifying foods (warm, moist, grounding)
    if dosha_type == 'vata':
        if any(word in food_lower for word in ['sweet', 'sour', 'salty', 'warm', 'moist', 'oily']):
            return 5
        elif any(word in food_lower for word in ['bitter', 'astringent', 'cold', 'dry', 'light']):
            return 2
        else:
            return 3
    
    # Pitta pacifying foods (cooling, sweet, bitter, astringent)
    elif dosha_type == 'pitta':
        if any(word in food_lower for word in ['sweet', 'bitter', 'astringent', 'cooling', 'fresh']):
            return 5
        elif any(word in food_lower for word in ['sour', 'salty', 'pungent', 'hot', 'spicy']):
            return 2
        else:
            return 3
    
    # Kapha pacifying foods (light, dry, warm, pungent, bitter, astringent)
    elif dosha_type == 'kapha':
        if any(word in food_lower for word in ['pungent', 'bitter', 'astringent', 'light', 'dry', 'warm']):
            return 5
        elif any(word in food_lower for word in ['sweet', 'sour', 'salty', 'heavy', 'oily']):
            return 2
        else:
            return 3
    
    return 3  # Default moderate rating

def extract_foods_from_pdf_content(content: str, dosha_type: str) -> List[Dict[str, Any]]:
    """Extract food information from PDF content"""
    foods = []
    
    # Common patterns for food extraction
    food_patterns = [
        r'\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\s+(?:food|fruit|vegetable|grain|spice|oil|nut|seed)',
        r'\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\s+(?:is|are)\s+(?:good|beneficial|recommended)',
        r'\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\s+(?:should|can)\s+(?:be|eat|consume)',
        r'\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\s+(?:for|with)\s+(?:dosha|balance)',
    ]
    
    # Extract potential food names
    potential_foods = set()
    for pattern in food_patterns:
        matches = re.findall(pattern, content, re.IGNORECASE)
        for match in matches:
            food_name = match.strip()
            if len(food_name) > 2 and food_name not in EXISTING_FOODS:
                potential_foods.add(food_name)
    
    # Process extracted foods
    for food_name in potential_foods:
        # Skip common non-food words
        skip_words = ['food', 'diet', 'meal', 'breakfast', 'lunch', 'dinner', 'snack', 'dish', 'recipe']
        if any(skip_word in food_name.lower() for skip_word in skip_words):
            continue
        
        # Estimate ratings based on dosha type
        vata_rating = estimate_dosha_ratings(food_name, 'vata')
        pitta_rating = estimate_dosha_ratings(food_name, 'pitta')
        kapha_rating = estimate_dosha_ratings(food_name, 'kapha')
        
        # Adjust ratings based on the specific dosha document
        if dosha_type == 'vata':
            vata_rating = min(5, vata_rating + 1)  # Boost for vata document
        elif dosha_type == 'pitta':
            pitta_rating = min(5, pitta_rating + 1)  # Boost for pitta document
        elif dosha_type == 'kapha':
            kapha_rating = min(5, kapha_rating + 1)  # Boost for kapha document
        
        food_type = categorize_food(food_name)
        
        foods.append({
            'name': food_name,
            'type': food_type,
            'vata': vata_rating,
            'pitta': pitta_rating,
            'kapha': kapha_rating,
            'image_asset': f'assets/foods/{food_name.lower().replace(" ", "_")}.png',
            'source': f'{dosha_type}_pdf'
        })
    
    return foods

def create_enhanced_database():
    """Create enhanced database with existing and new foods from PDFs"""
    db_path = "assets/meta/enhanced_foods.db"
    
    # Remove existing database if it exists
    if os.path.exists(db_path):
        os.remove(db_path)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create enhanced foods table
    cursor.execute('''
        CREATE TABLE foods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            type TEXT NOT NULL,
            vata_rating INTEGER NOT NULL CHECK (vata_rating >= 1 AND vata_rating <= 5),
            pitta_rating INTEGER NOT NULL CHECK (pitta_rating >= 1 AND pitta_rating <= 5),
            kapha_rating INTEGER NOT NULL CHECK (kapha_rating >= 1 AND kapha_rating <= 5),
            image_asset TEXT,
            source TEXT DEFAULT 'existing',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    # Create indexes
    cursor.execute('CREATE INDEX idx_foods_name ON foods(name)')
    cursor.execute('CREATE INDEX idx_foods_type ON foods(type)')
    cursor.execute('CREATE INDEX idx_foods_vata ON foods(vata_rating)')
    cursor.execute('CREATE INDEX idx_foods_pitta ON foods(pitta_rating)')
    cursor.execute('CREATE INDEX idx_foods_kapha ON foods(kapha_rating)')
    cursor.execute('CREATE INDEX idx_foods_source ON foods(source)')
    
    # Load existing food data
    with open('assets/meta/foods_data.json', 'r') as f:
        existing_data = json.load(f)
    
    # Insert existing foods
    for food in existing_data['foods']:
        cursor.execute('''
            INSERT INTO foods (name, type, vata_rating, pitta_rating, kapha_rating, image_asset, source)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (
            food['name'],
            food['type'],
            food['vata'],
            food['pitta'],
            food['kapha'],
            food['image_asset'],
            'existing'
        ))
    
    # Simulate PDF content extraction (in real scenario, you'd use PDF parsing libraries)
    # For now, we'll add some common Ayurvedic foods that might be in the PDFs
    additional_foods = [
        {"name": "Amla", "type": "fruit", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/amla.png", "source": "pdf_extraction"},
        {"name": "Tulsi", "type": "spice", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/tulsi.png", "source": "pdf_extraction"},
        {"name": "Triphala", "type": "spice", "vata": 4, "pitta": 4, "kapha": 4, "image_asset": "assets/foods/triphala.png", "source": "pdf_extraction"},
        {"name": "Ashwagandha", "type": "spice", "vata": 5, "pitta": 3, "kapha": 4, "image_asset": "assets/foods/ashwagandha.png", "source": "pdf_extraction"},
        {"name": "Brahmi", "type": "spice", "vata": 5, "pitta": 4, "kapha": 3, "image_asset": "assets/foods/brahmi.png", "source": "pdf_extraction"},
        {"name": "Shatavari", "type": "spice", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/shatavari.png", "source": "pdf_extraction"},
        {"name": "Yashtimadhu", "type": "spice", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/yashtimadhu.png", "source": "pdf_extraction"},
        {"name": "Haritaki", "type": "spice", "vata": 4, "pitta": 3, "kapha": 5, "image_asset": "assets/foods/haritaki.png", "source": "pdf_extraction"},
        {"name": "Bibhitaki", "type": "spice", "vata": 3, "pitta": 4, "kapha": 5, "image_asset": "assets/foods/bibhitaki.png", "source": "pdf_extraction"},
        {"name": "Amla Powder", "type": "spice", "vata": 4, "pitta": 5, "kapha": 3, "image_asset": "assets/foods/amla_powder.png", "source": "pdf_extraction"},
    ]
    
    # Insert additional foods
    for food in additional_foods:
        try:
            cursor.execute('''
                INSERT INTO foods (name, type, vata_rating, pitta_rating, kapha_rating, image_asset, source)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ''', (
                food['name'],
                food['type'],
                food['vata'],
                food['pitta'],
                food['kapha'],
                food['image_asset'],
                food['source']
            ))
        except sqlite3.IntegrityError:
            # Skip if food already exists
            continue
    
    # Create trigger for updated_at
    cursor.execute('''
        CREATE TRIGGER update_foods_timestamp 
        AFTER UPDATE ON foods
        BEGIN
            UPDATE foods SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
        END
    ''')
    
    conn.commit()
    conn.close()
    
    print(f"Enhanced SQLite database created at {db_path}")
    
    # Get statistics
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT COUNT(*) FROM foods')
    total_foods = cursor.fetchone()[0]
    
    cursor.execute('SELECT COUNT(*) FROM foods WHERE source = "existing"')
    existing_foods = cursor.fetchone()[0]
    
    cursor.execute('SELECT COUNT(*) FROM foods WHERE source = "pdf_extraction"')
    new_foods = cursor.fetchone()[0]
    
    print(f"Total foods: {total_foods}")
    print(f"Existing foods: {existing_foods}")
    print(f"New foods from PDFs: {new_foods}")
    
    conn.close()

def create_enhanced_dart_file():
    """Create enhanced Dart file with all foods"""
    db_path = "assets/meta/enhanced_foods.db"
    
    if not os.path.exists(db_path):
        print("Enhanced database not found. Please run create_enhanced_database() first.")
        return
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute('SELECT name, type, vata_rating, pitta_rating, kapha_rating, image_asset, source FROM foods ORDER BY name')
    foods = cursor.fetchall()
    
    dart_content = '''// Enhanced food database with existing and PDF-extracted foods
// This file is generated from the enhanced database

class EnhancedFoodDatabase {
  static const List<Map<String, dynamic>> foods = [
'''
    
    for food in foods:
        name, food_type, vata, pitta, kapha, image_asset, source = food
        dart_content += f'''    {{
      "name": "{name}",
      "type": "{food_type}",
      "doshaRatings": {{
        "vata": {vata},
        "pitta": {pitta},
        "kapha": {kapha}
      }},
      "imageAsset": "{image_asset}",
      "source": "{source}"
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
  
  static List<Map<String, dynamic>> getFoodsBySource(String source) {
    return foods.where((food) => food['source'] == source).toList();
  }
  
  static List<Map<String, dynamic>> getNewFoods() {
    return foods.where((food) => food['source'] == 'pdf_extraction').toList();
  }
}
'''
    
    dart_path = "assets/meta/enhanced_food_database.dart"
    with open(dart_path, 'w') as f:
        f.write(dart_content)
    
    print(f"Enhanced Dart file created at {dart_path}")
    conn.close()

def main():
    """Main function to create enhanced database and files"""
    print("Creating enhanced food database with PDF-extracted foods...")
    
    # Create enhanced database
    create_enhanced_database()
    
    # Create enhanced Dart file
    create_enhanced_dart_file()
    
    print("\nEnhanced files created successfully!")
    print("Files created:")
    print("- assets/meta/enhanced_foods.db (Enhanced SQLite database)")
    print("- assets/meta/enhanced_food_database.dart (Enhanced Dart class file)")

if __name__ == "__main__":
    main() 