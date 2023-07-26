echo "1 -> ${1}"
echo "2 -> ${2}"
echo "3 -> ${3}"

if [ ! -d "test" ]; then
    echo "??"
fi

if [ "${1}" != "--out-dir" ] || [ "${2}" == "" ]; then
    echo "Please give parameter --out-dir"
    exit 1
fi