import os
import pyperclip
from openai import OpenAI

client = OpenAI(api_key=os.environ["OPEN_AI_API_KEY"])

if __name__ == "__main__":
    audio_file = open("audio.wav", "rb")
    transcript = client.audio.transcriptions.create(model="whisper-1", file=audio_file)

    pyperclip.copy(transcript.text)
    print("文字起こし結果がクリップボードにコピーされました。")
    
    # 完了通知音を再生（Hero、音量50%）
    os.system('afplay -v 0.1 /System/Library/Sounds/Blow.aiff')
