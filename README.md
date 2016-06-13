### Gather Source Code
<pre><code># pull down source repository and build placeholder project 
git clone https://github.com/zooniverse/scribeAPI.git  

# install dependencies
npm install  
bundle install  

# create a placeholder project using available resources
rm -r project/emingrant/subjects   
mv project/whale_tales/subjects project/emigrant/  
rake project:load[emigrant]  

# update classification.rb to use Mongoid 5.x API
# by replacing find_and_modify calls to find_one_and_update  

# update config/mongoid.yml to follow Mongoid 5.x config syntax
# For more on the changes made in Mongoid 5.x, see: https://docs.mongodb.com/ecosystem/tutorial/mongoid-upgrade/  

# fire up the server
rails s {{-e production}}</code></pre>

### Configure MongoDB
<pre><code># access admin db  
mongo aws-us-east-1-portal.17.dblayer.com:10331/admin -u {{username}} -p {{user-password}}

# access ensemble db
mongo aws-us-east-1-portal.17.dblayer.com:10331/ensembleDb -u {{username}} -p {{user-password}}

# check current db name  
db.getName()  

# check current db user
db.runCommand({connectionStatus : 1})  

# create users at https://app.compose.io, then grant user privileges as follows:
https://app.compose.io  
db.grantRolesToUser("ded34", [{role: "read", db: "ensembleDb"}])  
db.grantRolesToUser("ded34", [{role: "readWrite", db: "ensembleDb"}])  
db.grantRolesToUser("ded34", [{role: "dbAdmin", db: "ensembleDb"}])  
db.grantRolesToUser("ded34", [{role: "dbOwner", db: "ensembleDb"}])  
db.grantRolesToUser("ded34", [{role: "userAdmin", db: "ensembleDb"}])</code></pre>

### Create Heroku instance
<pre><code># create heroku instance  
heroku create ensemble-at-yale  
  
# set environment variables
heroku config:set MONGOLAB_URI={{your mongolab uri}}  
heroku config:set SECRET_KEY_BASE_TOKEN={{your secret key base token}}  
heroku config:set ENSEMBLE_DEVISE_SECRET_KEY={{your devise secret key}}
heroku config:set GOOGLE_ID={{your google id}}
heroku config:set GOOGLE_SECRET={{your google secret}} 
   
# use multi buildpacks
heroku buildpacks:set https://github.com/duhaime/heroku-buildpack-multi.git  

# push application to heroku
git push heroku master  
</code></pre>
