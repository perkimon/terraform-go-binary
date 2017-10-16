package main

import (
	"io"
	"net/http"
	"log"
	"flag"
)

// hello world, the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "hello, world!\n")
}
func HelloRiverisland(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "hello river island!\n")
}

func main() {
	platform := flag.String("platform","","test1")
	flag.Parse()
	if len(*platform) == 0 {
		panic("no platform")
	}
	log.Println("Platform:", *platform)

	http.HandleFunc("/hello", HelloServer)
	http.HandleFunc("/ri", HelloRiverisland)
	http.HandleFunc("/will", func(w http.ResponseWriter, req *http.Request){
		io.WriteString(w, "WILL SAYS HI:"+*platform+"\n")
		log.Println("Will Accessed")
	})
	log.Fatal(http.ListenAndServe(":12345", nil))
}
