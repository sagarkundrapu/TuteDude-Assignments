from flask import Flask, render_template, request, redirect
from pymongo.mongo_client import MongoClient
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

MONGO_URI = os.getenv("MONGO_URI")

client = MongoClient("mongodb+srv://sagar:sagar1636@cluster0.qnwplx3.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")  # // fake query to display error message
# client = MongoClient(MONGO_URI)

db = client.clients_data
collection = db.clients_collection


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit():
    try:
        client.admin.command('ping')
        data = request.form.to_dict()
        collection.insert_one(data)
        return redirect('/success')
    except Exception as e:
        return render_template('index.html', message="Unable to connect Atlas server", error=f"Error: {str(e)}")

@app.route('/success')
def success():
    return render_template('success.html')

if __name__ == '__main__':  
    app.run(debug=True)
