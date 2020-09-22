echo ;
echo Judge Started
echo ;
rm Main.py
cat ./draft.py > ./Main.py
echo ====================================
echo input
echo ====================================
cat ../input/input.txt
echo ====================================
echo output
echo ====================================
time python3.8 ./Main.py < ../input/input.txt
echo ====================================
python3.8 ./copy_paster.py
echo ====================================