### Gather Source Code
```
# pull down source
git clone https://github.com/yaledhlab/ensemble-at-yale

# install dependencies
npm install  
bundle install  
```

### Store environment variables
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

### Compile new assets
To compile new assets for production, one can run:
```
rvmsudo rake assets:precompile RAILS_ENV=production
```

### Start the dev server
```
# fire up the server
rails s {{-e production}}
```

### Start the producton server
```
rvmsudo rails s -p 80 -e production
```