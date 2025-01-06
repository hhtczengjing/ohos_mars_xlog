import { LogLevel, LogMode } from "./Types";

export class XLogBuilder {
  private static readonly DEFAULT_NAME_PREFIX = 'XLog';
  private static readonly DEFAULT_FILE_SIZE: number = 50 * 1024 * 1024;
  private static readonly DEFAULT_ALIVE_TIME: number = 7 * 24 * 60 * 60;

  // 日志的输出路径，必填，填写示例如 getContext(this).filesDir + "/logs"
  public logDir: string;

  // 日志文件的前缀名称，必填
  public namePrefix: string;

  // 设置日志输出等级
  public logLevel: LogLevel;

  // 设置日志写入模式，分同步和异步，Release版本一定要用异步Async方式，Debug版本两个都可以，Sync可能有卡顿
  public mode: LogMode;

  // 是否同时将日志打印到console
  public consoleLog: boolean;

  // 可参考 https://github.com/Tencent/mars 使用 `gen_key.py` 生成公私钥
  public pubKey: string;

  // 设置单个日志文件的最大值，单位字节，默认50M
  public maxFileSize: number;

  // 设置日志文件的保存时间，单位秒，默认7天
  public maxAliveTime: number;

  constructor() {
    this.logLevel = LogLevel.LEVEL_ALL;
    this.mode = LogMode.Async;
    this.logDir = "";
    this.namePrefix = XLogBuilder.DEFAULT_NAME_PREFIX;
    this.consoleLog = false;
    this.pubKey = "";
    this.maxFileSize = XLogBuilder.DEFAULT_FILE_SIZE;
    this.maxAliveTime = XLogBuilder.DEFAULT_ALIVE_TIME;
  }
}