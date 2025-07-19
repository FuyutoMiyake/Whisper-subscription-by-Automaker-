#!/bin/bash

echo "=== マイクアクセステスト ==="
echo "テスト開始: $(date)"

# 1. soxコマンドの存在確認
echo ""
echo "1. Soxコマンドの確認:"
which sox
/opt/homebrew/bin/sox --version

# 2. 利用可能なオーディオデバイスの確認
echo ""
echo "2. 利用可能なオーディオデバイス:"
/opt/homebrew/bin/sox -d -n trim 0 0.001 2>&1 | grep -E "Input|Default"

# 3. 短い録音テスト（1秒）
echo ""
echo "3. 1秒間の録音テスト:"
echo "録音開始..."
/opt/homebrew/bin/sox -d -c 1 -r 16000 -b 16 test_audio.wav trim 0 1
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo "✅ 録音成功!"
    echo "ファイルサイズ: $(ls -lh test_audio.wav | awk '{print $5}')"
    rm -f test_audio.wav
else
    echo "❌ 録音失敗 (エラーコード: $RESULT)"
fi

# 4. エラーログの確認
echo ""
echo "4. エラーログの確認:"
if [ -f /tmp/whisper_sox_error.log ]; then
    echo "--- エラーログ内容 ---"
    cat /tmp/whisper_sox_error.log
    echo "--- エラーログ終了 ---"
else
    echo "エラーログファイルなし"
fi

echo ""
echo "=== テスト完了 ==="

# マイクアクセス権限の確認方法を表示
echo ""
echo "📌 マイクアクセス権限の確認方法:"
echo "1. システム環境設定 → セキュリティとプライバシー → プライバシー → マイク"
echo "2. 以下のアプリケーションにチェックがあるか確認:"
echo "   - ターミナル.app"
echo "   - iTerm.app (使用している場合)"
echo "   - Karabiner関連プロセス"