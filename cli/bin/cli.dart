import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('DartPedia cli version $version');
  } else if (arguments.first == 'wiki') {
    // final - переменная назначается 1 раз и в последствии не может быть изменена
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printMessage();
  }
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return;
    }
    articleTitle = inputFromStdin;
  } else {
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait...');

  final articleContent = await getWikiArticle(articleTitle);

  print(articleContent);
}

void printMessage() {
  print(
    "The following command are valid: 'help', 'wiki', 'search <ARTICLE-TITLE>'",
  );
}

// Тип Future<String> говорит нам о том, что функция вернет строку, но не немедленно, а в когда то в будущем
// Легко провести аналогию с TS, где мы бы написали Promise<string> - то есть обещание о том, что когда-то мы вернем строку
Future<String> getWikiArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }

  // интерполяция свойств объекта происходит через $ и фигурные скобки
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
