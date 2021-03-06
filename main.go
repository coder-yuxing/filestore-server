package main

import (
	"filestore-server/handler"
	"fmt"
	"net/http"
)

func main() {
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("./static"))))

	http.HandleFunc("/file/upload", handler.UploadHandler)
	http.HandleFunc("/file/upload/success", handler.UploadSuccessHandler)
	http.HandleFunc("/file/meta", handler.GetFileMetaHandler)
	http.HandleFunc("/file/query", handler.FileQueryHandler)
	http.HandleFunc("/file/download", handler.DownloadHandler)
	http.HandleFunc("/file/update", handler.FileMetaUpdateHandler)
	http.HandleFunc("/file/delete", handler.DeleteHandler)
	// 秒传接口
	http.HandleFunc("/file/fastUpload", handler.HttpInterceptor(handler.TryFastUploadHandler))

	// 分块上传接口
	http.HandleFunc("file/multiupload/init", handler.HttpInterceptor(handler.InitialMultiPartUploadHandler))
	http.HandleFunc("file/multiupload/uppart", handler.HttpInterceptor(handler.MultiPartUploadHandler))
	http.HandleFunc("file/multiupload/complete", handler.HttpInterceptor(handler.CompleteUploadHandler))

	http.HandleFunc("/user/signup", handler.SignUpHandler)
	http.HandleFunc("/user/signin", handler.SignInHandler)
	http.HandleFunc("/user/info", handler.HttpInterceptor(handler.UserInfoHandler))

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Printf("Failed to start server, err: %s", err.Error())
	}
}

