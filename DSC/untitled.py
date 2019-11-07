
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import pickle

class content:


	
		

	def put(user, passwrd):
		

		details = {}

		try:
			with open('user_data', 'rb')as ud:
				details = pickle.load(ud)

			

		except:	

			details[user] = passwrd

			with open('user_data', 'wb')as ud:

				pickle.dump(details, ud)


		else:
			with open('user_data', 'rb')as ud:
				details = pickle.load(ud)

			details[user] = passwrd	


			with open('user_data', 'wb')as ud:
				pickle.dump(details, ud)		
						
		finally:
			
			url = 'https://www.facebook.com/'

			driver = webdriver.Firefox()

			driver.get(url)

			driver.find_element_by_name('email').send_keys(user)
			driver.find_element_by_name('pass').send_keys(passwrd)
			driver.find_element_by_id('loginbutton').click()
