# pico_docker_image

Builds a container image every month to use in other actions to not build the container on every push, but still keep it updated. 
 
Use with
```yaml
jobs:
    build-deploy:
        runs-on: ubuntu-latest
        name: Build and deploy
        container: ghcr.io/arendjan/pico_docker_image:main
        steps:
          - uses: actions/checkout@main
          - name: build
            run: |
              cmake -B build
              cmake --build build/
```

