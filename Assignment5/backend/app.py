from flask import Flask, request, render_template
import json

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello, from server!"

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    return render_template('index.html', data=data)
    
if __name__ == '__main__':  
    app.run(debug=True, port=5000,host='0.0.0.0')