#!/usr/bin/env python3
"""
Sample the dominant color at a specific position on the wallpaper.
This is used when the user drags the clock widget to a new position.
"""

import os
os.environ["OPENCV_LOG_LEVEL"] = "SILENT"
import cv2
import numpy as np
import argparse
import json
import sys

def center_crop(img, target_w, target_h):
    """Crop image to target dimensions from center"""
    h, w = img.shape[:2]
    if w == target_w and h == target_h:
        return img
    x1 = max(0, (w - target_w) // 2)
    y1 = max(0, (h - target_h) // 2)
    x2 = x1 + target_w
    y2 = y1 + target_h
    return img[y1:y2, x1:x2]

def get_dominant_color(image_path, center_x, center_y, w, h, screen_width=None, screen_height=None, screen_mode="fill"):
    """Get dominant color at a specific region on the wallpaper"""
    img = cv2.imread(image_path)
    if img is None:
        raise FileNotFoundError(f"Image not found: {image_path}")
    
    orig_h, orig_w = img.shape[:2]
    
    # Scale and crop image to match screen dimensions
    if screen_width is not None and screen_height is not None:
        scale_w = screen_width / orig_w
        scale_h = screen_height / orig_h
        if screen_mode == "fill":
            scale = max(scale_w, scale_h)
        else:
            scale = min(scale_w, scale_h)
        new_w = int(orig_w * scale)
        new_h = int(orig_h * scale)
        img = cv2.resize(img, (new_w, new_h), interpolation=cv2.INTER_LANCZOS4)
        img = center_crop(img, screen_width, screen_height)
    
    # Calculate region coordinates from center position
    x = max(0, center_x - w // 2)
    y = max(0, center_y - h // 2)
    
    # Ensure region is within bounds
    x = max(0, min(x, img.shape[1] - w))
    y = max(0, min(y, img.shape[0] - h))
    w = max(1, min(w, img.shape[1] - x))
    h = max(1, min(h, img.shape[0] - y))
    
    region = img[y:y+h, x:x+w]
    if region.size == 0 or region.shape[0] == 0 or region.shape[1] == 0:
        return [0, 0, 0]
    
    # Reshape for k-means
    region = region.reshape((-1, 3))
    
    # Filter out very dark pixels (likely black borders)
    non_black = region[np.any(region > 10, axis=1)]
    if non_black.shape[0] == 0:
        non_black = region
    
    region = np.float32(non_black)
    if region.shape[0] < 3:
        return [int(x) for x in np.mean(region, axis=0)]
    
    # Use k-means to find dominant colors
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    K = min(3, region.shape[0])
    _, labels, centers = cv2.kmeans(region, K, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)
    counts = np.bincount(labels.flatten())
    dominant = centers[np.argmax(counts)]
    
    # Return RGB (reversed from BGR)
    return [int(x) for x in reversed(dominant)]

def main():
    parser = argparse.ArgumentParser(description="Sample dominant color at a specific position on wallpaper")
    parser.add_argument("image_path", help="Path to the wallpaper image")
    parser.add_argument("--center-x", type=int, required=True, help="Center X position of the widget")
    parser.add_argument("--center-y", type=int, required=True, help="Center Y position of the widget")
    parser.add_argument("--width", type=int, required=True, help="Widget width")
    parser.add_argument("--height", type=int, required=True, help="Widget height")
    parser.add_argument("--screen-width", type=int, default=1920, help="Screen width")
    parser.add_argument("--screen-height", type=int, default=1080, help="Screen height")
    parser.add_argument("--screen-mode", choices=["fill", "fit"], default="fill", help="Scaling mode")
    parser.add_argument("--verbose", action="store_true", help="Print verbose output to stderr")
    
    args = parser.parse_args()

    if args.verbose:
        print(f"Sampling color at center: ({args.center_x}, {args.center_y})", file=sys.stderr, flush=True)
        print(f"Widget dimensions: {args.width}x{args.height}", file=sys.stderr, flush=True)
    
    dominant_color = get_dominant_color(
        args.image_path,
        args.center_x,
        args.center_y,
        args.width,
        args.height,
        screen_width=args.screen_width,
        screen_height=args.screen_height,
        screen_mode=args.screen_mode
    )
    
    dominant_color_hex = '#{:02x}{:02x}{:02x}'.format(*dominant_color)
    
    if args.verbose:
        print(f"Dominant color: {dominant_color_hex}", file=sys.stderr, flush=True)
    
    result = {
        "dominant_color": dominant_color_hex,
        "center_x": args.center_x,
        "center_y": args.center_y
    }
    
    print(json.dumps(result))

if __name__ == "__main__":
    main()