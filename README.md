# Publish! Crossplattform Publishing
Publish your data on all channels!

## Software Requirements

```js
apt-get install nodejs phantomjs git mongodb imagemagick graphicsmagick zip
```
On Mac OSX use Homebrew
```js
brew install nodejs phantomjs git mongodb imagemagick graphicsmagick zip
```
Install node.js modules
```js
npm install -g bower grunt jake
```
Make sure mongod process is running, start it with mongod

## Installation
```js
git clone https://github.com/dni/publish-.git
cd publish- && jake && grunt install
```

## Starting the App
```js
grunt start
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

## Starting the App for Development
```js
grunt dev
```


