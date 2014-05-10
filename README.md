[![Build Status](https://travis-ci.org/Prowl/api.svg?branch=master)](https://travis-ci.org/Prowl/api)

Prowl - api
===
Prowl is a rails/resque based deployment system written as a RESTful api.  
This api is for managing organisations/apps/environments and deployments within prowl.  

Dev Environment
===
Prowl comes with a vagrant setup available for it. Git clone the api and app into the same folder, cd into the api directory and run `vagrant up`.  
This will download a basebox for prowl and bring the dev environment up.  
You can then `vagrant ssh` and start running the servers for the api and app.  
`cd /code/prowl/api` and `rails s`  
the app is simple html and js , so run it however you want, I use the python server  
`cd /code/prowl/app` and `python -m SimpleHTTPServer`  

You can then visit `http://app.prowl.dev:8000/` with the api available on `api.prowl.dev:3000`  
Mailcatcher is available as well, on `http://prowl.dev:1080/`  
