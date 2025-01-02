import { LoggerManager } from "./LoggerManager";
import { XLogBuilder } from "./XLogBuilder";
import { LogLevel, LogMode } from "./Types";
import process from "@ohos.process";
import { XLogClient } from "./client/impl/XLogClient";

export class XLog {
  private static initialed: boolean = false;
  private static readonly TAG: string = 'Logger';

  public static init(builder: XLogBuilder): void {
    if (XLog.initialed) {
      LoggerManager.getLogger().printWarn(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "[Logger Init] XLog has already initted!");
      return;
    }

    if (!builder) {
      LoggerManager.getLogger().printError(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "[Logger Init] Failed to init XLog, builder is null or undefined.");
      return;
    }

    if (builder.logLevel < LogLevel.LEVEL_ALL || builder.logLevel > LogLevel.LEVEL_NONE) {
      LoggerManager.getLogger().printError(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "[Logger Init] Failed to init XLog, log level is invalid.");
      return;
    }

    if (builder.mode != LogMode.Async && builder.mode != LogMode.Sync) {
      LoggerManager.getLogger().printError(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "[Logger Init] Failed to init XLog, log mode is invalid.");
      return;
    }

    const xlog = new XLogClient();
    LoggerManager.setLogger(xlog);
    LoggerManager.setPubKey(builder.pubKey);
    LoggerManager.appenderOpen(builder.logLevel, builder.mode, builder.logDir, builder.namePrefix);
    LoggerManager.setConsoleLogOpen(builder.consoleLog);
    LoggerManager.setMaxFileSize(builder.maxFileSize);
    LoggerManager.setMaxAliveTime(builder.maxAliveTime);
    LoggerManager.setLogDir(builder.logDir);
    XLog.initialed = true;
    LoggerManager.getLogger().printInfo(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "[Logger Init] Init XLog success!");
  }

  /**
   * 强制将日志写入文件(含日志子实例)
   */
  static flushLog(): void {
    LoggerManager.appenderFlush();
  }

  /**
   * 关闭日志实例(含日志子实例)
   */
  static closeLog(): void {
    LoggerManager.appenderClose();
  }

  /**
   * 获取日志等级(仅日志主实例)
   */
  static getLogLevel(): LogLevel {
    return LoggerManager.getLogLevel();
  }

  /**
   * 设置日志等级(含日志子实例)
   *
   * @param level 日志等级
   */
  static setLogLevel(level: LogLevel): void {
    if (level < LogLevel.LEVEL_ALL || level > LogLevel.LEVEL_NONE) {
      LoggerManager.getLogger().printInfo(0, XLog.TAG, "", "", 0, process.pid, process.tid, process.pid, "Failed to set log level, log level is invalid.");
      return;
    }
    LoggerManager.setLogLevel(level);
  }

  public static f(tag: string, message: string): void {
    LoggerManager.f(tag, message);
  }

  public static e(tag: string, message: string): void {
    LoggerManager.e(tag, message);
  }

  public static w(tag: string, message: string): void {
    LoggerManager.w(tag, message);
  }

  public static i(tag: string, message: string): void {
    LoggerManager.i(tag, message);
  }

  public static d(tag: string, message: string): void {
    LoggerManager.d(tag, message);
  }

  public static v(tag: string, message: string): void {
    LoggerManager.v(tag, message);
  }

  public static printErrStackTrace(tag: string, error: Error, message: string): void {
    LoggerManager.printErrStackTrace(tag, error, message);
  }
}