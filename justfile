set dotenv-load


version := `cat version`

_default:
   @just --list

build:
    uvx markata clean
    uvx markata build
serve:
    uvx markata server

deploy:
    echo $AWS_ACCESS_KEY_ID
    # mcli cp markout/ minio-wayl-one/k8s-pages/aylawalker --recursive
    uvx --with awscli aws s3 sync markout/ s3://k8s-pages/aylawalker.com --profile minio

watch:
    uvx watchfiles "just build" pages

dev:
   uvx --with awscli aws s3 sync ./markout s3://k8s-pages/rwdev --delete

prod:
   uvx --with awscli aws s3 sync s3://k8s-pages/rwdev s3://k8s-pages/rw
