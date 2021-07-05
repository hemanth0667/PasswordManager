import 'package:encrypt/encrypt.dart' as en;

class Encrypt_decrypt {
  static final key = en.Key.fromLength(32);
  static final iv = en.IV.fromLength(16);

  static final encrypter = en.Encrypter(en.AES(key));
  static encrypt(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static decrypt(text) {
    final decrypted = encrypter.decrypt64(text, iv: iv);
    return decrypted;
  }
}
