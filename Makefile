# `adocker` is alias to `azk docker`
all:
	adocker build -t azukiapp/php-fpm .

no-cache:
	adocker build --rm --no-cache -t azukiapp/php-fpm .
