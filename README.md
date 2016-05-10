<html>
<body>
<p><b>PCF DEMOS</b></p>
<p><b>Setup Instructions</b></p>
<p>To run these demos, you must have a Pivotal Cloud Foundry install available, with MySQL, RabbitMQ, and Redis installed.</p>
<p>First you need to login to your environment from the CLI, for example </p>
<ul>
  <li>cf login -a api.run.pivotal.io  (or api.system.IP.xip.io when using xip.io, be sure to include the --skip-ssl-validation flag)</li>
  <li>Enter userid when prompted   (can use "admin" for new installs)</li>
  <li>Enter password when prompted    (if using "admin" for userid, get password from Elastic Runtime credential page under UAA)</li>
  <li>Select space when prompted</li>
</ul>
<p>To install the demos, just 'cd' into each individual demo folder and run 'cf push'.  To run the application, find the application in the space you pushed
  it to in Apps Manager, and click on its URL.
<p><b>Demos</b></p>
<ol>
<li>PHP Application</li>
<p>Simple application, when you click on the app URL, you should just see a page
saying 'Hello world version 1'.  This is the simplest app, and a good one to start with. </p>
<li>Ruby Application</li>
<p>Simple application, when you click on the app URL, you should just see a page
saying 'Hello World from port 61661!!'.  This app gets the container port the app is listening on and displays it. </p>
<li>Java Spring Music Application</li>
<p>This is a Java app that displays a collection of albums.  It defaults to using an in-memory database.  To demo this app, just push the app as usual and bring up
  the URL in a browser.  Click on the "i" icon in the upper right corner of the app, it should say 'cloud, in-memory' next to 'profiles'.<p>
  To use a MySQL database, just create a MySQL service instance (ex. cf create-service cleardb spark mydb), then bind it to your app
  (ex. cf bind-service spring-music mydb) and restage the app (ex. cf restage spring-music).  Once the app is done staging and restarted, refresh the browser
  and click the "i" icon again.  It should now say 'cloud,mysql,mysql-cloud' next to 'profiles', and 'mydb' next to 'services'.  </p>
<li>Java Environment Demo Application</li>
<p>This is a Java app that displays environment variables, and demonstrates application instance recovery.
  The manifest.yml file specifies 2 instances, so when you run the app, hit the
green 'Refresh' button a few times until you see the values for the application port and instance ID change.  Then right-click on the red 'Kill' button, and
select the option to run in a new tab.  The new tab should display a '502 Bad Gateway' error because one app instance was killed.  <p>
Now go back to your
first tab and hit 'Refresh' a few more times, you should notice the port and instance ID remain constant.  You can go back to apps manager and select
the app, and you should see a second instance starting, along with a recent 'App Crashed' event.  Then go back to the app and refresh a few more times, and
you should see the port and instance ID alternate again once the second app instance has been automatically restarted.</p>
<li>RabbitMQ Application</li>
<p>This is a NodeJS app that uses Rabbit MQ to store and retrieve messages.  This app requires you to create the rabbitmq service instance before you push
the app.  So go ahead and create the service first (ex. cf create-service cloudamqp lemur rabbitmq), then push the app.  You don't need to bind it via
the CLI because the binding is specified in the manifest.yml file.  <p>
To run the app, bring it up in a browser, and enter a few values in the input
field, clicking the submit button each time.  The values you enter are sent to rabbitmq, then retrieved from rabbitmq and displayed.</p>
<li>Redis Application</li>
<p>This is a Java app that demonstrates using Redis for session state.  You push the app as usual, then bring it up in a browser.  Enter a name and
description, then click Submit.  You should see the values you entered, which are being stored in the app instance session, in-memory.  Click refresh a few
times to demonstrate the value is stored in-memory.  Then right-click the 'Stop! link, and run it in a new tab.  You should get an error in that tab since
the application instance died.  <p>
You can go back to your original tab, and hit refresh.  This page will also display an error, since we had only one
application instance, and we just killed it.  Keep refreshing the page until the application instance is automatically recovered.  Once the app comes back,
note that the values you entered are gone - because the session was stored in-memory in the application instance.  Now go to the CLI and create the redis service
(ex. cf create-service rediscloud 30mb session-replication), and bind it to the app (ex. cf bind-service redis-app session-replication), and restage
the app (ex. cf restage redis-app).  Once the app is staged and running, bring it up in the browser and repeat the steps above to create name and description
and refresh the page.  The session data is now stored in redis, so it will survive after the application instance is killed.  <p>
To demonstrate this, go ahead and kill
the instance, wait for it to be automatically recovered, and refresh the page again.  You should see the name/description you entered.  Note that no code changes
were needed.  The Java buildpack saw the 'sesssion-replication' service was bound to the app, and auto-magically reconfigured the session to use redis.  You must
use the exact service instance name 'session-replication' for this to work, since that is how the  buildpack detects the redis service.</p>
</ol>
</body>
</html>
