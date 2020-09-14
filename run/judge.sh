echo ;
echo Judge Started
echo ;
python3.8 ./submission_maker.py
python3.8 ./Main.py ONLINE_JUDGE 2>/dev/null

echo ====================================
echo input
echo ====================================
cat ../input/input.txt
echo ====================================
echo output
echo ====================================
time python3.8 ./Main.py < ../input/input.txt
echo ====================================

rm atcoder*