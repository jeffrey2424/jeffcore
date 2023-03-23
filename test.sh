output_dir="boo/far/"

if [[ -z "$output_dir" ]]; then
	echo "yes" 
	else echo "no" 
fi

input_file="foo/bar/tee/file.jeff"
DIR="$(dirname "${input_file}")/"
echo $DIR

