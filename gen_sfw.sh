#!/data/data/com.termux/files/usr/bin/bash
cd ~/Kurumi.AI || { echo "❌ Gagal masuk folder Kurumi.AI" 
  exit 1
}
repo_url="https://raw.githubusercontent.com/ann468/Kurumi.AI/main"
sfw_file="sfw.txt"
# Buat sfw.txt kalau belum ada
touch "$sfw_file"
# Ambil semua nama file di folder assets/sfw
existing_files=$(ls assets/sfw)
# Step 1: Hapus link di sfw.txt yang file-nya udah gak ada
echo "🧹 Membersihkan link mati dari sfw.txt..." grep -F 
"$repo_url" "$sfw_file" | while read -r line; do
  filename=$(basename "$line") if ! echo "$existing_files" 
  | grep -qx "$filename"; then
    echo "❌ Menghapus: $filename (file tidak ditemukan)" 
    sed -i "\|$line|d" "$sfw_file"
  fi done
# Step 2: Tambah file baru kalau belum ada
echo "➕ Menambahkan file baru ke sfw.txt..." echo 
"$existing_files" | while read -r filename; do
  full_url="$repo_url/assets/sfw/$filename" if ! grep -qxF 
  "$full_url" "$sfw_file"; then
    echo "$full_url" >> "$sfw_file" echo "✅ Ditambahkan: 
    $filename"
  else echo "⚠️ Sudah ada: $filename" fi done echo "✅ 
sfw.txt selesai diperbarui dan dibersihkan!"
# Git auto push
git add "$sfw_file" git commit -m "🔄 Update sfw.txt 
(auto-cleaned & synced)" git push origin main
echo "🚀 Auto push ke GitHub berhasil!"

