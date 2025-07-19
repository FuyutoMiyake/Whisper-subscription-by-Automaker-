#!/bin/bash

# シンプルな録音スクリプト（デバッグ用）
cd /Users/fm/Downloads/whisper-launcher-main

STATE_FILE="/tmp/whisper_state"

echo "録音開始（最大30秒、Ctrl+Cで停止）"

# 状態チェック関数
check_stop() {
    if [ -f "$STATE_FILE" ]; then
        STATE=$(cat "$STATE_FILE")
        if [ "$STATE" = "stop" ]; then
            return 0  # 停止要求あり
        fi
    fi
    return 1  # 継続
}

# 録音実行（停止チェック付き）
(
    /opt/homebrew/bin/sox -d -c 1 -r 16000 -b 16 audio_new.wav trim 0 120 &
    SOX_PID=$!
    
    # 停止チェックループ
    while kill -0 $SOX_PID 2>/dev/null; do
        if check_stop; then
            kill $SOX_PID 2>/dev/null
            break
        fi
        sleep 0.5
    done
    wait $SOX_PID 2>/dev/null
)

echo "録音終了"

# 状態ファイルをリセット
rm -f "$STATE_FILE"

# 文字起こし実行
if [ -f audio_new.wav ]; then
    mv audio_new.wav audio.wav
    bash hack/run.sh /Users/fm/.local/bin/uv run main.py
    echo "録音テスト終了 $(date)" >> sox_test.log
fi