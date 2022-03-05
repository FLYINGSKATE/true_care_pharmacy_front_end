import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../app/AppHelper.dart';
import '../app/application.dart';

import '../helper/progress_dialog.dart';
import '../main.dart';
import 'api_callback_listener.dart';
import 'http_methods.dart';


class ApiRequest {
  JsonDecoder jsonDecoder = const JsonDecoder();
  String url="", action = "", httpType = "";
  late Map<String, String> headers;
  Map<String, String>? body;
  Map<String, dynamic> jsonResult ={};
  late BuildContext context;
  Encoding? encoding;
  Duration connectionTimeout = const Duration(minutes: 10);
  late ApiCallBackListener apiCallBackListener;
  bool showLoader = true;
  bool isMultiPart = false;
  Map<String, File>? mapOfFilesAndKey;

  ApiRequest(
      {required BuildContext context,
      required ApiCallBackListener apiCallBackListener, bool showLoader = true,
      required String httpType,
      required String url,
      required String apiAction,
      required Map<String, String> headers,
      Map<String, String>? body,
      required encoding,
      required bool isMultiPart,
      Map<String, File>? mapOfFilesAndKey}) {
    this.apiCallBackListener = apiCallBackListener;
    this.url = url;
    this.isMultiPart = isMultiPart;
    this.mapOfFilesAndKey = mapOfFilesAndKey!;
    this.body = body!;
    this.headers = headers;
    this.encoding = encoding;
    this.context = context;
    action = apiAction;
    this.httpType = httpType;
    this.showLoader = showLoader;
    if (context != null) {
      AppHelper.checkInternetConnectivity().then((bool isConnected) async {
        if (isConnected) {
          try {
            if (showLoader) {
              ProgressDialog.show(context);
            }
            String accessToken = "";
            /*if (userSession != null &&
                userSession.accessToken != null &&
                userSession.accessToken.isNotEmpty) {
              accessToken = userSession.accessToken;
            }*/
            headers = getApiHeader(accessToken);
            if (isMultiPart != null && isMultiPart) {
              if (mapOfFilesAndKey != null) {
                getAPIMultiRequest(url,
                    headers: headers,
                    body: body,
                    encoding: encoding,
                    mapOfFilesAndKey: mapOfFilesAndKey);
              } else {
                getAPIMultiStringRequest(
                  url,
                  headers: headers,
                  body: body,
                  encoding: encoding,
                );
              }
            } else {
              getAPIRequest(url,
                  headers: headers, body: body, encoding: encoding);
            }
          } catch (onError) {
            debugPrint(onError.toString());
          }
        } else {
          // AppHelper.showSnackBarMessage("No Internet Connection.");
        }
      });
    }
  }

