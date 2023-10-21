// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//*  all fields of this class were already immutable because of final keyword , so we declared it/Override with immutable
@immutable
class User {
  final String name;
  final int age;
  const User({
    required this.name,
    required this.age,
  });

  //! installed data class generator for dart then click on class name(here User) then  click on generate data class to get these methods

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, age: $age)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

//!method 2 for understanding first swipe down to method 1 , method 2 is implementation with better advance way
class UserNotifier2 extends StateNotifier<User> {
//& StateNotifier will give us state (a variable) which will be used to update data in User class (State class provided in StateNotifier<Generic>).
//& whatever data we are going to pass state will be of that type in our case it will be of User type.

  UserNotifier2(
      super._state); //& it will require User variable in its constructor whenever object of this class is called
  //& now by this method we just need to provide String for name as we only want to change that

  void updateName(String s) {
    state = state.copyWith(
        name:
            s); //& this is copying all the properties of the state and will only change name
  }

  void updateAge(int n) {
    state = state.copyWith(age: n);
  }
}

//! Method 1 (other) for understanding (for this we don't need data class it was normal simple function)

//^ Creating class to Keep all methods to update name and age of User

class UserNotifier extends StateNotifier<User> {
//& StateNotifier will give us state (a variable) which will be used to update data in User class (State class provided in StateNotifier<Generic>).
//& whatever data we are going to pass state will be of that type in our case it will be of User type.

  UserNotifier(
      super._state); //& it will require User variable in its constructor whenever object of this class is called

  //^ making function to update name

  void updateName(String s) {
    //~ state.name = s;                this could be done if name was mutable , it is final hence it is immutable

    //^ Method 1 but this is ineffective because here we are just changing name and we have to pass age also , suppose 10 fields would have been there
    //^ state = User(name: s, age: state.age);
  }
}
