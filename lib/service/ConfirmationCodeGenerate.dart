// ignore_for_file: file_names

import 'dart:math';

String generateConfirmationCode() =>
    (100000 + Random().nextInt(900000)).toString();
