sudo apt-get install -y git
sudo apt-get install -yq zenity

cd `zenity --file-selection --directory --title="Choose where to install" --filename=$HOME/`

mkdir CLion
cd CLion

while true; do
 read -p "Select which jdk you want to install/update: Enter
 1 for openJDK
 2 for Oracle
 :>  " ch
    case $ch in
        [1]* ) 
			echo "Installing/Updating openJDK";
			sudo apt-get install -y openjdk-7-jdk;
			break;;
        [2]* ) echo "Installing/Updating Oracle JDK";
			sudo apt-get install -y python-software-properties;
			sudo add-apt-repository -y ppa:webupd8team/java;
			sudo apt-get -y update;
			sudo apt-get install -y oracle-java7-installer;
			break;;
        * ) echo "Please choose 1 or 2";;
    esac
done

while true; do
 read -p "Do you want to automatically download CLion. Enter
 y or Y to automatically download
 n or N if you will manually download it into $PWD
 :>  " ch
    case $ch in
        [yY]* ) 
			wget_output=$(wget "http://download.jetbrains.com/cpp/CLion-2016.1.1.tar.gz");
			if [ $? -ne 0 ]; then
				echo "The download link has expired. Please download Clion manually into $PWD"
				xdg-open https://confluence.jetbrains.com/display/CLION/Previous+CLion+Releases
				echo "Press any key to continue after downloading into $PWD"
				read -n 1 -s
			else 
				echo "Clion downloaded"
			fi
			break;;
        [nN]* )
				echo "Press any key to continue after downloading into $PWD"
				read -n 1 -s
			break;;
        * ) echo "Please enter correct option";;
    esac
done

echo "Extrating CLion"
tar xzf clion*.tar.gz -C

# Make CLion globally accessible
echo "Linking CLion"
cd clion*
sudo ln -s "$(pwd)/bin/clion.sh" "/usr/local/bin/clion"

sudo apt-get install -y build-essential linux-headers-$(uname -r) g++ cmake freeglut3 freeglut3-dev libxmu-dev libxi-dev cmake make g++ libx11-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxrandr-dev libxext-dev libxi-dev

cd `zenity --file-selection --directory --title="Choose where to download starter project's folder" --filename=$PWD/..`
git clone https://github.com/YashalShakti/OPENGL_using_CMake_starter.git
clion OPENGL_using_CMake_starter/