from flask import Flask, request, jsonify, render_template
from pymongo import MongoClient
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)

client = MongoClient(os.getenv('MONGO_URL'))
db = client['todo_db']
collection = db['todo_items']

@app.route('/')
def index():
    return "Hello from server"

@app.route('/submittodoitem', methods=['POST'])
def submit_todo_item():
    data = request.form.to_dict()
    print(data)
    if not data:
        return jsonify({'error': 'No form data provided'}), 400
    result = collection.insert_one(data)
    return '', 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)