import '../../utils/web/constant/network_constants.dart' show BASE_URL;

///
/// Image Model.
/// Note: this will call in web service.
///
class ImageModel {
  final int imageId;
  final String imageUrl;
 // *********** * Constructor. ********** /
  ImageModel({
    required this.imageId,
    required this.imageUrl,
  });

  ///////////////////////////////////////////////////////////////
  
  // *********** * From web service. ********** /
  factory ImageModel.fromWebService(Map<String, dynamic> json,
      {required bool isAttributeJson}) {
    try {
      return ImageModel(
        imageId: json['id'],
        imageUrl: BASE_URL +
            (isAttributeJson ? json['attributes']['url'] : json['url']),
      );
    } catch (error) {
      // FIXME: remove this print line.
      print('Error message from image model is \n$error');
      return ImageModel(imageId: 0, imageUrl: '');
    }
  }

  ///////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////
