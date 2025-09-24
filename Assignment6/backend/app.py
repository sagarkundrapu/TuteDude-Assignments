from flask import Flask, render_template
import json
import os

app = Flask(__name__)

@app.route('/api')
def api():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    file_path = os.path.join(base_dir, 'names.txt')
    with open(file_path) as f:
        data = f.read()
    return data

if __name__ == '__main__':  
    app.run(debug=True,host='0.0.0.0',port=5000)