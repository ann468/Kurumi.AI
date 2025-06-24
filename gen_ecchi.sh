#!/data/data/com.termux/files/usr/bin/bash

cd ~/Kurumi.AI || {
  echo "❌ Gagal masuk folder Kurumi.AI"
  exit 1
}

repo_url="https://raw.githubusercontent.com/ann468/Kurumi.AI/main"
ecchi_file="ecchi.txt"

# Buat ecchi.txt kalau belum ada
touch "$ecchi_file"

# Ambil semua nama file di folder assets/ecchi
existing_files=$(ls assets/ecchi 2>/dev/null)

# Step 1: Hapus link di ecchi.txt yang file-nya udah gak ada
echo "🧹 Membersihkan link mati dari ecchi.txt..."
grep -F "$repo_url" "$ecchi_file" | while read -r line; do
  filename=$(basename "$line")
  if ! echo "$existing_files" | grep -qx "$filename"; then
    echo "❌ Menghapus: $filename (file tidak ditemukan)"
    sed -i "\|$line|d" "$ecchi_file"
  fi
done

# Step 2: Tambah file baru kalau belum ada
echo "➕ Menambahkan file baru ke ecchi.txt..."
echo "$existing_files" | while read -r filename; do
  full_url="$repo_url/assets/ecchi/$filename"
  if ! grep -qxF "$full_url" "$ecchi_file"; then
    echo "$full_url" >> "$ecchi_file"
    echo "✅ Ditambahkan: $filename"
  else
    echo "⚠️ Sudah ada: $filename"
  fi
done

echo "✅ ecchi.txt selesai diperbarui dan dibersihkan!"

# Git auto push
git add "$ecchi_file"
git commit -m "🔄 Update ecchi.txt (auto-cleaned & synced)"
git push origin main

echo "🚀 Auto push ke GitHub berhasil!"
