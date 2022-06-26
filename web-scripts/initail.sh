#! /bin/bash

# arrays
declare -a arr-dir=("utilities" "base" "components" "layouts" "pages" "themes" "vendor") && declare -a arr-file=("utilities/_variables.sass" "utilities/_mixins.sass" "base/_reset.sass" "base/_typography.sass")

#  read variables
read -p "Enter project name: " name
read -p "Enter origin githupe rep link: " origin

# create repo
git init && touch README.md && echo $name >> README.md && git add . && git commit -m "Initial commit" && git remote add origin $origin && git push -u origin master

# create sass files
mkdir src && mkdir sass && cd sass
for dir in "${arr-dir[@]}"
do
	mkdir $dir
done
for file in "${arr-file[@]}"
do
	touch $file
done
touch main.sass
echo "@import 'abstracts/variables';
@import 'abstracts/mixins';


@import 'base/reset';
@import 'base/typography';" >> main.sass

cd ../

# push sass files to repo
git add . && git commit -m "create sass 7-1 structure" && git push

# create pug files
touch index.pug

echo "html(lang="en")
	head
		meta(charset='UTF-8')
		meta(http-equiv='X-UA-Compatible', content='IE=edge')
		meta(name='viewport', content='width=device-width, initial-scale=1.0')
		//- add font awsome library
		link(rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css')
		//- add main css file
        link(rel='stylesheet', href='./style/style.css')
        //- add normalizer
        link(rel='stylesheet, href='./compenents/normalize.css')
        //- add bootstrap 5
        link(href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet')
        script(src='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js')
		//- add js files
		script(src='js/main.js')
		title $name
	body " >> index.pug
	
#push pug files to repo
git add . && git commit -m "create pug file" && git push

# create js files
mkdir js && touch js/main.js

# create gulpfile.js
touch gulpfile.js

echo "const	gulp = require('gulp'),
		sass = require('gulp-sass')(require('sass')),
		pug = require('gulp-pug'),
		prefixer = require('gulp-autoprefixer');

// start pug task
var pugFiles = ['index.pug'],
	pugDest = '../dist';
var pugFunction =  function () {
	return gulp.src(pugFiles)
		.pipe(pug({pretty: true}))
		.pipe(gulp.dest(pugDest));
};

gulp.task('pug', pugFunction);

// start sass task and auto-prefix
var sassFiles = ['./style/sass/main.sass', './style/sass/**/*.sass'],
	sassDest = '../dist/css';
var sassFunction = function () {
	return gulp.src(sassFiles)
		.pipe(sass({outputStyle: 'compressed'}))
		.pipe(prefixer('last 2 versions'))
		.pipe(gulp.dest(sassDest));
};

gulp.task('sass', sassFunction);

// start watch task

gulp.task('init', function () {
	gulp.watch(pugFiles, pugFunction);
	gulp.watch(sassFiles, sassFunction)
});" >> gulpfile.js

# push gulpfile.js to repo
git add . && git commit -m "create gulpfile.js" && git push
