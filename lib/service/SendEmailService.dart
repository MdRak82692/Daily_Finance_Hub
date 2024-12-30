// ignore_for_file: file_names

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../untils/CustomDateTime.dart';

Future<void> sendEmailConfirmationCode(
    String email, String confirmationCode) async {
  final smtpServer = gmail('mdrak82692@gmail.com', 'rdjpcudzykcpftrj');
  final message = Message()
    ..from = const Address('mdrak82692@gmail.com', 'Daily Finance Hub')
    ..recipients.add(email)
    ..subject = 'Confirmation Code'
    ..html = '''<p>Your Confirmation Code is <b>$confirmationCode</b></p>
                  <p>The Confirmation Code will <b>Expire</b> after <b>10 minutes</b>.</p>
                  <p>Before <b>${formatDate(DateTime.now())} ${formatTime(DateTime.now().add(const Duration(minutes: 10)))}</b> Time & Date, You need be Enter the Confirmation Code.</p>
                  <p>After This <b>${formatDate(DateTime.now())} ${formatTime(DateTime.now().add(const Duration(minutes: 10)))}</b> Time & Date, The Confirmation Code will not Valid.</p>
                  ''';

  try {
    await send(message, smtpServer);
  } on MailerException catch (e) {
    // ignore: avoid_print
    print('Message not sent. \n$e');
  }
}
