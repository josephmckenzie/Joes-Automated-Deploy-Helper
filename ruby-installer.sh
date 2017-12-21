#!/bin/bash


uname="$(uname)"
unameArch="$(uname -m)"

exists() {
  command -v "$1" >/dev/null 2>&1
}

RUBYINSTALLER() {
echo "Do you wish to install Ruby?"
select yn in "Yes" "No"; do
case $yn in
				Yes ) 
				echo "yes selected"
				if exists ruby; then
						echo "Ruby installed already"
				else
						if [[ "$uname" == "Linux" ]]; then
								if exists apt; then
											apt update -y
											sudo apt-get --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev python-software-properties libffi-dev libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev nodejs -y	
											apt install ruby -y
								else  
											yum install ruby -y
											sudo yum --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev python-software-properties libffi-dev libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev nodejs -y	
								fi
						elif [[ "$uname" == "Darwin" ]]; then 			
								if exists brew; then
											brew install ruby -y
											export PATH=/usr/local/opt/ruby/bin:$PATH
								fi
						else
								echo "Couldn't find a compatible method to install Ruby for your system"
								echo "Please download Ruby from"
								echo https://www.ruby-lang.org/en/downloads/
						fi
				fi
				break
				;;
				No )
				echo "No selected"
				exit
				;;
esac
done
}

INSTALLRUBY() {
if [[ "$uname" == "Darwin" ]]; then
 echo "We need to install some required files before you can run this script properly (Mac)"
  				 RUBYINSTALLER
elif [[ "$uname" == "Linux" ]]; then
  echo "We need to install some required files before you can run this script properly (Linux)"
				 RUBYINSTALLER
elif [[ "$uname"] == *"MING"* ]]; then
  echo "We need to install some required files before you can run this script properly (Windows)"
	    RUBYINSTALLER
else
  echo "We need to install some required files before you can run this script properly (Windows)"
     RUBYINSTALLER
fi
}


#INSTALLRUBY