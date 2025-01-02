import { CompressLevel, CompressMode, LogLevel, LogMode } from "./Types";

export class LogConfig {
  static readonly DEFAULT_CACHE_DAYS: number = 0;

  public level: LogLevel;
  public mode: LogMode;
  public logDir: string;
  public namePrefix: string;
  public pubKey: string;
  public compressMode: CompressMode;
  public compressLevel: CompressLevel;
  public cacheDir: string;
  public cacheDays: number;

  constructor(level: LogLevel = LogLevel.LEVEL_INFO, mode: LogMode = LogMode.Async, logDir: string = "", namePrefix: string = "", pubKey: string = "", compressMode: CompressMode = CompressMode.ZLIB, compressLevel: CompressLevel = CompressLevel.ZSTD_COMPRESS_LEVEL6, cacheDir: string = "", cacheDays: number = LogConfig.DEFAULT_CACHE_DAYS) {
    this.level = level;
    this.mode = mode;
    this.logDir = logDir;
    this.namePrefix = namePrefix;
    this.pubKey = pubKey;
    this.compressMode = compressMode;
    this.compressLevel = compressLevel;
    this.cacheDir = cacheDir;
    this.cacheDays = cacheDays;
  }
}