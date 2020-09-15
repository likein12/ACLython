echo ;
echo Judge Started
echo ;
rm Main.py
rm Main_local.py
echo ====================================
echo submission_maker.py message
echo ====================================
python3.8 ./submission_maker.py
echo ====================================
echo cythonize message
echo ====================================
python3.8 ./Main.py ONLINE_JUDGE
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

rm atcoder.cpp
rm atcoder.cpython-38*
rm atcoder.pyx