import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'secret.dart';
import 'package:minio/minio.dart';

Future<void> main(List<String> args) async {
  List<String> urls=[];
  for(var item in args){
    Uint8List fileEncode;
    try{
      fileEncode=File(item).readAsBytesSync();
    }
    catch(e){
      print('Failed to Upload: $e');
      return;
    }
    urls.add(await base64ToUrl(fileEncode, '${DateTime.now().toIso8601String()}-${randomString(5)}.png'));
  }
  print('Upload Success:');
  for(var item in urls){
    print(item);
  }
  return;
}
String randomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}



/// 将Uint8List数据上传到S3并返回访问URL
/// [base64] 图片的字节数据
/// [filename] 文件名
/// 返回上传成功后的完整URL
Future<String> base64ToUrl(Uint8List base64, String filename) async {
  try {
    // 创建MinIO客户端
    final minio = Minio(
      endPoint: endPoint,
      accessKey: ak,
      secretKey: sk,
      region: area,
    );

    // 上传文件到S3
    final objectName = 'images/$filename';
    await minio.putObject(
      bucket,
      objectName,
      Stream<Uint8List>.value(base64),
      size: base64.length,
    );

    // 构建完整的访问URL
    // 格式: https://bucket.endpoint/objectName
    final url = 'https://$bucket.$endPoint/$objectName';

    return url;
  } catch (e) {
    // 上传失败时抛出异常
    throw Exception('S3上传失败: $e');
  }
}
