#!/bin/bash

cd /Users/fm/Downloads/whisper-launcher-main

echo "録音テスト開始 $(date)"
# 録音テスト(静音が3秒続くと録音が終了する)
/opt/homebrew/bin/sox -d -c 1 -r 16000 -b 16 audio.wav trim 0 30 silence 1 0.1 8% 1 2.5 8%
echo "録音テスト終了 $(date)"

# 録音ファイルをwhisperで文字起こし
bash hack/record_and_transcribe.sh 