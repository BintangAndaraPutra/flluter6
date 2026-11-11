import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators.isValidEmail', () {
    test('accepts a valid email address', () {
      expect(Validators.isValidEmail('user@example.com'), isTrue);
    });

    test('rejects malformed or incomplete email addresses', () {
      expect(Validators.isValidEmail(''), isFalse);
      expect(Validators.isValidEmail('userexample.com'), isFalse);
      expect(Validators.isValidEmail('user@'), isFalse);
      expect(Validators.isValidEmail('user@example.com trailing'), isFalse);
    });
  });

  group('Validators.sanitize', () {
    test('escapes HTML and script injection characters', () {
      expect(
        Validators.sanitize('<script>alert("x")</script>'),
        '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      );
    });

    test('escapes ampersands and apostrophes', () {
      expect(Validators.sanitize("Tom & Jerry's"), 'Tom &amp; Jerry&#x27;s');
    });
  });

  group('Validators.validateText', () {
    test('rejects empty or too-short input', () {
      expect(Validators.validateText('  '), isNotNull);
      expect(Validators.validateText('ab', minLength: 3), isNotNull);
    });

    test('accepts input within the configured length', () {
      expect(
        Validators.validateText('hello', minLength: 3, maxLength: 5),
        isNull,
      );
    });

    test('rejects input longer than the configured maximum', () {
      expect(Validators.validateText('hello!', maxLength: 5), isNotNull);
    });
  });

  group('Additional validators', () {
    test('validates phone numbers with 10 to 13 digits', () {
      expect(Validators.validatePhone('1234567890'), isNull);
      expect(Validators.validatePhone('1234567890123'), isNull);
      expect(Validators.validatePhone('123456789'), isNotNull);
      expect(Validators.validatePhone('12345678901234'), isNotNull);
      expect(Validators.validatePhone('12345abc90'), isNotNull);
    });

    test('validates HTTP and HTTPS URLs', () {
      expect(Validators.validateUrl('https://example.com'), isNull);
      expect(Validators.validateUrl('http://example.com/path'), isNull);
      expect(Validators.validateUrl('ftp://example.com'), isNotNull);
      expect(Validators.validateUrl('https://'), isNotNull);
    });

    test('validates password length, uppercase, digit, and symbol', () {
      expect(Validators.validatePassword('Strong1!'), isNull);
      expect(Validators.validatePassword('short1!'), isNotNull);
      expect(Validators.validatePassword('lowercase1!'), isNotNull);
      expect(Validators.validatePassword('NoNumber!'), isNotNull);
      expect(Validators.validatePassword('NoSymbol1'), isNotNull);
    });
  });
}
