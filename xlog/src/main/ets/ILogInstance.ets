/**
 * 日志子实例
 */
export interface ILogInstance {
  /**
   * 打印日志(FATAL)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  f(tag: string, message: string): void;

  /**
   * 打印日志(ERROR)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  e(tag: string, message: string): void;

  /**
   * 打印日志(WARNING)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  w(tag: string, message: string): void;

  /**
   * 打印日志(INFO)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  i(tag: string, message: string): void;

  /**
   * 打印日志(DEBUG)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  d(tag: string, message: string): void;

  /**
   * 打印日志(VERBOSE)
   *
   * @param tag Tag
   * @param message 日志内容
   */
  v(tag: string, message: string): void;

  /**
   * 打印错误堆栈
   *
   * @param tag Tag
   * @param error 错误信息
   * @param message 日志内容
   */
  printErrStackTrace(tag: string, error: Error, message: string): void;

  appenderFlush(): void;

  /**
   * 强制将日志写入文件
   */
  flushLog(): void;

  /**
   * 获取日志等级
   */
  getLogLevel(): number;

  /**
   * 设置日志等级
   * @param level 日志等级
   */
  setLogLevel(level: number): void;

  /**
   * 设置是否打印到控制台，不设置则默认使用主实例设置
   *
   * @param isOpen 开启状态
   */
  setConsoleLogOpen(isOpen: boolean): void;

  /**
   * 设置单个日志文件的最大值，不设置则默认使用主实例设置
   *
   * @param maxFileSize 文件大小最大值，单位字节
   */
  setMaxFileSize(maxFileSize: number): void;

  /**
   * 设置日志文件的保存时间，不设置则默认使用主实例设置
   *
   * @param maxAliveTime 文件最大保存时间，单位秒
   */
  setMaxAliveTime(maxAliveTime: number): void;
}