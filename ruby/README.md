hello-cf
========

This simple application displays the request URL and the port number for the deployed application instance.  Displaying the port number supports a demonstration where, when deployed to cloud foundry and the application crashes, a new warden container will be created and the app will be redeployed and started therein.

the script for the demo is as follows:

# Clone this repo
# Deploy the app
Deploy two instances - this will allow you to show that in the short time that one instance is crashed, the other is still serving traffic.

```
cf push -m 128M -i 2 <your unique app name>
```
# Start tailing the logs
Recommend splitting your terminal and in one half start logging with:

```
cf logs <your unique app name>
```
# Access the app in your browser
Hit refresh a few times and point out the two different port numbers displayed. Have audience remember the two port numbers
# Kill one of the app instances
You can do this by accessing the url
```
http:\\<appurl>\broken
```
# Look at log and app instances
You'll have to be quick - do a 
```
cf apps
```
showing that one of the app instances is down.
Highlight stack trace in the logs and then run this again showing the app is restarted:
```
cf apps
```
# Refresh app in browser
Refresh until you show that one of the port numbers remains the same but one has been replaced with a new port number (warden container).

Reminder!!! Make sure you go back to the URL without the "/broken" suffix or you'll crash your app again.