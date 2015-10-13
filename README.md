[gullitmiranda/php-fpm](http://images.azk.io/#/php-fpm)
==================

Base docker image to run **PHP** applications in [`azk`](http://azk.io)

Versions (tags)
---

<versions>
- [`latest`, `5`, `5.6`, `5.6.14`](https://github.com/azukiapp/docker-php-fpm/blob/master/5.6/Dockerfile)
</versions>

Image content:
---

- Alpine
- Git
- Composer
- PHP

### Usage with `azk`

Example of using this image with [azk](http://azk.io):

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "my-app": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "gullitmiranda/php-fpm"},
    // Steps to execute before running instances
    provision: [
      // "composer install",
    ],
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    wait: {"retry": 20, "timeout": 1000},
    mounts: {
      '/azk/#{manifest.dir}': sync("."),
    },
    scalable: {"default": 1},
    http: {
      // my-app.dev.azk.io
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    ports: {
      // exports global variables
      http: "80/tcp",
    },
    envs: {
      // set instances variables
      APP_DIR: "/azk/#{manifest.dir}",
      //or use PUBLIC_DIR to lock your application
    },
  },
});
```

### Usage with `docker`

To create the image `gullitmiranda/php-fpm`, execute the following command on the docker-php-fpm folder:

```sh
# Build
docker build -t gullitmiranda/php-fpm 5.6/

# Run
docker run -d --rm --name my-app -p 80:80 -p 443:443 gullitmiranda/php-fpm

# Run with a mounted volume
docker run -d --rm --name my-app -p 80:80 -p 443:443 -v "$PWD":/var/www -w /var/www gullitmiranda/php-fpm
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs my-app
```

## License

Azuki Dockerfiles distributed under the [Apache License](https://github.com/azukiapp/dockerfiles/blob/master/LICENSE).
