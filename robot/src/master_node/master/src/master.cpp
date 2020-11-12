#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <cpprest/ws_client.h>
#include <cpprest/json.h>
#include <iostream>
#include <vector>
#include <string>
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
#include <stdio.h>
//#include "master/Pair.h"
//#include "master/CupNumber.h"

using namespace utility;                    // Common utilities like string conversions
using namespace web;                        // Common features like URIs.
using namespace web::websockets::client;
using namespace web::http;                  // Common HTTP functionality
using namespace web::http::client;          // HTTP client features
using namespace concurrency::streams;       // Asynchronous streams
using namespace std;

static string id = "servience";
websocket_callback_client websocketSetting();
void SendCupNumberOn(const std_msgs::Int32& _num);
void SendCupNumberOff(const std_msgs::Int32& _num);
void SendTableNumber(const std_msgs::Int32& _num);
void GetJson();
void RecieveOrderList();



web::json::value from_string(string input){

	utility::stringstream_t s;

	s << U(input);

	web::json::value ret = web::json::value::parse(s);

	return ret;

}



int main(int argc, char **argv)
{
	websocket_callback_client ws = websocketSetting();
	ros::init(argc,argv,"master");
	ros::NodeHandle nh;

	ROS_INFO("node setting..");
	ros::Subscriber cupnum_on_sub = nh.subscribe("cup_num_on",100,SendCupNumberOn);
	ros::Subscriber cupnum_off_sub = nh.subscribe("cup_num_off",100,SendCupNumberOff);
	ros::Subscriber send_tableNumber = nh.subscribe("goal_result",100,SendTableNumber);
	ros::Publisher table_pub = nh.advertise<std_msgs::Int32MultiArray>("trigger",100);
	ROS_INFO("master start");
	ws.set_message_handler([=](websocket_incoming_message msg){
			msg.extract_string().then([=](string body){
					cout<<body<<'\n';

					vector<int> list;
					web::json::value ret = from_string(body);
					auto order = ret.at(U("content")).as_object().at(U("orders")).as_array();

					//cout<<i.at(0).at(U("_id")).as_string()<<'\n';

					for(auto Order:order){
					list.push_back(Order.at(U("table_id")).as_integer());
					}

					std_msgs::Int32MultiArray table_list;
					table_list.data.clear();

					for(int i=0;i<list.size();i++)
					table_list.data.push_back(list[i]+1);

					table_pub.publish(table_list);

					ROS_INFO("publish table list to slave_node");
			});
	});

	ros::spin();
	ws.close();

	return 0;
}

void SendCupNumberOn(const std_msgs::Int32& _num)
{
	int num = _num.data;
	ROS_INFO("recieve cup_num_on : %d",num);
	try{
		http_client client(U("http://api.cafeservi.com/cup"));
		auto request = http_request{methods::PATCH};

		json::value postData;
		postData["product_id"] = json::value::string(id);
		postData["cup_id"] = json::value::number(num-1);

		request.set_body(postData);

		auto response = client.request(request).get();
		cout<<response.status_code()<<'\n';
	}
	catch(exception& e){
		cout<<e.what()<<'\n';
	}
	ROS_INFO("finish sending cup number to server");
}


void SendCupNumberOff(const std_msgs::Int32& _num)
{
	int num = _num.data;
	ROS_INFO("recieve cup_num_on : %d",num);
	try{
		http_client client(U("http://api.cafeservi.com/cup"));
		auto request = http_request{methods::PATCH};

		json::value postData;
		postData["product_id"] = json::value::string(id);
		postData["cup_id"] = json::value::number(num-1);

		request.set_body(postData);

		auto response = client.request(request).get();
		cout<<response.status_code()<<'\n';
	}
	catch(exception& e){
		cout<<e.what()<<'\n';
	}
	ROS_INFO("finish sending cup number to server");
}

void SendTableNumber(const std_msgs::Int32& _num)
{
	int num = _num.data;
	ROS_INFO("recieve table number(%d) is finish",num);
	try{
		http_client client(U("http://api.cafeservi.com/order/notify_arrival"));
		auto request = http_request{methods::POST};

		json::value postData;
		postData["table_id"] = json::value::number(num-1);
		
		request.set_body(postData);

		auto response = client.request(request).get();
		cout<<response.status_code()<<'\n';
	}
	catch(exception& e){
		cout<<e.what()<<'\n';
	}
	ROS_INFO("finish sending finished table number");
}

websocket_callback_client websocketSetting()
{
	websocket_callback_client client;
	try{
		websocket_outgoing_message msg;
		client.connect(U("ws://3.35.95.187:3000/robot")).then([](){
				cout<<"Connect!"<<'\n';
				//client.send(msg).then([](){});
				});
		json::value obj;
		obj[U("flag")] = json::value::string(U("auth"));
		obj[U("id")] = json::value::string(U(id));

		sleep(1);

		msg.set_utf8_message(obj.serialize());
		client.send(msg).then([](){
				cout<<"send.."<<'\n';
				});

		sleep(1);
		/*
		   client.receive().then([](websocket_incoming_message msg){
		   return msg.extract_string();
		   }).then([](string body){
		   cout<<body<<'\n';
		   });
		 */
		sleep(1);
	}
	catch(exception& e){
		cout<<e.what()<<'\n';
	}
	return client;
}
