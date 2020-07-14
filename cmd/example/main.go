package main

import (
	"errors"
	"fmt"
)

func main() {
	fmt.Println("hello world.")
	example()
}

func example() error {
	return errors.New("error test")
}
