# PTGs iOS App

这是 Terry 的 **PTGs iOS / Xcode 工程公开备份仓库**。

## 在 Mac 上恢复工程

1. 点击 GitHub 页面右上方 **Code → Download ZIP**。
2. 解压下载的仓库。
3. 打开“终端”，进入解压后的文件夹，运行：

```bash
bash 恢复PTGs工程.command
```

脚本会自动：

- 合并 `bundle_parts` 中的完整工程归档；
- 校验 SHA-256，确认文件没有损坏；
- 解压到 `PTGs-restored` 文件夹；
- 在 Finder 中自动打开恢复后的工程。

随后打开其中的 `PTGs.xcodeproj`，使用 Xcode 16+，选择 iOS 17+ 模拟器或真机运行。

## 备份内容

工程包含 SwiftUI 源码、测试、配置、Xcode 工程、README 与验证文档；已排除本地 `.git`、Xcode 用户缓存、`.DS_Store` 等无关文件。检查中未发现真实 API Key。

> 受当前上传接口的二进制传输限制，备份版将原始大尺寸 PNG 图标替换为同尺寸的轻量 PTG 图标；应用源码和功能文件未改动。

## 完整性校验

恢复后的归档 SHA-256：

```text
5df0f386adb08c41e5f83dcb1b265a094fe02772cc6d690a8ef6a01e216c21ce
```

仓库内 11 个数据分段均已逐一核对 Git Blob 哈希，与本地备份原件一致；恢复演练已成功还原 `PTGs.xcodeproj` 与 39 个 Swift 文件。
