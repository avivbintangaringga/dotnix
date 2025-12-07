#!/usr/bin/env python3

import os
os.environ["OPENCV_LOG_LEVEL"] = "SILENT"
import cv2
import numpy as np
import argparse
import json
import sys

def center_crop(img, target_w, target_h):
    h, w = img.shape[:2]
    if w == target_w and h == target_h:
        return img
    x1 = max(0, (w - target_w) // 2)
    y1 = max(0, (h - target_h) // 2)
    x2 = x1 + target_w
    y2 = y1 + target_h
    return img[y1:y2, x1:x2]

def find_least_busy_region(image_path, region_width=300, region_height=200, screen_width=None, screen_height=None, verbose=False, stride=2, screen_mode="fill", horizontal_padding=50, top_padding=50, bottom_padding=50):
    img = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    if img is None:
        raise FileNotFoundError(f"Image not found: {image_path}")
    orig_h, orig_w = img.shape
    scale = 1.0
    if screen_width is not None and screen_height is not None:
        scale_w = screen_width / orig_w
        scale_h = screen_height / orig_h
        if screen_mode == "fill":
            scale = max(scale_w, scale_h)
        else:
            scale = min(scale_w, scale_h)
        new_w = int(orig_w * scale)
        new_h = int(orig_h * scale)
        if verbose:
            print(f"Scaling image from {orig_w}x{orig_h} to {new_w}x{new_h} (scale: {scale:.3f}, mode: {screen_mode})", file=sys.stderr, flush=True)
        img = cv2.resize(img, (new_w, new_h), interpolation=cv2.INTER_LANCZOS4)
        img = center_crop(img, screen_width, screen_height)
        if verbose:
            print(f"Cropped image to {screen_width}x{screen_height}", file=sys.stderr, flush=True)
    else:
        if verbose:
            print(f"Using original image size: {orig_w}x{orig_h}", file=sys.stderr, flush=True)
    
    arr = img.astype(np.float64)
    h, w = arr.shape
    
    # Validate & adjust stride
    stride = max(1, int(stride) if stride else 1)
    
    if verbose:
        print(f"Image dimensions: {w}x{h}", file=sys.stderr, flush=True)
        print(f"Region dimensions: {region_width}x{region_height}", file=sys.stderr, flush=True)
        print(f"Padding: top={top_padding}, bottom={bottom_padding}, horizontal={horizontal_padding}", file=sys.stderr, flush=True)
    
    # Ensure region fits in image
    if region_width > w:
        if verbose:
            print(f"WARNING: Region width {region_width} > image width {w}, clamping to {w}", file=sys.stderr, flush=True)
        region_width = w
    if region_height > h:
        if verbose:
            print(f"WARNING: Region height {region_height} > image height {h}, clamping to {h}", file=sys.stderr, flush=True)
        region_height = h
    
    # Calculate the maximum range where we can place the region
    max_x = w - region_width
    max_y = h - region_height
    
    if verbose:
        print(f"Max valid top-left position: ({max_x}, {max_y})", file=sys.stderr, flush=True)
    
    # Apply padding constraints
    x_start = min(horizontal_padding, max_x)
    y_start = min(top_padding, max_y)
    x_end = max(0, max_x - horizontal_padding)
    y_end = max(0, max_y - bottom_padding)
    
    # Ensure start <= end
    if x_start > x_end:
        x_start = 0
        x_end = max_x
        if verbose:
            print(f"WARNING: Horizontal padding too large, ignoring", file=sys.stderr, flush=True)
    
    if y_start > y_end:
        y_start = 0
        y_end = max_y
        if verbose:
            print(f"WARNING: Vertical padding too large, ignoring", file=sys.stderr, flush=True)
    
    if verbose:
        print(f"Search range (top-left coords): x=[{x_start}, {x_end}], y=[{y_start}, {y_end}]", file=sys.stderr, flush=True)
        positions_to_check = ((x_end - x_start) // stride + 1) * ((y_end - y_start) // stride + 1)
        print(f"Will check approximately {positions_to_check} positions", file=sys.stderr, flush=True)
    
    # Use OpenCV's integral for fast computation
    integral = cv2.integral(arr, sdepth=cv2.CV_64F)[1:,1:]
    integral_sq = cv2.integral(arr**2, sdepth=cv2.CV_64F)[1:,1:]
    
    def region_sum(ii, x1, y1, x2, y2):
        total = ii[y2, x2]
        if x1 > 0:
            total -= ii[y2, x1-1]
        if y1 > 0:
            total -= ii[y1-1, x2]
        if x1 > 0 and y1 > 0:
            total += ii[y1-1, x1-1]
        return total
    
    min_var = None
    min_coords = (x_start, y_start)
    area = region_width * region_height
    
    checked = 0
    # Scan for least busy region
    for y in range(y_start, y_end + 1, stride):
        for x in range(x_start, x_end + 1, stride):
            x1, y1 = x, y
            x2, y2 = x + region_width - 1, y + region_height - 1
            
            if x2 >= w or y2 >= h:
                if verbose:
                    print(f"WARNING: Skipping out of bounds position ({x}, {y})", file=sys.stderr, flush=True)
                continue
            
            s = region_sum(integral, x1, y1, x2, y2)
            s2 = region_sum(integral_sq, x1, y1, x2, y2)
            mean = s / area
            var = (s2 / area) - (mean ** 2)
            
            checked += 1
            
            if (min_var is None) or (var < min_var):
                min_var = var
                min_coords = (x, y)
    
    if verbose:
        print(f"Checked {checked} positions", file=sys.stderr, flush=True)
        print(f"Best position (top-left): ({min_coords[0]}, {min_coords[1]})", file=sys.stderr, flush=True)
        print(f"Best position (bottom-right): ({min_coords[0] + region_width}, {min_coords[1] + region_height})", file=sys.stderr, flush=True)
        print(f"Minimum variance: {min_var}", file=sys.stderr, flush=True)
    
    return min_coords, min_var

def get_dominant_color(image_path, x, y, w, h, screen_width=None, screen_height=None, screen_mode="fill"):
    img = cv2.imread(image_path)
    if img is None:
        raise FileNotFoundError(f"Image not found: {image_path}")
    orig_h, orig_w = img.shape[:2]
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
    
    # Ensure region is within bounds
    x = max(0, x)
    y = max(0, y)
    w = max(1, min(w, img.shape[1] - x))
    h = max(1, min(h, img.shape[0] - y))
    
    region = img[y:y+h, x:x+w]
    if region.size == 0 or region.shape[0] == 0 or region.shape[1] == 0:
        return [0, 0, 0]
    
    region = region.reshape((-1, 3))
    non_black = region[np.any(region > 10, axis=1)]
    if non_black.shape[0] == 0:
        non_black = region
    
    region = np.float32(non_black)
    if region.shape[0] < 3:
        return [int(x) for x in np.mean(region, axis=0)]
    
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    K = min(3, region.shape[0])
    _, labels, centers = cv2.kmeans(region, K, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)
    counts = np.bincount(labels.flatten())
    dominant = centers[np.argmax(counts)]
    
    return [int(x) for x in reversed(dominant)]

def main():
    parser = argparse.ArgumentParser(description="Find least busy region in an image and output a JSON.")
    parser.add_argument("image_path", help="Path to the input image")
    parser.add_argument("--width", type=int, default=300, help="Region width")
    parser.add_argument("--height", type=int, default=200, help="Region height")
    parser.add_argument("--screen-width", type=int, default=1920, help="Screen width")
    parser.add_argument("--screen-height", type=int, default=1080, help="Screen height")
    parser.add_argument("--stride", type=int, default=10, help="Step size for sliding window")
    parser.add_argument("--screen-mode", choices=["fill", "fit"], default="fill", help="Scaling mode")
    parser.add_argument("--verbose", action="store_true", help="Print verbose output to stderr")
    parser.add_argument("--horizontal-padding", type=int, default=50, help="Horizontal padding from edges")
    parser.add_argument("--top-padding", type=int, default=50, help="Top padding from edge")
    parser.add_argument("--bottom-padding", type=int, default=50, help="Bottom padding from edge")
    args = parser.parse_args()

    coords, variance = find_least_busy_region(
        args.image_path,
        region_width=args.width,
        region_height=args.height,
        screen_width=args.screen_width,
        screen_height=args.screen_height,
        verbose=args.verbose,
        stride=args.stride,
        screen_mode=args.screen_mode,
        horizontal_padding=args.horizontal_padding,
        top_padding=args.top_padding,
        bottom_padding=args.bottom_padding
    )
    
    top_left_x, top_left_y = coords
    center_x = top_left_x + args.width // 2
    center_y = top_left_y + args.height // 2
    
    if args.verbose:
        print(f"Center position: ({center_x}, {center_y})", file=sys.stderr, flush=True)
    
    dominant_color = get_dominant_color(
        args.image_path, top_left_x, top_left_y, args.width, args.height,
        screen_width=args.screen_width, screen_height=args.screen_height, 
        screen_mode=args.screen_mode
    )
    dominant_color_hex = '#{:02x}{:02x}{:02x}'.format(*dominant_color)
    
    result = {
        "center_x": center_x,
        "center_y": center_y,
        "width": args.width,
        "height": args.height,
        "variance": variance,
        "dominant_color": dominant_color_hex
    }
    
    print(json.dumps(result))

if __name__ == "__main__":
    main()