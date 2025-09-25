from flask import Flask, render_template
import json

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api')
def api():
    with open('data.json') as f:
        data = f.read()
        data = json.loads(data)
    return data

if __name__ == '__main__':  
    app.run(debug=True)