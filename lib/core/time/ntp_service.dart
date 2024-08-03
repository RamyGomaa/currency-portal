import 'package:ntp/ntp.dart';

abstract class NTPService {
  Future<DateTime> now();
}

class NTPServiceImpl implements NTPService {
  @override
  Future<DateTime> now() async {
    return await NTP.now();
  }
}
