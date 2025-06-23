#!/data/data/com.termux/files/usr/bin/bash

cd ~/Kurumi.AI || {
  echo "❌ Gagal masuk folder Kurumi.AI"
  exit 1
}

repo_url="https://raw.githubusercontent.com/ann468/Kurumi.AI/main/assets/sfw"

# Generate sfw.txt di folder Kurumi.AI
ls assets/sfw > sfw.txt
sed -i "s|^|$repo_url/|" sfw.txt

echo "✅ sfw.txt berhasil dibuat!"

# Git auto push
git add sfw.txt
git commit -m "🔄 Update sfw.txt auto-generated"
git push origin main

echo "🚀 Auto push ke GitHub berhasil!"
