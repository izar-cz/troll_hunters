#!/bin/bash

# create a new svg file, embedding a given image, and applying a clip path to it

main() {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <image_file>"
		exit 1
	fi

	file="$1"
	file_svg="${file%.*}".svg

	if [ ! -f "$file" ]; then
		echo "Error: File '$file' not found."
		exit 1
	fi

	if [ -f "$file_svg" ]; then
		echo "Error: SVG file '$file_svg' already exists."
		exit 1
	fi

	create_wrapper "$file"
}


create_wrapper() {
	filename=$(basename -- "$file")

	width=$(identify -format "%w" "$file")
	height=$(identify -format "%h" "$file")
	cropped_height=$((height * 8 / 10))

	cat <<EOF > "$file_svg"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   width="${width}px"
   height="${height}px"
   viewBox="0 0 ${width} ${height}"
   version="1.1"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
>
<defs>
  <clipPath clipPathUnits="userSpaceOnUse" id="X"><rect
      width="${width}"
      height="${cropped_height}"
      x="0"
      y="0" />
  </clipPath>
</defs>
<g>
  <image
    width="${width}"
    height="${height}"
    preserveAspectRatio="none"
    xlink:href="$filename"
    x="0"
    y="0"
    clip-path="url(#X)" />
</g>
</svg>
EOF
}

main "$@"