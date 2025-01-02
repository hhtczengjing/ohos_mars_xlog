import { LogConfig } from "./LogConfig";
import { LogLevel, LogMode } from "./Types";
import process from "@ohos.process";
import { HiLogClient } from "./client/impl/HiLogClient";
import { ILoggerClient } from "./client/ILoggerClient";

export class LoggerManager {
  private static readonly cacheDays: number = 0;
  private static logDir: string = '';
  private static cacheDir: string = '';
  private static pubKey = '';
  private static consoleLog: boolean = false;
  private static maxFileSize = 50 * 1024 * 1024;
  private static maxAliveTime = 7 * 24 * 60 * 60;
  private static sharedLogger: ILoggerClient = new HiLogClient();

  static getConsoleLogOpen(): boolean {
    return LoggerManager.consoleLog;
  }

  static setLogDir(logDir: string): void {
    LoggerManager.logDir = logDir;
  }

  static getLogDir(): string {
    return LoggerManager.logDir;
  }

  static setCacheDir(cacheDir: string): void {
    LoggerManager.cacheDir = cacheDir;
  }

  static getCacheDir(): string {
    return LoggerManager.cacheDir;
  }

  static setPubKey(key: string): void {
    LoggerManager.pubKey = key;
  }

  static getPubKey(): string {
    return LoggerManager.pubKey;
  }

  static setLogger(client: ILoggerClient) {
    LoggerManager.sharedLogger = client;
  }

  static getLogger(): ILoggerClient {
    return LoggerManager.sharedLogger;
  }

  static setMaxFileSize(maxFileSize: number) {
    if (LoggerManager.sharedLogger) {
      LoggerManager.maxFileSize = maxFileSize;
      LoggerManager.sharedLogger.setMaxFileSize(0, maxFileSize);
    }
  }

  static setMaxAliveTime(maxAliveTime: number) {
    if (LoggerManager.sharedLogger) {
      LoggerManager.maxAliveTime = maxAliveTime;
      LoggerManager.sharedLogger.setMaxAliveTime(0, maxAliveTime);
    }
  }

  public static appenderOpen(level: LogLevel, mode: LogMode, logDir: string, namePrefix: string) {
    if (LoggerManager.sharedLogger) {
      const config = new LogConfig();
      config.level = level;
      config.mode = mode;
      config.logDir = logDir;
      config.namePrefix = namePrefix;
      config.pubKey = LoggerManager.pubKey;
      config.cacheDir = LoggerManager.cacheDir;
      config.cacheDays = LoggerManager.cacheDays;
      LoggerManager.sharedLogger.appenderOpen(config);
    }
  }

  static appenderClose() {
    if (LoggerManager.sharedLogger) {
      LoggerManager.sharedLogger.appenderClose();
    }
  }

  public static appenderFlush(): void {
    if (LoggerManager.sharedLogger) {
      LoggerManager.sharedLogger.appenderFlush(0, false);
    }
  }

  static appenderFlush1(isSync: boolean) {
    if (LoggerManager.sharedLogger) {
      LoggerManager.sharedLogger.appenderFlush(0, isSync);
    }
  }

  static getLogLevel(): LogLevel {
    if (LoggerManager.sharedLogger) {
      return LoggerManager.sharedLogger.getLogLevel(0);
    }
    return LogLevel.LEVEL_NONE;
  }

  static setLogLevel(level: LogLevel): void {
    if (LoggerManager.sharedLogger) {
      LoggerManager.sharedLogger.setLogLevel(0, level);
    }
  }

  static setConsoleLogOpen(isOpen: boolean) {
    LoggerManager.consoleLog = isOpen;
    if (LoggerManager.sharedLogger) {
      LoggerManager.sharedLogger.setConsoleLogOpen(0, isOpen);
    }
  }

  static f(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_FATAL) {
      instance.printFatal(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static e(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_ERROR) {
      instance.printError(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static w(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_WARNING) {
      instance.printWarn(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static i(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_INFO) {
      instance.printInfo(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static d(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_DEBUG) {
      instance.printDebug(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static v(tag: string, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_VERBOSE) {
      instance.printVerbose(0, tag, "", "", 0, process.pid, process.tid, process.pid, message);
    }
  }

  static printErrStackTrace(tag: string, error: Error, message: string) {
    const instance = LoggerManager.sharedLogger;
    if (instance && LoggerManager.getLogLevel() <= LogLevel.LEVEL_ERROR) {
      const i27 = error.name + '\n' + error.message + '\n' + error.stack ? error.stack : "";
      instance.printFatal(0, tag, "", "", 0, process.pid, process.tid, process.pid, message + '\n' + i27);
    }
  }
}