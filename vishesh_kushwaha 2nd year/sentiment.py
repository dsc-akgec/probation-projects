
#importing  required modules
import matplotlib.pyplot as plt
from textblob import TextBlob
import tweepy

#for calculating the percent of something
def percent(num,denom):
    return 100*float(num)/float(denom)
    
    
#apikey,apikeysecret,consumertoken,consumertokensecret not provived due to security reason
apikey=""
apisecret=""
token=""
tokensecret=""
auth=tweepy.OAuthHandler(consumer_key=apikey,consumer_secret=apisecret)
auth.set_access_token(token,tokensecret)
api=tweepy.API(auth)

#search about the keyword for which it is to be analyzed
search=input("Enter your search term:")
n=int(input("Enter the no. of tweets to be analysed:"))
tweets=tweepy.Cursor(api.search,q=search).items(n)
positive=0
negative=0
neutral=0
polarity=0

#calculaing the positive,negative ,neutral  tweets
for tweet in tweets:
    analyse=TextBlob(tweet.text)
    polarity+=analyse.sentiment.polarity
    
    if(analyse.sentiment.polarity==0):
        neutral+=1
    elif(analyse.sentiment.polarity>0.00):
        positive+=1
    elif(analyse.sentiment.polarity<0.00):
        negative+=1
        
#to calculate the percent of positive,negative,neutral comments to present it on pie chart
positive=percent(positive,n)
negative=percent(negative,n)
neutral=percent(neutral,n)

print("The reponse of tweets is shown in following pie-chart")

#working on pie chart to represent the reaction of tweets grahically
labels=['positve','negative','neutral']
sizes=[neutral,negative,positive]
colours=['green','red','yellow']
plt.pie(sizes,labels=labels,colors=colours)
plt.tight_layout()
plt.axis('equal')
plt.show()

