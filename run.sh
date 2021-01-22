fck () 
{ 
    cnt=$(ps aux | egrep $1 -w| awk '{print $2}' | wc -l);
    echo $cnt;
    for i in $(seq 1 $cnt);
    do
        echo "kill process with id:"$(ps aux | egrep $1 | awk '{print $2}' | sed -n ${i}p);
        pidNo=$(ps aux | egrep $1 | awk '{print $2}' | sed -n ${i}p);
        sudo kill -9 $((pidNo));
    done
}


gcc -c -Wall -Werror -fpic libhello.c
gcc -shared -o libhello.so libhello.o

gcc -fpie -std=c99 -Wall -Wextra -g test.c -o dlinject

fck test

sleep 2

gnome-terminal -x ./dlinject

sleep 5

PSID=$(pidof ./dlinject)

echo $PSID

python3 dlinject.py $PSID --stopmethod sigstop ./libhello.so


