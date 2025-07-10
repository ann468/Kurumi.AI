#!/data/data/com.termux/files/usr/bin/bash

cd ~/Kurumi.AI/assets || {
  echo "❌ Gagal masuk folder Kurumi.AI/assets"
  exit 1
}

echo "🧹 Step 1: Bersihkan ecchi/ dari file yang juga ada di sfw/"
for file in ecchi/*; do
  name=$(basename "$file")
  if [ -f "sfw/$name" ]; then
    echo "❌ ecchi/$name duplikat, menghapus..."
    rm "ecchi/$name"
  fi
done

echo "🧹 Step 2: Bersihkan sfw/ dari file yang juga ada di ecchi/"
for file in sfw/*; do
  name=$(basename "$file")
  if [ -f "ecchi/$name" ]; then
    echo "❌ sfw/$name duplikat, menghapus..."
    rm "sfw/$name"
  fi
done

echo "✅ Selesai! Duplikat dibersihin per-folder secara terpisah."
