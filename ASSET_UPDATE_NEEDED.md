# PNG Assets Requiring Update

The following PNG image assets still contain the old Spliit branding and green color scheme. They should be regenerated with the new Gliift gift theme (magenta/purple/pink colors with gift box iconography).

## Files to Update

### Logo Files
- `public/logo-with-text.png` - Main logo with "Gliift" text
  - Should use the new gift box icon from logo.svg
  - Text should say "Gliift" instead of "Spliit"
  - Colors: magenta (#c026d3) primary

### Icon Files
All icon PNGs should be regenerated from the new icon.svg:
- `public/android-chrome-192x192.png`
- `public/android-chrome-512x512.png`
- `public/logo/48x48.png`
- `public/logo/64x64.png`
- `public/logo/128x128.png`
- `public/logo/144x144.png`
- `public/logo/192x192.png`
- `public/logo/256x256.png`
- `public/logo/512x512.png`
- `public/logo/512x512-maskable.png`
- `src/app/apple-icon.png`

### Banner
- `public/banner.png` - Social media preview image
  - Should feature gift theme
  - Include "Gliift" branding
  - Use new color palette

## Updated Assets (SVG)

These have been successfully updated:
- ✅ `public/logo.svg` - New gift box icon
- ✅ `src/app/icon.svg` - New gift box icon

## How to Regenerate

### Option 1: Using Design Tools
1. Open the SVG files in Figma, Adobe Illustrator, or Inkscape
2. Export as PNG at required dimensions
3. Replace existing PNG files

### Option 2: Using Command Line (imagemagick)
```bash
# Install imagemagick if needed
# Convert SVG to PNG at various sizes
convert -background none -density 300 public/logo.svg -resize 192x192 public/android-chrome-192x192.png
convert -background none -density 300 public/logo.svg -resize 512x512 public/android-chrome-512x512.png
# Repeat for all sizes needed
```

### Option 3: Using Online Tools
- Upload SVG to https://cloudconvert.com/svg-to-png
- Convert at required dimensions
- Download and replace files

## New Color Palette Reference

Use these colors when regenerating assets:

**Light Mode:**
- Primary: `#c026d3` (magenta)
- Secondary: `#f5d0e9` (light pink)
- Accent: `#fde68a` (warm gold)

**Dark Mode:**
- Primary: `#e879f9` (bright pink)
- Background: `#1a0e1f` (deep purple)
- Accent: `#fcd34d` (gold)

## Current Status

- ✅ Color palette updated in CSS
- ✅ SVG logos updated
- ⏳ PNG assets need regeneration
- ⏳ Favicon may need update

**Note**: The app will function correctly with old PNG assets, but visual consistency will be improved once they're regenerated.
