import 'package:flutter_test/flutter_test.dart';
import 'package:hotel/screens/authenticate/sign_in.dart';

void main(){

  test('empty email return error',(){
    var result =EmailFieldValidator.validate("");
    expect(result,'Enter email');
  });
 test('non-empty email return null',(){
    var result =EmailFieldValidator.validate("abc@gmail.com");
    expect(result,null);
  });
  test('password length less than 6',(){
    var result =PasswordFieldValidator.validate("12345");
    expect(result,'Enter password 6 chars long');
  });

   test('password length greater than 6',(){
    var result =PasswordFieldValidator.validate("123456");
    expect(result,null);
  });


}