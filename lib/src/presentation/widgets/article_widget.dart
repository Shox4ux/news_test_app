import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final bool isRemovable;
  final void Function(Article article)? onRemove;
  final void Function(Article article)? onArticlePressed;
  final void Function(Article article)? onArticleAddPressed;

  const ArticleWidget({
    Key? key,
    required this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
    this.onArticleAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 7.h,
          horizontal: 14.w,
        ),
        height: 160.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
            _buildActionArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 14.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: 140.w,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Image.network(
            article.urlToImage ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text(
                  '404\nNOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
                color: Colors.black87,
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  article.description ?? '',
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionArea() {
    if (isRemovable) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Icon(Ionicons.trash_outline, color: Colors.red),
      );
    } else {
      return GestureDetector(
        onTap: _onAdd,
        child: Icon(
          Icons.favorite,
          color: Colors.black,
          size: 32.h,
        ),
      );
    }
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed?.call(article);
    }
  }

  void _onAdd() {
    if (onArticleAddPressed != null) {
      onArticleAddPressed?.call(article);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove?.call(article);
    }
  }
}
