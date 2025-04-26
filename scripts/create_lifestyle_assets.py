import os
from PIL import Image, ImageDraw, ImageFont
import textwrap

def create_placeholder_image(text, output_path, width=400, height=300, bg_color=(240, 240, 240), text_color=(100, 100, 100)):
    """Create a placeholder image with text in the center"""
    # Create a new image with the specified background color
    img = Image.new('RGB', (width, height), color=bg_color)
    draw = ImageDraw.Draw(img)
    
    # Use a default font (you might need to adjust the path)
    try:
        font = ImageFont.truetype("Arial", 24)
    except IOError:
        font = ImageFont.load_default()
    
    # Wrap the text
    lines = textwrap.wrap(text, width=20)
    
    # Calculate text position (centered)
    total_text_height = len(lines) * font.getsize('A')[1]
    y = (height - total_text_height) // 2
    
    # Draw each line of text
    for line in lines:
        text_width = draw.textlength(line, font=font)
        x = (width - text_width) // 2
        draw.text((x, y), line, font=font, fill=text_color)
        y += font.getsize(line)[1]
    
    # Save the image
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path)

def main():
    # Base directory for assets
    base_dir = os.path.join('assets', 'lifestyle')
    
    # Create lifestyle tips images
    lifestyle_data = {
        'vata': [
            ('Regular Routine', 'vata_1.jpg'),
            ('Gentle Yoga', 'vata_2.jpg'),
            ('Stay Warm', 'vata_3.jpg')
        ],
        'pitta': [
            ('Stay Cool', 'pitta_1.jpg'),
            ('Meditation', 'pitta_2.jpg'),
            ('Nature Time', 'pitta_3.jpg')
        ],
        'kapha': [
            ('Vigorous Exercise', 'kapha_1.jpg'),
            ('Try New Activities', 'kapha_2.jpg'),
            ('Wake Up Early', 'kapha_3.jpg')
        ]
    }
    
    # Create colored backgrounds for each dosha
    colors = {
        'vata': (200, 230, 255),  # Light blue
        'pitta': (255, 220, 200),  # Light orange
        'kapha': (220, 255, 220)   # Light green
    }
    
    # Generate all placeholder images
    for dosha, tips in lifestyle_data.items():
        for i, (text, filename) in enumerate(tips, 1):
            output_path = os.path.join(base_dir, f'{dosha}_{i}.jpg')
            create_placeholder_image(
                text=text,
                output_path=output_path,
                bg_color=colors[dosha],
                text_color=(80, 80, 80)
            )
            print(f'Created: {output_path}')
    
    print('\nAll placeholder images have been created successfully!')

if __name__ == '__main__':
    main()
