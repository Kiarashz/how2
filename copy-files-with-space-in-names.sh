find /home/kiarash/Photos/ -type f -print0 | while IFS= read -r -d '' file; do cp "$file" ~/Public/$((var++)).$(printf '%s\n' "${file##*.}"); done
