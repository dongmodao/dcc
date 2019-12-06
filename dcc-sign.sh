apk=$1
sign=$2
echo $apk
echo $sign
out=${apk:0:-4}-out.apk
python dcc.py -o $out $apk
echo "start rm apk META-INF..."
7z -d $out META-INF/\*
zipa=${out:0:-4}-zipa.apk
echo "start zipalign apk..."
./tools/zipalign.exe -p -v 4 $out $zipa
apksign=${zipa:0:-4}-apksign.apk
echo "start sign apk with apksigner..."
java -jar tools/apksigner.jar sign --ks $sign --in $zipa --out $apksign
echo "zipalign verify..."
./tools/zipalign.exe -c -v 4 $apksign
echo "apksigner verify..."
java -jar tools/apksigner.jar verify -v $apksign
rm $out
rm $zipa
echo "result file : " 
echo $apksign
