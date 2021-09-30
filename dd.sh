#!/bin/bash

function usage() {
   cat << HEREDOC
Usage: $0 --target=TARGET_PATH --crash=CRASH_PATH --seeds=SEEDS_PATH

positional arguments:
  -t, --target TARGET_PATH absolute pathname of the fuzz target
  -c, --crash CRASH_PATH   absolute pathname of the crashing test case
  -s, --seeds SEEDS_PATH   absolute pathname of the corpus

optional arguments:
  -h, --help               show this help message and exit

HEREDOC
}

# ./virtfuzz-dd.sh -t
for i in "$@"; do
  case $i in
    -t=*|--target=*)
      target="${i#*=}"
      shift # past argument=value
      ;;
    -c=*|--crash=*)
      crash="${i#*=}"
      shift # past argument=value
      ;;
    -s=*|--seeds=*)
      seeds="${i#*=}"
      shift # past argument=value
      ;;
    -h*|--help*)
      usage
      exit 0
      ;;
    *)
      # unknown option
      ;;
  esac
done

if [[ -z $target ]]; then
    echo "[-] -t/--target is missing"
    exit 1
fi

if [[ -z $crash ]]; then
    echo "[-] -c/--crash is missing"
    exit 1
fi

if [[ -z $seeds ]]; then
    echo "[-] -s/--seeds is missing"
    exit 1
fi

echo "[-] target = $target"
echo "[-] crash  = $crash"
echo "[-] seeds  = $seeds"

# step 1: create a private directory
ws=$(mktemp -d)
echo [-] working in $ws

# step 2: create a tester script
echo "#!/bin/bash" > $ws/picire_tester.sh
echo "$target $crash -pre_seed_inputs=@\$1 2>&1 | grep -q \"ERROR\";" >> $ws/picire_tester.sh
chmod +x $ws/picire_tester.sh
echo [-] created $ws/picire_tester.sh
echo "#!/bin/bash" > $ws/picire_reproduce.sh
echo "$target $crash -pre_seed_inputs=@\$1" >> $ws/picire_reproduce.sh
chmod +x $ws/picire_reproduce.sh
echo [-] created $ws/picire_reproduce.sh

# step 3: create an input
find $seeds -type f | sort -t/ -k4 > $ws/picire_inputs
echo [-] created $ws/picire_inputs

# step 4: let's start dd
echo [-] starting delta debugging!
time picire --input=$ws/picire_inputs --test=$ws/picire_tester.sh \
	--parallel --subset-iterator=skip --complement-iterator=backward

echo [-] saved output to $ws/picire_inputs.*/picire_inputs
echo [-] run $ws/picire_reproduce.sh $ws/picire_inputs.*/picire_inputs
