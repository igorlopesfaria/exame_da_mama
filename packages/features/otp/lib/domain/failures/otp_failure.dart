import 'package:commons_infra/failures/app_failures.dart';

class InvalidCode extends Failure { const InvalidCode() : super('Invalid or expired code'); }
class TooManyAttempts extends Failure { const TooManyAttempts() : super('Too many attempts'); }
