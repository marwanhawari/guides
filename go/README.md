# Go guide

## General
* Your GOPATH should be `~/go`
* Your GOROOT should be `/usr/local/go`
* You need to manually create the workspace structure in the GOPATH
```
~/go
├── bin
├── pkg
└── src
```
* Then create a new dir for your project in the `src` directory.
* Running `go mod init github.com/marwanhawari/myproj` creates a `go.mod` file
* Running `go mod install github.com/marwanhawari/myproj` compiles your `package main` go file in the `myproj` directory and installs the compiled binary in yout `~/go/bin` directory.

```
~/go
├── bin
│   └── projfile
├── pkg
└── src
    └── myproj
        ├── go.mod
        └── projfile.go
```

* Go has built in testing capabilities.
  * Test files should end in `_test.go`
  * Run tests with `go test`

* Manually run formatting with `go fmt`

## Go packages

<p align="center">
  <img src="https://github.com/marwanhawari/guides/blob/main/images/go-imports.png" alt="go-imports" width="700"/>
</p>
source: https://stackoverflow.com/questions/24790175/when-is-the-init-function-run
