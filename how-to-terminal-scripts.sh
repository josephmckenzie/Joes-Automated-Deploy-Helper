#Some scripts for linux (Ubuntu)

#Here are some simple scriptps to show some cool shit when you launch a new istance of a terminal window


#To add a script that will be fired or launched everytime yo launch a new terminal window add it in your .bashrc file by going to. Sudo is the superuser and needed so you will have access to write the file and not just read it.

$ sudo nano ~/.bashrc 


#----------------------------------------------------------------------------------------------------------------
#
# --This shows the current time in a cool rainbow font and border and will keep updating every second until you stop it

$ while true; do echo "$(date '+%D %T' | toilet -f term -F border --gay)"; sleep 1; done
#┌─────────────────┐
#│11/19/17 23:36:58│
#└─────────────────┘
#
#-------------------------------------------------------------------------------------------------------------------
#
#This will show a statement that mike sucks every time you launch a terminal window (with a rainbow ont and border)

$ echo 'Mike Sucks' | toilet -f term -F border --gay
#┌──────────┐
#│Mike Sucks│
#└──────────┘
#
#-------------------------------------------------------------------------------------
#
#This will show a cute kitty in a somewhat colorful scheme and display the message that well "MIKE SUCKS"

$ toilet -f ivrit 'Mike Sucks' | boxes -d cat -a hc -p h8 | lolcat
#                          /\             /\
#                         |`\\_,--="=--,_//`|
#                         \ ."  :'. .':  ". /
#                        ==)  _ :  '  : _  (==
#                          |>/O\   _   /O\<|
#                          | \-"~` _ `~"-/ |
#                         >|`===. \_/ .===`|<
#                   .-"-.   \==='  |  '===/   .-"-.
#.-----------------{'. '`}---\,  .-'-.  ,/---{.'. '}-----------------.
# )                `"---"`     `~-===-~`     `"---"`                (
#(           __  __ _ _          ____             _                  )
# )         |  \/  (_) | _____  / ___| _   _  ___| | _____          (
#(          | |\/| | | |/ / _ \ \___ \| | | |/ __| |/ / __|          )
# )         | |  | | |   <  __/  ___) | |_| | (__|   <\__ \         (
#(          |_|  |_|_|_|\_\___| |____/ \__,_|\___|_|\_\___/          )
# )                                                                 (
#'-------------------------------------------------------------------'
#
#----------------------------------------------------------------------------------------------------------
#
#Say you want to add a custom cow file owl.cow file you can do it like
#

$ figlet Mined Minds | cowsay -f ~/Desktop/cows/owl.cow -n
#
#you will wan to add the -n option at the end to avoid line wrapping and having  "Mined Minds" all jumbled up
#
#
# ________________________________________________________
#/  __  __ _                _   __  __ _           _      \
#| |  \/  (_)_ __   ___  __| | |  \/  (_)_ __   __| |___  |
#| | |\/| | | '_ \ / _ \/ _` | | |\/| | | '_ \ / _` / __| |
#| | |  | | | | | |  __/ (_| | | |  | | | | | | (_| \__ \ |
#| |_|  |_|_|_| |_|\___|\__,_| |_|  |_|_|_| |_|\__,_|___/ |
#\                                                        /
# --------------------------------------------------------
#            \
#             \ 
#
#
#
#		"|||||,,,..   ..,,,|||||"
#		 '||(    |||,|||    )||'
#		  "||,,,,. "|" .,,,,||"
#		   .d8888b.   .d8888b.
#		  o8'  o '8o o8'o   `8o
#		  o8.    .8o o8.    .8o
#		   `Y8888P'   `Y8888P'
#		  ,||''||    / ||''||,
#		 ,||   ||,  / .||   ||,
#		 ||     ||  `  ||     ||
#		,||     '||   ||'     ||,
#		||      '||   ||'      ||
#		||       |;   ;|       ||
#		||      ,|     |,      ||
#		||,    ,||     ||,    ,||
#		 ||,  ,|||     |||,  ,||
#		 '||,,||||,...,||||,,||
#		   `|||..."|||"...|||'
#		 %%%%%WWWW%%%%%%WWWW%%%%%
#
