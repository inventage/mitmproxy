#Quick Start

The following script does the setup to run `mitmweb` behind a `Nginx` reverse proxy.

```bash
    ./devenv.sh
```

* if the script is not run from a virtual environment, a virtual environment is started
* all the required dependnecies are installed.
* `mitmweb` is installed into the virtual environment.
* a Nginx reverse proxy is started on `localhost:8080` that proxies all requests to `/foo` to the `mitmweb` UI
* `mitmweb` is started, where the proxy is running on port `8084` and the UI on port `8081`
* on shutdown, everything is cleaned up

