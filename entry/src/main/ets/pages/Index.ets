import { XLog } from '@devzeng/xlog';
import { util } from '@kit.ArkTS';

@Extend(TextArea)
function inputStyle() {
  .width('100%')
  .borderRadius(0)
  .fontSize(16)
  .fontColor('#020F22')
}

@Extend(Button)
function btnStyle() {
  .fontSize(16)
  .fontWeight(FontWeight.Regular)
  .backgroundColor('#344F9C')
  .width('35%')
}

const TAG = '[Index]';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    this.requestData();
  }

  build() {
    Column() {
      TextArea({ text: this.message })
        .inputStyle()
        .height('60%')
        .margin({ top: 10 })

      Row() {
        Button('写入日志')
          .btnStyle()
          .onClick(() => {
            this.writeToLog(this.message);
          })

        Button('刷新日志')
          .btnStyle()
          .onClick(() => {
            this.flushLog();
          })
      }
      .padding({ left: 10, right: 10 })
      .margin({ top: 20 })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }

  requestData() {
    this.readTextContent('log.txt').then((value) => {
      this.message = value;
    });
  }

  flushLog() {
    XLog.i(TAG, '开始刷新日志...');
    XLog.flushLog();
    XLog.i(TAG, '完成日志刷新');
  }

  writeToLog(message: string) {
    XLog.i(TAG, '开始写入日志...');
    XLog.i(TAG, message);
    XLog.w(TAG, message);
    XLog.d(TAG, message);
    XLog.e(TAG, message);
    XLog.v(TAG, message);
    XLog.f(TAG, message);
    XLog.i(TAG, '完成日志写入');
  }

  readTextContent(name: string): Promise<string> {
    return new Promise((resolve, reject) => {
      getContext(this).resourceManager.getRawFileContent(name, (error, rawFile) => {
        if (error) {
          reject(error);
          return;
        }
        const textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
        const js = textDecoder.decodeToString(rawFile);
        resolve(js);
      });
    });
  }
}