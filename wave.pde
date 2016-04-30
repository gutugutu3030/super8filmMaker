import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;

import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;


AudioInputStream is;
AudioFormat format;
int interval=3;
float sampleRate;
float thick;

void initWave(String path) {
  try {
    is = AudioSystem.getAudioInputStream( new File(path) );
    format = is.getFormat();
    sampleRate=format.getSampleRate();
    interval=(int)(sampleRate/8000);
    thick=76.203/sampleRate;
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void drawWave(float x, float min, float max) {
  try {
    // 音声データの取得
    int index=0;
    while (true) {
      // 1標本分の値を取得
      int     size        = format.getFrameSize();
      byte[]  data        = new byte[ size ];
      int     readedSize  = is.read(data);
      // データ終了でループを抜ける
      if ( readedSize == -1 ) { 
        break;
      } 
      if (index%interval==0) {
        if (max<min+thick*index) {
          break;
        }
        int value=0;
        // 1標本分の値を取得
        switch( format.getSampleSizeInBits() ) {
        case 8:
          value=(int)data[0];
          break;
        case 16:
          value=(int)ByteBuffer.wrap( data ).order( ByteOrder.LITTLE_ENDIAN ).getShort();
          break;
        default:
        }
        float w=value*0.8/32767/2;//max(1, mouseY);
        strokeWeight(thick*interval);
        stroke(255);
        line(x-w, min+thick*index, x+w, min+thick*index);
      }
      index++;
    }
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

