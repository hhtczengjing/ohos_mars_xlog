import { ILoggerClient } from "../ILoggerClient";
import { LogConfig } from "../../LogConfig";
import { LogLevel, LogMode } from "../../Types";
import xlog from 'libmarsxlog.so';

export class XLogClient implements ILoggerClient {
  printVerbose(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_VERBOSE, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  printError(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_ERROR, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  printWarn(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_WARNING, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  printInfo(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_INFO, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  printDebug(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_DEBUG, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  printFatal(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void {
    xlog.logWrite2(logInstancePtr, LogLevel.LEVEL_FATAL, tag, filename, funcName, line, pid, tid, mainTid, log);
  }

  getLogLevel(logInstancePtr: number): LogLevel {
    return xlog.getLogLevel(logInstancePtr) as LogLevel;
  }

  setLogLevel(logInstancePtr: number, level: LogLevel): void {
    xlog.setLogLevel(logInstancePtr, level);
  }

  setAppenderMode(logInstancePtr: number, mode: LogMode): void {
    xlog.setAppenderMode(logInstancePtr, mode);
  }

  newXlogInstance(xlogConfig: LogConfig): number {
    return xlog.newXlogInstance(xlogConfig);
  }

  getXlogInstance(namePrefix: string): number {
    return xlog.getXlogInstance(namePrefix);
  }

  releaseXlogInstance(namePrefix: string): void {
    xlog.releaseXlogInstance(namePrefix);
  }

  appenderOpen(xlogConfig: LogConfig): void {
    xlog.appenderOpen(xlogConfig);
  }

  appenderClose(): void {
    xlog.appenderClose();
  }

  appenderFlush(logInstancePtr: number, isSync: boolean): void {
    xlog.appenderFlush(logInstancePtr, isSync);
  }

  setConsoleLogOpen(logInstancePtr: number, isOpen: boolean): void {
    xlog.setConsoleLogOpen(logInstancePtr, isOpen);
  }

  setMaxFileSize(logInstancePtr: number, maxSize: number): void {
    xlog.setMaxFileSize(logInstancePtr, maxSize);
  }

  setMaxAliveTime(logInstancePtr: number, maxTime: number): void {
    xlog.setMaxAliveTime(logInstancePtr, maxTime);
  }
}