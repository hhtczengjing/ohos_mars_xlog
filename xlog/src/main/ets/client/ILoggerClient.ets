import { LogConfig } from "../LogConfig";
import { LogLevel, LogMode } from "../Types";

export interface ILoggerClient {
  printVerbose(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  printError(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  printWarn(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  printInfo(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  printDebug(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  printFatal(logInstancePtr: number, tag: string, filename: string, funcName: string, line: number, pid: number, tid: number, mainTid: number, log: string): void;

  getLogLevel(logInstancePtr: number): LogLevel;

  setLogLevel(logInstancePtr: number, level: LogLevel): void;

  setAppenderMode(logInstancePtr: number, mode: LogMode): void;

  newXlogInstance(xlogConfig: LogConfig): number;

  getXlogInstance(namePrefix: string): number;

  releaseXlogInstance(namePrefix: string): void;

  appenderOpen(xlogConfig: LogConfig): void;

  appenderClose(): void;

  appenderFlush(logInstancePtr: number, isSync: boolean): void;

  setConsoleLogOpen(logInstancePtr: number, isOpen: boolean): void;

  setMaxFileSize(logInstancePtr: number, maxSize: number): void;

  setMaxAliveTime(logInstancePtr: number, maxTime: number): void;
}