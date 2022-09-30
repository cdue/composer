# composer-soap
Docker image base on composer/composer (alpine) and containing soap and xdebug extensions

## Build Docker image

### Simple build

Run:
```sh
docker build -t cdue/composer:latest .
```

### Build for multiple plaforms

If not already done, you might create a new docker buildx builder using the following command:
```sh
docker buildx create --name mybuilder
```
(If you don't remember if you already created one, you can check it using: `docker buildx ls`)

and tell buildx to use this new builder:
```sh
docker buildx use mybuilder
```

you can then inspect buildx to see which platforms can be built:
```sh
docker buildx inspect --bootstrap
```

then eventually, run the following command to build (and push) it for given platforms:
```sh
docker buildx build --push --tag cdue/composer:2.0.7 --platform=linux/arm64,linux/amd64 .
```

## Push Docker image

Simply use the `--push` option with the previous "build" command (it assume you already have `docker login` and have granted access to the tag registry you're pointing to).

Or run :
```sh
docker image push cdue/composer:latest
```
