# Publish! Crossplattform Publishing
Publish your data on all channels!

## Requirements
* apt-get npm phantomjs git mongo imagemagick graphicsmagick zip (or use Homebrew on macosx)

## Installation
* git clone https://github.com/dni/publish-.git
* cd publish-
* npm install -g bower jake
* npm install
* bower install
* git clone https://github.com/bakerframework/baker.git baker-master
* cd bower_components/tinymce && jake && cd ../..
* TEMP!! should be fixed with gitgnore >>
* mkdir cache && mkdir cache/publish-baker && mkdir public/files && mkdir public/books && mkdir components/magazine/images
## Starting the App
* make sure mongod process is running, start it with mongod
* node app