  getAPIRequest(String url,
      {required Map<String, String> headers, body, encoding}) async {
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    debugPrint("\nApiRequest_url===" + url.toString());
    debugPrint("\nApiRequest_headers===" + headers.toString());
    debugPrint("\nApiRequest_body===" + body.toString());
    debugPrint("\n****************************API REQUEST************************************\n");
    AppHelper.hideKeyBoard(context);
    Uri uri = Uri.parse(url);
    if (httpType == HttpMethods.GET) {
      return http
          .get(
            uri,
            headers: headers,
          )
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.POST) {
      return http
          .post(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.PUT) {
      return http
          .put(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.DELETE) {
      return http
          .delete(uri, headers: headers)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.PATCH) {
      return http
          .patch(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    }
  }

  httpCatch(onError) {
    if (showLoader) {
      ProgressDialog.hide();
    }
    debugPrint("httpCatch===" + onError.toString());
    //AppHelper.showSnackBarMessage("Oops! Something went wrong.\n" + onError.toString());
  }

  FutureOr httpResponse(Response response) {
    try {
      if (showLoader) {
        ProgressDialog.hide();
      }
      var res = response.body;
      var statusCode = response.statusCode;
      // if (statusCode == 401) {
      //   debugPrint("error===");
      //   AppHelper.logOut(context);
      //   return null;
      // }


      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      debugPrint("\n\nApiRequest_HTTP_RESPONSE===" + res.toString());
      debugPrint("\n\nApiRequest_HTTP_BODY_RESPONSE===" + res);
      debugPrint(
          "\n\nApiRequest_HTTP_RESPONSE_CODE===" + statusCode.toString());

      debugPrint(
          "\n****************************API RESPONSE************************************\n");
      jsonResult = jsonDecoder.convert(res);
      if (jsonResult != null) {
        debugPrint("success===" + jsonResult.toString());
        return apiCallBackListener.apiCallBackListener(
            action, statusCode, jsonResult);
      } else {
        if (jsonResult != null && jsonResult['message'] != null) {
          AppHelper.showSnackBarMessage(jsonResult['message'].toString());
        }
      }
    } catch (onError) {
      httpCatch(onError);
    }
  }

  Future<FutureOr> httpResponseString(http.StreamedResponse response) async {
    try {
      if (showLoader) {
        ProgressDialog.hide();
      }
      var res = await response.stream.bytesToString();
      var statusCode = response.statusCode;
      // if (statusCode == 401) {
      //   debugPrint("error===");
      //   AppHelper.logOut(context);
      //   return null;
      // }
      jsonResult = jsonDecoder.convert(res);

      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      debugPrint("\n\nApiRequest_HTTP_RESPONSE===" + jsonResult.toString());
      debugPrint("\n\nApiRequest_HTTP_BODY_RESPONSE===" + res);
      debugPrint(
          "\n\nApiRequest_HTTP_RESPONSE_CODE===" + statusCode.toString());

      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      if (jsonResult != null) {
        debugPrint("success===" + jsonResult.toString());
        return apiCallBackListener.apiCallBackListener(
            action, statusCode, jsonResult);
      } else {
        if (jsonResult != null && jsonResult['message'] != null) {
          AppHelper.showSnackBarMessage(jsonResult['message'].toString());
        }
      }
    } catch (onError) {
      httpCatch(onError);
    }
  }

  Future uploadImage(BuildContext context,
      ApiCallBackListener apiCallBackListener, String url, String action,
      {required Map<String, String> headers, body, encoding}) async {
    this.apiCallBackListener = apiCallBackListener;
    this.url = url;
    this.body = body;
    this.headers = headers;
    this.encoding = encoding;
    this.context = context;
    this.action = action;
    try {
      ProgressDialog.show(context);
    } catch (onError) {
      debugPrint(onError.toString());
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // this.headers = getApiHeader(prefs.getString(Constants.ACCESS_TOKEN));
    var uri = Uri.parse(url);
    var request = MultipartRequest("POST", uri);
    var multipartFile = await MultipartFile.fromPath("file", body);
    request.files.add(multipartFile);

    StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonResult = jsonDecoder.convert(value);
      apiCallBackListener.apiCallBackListener(
          action, response.statusCode, jsonResult);
      debugPrint(value);
    });
  }

  apiTimeOut() {
    if (showLoader) {
      ProgressDialog.hide();
    }
    debugPrint('Please try again .');
    AppHelper.showSnackBarMessage("Connection timeout Please try again...");
  }

  Map<String, String> getApiHeader(String accessToken) {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer " + accessToken,
    };
  }

  Future getAPIMultiRequest(String url,
      {required Map<String, String> headers,
      body,
      encoding,
      Map<String, File>? mapOfFilesAndKey}) async {
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    debugPrint("\nApiRequest_url===" + url.toString());
    debugPrint("\nApiRequest_headers===" + headers.toString());
    debugPrint("\nApiRequest_body===" + body.toString());
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    var uri = Uri.parse(url);
    var request = MultipartRequest(httpType, uri);

    List<String> keysForImage = [];
    if (mapOfFilesAndKey != null) {
      for (int i = 0; i < mapOfFilesAndKey.length; i++) {
        String key = mapOfFilesAndKey.keys.elementAt(i);
        keysForImage.add(key);
      }
    }

    if (body != null) {
      for (int i = 0; i < body.length; i++) {
        String key = body.keys.elementAt(i);
        request.fields[key] = body[key];
      }
    }

    for (int i = 0; i < keysForImage.length; i++) {
      var multipartFile = await MultipartFile.fromPath(
          keysForImage[i], mapOfFilesAndKey![keysForImage[i]]!.path);
      request.files.add(multipartFile);
    }
    request.headers.addAll(headers);

    http.Response.fromStream(await request.send())
        .then(httpResponse)
        .catchError(httpCatch)
        .timeout(connectionTimeout, onTimeout: () {
      apiTimeOut();
    });
  }

  Future getAPIMultiStringRequest(
    String url, {
    required Map<String, String> headers,
    Map<String, String>? body,
    encoding,
  }) async {
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    debugPrint("\nApiRequest_url===" + url.toString());
    debugPrint("\nApiRequest_headers===" + headers.toString());
    debugPrint("\nApiRequest_body===" + body.toString());
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    var uri = Uri.parse(url);
    var request = MultipartRequest(httpType, uri);

    if (body != null) {
      request.fields.addAll(body);
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    request
        .send()
        .then(httpResponseString)
        .catchError(httpCatch)
        .timeout(connectionTimeout, onTimeout: () {
      apiTimeOut();
    });
  }
}


