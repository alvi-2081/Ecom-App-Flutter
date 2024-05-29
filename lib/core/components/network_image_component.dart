import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageComponent extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final String? assetImage;
  const NetworkImageComponent({
    required this.url,
    required this.width,
    required this.height,
    this.assetImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return url != null && url != ''
        ? CachedNetworkImage(
            imageUrl: url ?? '',
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey,
              ),
            ),
            width: width,
            height: height,
            fit: BoxFit.cover,
          )
        //  Image.network(
        //     url ?? '',
        //     width: width,
        //     height: height,
        //     fit: BoxFit.cover,
        //   )
        : assetImage != null
            ? Image.asset(
                assetImage!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
            : Image.network(
                url ?? '',
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
  }
}
