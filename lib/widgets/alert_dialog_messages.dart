import 'package:flutter/material.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

class DateTimeNotMatched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      dialogTitle: 'Hata!',
      dialogContent:
          'Belirtmiş olduğunuz tarih aralığında herhangi bir veri bulunamamıştır.',
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
          'Kullanıcı adınız veya şifreniz yanlış. Lütfen tekrar deneyiniz.',
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
