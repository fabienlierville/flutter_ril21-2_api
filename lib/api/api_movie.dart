import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMovie{
  final String Url = "https://api.themoviedb.org/3/movie";
  final String Key = "f5a8a486fb069fcb10396a7a3e49ceb4";
  final String Lang = "fr-FR";


  // {"code":200, "body":json/message erreur}
  Future<Map<String,dynamic>> getPopular() async{
    String completeUrl = "${Url}/popular?api_key=${Key}&language=${Lang}&page=1";
    print(completeUrl);

    http.Response response = await http.get(Uri.parse(completeUrl));

    if(response.statusCode == 200){
      return {
        "code":200,
        "body": jsonDecode(response.body)
      };
    }

    return {
      "code":response.statusCode,
      "body": response.body
    };


  }


}