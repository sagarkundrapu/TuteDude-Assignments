from flask import Flask, render_template
import json

app = Flask(__name__)

@app.route('/api')
def api():
    with open('names.txt') as f:
        data = f.read()
    return data

if __name__ == '__main__':  
    app.run(debug=True,host='0.0.0.0',port=5000)