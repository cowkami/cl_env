# Common Lisp Envinronment

## Build the image
docker build -t clenv .

## Start a container
docker run --rm --name clenv_test -v work:/work -itd clenv

## Enter the container
docker exec -it clenv_test zsh
