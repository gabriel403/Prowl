[![Build Status](https://travis-ci.org/gabriel403/Prowl.svg?branch=2.0)](https://travis-ci.org/gabriel403/Prowl)

Prowl
===
Prowl is a rails/resque based deployment system written as a RESTful api.  
This api is for managing organisations/apps/environments and deployments within Prowl.  
The 2.0 branch holds the API code and the gh-pages branch holds a js/html based web-ui to interact with the API

Dev Environment
===
Prowl comes with a vagrant setup available for it. Git clone the 2.0 and gh-pages branches as seperate clones in the same folder, named api and app,  
cd into the api directory and run `vagrant up`.  

This will download a basebox for Prowl and bring the dev environment up.  
You can then `vagrant ssh` and start running the servers for the api and app.  
`cd /code/prowl/api` and `rails s`  
the app is simple html and js , so run it however you want, I use the python server  
`cd /code/prowl/app` and `python -m SimpleHTTPServer`  

You can then visit `http://app.prowl.dev:8000/` with the api available on `api.prowl.dev:3000`  
Mailcatcher is available as well, on `http://prowl.dev:1080/`  
