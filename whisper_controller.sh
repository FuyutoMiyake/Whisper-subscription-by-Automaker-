#!/bin/bash

# 作業ディレクトリに移動
cd /Users/fm/Downloads/whisper-launcher-main

# 状態ファイル
STATE_FILE="/tmp/whisper_state"
AUDIO_FILE="audio.wav"
LOG_FILE="sox_test.log"

# 状態確認
if [ -f "$STATE_FILE" ]; then
    # 録音中 → 停止
    STATE=$(cat "$STATE_FILE")
    if [ "$STATE" = "recording" ]; then
        echo "stop" > "$STATE_FILE"
        echo "録音停止要求 $(date)" >> "$LOG_FILE"
    fi
else
    # 録音開始
    echo "recording" > "$STATE_FILE"
    echo "録音テスト開始 $(date)" >> "$LOG_FILE"
    
    # 新しいターミナルウィンドウで録音実行（前景実行でマイクアクセス確保）
    osascript -e 'tell application "Terminal" to do script "cd /Users/fm/Downloads/whisper-launcher-main && bash simple_record.sh"'
fi

exit 0