import { LogConfig } from "../../LogConfig";
import { LogLevel, LogMode } from "../../Types";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { ILoggerClient } from "../ILoggerClient";

export class HiLogClient implements ILoggerClient {
  private static readonly domain = 0x0000;
  private static readonly format = '%{public}s';
  private static level = LogLevel.LEVEL_ALL;

  printVerbose(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.info(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  printError(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.error(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  printWarn(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.warn(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  printInfo(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.info(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  printDebug(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.debug(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  printFatal(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    hilog.fatal(HiLogClient.domain, tag, HiLogClient.format, log);
  }

  getLogLevel(logInstancePtr: number): LogLevel {
    return HiLogClient.level;
  }

  setLogLevel(logInstancePtr: number, level: LogLevel): void {
    HiLogClient.level = level;
  }

  setAppenderMode(logInstancePtr: number, mode: LogMode): void {
    // do nothing
  }

  newXlogInstance(xlogConfig: LogConfig): number {
    return 0;
  }

  getXlogInstance(namePrefix: string): number {
    return 0;
  }

  releaseXlogInstance(namePrefix: string): void {
    // do nothing
  }

  appenderOpen(xlogConfig: LogConfig): void {
    // do nothing
  }

  appenderClose(): void {
    // do nothing
  }

  appenderFlush(logInstancePtr: number, isSync: boolean): void {
    // do nothing
  }

  setConsoleLogOpen(logInstancePtr: number, isOpen: boolean): void {
    // do nothing
  }

  setMaxFileSize(logInstancePtr: number, maxSize: number): void {
    // do nothing
  }

  setMaxAliveTime(logInstancePtr: number, maxTime: number): void {
    // do nothing
  }

}