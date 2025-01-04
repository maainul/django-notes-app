from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Mainul!'
    
@app.route('/hi')
def hello_world():
    return 'Hi, Mainul!'

@app.route('/show')
def hello_world():
    return 'Show, Mainul!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
