#!/data/data/com.termux/files/usr/bin/bash

cd ~/Kurumi.AI || {
  echo "❌ Gagal masuk folder Kurumi.AI"
  exit 1
}

repo_url="https://raw.githubusercontent.com/ann468/Kurumi.AI/main"
tebura_file="tebura.txt"

# Buat tebura.txt kalau belum ada
touch "$tebura_file"

# Ambil semua nama file di folder assets/tebura
existing_files=$(ls assets/tebura 2>/dev/null)

# Step 1: Hapus link di tebura.txt yang file-nya udah gak ada
echo "🧹 Membersihkan link mati dari tebura.txt..."
grep -F "$repo_url" "$tebura_file" | while read -r line; do
  filename=$(basename "$line")
  if ! echo "$existing_files" | grep -qx "$filename"; then
    echo "❌ Menghapus: $filename (file tidak ditemukan)"
    sed -i "\|$line|d" "$tebura_file"
  fi
done

# Step 2: Tambah file baru kalau belum ada
echo "➕ Menambahkan file baru ke tebura.txt..."
echo "$existing_files" | while read -r filename; do
  full_url="$repo_url/assets/tebura/$filename"
  if ! grep -qxF "$full_url" "$tebura_file"; then
    echo "$full_url" >> "$tebura_file"
    echo "✅ Ditambahkan: $filename"
  else
    echo "⚠️ Sudah ada: $filename"
  fi
done

echo "✅ tebura.txt selesai diperbarui dan dibersihkan!"

# Git auto push
git add "$tebura_file"
git commit -m "🔄 Update tebura.txt (auto-cleaned & synced)"
git push origin main

echo "🚀 Auto push ke GitHub berhasil!"

