from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_mainul():
    return 'Hello, Mainul!'

@app.route('/master')
def hello_master():
    return 'Hello, Mainul Master!'

@app.route('/hi')
def hi_mainul():
    return 'Hi, Mainul!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
