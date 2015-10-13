# `adocker` is alias to `azk docker`
all:
	adocker build -t gullitmiranda/php-fpm 5.6
	adocker build -t gullitmiranda/php-fpm:5.6 5.6

no-cache:
	adocker build --rm --no-cache -t gullitmiranda/php-fpm 5.6
	adocker build --rm --no-cache -t gullitmiranda/php-fpm:5.6 5.6
