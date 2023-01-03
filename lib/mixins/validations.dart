
mixin ValidationsMixin{

  String? isNotEmpty(String? value, [String? message]){
    if (value!.isEmpty) return message ?? 'Enter your name';
    return null;
  }

  String? hasFiveChars(String? value, [String? message]){
    if (value!.length < 5) return message ?? '5 characters at least';
    return null;
  }

  String? combine(List<String? Function()> validators){
    for(final func in validators){
      final validation = func();
      if(validation != null) return validation;
    }
    return null;
  }
}