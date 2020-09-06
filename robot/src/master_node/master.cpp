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

int main(int argc, char* argv[])
{
    websocket_client client;
    printf("connet....\n");
    client.connect(U("ws://3.35.95.187:3001")).wait();
    printf("connet!!\n");
    
    std::cout<<client.uri().to_string()<<'\n';  // uri check


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