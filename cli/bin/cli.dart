import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('DartPedia cli version $version');
  } else if (arguments.first == 'search') {
    // final - переменная назначается 1 раз и в последствии не может быть изменена
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printMessage();
  }
}

void searchWikipedia(List<String>? arguments) {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait...');
  print('Here ya go!');
  print('(Pretend this is an article about "$articleTitle")');
}

void printMessage() {
  print(
    "The following command are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}
