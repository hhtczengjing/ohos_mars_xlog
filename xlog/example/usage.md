1、初始化

```typescript
const builder = new XLogBuilder();
builder.logDir = this.context.filesDir + '/logs'; // 必填，日志的输出路径，如 getContext(this).filesDir + "/logs"
builder.namePrefix = "mylog"; // 必填，日志文件的前缀名称
builder.logLevel = LogLevel.LEVEL_ALL; // 可选，设置日志输出等级
builder.mode = LogMode.Async; // 可选，设置日志写入模式
builder.consoleLog = true; // 可选，是否同时将日志打印到console
builder.pubKey = "xxxxx"; // 可选，可参考 https://github.com/Tencent/mars 使用 `gen_key.py` 生成公私钥
builder.maxFileSize = 50 * 1024 * 1024; // 可选，设置单个日志文件的最大值，单位字节，默认50M
builder.maxAliveTime = 7 * 24 * 60 * 60; // 可选，设置日志文件的保存时间，单位秒，默认7天
XLog.init(builder);
```

2、打印

```typescript
XLog.d("tag", "xxxxxxx");
XLog.i("tag", "xxxxxxx");
XLog.w("tag", "xxxxxxx");
XLog.e("tag", "xxxxxxx");
XLog.f("tag", "xxxxxxx");
XLog.printErrStackTrace("tag", error, "xxxx");
```