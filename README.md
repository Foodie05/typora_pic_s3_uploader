# Typora S3 Uploader

这是一个用于 **Typora 图片上传** 的小工具，使用 **Dart + MinIO SDK** 实现，可以将本地图片上传到 **S3/MinIO** 并返回可访问的 URL。
适合自建对象存储（MinIO）或兼容 S3 的云存储服务。

---

## 功能特性 ✨

* 支持从命令行批量上传图片
* 自动为文件生成唯一文件名（基于时间戳 + 随机字符串）
* 上传后输出完整的访问 URL，方便在 Typora 中自动替换为网络链接
* 简单、轻量、跨平台（Linux / macOS / Windows）

---

## 项目结构 📂

```
.
├── main.dart        # 程序入口
├── secret.dart      # 存储 S3 配置（需手动创建）
└── pubspec.yaml     # 依赖配置文件
```

---

## 安装与配置 ⚙️

### 1. 克隆项目

```bash
git clone https://github.com/yourname/typora-s3-uploader.git
cd typora-s3-uploader
```

### 2. 安装依赖

```bash
dart pub get
```

### 3. 配置 S3 账号信息

在项目根目录新建 **secret.dart** 文件，填入你的 S3/MinIO 配置信息：

```dart
// secret.dart
const String endPoint = "s3.yourdomain.com"; // MinIO/S3 访问域名
const String ak = "your-access-key";         // Access Key
const String sk = "your-secret-key";         // Secret Key
const String bucket = "your-bucket";         // 存储桶名称
const String area = "us-east-1";             // 区域（若不需要可随意填）
```

---

## 使用方法 🚀

### 1. 命令行上传图片

例如要上传 `test.png`：

```bash
dart run bin/typora_uploader.dart test.png
```

成功后输出：

```
Upload Success:
https://your-bucket.s3.yourdomain.com/images/2025-09-07T10:12:30.123Z-AbC12.png
```

### 2. Typora 配置上传命令

在 Typora 中打开：

> 偏好设置 → 图像 → 上传服务设定

选择 **自定义命令**，填入：

```
dart run /path/to/project/bin/typora_uploader.dart
```

这样在 Typora 中粘贴图片时，会自动调用该脚本上传并替换为网络 URL。

---

## 注意事项 ⚠️

* 请确认你的 S3/MinIO 存储桶已开启 **公有读权限** 或配置了正确的 CDN/网关，否则上传后可能无法访问。
* 建议为不同用途的图片设置单独的存储路径（本项目默认上传到 `images/` 目录）。
* 仅用于 Typora 图床上传，不适合作为生产环境大规模文件上传工具。

---

## License 📜

MIT License

---

# Typora S3 Uploader

This is a small tool for **Typora image uploading**, built with **Dart + MinIO SDK**.
It allows you to upload local images to **S3/MinIO** and returns an accessible URL.
Suitable for self-hosted object storage (MinIO) or any cloud storage service compatible with S3.

---

## Features ✨

* Support batch image uploads from the command line
* Automatically generates unique filenames (timestamp + random string)
* Outputs a full access URL after upload, making it easy for Typora to replace with a web link
* Simple, lightweight, and cross-platform (Linux / macOS / Windows)

---

## Project Structure 📂

```
.
├── main.dart        # Entry point
├── secret.dart      # Stores S3 configuration (must be created manually)
└── pubspec.yaml     # Dependency configuration file
```

---

## Installation & Configuration ⚙️

### 1. Clone the project

```bash
git clone https://github.com/yourname/typora-s3-uploader.git
cd typora-s3-uploader
```

### 2. Install dependencies

```bash
dart pub get
```

### 3. Configure your S3 account

Create a **secret.dart** file in the project root directory and fill in your S3/MinIO configuration:

```dart
// secret.dart
const String endPoint = "s3.yourdomain.com"; // MinIO/S3 endpoint
const String ak = "your-access-key";         // Access Key
const String sk = "your-secret-key";         // Secret Key
const String bucket = "your-bucket";         // Bucket name
const String area = "us-east-1";             // Region (arbitrary if not required)
```

---

## Usage 🚀

### 1. Upload images via command line

For example, to upload `test.png`:

```bash
dart run bin/typora_uploader.dart test.png
```

If successful, it outputs:

```
Upload Success:
https://your-bucket.s3.yourdomain.com/images/2025-09-07T10:12:30.123Z-AbC12.png
```

### 2. Configure Typora upload command

In Typora, go to:

> Preferences → Image → Image Upload Settings

Choose **Custom Command** and enter:

```
dart run /path/to/project/bin/typora_uploader.dart
```

Now, whenever you paste an image in Typora, it will automatically call this script, upload it, and replace it with the corresponding web URL.

---

## Notes ⚠️

* Make sure your S3/MinIO bucket has **public read permission** enabled or is properly configured with CDN/gateway; otherwise, the uploaded image may not be accessible.
* It’s recommended to use separate storage paths for different image purposes (this project defaults to uploading under the `images/` directory).
* Intended only for Typora image hosting, not for large-scale file uploads in production.

---

## License 📜

MIT License
