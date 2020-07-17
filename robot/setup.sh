sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ros-kinetic-joy ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc ros-kinetic-rgbd-launch ros-kinetic-depthimage-to-laserscan ros-kinetic-rosserial-arduino ros-kinetic-rosserial-python ros-kinetic-rosserial-server ros-kinetic-rosserial-client ros-kinetic-rosserial-msgs ros-kinetic-amcl ros-kinetic-map-server ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro ros-kinetic-compressed-image-transport ros-kinetic-rqt-image-view ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers &
wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_kinetic.sh
chmod 755 /install_ros_kinetic.sh
bash ./install_ros_kinetic.sh
cd ~/catkin_ws/src/
git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b kinetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
cd ~/catkin_ws
catkin_make
echo 'export ROS_HOSTNAME=127.0.0.1' >> ~/.bashrc
echo 'export ROS_MASTER_URI=http://$ROS_HOSTNAME:11311' >> ~/.bashrc
