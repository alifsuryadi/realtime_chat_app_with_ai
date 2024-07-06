from flask import Flask, request, jsonify
import os
from groq import Groq
from dotenv import load_dotenv
import csv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

# Konfigurasi API Key Groq dari environment variables
api_key = os.getenv("GROQ_API_KEY")

if not api_key:
    raise EnvironmentError("GROQ_API_KEY environment variable is not set.")

client = Groq(api_key=api_key)

# Membaca file CSV dan memuat data ke dalam dictionary
def load_minang_words(file_path):
    minang_words = {}
    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            indonesia = row['indonesia'].strip()
            minang = row['minang'].strip()
            minang_words[indonesia] = [word.strip() for word in minang.split(',')]
    return minang_words

# Format data menjadi string
def format_minang_words(minang_words):
    formatted_words = []
    for indonesia, minang_list in minang_words.items():
        minang_str = ', '.join(minang_list)
        formatted_words.append(f"{indonesia}: {minang_str}")
    return "\n".join(formatted_words)

minang_words = load_minang_words('minang_words.csv')
minang_knowledge = format_minang_words(minang_words)

# print(minang_knowledge)

@app.route("/generate", methods=["POST"])
def chat():
    user_message = request.json.get("prompt", "").lower()
    
    conversation = [
        {
            "role": "system",
            "content": f"""
                Kamu harus selalu menjawab menggunakan bahasa Minang, kamu adalah orang Minang dari Sumatera Barat (Sumatera Baraik).
                Kamu adalah "AmboAI". Walaupun pertanyaannya bahasa Indonesia dan bahasa inggris wajib Jawab semua pertanyaan tersebut menggunakan bahasa Minang.
                Gunakan huruf 'O' untuk mengganti kata 'A' di ujung kata yang ada huruf 'A' nya seperti 'kita' menjadi 'kito', 'percaya' menjadi 'pacayo'.
                Setiap bicara gunakan kata-kata yang sopan. Gunakan kata 'ondeh mandeh' sesekali ketika pertanyaannya terlalu komplek atau lucu.
                Berikut adalah beberapa kata dalam bahasa Minang yang dapat kamu gunakan:
                {minang_knowledge}
                
                important : Walaupun pertanyaannya bahasa Indonesia ataupun bahasa inggris wajib Jawab semua pertanyaan tersebut menggunakan bahasa Minang.
                
                knowledge : pakai 'AWOKWOKK', 'WKWK', 'AWOKWOK' kalau ado yang lawak
                
                
                knowledge: Tim Developer Chat Awak adolah:
                    1. Alif Suryadi sebagai Machine Learning Engineer jo Mobile Developer. Fakta Menarik: 1. Alif adolah urang nan indak manyabuik dirinyo SEPUH, padahal inyo alah sangaik SEPUH. 2. Alif sangaik barambisi untuak taruih baraja alat nan baru jo malah ingin mambueknyo pulo.
                    2. Damrul Afriadi sebagai Mobile Developer.
            """
        },
        {"role": "user", "content": user_message},
    ]

    response = client.chat.completions.create(
        messages=conversation,
        model="llama3-70b-8192",
        temperature=0.5,
        max_tokens=1024,
        top_p=1,
        stop=None,
        stream=False,
    )

    response_content = response.choices[0].message.content.strip()

    return jsonify({
        "response": response_content
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", 8080)))
