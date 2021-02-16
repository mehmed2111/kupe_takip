import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kupe/widgets/agree_or_not_button_widget.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

class AgreeOrNotAgreeVaccineDate extends StatelessWidget {
  final Function agreeOnPressed;
  final Function notAgreeOnPressed;

  AgreeOrNotAgreeVaccineDate({
    @required this.agreeOnPressed,
    @required this.notAgreeOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AgreeOrNotButton(
      dialogTitle: 'Aşı Tarihi',
      dialogContent:
          'Aşı tarihi olarak bugünkü tarih girilecektir. Onaylıyor musunuz?',
      agreeBtnTitle: 'Evet',
      notAgreeBtnTitle: 'Hayır',
      agreeOnPressed: agreeOnPressed,
      notAgreeOnPressed: notAgreeOnPressed,
    );
  }
}

class VaccineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Aşı Tarih',
      dialogContent:
          'Buradaki alan dostunuzun son aşı tarihini göstermektedir.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class VaccineEndDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Kalan Süre',
      dialogContent:
          'Buradaki alan dostunuzun bir sonraki aşısı için kalan süreyi göstermektedir.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class AnimalIdDoesNotMatched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent: 'Dostunaza ait herhangi bir sağlık eşleşmesi bulunamadı.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class DateTimeNotMatched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent:
          'Belirtmiş olduğunuz tarih aralığında herhangi bir konum verisi bulunamadı.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class InternetError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'İnternet hatası!',
      dialogContent:
          'Lütfen internete bağlı olduğunuzdan emin olun ve tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class UnsuccessfulLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Giriş Başarısız!',
      dialogContent:
          'Kullanıcı adınız veya şifreniz yanlış. Lütfen verilerinizi kontrol edin ve tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class CouldNotLoadData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent:
          'Verileriniz yüklenemedi. Lütfen daha sonra tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class EmptyAreaError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent:
          'Alanlar boş bırakılamaz. Lütfen boş alanları doldurun ve tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class CheckFilledArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent:
          'Lütfen girmiş olduğunuz bilgileri kontrol edin ve tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class PasswordError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Şifre Hatası!',
      dialogContent: 'Lütfen şifrenizi kontrol edin ve tekrar deneyin.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class ProfileIsUpToDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Profiliniz Güncel!',
      dialogContent:
          'Profilinizde yer alan bilgiler zaten güncel bilgilerinizdir.',
      btnTitle: 'Kapat',
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class OnBackPressedExitOrNot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AgreeOrNotButton(
      dialogTitle: 'Çıkış Yap',
      dialogContent: 'Uygulamadan çıkmak istediğinize emin misiniz?',
      agreeBtnTitle: 'Evet',
      notAgreeBtnTitle: 'Hayır',
      agreeOnPressed: () => exit(0),
      notAgreeOnPressed: () => Navigator.of(context).pop(false),
    );
  }
}
