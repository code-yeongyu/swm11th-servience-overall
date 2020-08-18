#include<string.h>
#include<sstream>
#include<queue>
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "actionlib_msgs/GoalStatusArray.h"
#include "move_base_msgs/MoveBaseActionResult.h"
#include "geometry_msgs/PoseStamped.h"
#include "std_msgs/Byte.h"
using namespace std;

class ServiceCore
{
	public:
		ServiceCore()
		{
			ros::Rate loop_rate(3);
			pub_Pose = nh_.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal",1); 
			pub_cup_num = nh_.advertise<std_msgs::Byte>("cup_num",1);
			while(ros::ok()){
				while(STATUS==0){
					sub_light_sensor = nh_.subscribe("light_sensor",1,&ServiceCore::get_light_sensor_callback,this);
					if(get_light){
						sub_trigger = nh_.subscribe("trigger",1,&ServiceCore::trigger_callback,this);
						get_light = 0;
					} 
				}
				while(!q.empty()){
					uint8_t num = q.front();
					q.pop();
					dest_setting(num);
					pub_Pose.publish(poseStampedTable);
					give=0;
					while(give==0)sub_light_sensor = nh_.subscribe("light_sensor",1,&ServiceCore::get_off_sensor_callback,this);
					loop_rate.sleep();
				}
				dest_setting(0);//return to base
				pub_Pose.publish(poseStampedTable);
				STATUS = 0;
			}   
		}

		void dest_setting(uint8_t num){
			poseStampedTable.pose.position.x = targetpose[num][0];
			poseStampedTable.pose.position.y = targetpose[num][1];
			poseStampedTable.pose.position.z = targetpose[num][2];
			poseStampedTable.pose.orientation.x = targetorient[num][0];
			poseStampedTable.pose.orientation.y = targetorient[num][1];
			poseStampedTable.pose.orientation.z = targetorient[num][2];
			poseStampedTable.pose.orientation.w = targetorient[num][3];   
		}

		void trigger_callback(const std_msgs::Byte& msg){
			if(msg.data){
				STATUS = 1;
			}
		}


		void get_tablenum_callback(const std_msgs::Byte& msg){
			//table_num = msg.data;
			//if(STATUS==0&&table_num==0) return;
			q.push(msg.data);   
		}


		void get_light_sensor_callback(const std_msgs::Byte& cup_holder){
			for(uint8_t i=0;i<4;i++){
				if((pre_cup_holder&(1<<i))^(cup_holder.data&(1<<i))){//different with previous cup_holder
					cup_num_msg.data = i+1;
					pub_cup_num.publish(cup_num_msg);//send cup num to master
					//table_num=0;
					//while(table_num==0){
					sub_table_num = nh_.subscribe("table_num",1,&ServiceCore::get_tablenum_callback,this);
					//}
					get_light = 1;
					break;
				}
			}
			pre_cup_holder = cup_holder.data;
		}

		void get_off_sensor_callback(const std_msgs::Byte& cup_holder){
			for(uint8_t i=0;i<4;i++){
				if((pre_cup_holder&(1<<i))^(cup_holder.data&(1<<i))){//different with previous cup_holder
					cup_num_msg.data = i+1;
					pub_cup_num.publish(cup_num_msg);//send cup num to master
					give = 1;
					break;
				}
			}
			pre_cup_holder = cup_holder.data;
		}



	private:
		bool get_light = 0;
		uint8_t STATUS = 0;
		uint8_t pre_cup_holder=0;
		//uint8_t table_num = 0;
		uint8_t give = 0;
		queue<uint8_t>q;
		double targetpose[7][3] = {{0.1,0.1,0.0},{0.869215607643, -5.00192499161, 0.0},{-0.228843331337, -5.19032335281, 0.0},{-1.1484041214, -4.76823806763, 0.0},{-1.87616157532, -3.07519674301, 0.0},{-0.856977939606, -2.94435453415, 0.0},{0.198088169098, -2.80627608299, 0.0}};
		double targetorient[7][4] = {{0.0,0.0,-0.55,0.55},{0.0, 0.0, -0.63459254249, 0.772846883293},{0.0, 0.0, -0.653903295489, 0.756578138826},{0.0, 0.0, -0.689908353443, 0.723896721812},{0.0, 0.0, 0.788695434872, 0.614784117404},{0.0, 0.0, 0.788695516865, 0.614784012217},{0.0, 0.0, 0.768605342232, 0.639723243202}};

		ros::NodeHandle nh_;

		//pub
		ros::Publisher pub_Pose;
		ros::Publisher pub_cup_num;
		//ros::Publisher pub_cup_num("cup_num",&cup_num_msg);

		//sub
		ros::Subscriber sub_trigger;
		ros::Subscriber sub_light_sensor;
		ros::Subscriber sub_table_num;

		//msgs
		std_msgs::Byte cup_num_msg;
		geometry_msgs::PoseStamped poseStampedTable;
		geometry_msgs::PoseStamped poseStampedCounter;
};


int main(int argc, char **argv)
{
	//Initiate ROS
	ros::init(argc, argv, "service_cor2");

	//Create an object of class ServiceCore that will take care of everything
	ServiceCore serviceCore;

	ros::spin();

	return 0;
}
