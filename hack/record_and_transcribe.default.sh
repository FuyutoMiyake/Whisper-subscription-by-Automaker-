#!/bin/bash

cd {{PROJECT_ROOT}}

touch sox_test.log
echo "録音テスト開始 $(date)" >> sox_test.log
# 録音テスト(静音が3秒続くと録音が終了する)
/opt/homebrew/bin/sox -d -c 1 -r 16000 -b 16 audio.wav silence 1 0.1 1% 1 3.0 1%
echo "録音テスト終了 $(date)" >> sox_test.log

# 録音ファイルをwhisperで文字起こし
bash hack/run.sh {{UV_PATH}} run main.py
