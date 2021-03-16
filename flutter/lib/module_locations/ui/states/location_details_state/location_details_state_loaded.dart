import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_list/comment_list.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/module_locations/ui/widgets/guides_list/guides_list.dart';

class LocationDetailsStateLoaded extends LocationDetailsState {
  LocationDetailsModel location;
  List<GuideListItemModel> guides;
  void Function(String) onPostComment;
  bool isLoggedIn;

  LocationDetailsStateLoaded({
    this.location,
    this.guides,
    this.onPostComment,
    this.isLoggedIn,
  });

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${location.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getCarousel(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                location.description,
                maxLines: 4,
              ),
            ),
            guides.isNotEmpty
                ? GuidesListWidget(guides, location.id)
                : Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('No guides for this place was found!'),
                    ),
                  ),
            _getCommentsList(),
          ],
        ),
      ),
    );
  }

  Widget _getCarousel() {
    List<Widget> carouselList = [];
    location.paths ??= [];
    if (location.paths != null) {
      location.paths.forEach((path) {
        carouselList.add(Image.network(
          '${path.path}'.contains('http')
              ? '${path.path}'.substring(path.path.lastIndexOf('http'))
              : path.path,
          errorBuilder: (c, e, s) {
            return Image.asset('resources/images/logo.png');
          },
        ));
      });
    }

    return Flex(
      direction: Axis.vertical,
      children: carouselList,
    );
  }

  Widget _getCommentsList() {
    location.comments ??= <CommentModel>[];
    return CommentListWidget(
      comments: location.comments,
      pageSize: 3,
      onCommentPosted: (comment) {
        onPostComment(comment);
      },
      isLoggedIn: isLoggedIn,
    );
  }
}
