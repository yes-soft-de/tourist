import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_list/comment_list.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/screens/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/module_locations/ui/widgets/guides_list/guides_list.dart';

class LocationDetailsStateLoaded extends LocationDetailsState {
  LocationDetailsModel location;
  List<GuideListItemModel> guides;
  bool isLoggedIn;
  double rate = 0.0;
  LocationDetailsScreenState screenState;
  LocationDetailsStateLoaded(
    this.screenState, {
    this.location,
    this.guides,
    this.isLoggedIn,
  }) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    location.comments ??= <CommentModel>[];
    return Scaffold(
      appBar: AppBar(
        title: Text('${location?.name}'),
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
            isLoggedIn
                ? Center(
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {
                          if (v > 0.0) {
                            screenState.createRate(
                                v, location.id.toString(), location.placeId);
                          }
                        },
                        starCount: 5,
                        rating: location.userRating != null
                            ? double.parse(location.userRating)
                            : 0.0,
                        size: 35.0,
                        isReadOnly: !isLoggedIn,
                        color: Color(0xff05F29B),
                        borderColor: Color(0xff05F29B),
                        spacing: 0.0),
                  )
                : Container(),
            guides.isNotEmpty
                ? GuidesListWidget(guides, location.placeId)
                : Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${S.of(context).noGuides}!'),
                    ),
                  ),
            //_getCommentsList(context),
            CommentListWidget(
              comments: location.comments,
              pageSize: 3,
              onCommentPosted: (comment) {
                screenState.createComment(
                    comment, location.id.toString(), location.placeId);
              },
              isLoggedIn: isLoggedIn,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCarousel() {
    List<Widget> carouselList = [];
    location.regionImage ??= [];
    if (location.regionImage != null) {
      location.regionImage.forEach((path) {
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

  Widget _getCommentsList(BuildContext context) {
    location.comments ??= <CommentModel>[];
    return CommentListWidget(
      comments: location.comments,
      pageSize: 3,
      onCommentPosted: (comment) {
        screenState.createComment(
            comment, location.id.toString(), location.placeId);
      },
      isLoggedIn: isLoggedIn,
    );
  }
}
