extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T f(int i)) {
    var i = 0;
    return this.map((e) => f(i++));
  }

  void forEachIndex(void f(int i)) {
    var i = 0;
    this.forEach((e) => f(i++));
  }
}

//USAGE
/*final userName = userList
                            .mapIndex(
                                (i) => 'Username: ${userList[i].username}')
                            .toList()
                            .join('\n');
                        final userPass = userList
                            .mapIndex(
                                (i) => 'Password: ${userList[i].password}')
                            .toList()
                            .join('\n');
                        final userID = userList
                            .mapIndex((i) => 'ID: ${userList[i].id}')
                            .toList()
                            .join('\n');

                        print(userName);
                        print(userPass);
                        print(userID);
*/
