// DI
export 'di/injection.dart';

// Failures
export 'domain/failures/validation_failure.dart';

// Repository interface
export 'domain/repositories/i_validation_repository.dart';

// Use cases
export 'domain/usecases/validate_email_usecase.dart';
export 'domain/usecases/validate_phone_usecase.dart';
export 'domain/usecases/validate_cpf_usecase.dart';
export 'domain/usecases/validate_password_usecase.dart'; // also exports PasswordStrength
