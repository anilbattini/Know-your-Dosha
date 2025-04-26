#!/usr/bin/env python3
import os

def create_simple_png(filename, width=64, height=64):
    """Create a simple 1x1 gray PNG image"""
    # This is a minimal valid PNG file (1x1 gray pixel)
    png_data = (
        b'\x89PNG\r\n\x1a\n'  # PNG signature
        b'\x00\x00\x00\r'     # IHDR chunk length
        b'IHDR'               # IHDR chunk type
        b'\x00\x00\x00\x01'   # width (1 pixel)
        b'\x00\x00\x00\x01'   # height (1 pixel)
        b'\x08\x02\x00\x00\x00'  # bit depth, color type, compression, filter, interlace
        b'\x00\x00\x00\x00'   # CRC placeholder
        b'\x00\x00\x00\x0c'   # IDAT chunk length
        b'IDAT'               # IDAT chunk type
        b'\x78\x9c\x63\x00\x00\x00\x02\x00\x01'  # compressed data
        b'\x00\x00\x00\x00'   # CRC placeholder
        b'\x00\x00\x00\x00'   # IEND chunk length
        b'IEND'               # IEND chunk type
        b'\x00\x00\x00\x00'   # CRC placeholder
    )
    
    with open(filename, 'wb') as f:
        f.write(png_data)

def main():
    # Create placeholder images for all food assets
    foods_dir = 'assets/foods'
    
    if not os.path.exists(foods_dir):
        print(f"Directory {foods_dir} does not exist")
        return
    
    for filename in os.listdir(foods_dir):
        if filename.endswith('.png'):
            filepath = os.path.join(foods_dir, filename)
            if os.path.getsize(filepath) == 0:
                print(f"Creating placeholder for {filename}")
                create_simple_png(filepath)
    
    # Create lifestyle images
    lifestyle_images = [
        'assets/vata_lifestyle.png',
        'assets/pitta_lifestyle.png', 
        'assets/kapha_lifestyle.png'
    ]
    
    for image_path in lifestyle_images:
        if os.path.exists(image_path) and os.path.getsize(image_path) == 0:
            print(f"Creating placeholder for {image_path}")
            create_simple_png(image_path)

if __name__ == '__main__':
    main() 