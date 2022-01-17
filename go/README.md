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
  * Actually, now you don't need to create your project in the `src` directory. You can create your go project anywhere on your file system.
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
  * Testing code generally lives in the same package which it tests. For example if you want to test code from `package main`, then the corresponding `_test.go` file should also use `package main`.
  * Calculate coverage and output a `coverage.out` file with `go test -v --coverprofile coverage.out`.
    * Read coverage in terminal using `go tool cover --func coverage.out`
    * Read html report using `go tool cover --html coverage.out`

* Manually run formatting with `go fmt`
* Go passes-by-value the following types: `[string, int, bool, float, array, struct]` for functions - need to explicitly used `*` character in function declarations to pass by reference.
  * However, types `[slice, map, function]` are passed-by-reference (don't need to use `*` in function signature or use `&/*` on variables.
  * Can create `value-receiver` _or_ `pointer-receiver` methods for `structs`. You don't need to use `*` to de-reference the struct variable inside the method - go does this automatically for you. You _do_ need to use the `*` to set the struct pointer type in the function signature.

### Structs w/in structs patterns:
```go
// "Base" struct
type Animal struct {
	Name string
	Age  int
}

func (self Animal) Speak() {
	fmt.Println("My name is", self.Name)
}
```
* `is-a` relationships (similar to **inheritance** in OOP languages):

```go
type Dog struct {
	Animal
	Breed string
}

dog := Dog{Animal: Animal{"Coco", 5}, Breed: "Shiba"}
fmt.Println(dog.Name, dog.Age, dog.Breed) // Coco 5 Shiba
dog.Speak()                               // "My name is Coco"

```

* `has-a` relationships (similar to **composition** in OOP languages):

```go
type Cat struct {
	Animal Animal
	Breed  string
}

cat := Cat{Animal: Animal{"Meow", 2}, Breed: "Siamese"}
fmt.Println(cat.Animal.Name, cat.Animal.Age, cat.Breed) // Meow 2 Siamese
cat.Animal.Speak()                                      // "My name is Meow"
```

### Interfaces
* Here `Animal` is a common interface for the `Dog` and `Cat` types. For a struct type to also be considered part of an interface type, the struct type must implement _all_ of the interfaces methods (but not limited to just the interface methods). So here, `Dog` and `Cat` types are also automatically `Animal` types because `Dog` and `Cat` both implement the `Speak()` method specified in the `Animal` interface.
* The interface is useful because `Dog.Speak()` and `Cat.Speak()` actually have different behaviors, but using the `Animal` interface we are able to provide a common _interface_ for the `Speak()` method that doesn't care about the individual implementations for each `Speak()` method. This is similar to **polymorphism** in OOP.

```go

type Dog struct {
	Name string
	Age  int
}

func (self Dog) Speak() string {
	return "Woof!"
}

type Cat struct {
	Name string
	Age  int
}

func (self Cat) Speak() string {
	return "Meow!"
}

type Animal interface {
	Speak() string
}

func AnimalSpeak(animal Animal) {
	fmt.Println(animal.Speak())
}

func main () {

	dog := Dog{"Coco", 5}
	cat := Cat{"Kitty", 2}

	animals := []Animal{dog, cat}
	for _, animal := range animals {
		AnimalSpeak(animal) // "Woof!", "Meow!"
	}

}
```

### Zero values
* The "0"/uninitialized values for types:
```go

type Types struct {
	String  string // ""
	Bool    bool // false
	Int     int // 0
	Float   float64 // 0
	Complex complex128 // (0+0i)
	Array   [2]int // [0 0]
	Slice   []int // []
	Map     map[int]int // map[]
	Pointer *int // <nil>
}
```




## Go packages

* If you are creating a non-executable go package (i.e. a go library), then you won't need a `package main` or `main()` function.
* Installing executables with 'go get' in module mode is deprecated.
* `go get` should still be used for updating dependencies, but not for installing a command.
* Starting in go 1.18, `go get` will only update go.mod for the current module and download source code needed to build packages - but it will not build or install the packages.
* Use `go install` to build and install commands.
  * To install an executable in the context of the current module, use `go install` without a version suffix: `go install github.com/marwanhawari/gopkg`
  * To install an executable while ignoring the current module, use `go install` with a version suffix: `go install github.com/marwanhawari/gopkg@latest`
    * With a version suffix, `go install` does not read or update the `go.mod` file in the current directory or a parent directory
    * `go install` without a version suffix won't work outside of a dir containing a `go.mod` file
    * If the `package main` of the module you want to download is not in the root directory, you have to point `go install` to that specific path or it won't compile/install the binary (it will only download the source code into `~/go/pkg/mod/github.com/marwanhawari/gopkg@v0.0.1`. For example, if the executable is in `github.com/marwanhawari/gopkg/cmd/gopkgcli`, then you need to do `go install github.com/marwanhawari/gopkg/cmd/gopkgcli`.
    * `go install` will build, compile, and add the executable to the `~/go/bin` automatically. It will also retain the entire source code (not just the `package main` code) in the `~/go/pkg/mod/github.com/marwanhawari/gopkg@v0.0.1` directory (assuming v0.0.1 is the latest).
      * `go get` will only download the source code (to the same `~/go/pkg/mod/github.com/marwanhawari/gopkg@v0.0.1`), and it will _not_ compile or install any executable.
* If your project is structured with multiple executables that will compiled into separated binaries, you can install them all with the `...` syntax: `go install github.com/marwanhawari/myproj/cmd/...@latest` or even just `go install github.com/marwanhawari/myproj/...@latest`
```
~/myproj
├── cmd
│   ├── executable1
│   │   └── main.go
│   └── executable2
│       └── main.go
├── go.mod
├── go.sum
├── mylib
│   └── projfuncC.go
├── projfuncA.go
├── projfuncB.go
└── vendor
```
* This will install `executable1` and `executable2` bianries in `~/go/bin`.
* The `executable1/main.go` and `executable2/main.go` must be `package main` (but they don't need to be named `main.go`, they can be named anything)
* The `projfuncA.go`, `projfuncB.go`, and `projfuncC.go` are used by `executable1` and `executable2`, but they can't be directly called from the command line. Their functions can be imported though (both within the project in `executable1/main.go` and `exectuable2/main.go` as well as in other projects where `myproj` was installed as a dependency.
* `projfuncA.go`, `projfuncB.go`, and `projfuncC.go` don't need to be `package main` and don't need a `main` function.

```go
// projfuncA.go
package myproj

import "fmt"

func ExportMe() {
    fmt.Println("exported function!)
}
```

```go
// projfuncB.go
package myproj

import "fmt"

func AlsoExportMe() {
    fmt.Println("also exported!")
}
```

```go
// mylib/projfuncC.go
package mylib

import "fmt"

func FinallyExportMe() {
	fmt.Println("finally exported!")
}
```

```go
// cmd/executable1/main.go
package main

import (
	myproj "github.com/marwanhawari/myproj"
	mylib "github.com/marwanhawari/myproj/mylib"
)

func main() {
  myproj.ExportMe()
  myproj.AlsoExportMe()
  mylib.FinallyExportMe()
}
```

* All downloaded dependencies are stored in one location (by default in `~/go/pkg/mod`). This is unlinke Python (which uses `venv`) or Node (which uses `node_modules`). However, you can make a copy of the 3rd party packages specific to your project using `go mod vendor`. Vendoring with `go mod vendor` will create a `vendor` directory within your project with all the source code for your 3rd party dependencies.
  * It is important to put `vendor/` under source control because go doesn't have a central package registry and it could be easy for one of your dependencies to be deleted by the author, re-tagged with breaking changes, etc.
  * The `go.mod` and `go.sum` files should also be under source control.



<p align="center">
  <img src="https://github.com/marwanhawari/guides/blob/main/images/go-imports.png" alt="go-imports" width="700"/>
</p>
source: https://stackoverflow.com/questions/24790175/when-is-the-init-function-run
