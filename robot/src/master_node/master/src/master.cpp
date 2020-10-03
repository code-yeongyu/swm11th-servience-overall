#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <cpprest/ws_client.h>
#include <iostream>
#include <unistd.h>
#include <stdio.h>
#include <wchar.h>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <ros/ros.h>
#include <std_msgs/String.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Int32MultiArray.h>
#include <std_msgs/Bool.h>
#include "master/Pair.h"
#include "master/CupNumber.h"
using namespace utility;                    // Common utilities like string conversions
using namespace web;                        // Common features like URIs.
using namespace web::websockets::client;
using namespace web::http;                  // Common HTTP functionality
using namespace web::http::client;          // HTTP client features
using namespace concurrency::streams;       // Asynchronous streams
using namespace std;

void SendCupNumber(const master::Pair& _num);
void GetJson();
void RecieveOrderList();

int main(int argc, char **argv)
{
    ros::init(argc,argv,"master");
    ros::NodeHandle nh;

    ros::Subscriber cupnum_sub = nh.subscribe("cupnum_msg",100,SendCupNumber);
    ros::Publisher table_pub = nh.advertise<master::CupNumber>("table_msg",100);
    
    websocket_client client;
    client.connect(U("ws://3.35.95.187:3001")).then([](){});
    
    client.receive().then([=](websocket_incoming_message msg){
        master::CupNumber cupNumberMsg;
        master::Pair pairMsg;
        cupNumberMsg.data.push_back(pairMsg);
        table_pub.publish(cupNumberMsg);
        return msg.extract_string();
    }).then([](string body){
        cout<<body<<endl;
    });
    
    cout<<"Master Start"<<'\n';
    ros::spin();

    RecieveOrderList();
    
    return 0;
}

void SendCupNumber(const master::Pair& _num)
{
    int num_a = _num.a;
    int num_b = _num.b;
    http_client client(U("http://3.35.95.187:3000"));
    //ROS_INFO("recieve cup_num : %d",num_b);
    if(num_a==-1)
	{
        http_client tmp(U("http://3.35.95.187:3000/order"));
        client = tmp;
    }
    else
    {
        http_client tmp(U("http://3.35.95.187:3000/order"));
        client = tmp;
    }
    
    json::value postData;
    postData["cup_number"] = json::value::number(num_b);

    client.request(methods::POST).then([=](const http_response& r){
		cout << U("STATUS : ") << r.status_code() << endl;
		cout << "content-type : " << r.headers().content_type() << endl;
        r.extract_json().then([](json::value v){
            auto i = v.as_object().at(U("order")).as_array();
            for(auto I : i)
                cout<<I.as_string()<<'\n';
        
        });
    }).wait();

    // client.request(methods::POST,U("/"),postData).then([](const http_response& response){
    //     return response.extract_json();
    // });
    
    ROS_INFO("finish sending cup number to server");
}

void GetJson()
{
	http_client client(U("http://3.35.95.187:3000/order"));
 
	http_request req(methods::POST);
    
	client.request(req).then([=](http_response r){
		cout << U("STATUS : ") << r.status_code() << endl;
		cout << "content-type : " << r.headers().content_type() << endl;
        r.extract_json().then([](json::value v){
            auto i = v.as_object().at(U("order")).as_array();
            for(auto I : i)
                cout<<I.as_string()<<'\n';
        
        });   // 동기는 get(), 비동기는 then() 사용
        
		// r.extract_json(true).then([](json::value v) {
		// 	cout << v.at(U("store_id")).as_integer() << endl;
		// 	cout << v.at(U("table_num")).as_integer() << endl;
        //     cout << v.at(U("orderer")).as_string() << endl;
        //     auto order = v.at(U("order")).as_array();
        //     for(auto i : order)
        //         cout<<i<<'\n';
		// }).wait();
 
	}).wait();
 
}

void RecieveOrderList()
{
    websocket_client client;
    client.connect(U("ws://3.35.95.187:3001")).then([](){});
    client.receive().then([](websocket_incoming_message msg){
        return msg.extract_string();
    }).then([](string body){
        cout<<body<<endl;
    });
    client.close();
}