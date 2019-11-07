import pickle

try :
	with open('user_data', 'rb') as ud:
		user_data = pickle.load(ud)
		

except EOFError:
	print('No logins found')

else:
	


	for login_id, passwrd in user_data.items():
		print(login_id, ' : ', passwrd)		