from PIL import Image, ImageDraw, ImageFont

def add_watermark(input_image, output_image, watermark_text):
    img = Image.open(input_image).convert("RGBA")
    txt = Image.new("RGBA", img.size, (255, 255, 255, 0))
    
    draw = ImageDraw.Draw(txt)
    font = ImageFont.load_default()
    
    text_width, text_height = draw.textsize(watermark_text, font=font)
    x, y = img.size[0] - text_width - 10, img.size[1] - text_height - 10
    
    draw.text((x, y), watermark_text, fill=(255, 0, 0, 128), font=font)
    
    watermarked = Image.alpha_composite(img, txt)
    watermarked.convert("RGB").save(output_image, "JPEG")

    print(f"✅ 워터마크 삽입 완료: {output_image}")

# 실행 예제
add_watermark("original.jpg", "watermarked.jpg", "User: 0x123456789")
