echo ;
echo Judge Started
echo ;
rm ./Main.py
echo ====================================
echo input
echo ====================================
cat ../input/input.txt
echo ====================================
echo output
echo ====================================
time python3.8 ./draft.py < ../input/input.txt
echo ====================================
cat ./draft.py > ./Main.py
python3.8 ./copy_paster.py
echo ====================================
