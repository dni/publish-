# Publish! Crossplattform Publishing
Publish your data on all channels!

## Software Requirements

```js
apt-get install nodejs npm coffeescript phantomjs git mongodb imagemagick graphicsmagick zip
```
On Mac OSX use Homebrew
```js
brew install nodejs npm coffeescript phantomjs git mongodb imagemagick graphicsmagick zip
```
Install node.js modules
```js
npm install -g bower grunt-cli
```
Make sure mongod process is running, start it with mongod

## Installation
```js
git clone https://github.com/dni/publish-.git
cd publish- && npm install
```


## Enjoy the App

Before you visit the Frontend you should

* create a new admin user
* go through the settings
* customize your staticblocks
* add some article

##### Frontend

http://localhost:1666/

##### Backend

http://localhost:1666/admin/ <br>
**User:** admin <br>
**Password:** password

## Grunt Tasks
* Restart the app daemon, mostly afterwards changes on the serverside script
grunt restart
* install the publish app
grunt install
* clean the project, drop the database and reinstall
grunt reinstall
* build all components use build:backend, build:frontend to build single components
grunt build
* reset the whole project, use npm install afterwards
grunt reset
* view all available tasks
grunt --help


## Support
The project was supported by aws - austria wirtschaftsservice
<a href="http://www.awsg.at/">http://www.awsg.at/</a>
