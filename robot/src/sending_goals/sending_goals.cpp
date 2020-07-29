#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <cstring>
#include <string.h>
#include <string>
#include <ctime>
#include <queue>
using namespace std;

pair<double,double> Table[10];
int main(int argc, char** argv)
{
	Table[0].first = 1.68; Table[0].second = 0.98;
	Table[1].first = 1.67; Table[1].second = -0.02;
	Table[2].first = 1.67; Table[2].second = -1.02;
	Table[3].first = 0.5; Table[3].second = 0.99;
	Table[4].first = 0.5; Table[4].second = -0.02;
	Table[5].first = 0.5; Table[5].second = -1.02;
	Table[6].first = -0.5; Table[6].second = 0.99;
	Table[7].first = -0.5; Table[7].second = -0.02;
	Table[8].first = -0.5; Table[8].second = -1.02;
	srand((unsigned int)time(0));

	ifstream readResultFile;
	
	string pub_sending_goals;
	string move_base_result;
	
	bool startTrigger = false;	// triger for start
	bool goalReach = false;		// to tell whether robot is arrived at goal
	queue<int> Table_queue;		// Table index for serving

	while(true)
	{
		int Table_idx = rand() % 9;
		Table_queue.push(Table_idx);
		
		//if(startTrigger)		// if startTrigger is true, robot start.
		//{
			while(!Table_queue.empty())		// robot is moving untli job is empty
			{
				int tableIdx = Table_queue.front(); Table_queue.pop();
				goalReach = false;
				string x = to_string(Table[tableIdx].first);	x.append("\n");
				string y = to_string(Table[tableIdx].second);	y.append("\n");
				string z = "0.9";	z.append("\n");
				string w = "0.04";	w.append("\"");

				pub_sending_goals = "rostopic pub -1 /move_base_simple/goal geometry_msgs/PoseStamped \"header:\n  seq: 0\n  stamp:\n    secs: 0\n    nsecs: 0\n  frame_id: \'map\'\npose:\n  position:\n    x: "+x+"    y: "+y+"    z: 0.0\n  orientation:\n    x: 0.0\n    y: 0.0\n    z: "+z+"    w: "+w;
				system(pub_sending_goals.c_str());

				// redirection to move_base_result.txt
				move_base_result = "rostopic echo move_base/result -n 1 > move_base_result.txt";
				system(move_base_result.c_str());

				// find Goal reached text. because goal is reached correctly, print "Goal reached"
				readResultFile.open("./move_base_result.txt");
				if(readResultFile.is_open())
				{
					while(!readResultFile.eof())
					{
						string readline;
						getline(readResultFile,readline);
						if(readline.find("Goal reached.")>=0)
						{
							goalReach = true;
							break;
						}
					}
				}
				if(goalReach)cout<<"Goal reach"<<'\n';
				else cout<<"Goal failed"<<'\n';
			}
			startTrigger = false;
		//}
	}
	return 0;
}
