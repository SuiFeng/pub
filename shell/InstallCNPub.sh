#!/bin/bash

#
pubpath=$(which pub)
if [ ! $pubpath ]
then
    flutterpath=$(dirname $(which flutter))
    pubpath="$flutterpath/cache/dart-sdk/bin"
else
    pubdir=$(dirname `which pub`)
    pubdir1=$(readlink `which pub`)
    pubdir2=$(dirname "$pubdir/$pubdir1")
    pubpath="$pubdir2/../libexec/bin"
fi

#
if [ ! -d $pubpath ]
then 
    echo -e "找不到pub路径!!!"
    exit 1
fi

#echo $pubpath

#
mkdir -p .cnpub

#
curl -L -o .cnpub/cnpub.snapshot 'https://github.com/SuiFeng/pub/releases/download/SDK-2.2.1-dev.3.0-CN/cnpub.snapshot'

curl -L -o .cnpub/cnpub 'https://github.com/SuiFeng/pub/releases/download/SDK-2.2.1-dev.3.0-CN/cnpub'


cp -rf .cnpub/cnpub.snapshot $pubpath/snapshots/
cp -rf .cnpub/cnpub $pubpath/

chmod +x $pubpath/snapshots/cnpub.snapshot
chmod +x $pubpath/cnpub

echo -e "#!/bin/bash\nexec \"$pubpath/cnpub\" \"\$@\"" > $pubpath/cnpube
ln -f -s $pubpath/cnpube /usr/local/bin/cnpub
chmod +x $pubpath/cnpube
chmod +x /usr/local/bin/cnpub

rm -rf .cnpub/