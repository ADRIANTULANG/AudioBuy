import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  //Instance of get storage
  final box = GetStorage();

  setUser(
      {required String username,
      required String password,
      required String userid,
      required String name,
      required String contactno,
      required String image,
      required String address,
      required String usertype}) {
    box.write('username', username);
    box.write('password', password);
    box.write('name', name);
    box.write('contactno', contactno);
    box.write('image', image);
    box.write('userid', userid);
    box.write('address', address);
    box.write('usertype', usertype);

    print(box.read('username'));
    print(box.read('password'));
    print(box.read('name'));
    print(box.read('contactno'));
    print(box.read('image'));
    print(box.read('address'));
    print(box.read('usertype'));
  }

  removedUser() {
    box.remove('username');
    box.remove('password');
    box.remove('name');
    box.remove('contactno');
    box.remove('userid');
    box.remove('image');
    box.remove('address');
    box.remove('usertype');

    print("Credentials Removed");
  }
}
