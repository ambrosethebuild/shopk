import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Invalid name",
        "fr": "Nom incorrect",
        "es": "Nombre inválido",
        "de": "Ungültiger Name",
        "pt": "Nome inválido",
        "ar": "اسم غير صحيح",
        "ko": "잘못된 이름"
      } +
      {
        "en": "Invalid email address",
        "fr": "Adresse e-mail invalide",
        "es": "Dirección de correo electrónico inválida",
        "de": "Ungültige E-Mail-Adresse",
        "pt": "Endereço de email invalido",
        "ar": "عنوان البريد الإلكتروني غير صالح",
        "ko": "잘못된 이메일 주소"
      } +
      {
        "en": "Invalid Phone",
        "fr": "Téléphone invalide",
        "es": "Teléfono inválido",
        "de": "Ungültiges Telefon",
        "pt": "Telefone inválido",
        "ar": "رقم الهاتف غير صحيح",
        "ko": "잘못된 전화"
      } +
      {
        "en": "Phone must be more than 9 digists",
        "fr": "Le téléphone doit comporter plus de 9 chiffres",
        "es": "El teléfono debe tener más de 9 dígitos",
        "de": "Telefon muss mehr als 9 Digisten sein",
        "pt": "O telefone deve ter mais de 9 dígitos",
        "ar": "يجب أن يكون الهاتف أكثر من 9 رقمي",
        "ko": "전화는 9 명 이상의 디지 스트 여야합니다."
      } +
      {
        "en": "Phone must be less than 14 digists",
        "fr": "Le téléphone doit comporter moins de 14 chiffres",
        "es": "El teléfono debe tener menos de 14 dígitos",
        "de": "Das Telefon muss weniger als 14 Digisten sein",
        "pt": "O telefone deve ter menos de 14 dígitos",
        "ar": "يجب أن يكون الهاتف أقل من 14 رقمًا",
        "ko": "전화는 14 명 미만이어야합니다."
      } +
      {
        "en": "Password must be more than 6 character",
        "fr": "Le mot de passe doit contenir plus de 6 caractères",
        "es": "La contraseña debe tener más de 6 caracteres",
        "de": "Das Passwort muss aus mehr als 6 Zeichen bestehen",
        "pt": "A senha deve ter mais de 6 caracteres",
        "ar": "يجب أن تكون كلمة المرور أكثر من 6 أحرف",
        "ko": "비밀번호는 6 자 이상이어야합니다."
      } +
      {
        "en": "is empty",
        "fr": "est vide",
        "es": "esta vacio",
        "de": "ist leer",
        "pt": "está vazia",
        "ar": "فارغ",
        "ko": "비었다"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
