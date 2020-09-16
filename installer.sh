phases=( 
    'Copying Script to /bin... '
    'Running chmod...'
    'Checking For Missing Files...'
    'Last Checks...'
)   

if [ "$EUID" -ne 0 ]
  then echo -e "You must run as root!";
  exit
fi

for i in $(seq 1 100); do  
    sleep 0.1

    if [ $i -eq 100 ]; then
        echo -e "XXX\n100\nDone!\nXXX"
    elif [ $(($i % 25)) -eq 0 ]; then
        let "phase = $i / 25"
        echo -e "XXX\n$i\n${phases[phase]}\nXXX"
    else
        echo $i
    fi 
done | whiptail --title 'nginx-control' --gauge "${phases[0]}" 6 50 0

cp nginx-control.sh /bin/nginx-control
chmod +x /bin/nginx-control 
 sleep 0.5
 echo 'Installation complete!'
 echo 'Run nginx-control to get started'

