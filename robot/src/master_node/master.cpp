#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <cpprest/ws_client.h>
#include <iostream>
using namespace utility;                    // Common utilities like string conversions
using namespace web;                        // Common features like URIs.
using namespace web::web_sockets::client;
using namespace web::http;                  // Common HTTP functionality
using namespace web::http::client;          // HTTP client features
using namespace concurrency::streams;       // Asynchronous streams
using namespace std;

void GetHttp();
void GetJson();

int main(int argc, char* argv[])
{
    websocket_client client;
    printf("connet....\n");
    client.connect(U("ws://3.35.95.187:3001")).wait();
    printf("connet!!\n");
    
    std::cout<<client.uri().to_string()<<'\n';  // uri check

    //GetHttp();

    GetJson();

    /*
    websocket_outgoing_message msg;

    client.receive().then([](websocket_incoming_message msg){
        printf("wait..");
        return msg.extract_string();
    }).then([](std::string body){
        printf("wait..");
        std::cout << body << std::endl;
    });*/


    client.close();
    printf("close\n");
    return 0;
}

void GetHttp()
{
	http_client client(U("http://3.35.95.187:3000/order"));
	auto resp = client.request(U("POST")).get();
 
	wcout << U("STATUS : ") << resp.status_code() << endl;
	cout << "content-type : " << resp.headers().content_type() << endl;
	cout << resp.extract_string(true).get() << endl;
}

void GetJson()
{
	http_client client(U("http://3.35.95.187:3000/order"));
 
	http_request req(methods::POST);
 
	client.request(req).then([=](http_response r){
		cout << U("STATUS : ") << r.status_code() << endl;
		cout << "content-type : " << r.headers().content_type() << endl;
 
		r.extract_json(true).then([](json::value v) {
			cout << v.at(U("store_id")).as_integer() << endl;
			cout << v.at(U("table_num")).as_integer() << endl;
            cout << v.at(U("orderer")).as_string() << endl;
            auto order = v.at(U("order")).as_array();
            for(auto i : order)
                cout<<i<<'\n';
		}).wait();
 
	}).wait();
 
}