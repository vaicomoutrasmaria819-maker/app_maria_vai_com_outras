// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class StorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // Upload de imagem
//   Future<String> uploadImage({
//     required File imageFile,
//     required String path,
//   }) async {
//     try {
//       final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final ref = _storage.ref().child('$path/$fileName');
//
//       final uploadTask = ref.putFile(imageFile);
//       final snapshot = await uploadTask;
//
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       throw Exception('Erro ao fazer upload da imagem: $e');
//     }
//   }
//
//   // Upload de múltiplas imagens
//   Future<List<String>> uploadImages({
//     required List<File> imageFiles,
//     required String path,
//   }) async {
//     final urls = <String>[];
//
//     for (final file in imageFiles) {
//       final url = await uploadImage(imageFile: file, path: path);
//       urls.add(url);
//     }
//
//     return urls;
//   }
//
//   // Deletar imagem
//   Future<void> deleteImage(String imageUrl) async {
//     try {
//       final ref = _storage.refFromURL(imageUrl);
//       await ref.delete();
//     } catch (e) {
//       throw Exception('Erro ao deletar imagem: $e');
//     }
//   }
//
//   // Deletar múltiplas imagens
//   Future<void> deleteImages(List<String> imageUrls) async {
//     for (final url in imageUrls) {
//       await deleteImage(url);
//     }
//   }
// }