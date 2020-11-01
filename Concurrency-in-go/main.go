package main

import (
	"fmt"
	"time"
)

func main() {

	go sayGo()

	time.Sleep(2 * time.Second)

	addition(2)

}

func addition(two int) {

	num := two
	fmt.Println(num)
}

func sayGo() {
	love := "I love Go"
	fmt.Println(love)
}
