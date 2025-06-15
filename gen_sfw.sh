repo_url="https://raw.githubusercontent.com/ann468/Kurumi.AI/main/assets/sfw"

ls assets/sfw > sfw.txt

sed -i "s|^|$repo_url/|" sfw.txt

echo "✅ Berhasil generate sfw.txt dengan full URL!"
