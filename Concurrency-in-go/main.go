package main

import (
	"fmt"
	"time"
)

func main() {

	go sayGo()

	time.Sleep(2 * time.Second)

	number(2)

}

func number(two int) {
	num := two
	fmt.Println(num)
}

func sayGo() {
	love := "I love Go"
	fmt.Println(love)
}
