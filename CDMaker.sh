for f in *; do mv "$f" `echo $f | tr ' ' '_'`; done

mkdir -p converted

for f in *.wav; do
    sox "$f" -c 2 -r 44100 "converted/${f%.wav}_v2.wav"
done

cd converted

find . -maxdepth 1 -type f -name '*.wav' -print0 | sort -z | xargs -0 wodim -v dev=/dev/sr0 -audio -pad -tao
