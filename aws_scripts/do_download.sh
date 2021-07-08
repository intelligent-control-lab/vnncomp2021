#!/bin/bash -e
# download vnncomp and tool

sudo apt-get update
sudo apt-get install -y ssmtp sharutils mutt

sudo rm -frv vnncomp2021


git clone https://github.com/stanleybak/vnncomp2021
pushd vnncomp2021
git checkout b682cb28ff817a122ea2c2623cb3abde8ca4172a
popd

source ./tool.sh

sudo rm -frv $TOOL_NAME

if [ ${REPO} != 0 ]
then
	git clone ${REPO} ${TOOL_NAME}
	pushd ${TOOL_NAME}
	git checkout ${COMMIT}
	
	############
	if [ ! -f "./$SCRIPTS_DIR/install_tool.sh" ] 
	then
		echo "tool script does not exist: ./$SCRIPTS_DIR/install_tool.sh"
		exit 1
	else
		chmod +x "./$SCRIPTS_DIR/install_tool.sh"
	fi
	
	#############
	if [ ! -f "./$SCRIPTS_DIR/prepare_instance.sh" ] 
	then
		echo "tool script does not exist: ./$SCRIPTS_DIR/prepare_instance.sh"
		exit 1
	else
		chmod +x "./$SCRIPTS_DIR/prepare_instance.sh"
	fi
	
	#############
	if [ ! -f "./$SCRIPTS_DIR/run_instance.sh" ] 
	then
		echo "tool script does not exist: ./$SCRIPTS_DIR/run_instance.sh"
		exit 1
	else
		chmod +x "./$SCRIPTS_DIR/run_instance.sh"
	fi
	
	popd
else
	echo "No repo provided... please manually transfer tool code to server (and adjust permissions of tool scripts if needed)"
fi
