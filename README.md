## Requirements

This app requires Ruby 2.1.5 (available via rvm), a recent Node.js, and MongoDB.

## Quickstart
```
# pull down source
git clone https://github.com/yaledhlab/ensemble-at-yale

# install dependencies
npm install
bundle install

# build the db
rake project:load[ensemble-at-yale]
```

## Configure Ruby on Amazon Linux
```
# install rvm
curl -sSL https://get.rvm.io | bash -s stable --ruby

# initialize rvm
source /home/ec2-user/.rvm/scripts/rvm

# install required ruby version
rvm install ruby-2.1.5
```

## Install Node.js on Amazon Linux
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 6.10.0
node -v
```

## Install Mongo on Amazon Linux
```
sudo touch /etc/yum.repos.d/mongodb-org-3.4.repo
sudo vim /etc/yum.repos.d/mongodb-org-3.4.repo

# paste the following:
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

sudo yum install -y mongodb-org
sudo service mongod start
sudo chkconfig mongod on

# bind to all ips
sudo vim /etc/mongod.conf
# change bindIp address to 0.0.0.0 (Update security in AWS accordingly)
sudo service mongod restart
```

## Store environment variables
```
# the mongolab uri is the path to your mongo port
export MONGOLAB_URI="mongodb://YOURDOMAIN.YOUREXTENSION:27017/YOURDBNAME"

# the keys below are long secure strings (e.g. rake secret)
export ENSEMBLE_DEVISE_SECRET_KEY=YOUR_LONG_STRING
export SECRET_KEY_BASE_TOKEN=YOUR_LONG_STRING

# the following are authentication keys for social media platforms
export FACEBOOK_ID=YOUR_FACEBOOK_INTEGER
export FACEBOOK_SECRET=YOUR_FACEBOOK_STRING

export GOOGLE_ID=YOUR_GOOGLE_STRING
export GOOGLE_SECRET=YOUR_GOOGLE_STRING

export TWITTER_KEY=YOUR_TWITTER_STRING
export TWITTER_SECRET=YOUR_TWITTER_STRING
```

## Compile new assets
To compile new assets for production, one can run:
```
rvmsudo rake assets:precompile RAILS_ENV=production
```

## Start the dev server
```
# fire up the server
rails s {{-e production}}
```

## Start the producton server
```
rvmsudo rails s -p 80 -e production
```