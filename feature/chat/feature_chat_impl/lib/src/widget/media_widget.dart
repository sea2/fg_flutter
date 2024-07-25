import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'chat_context.dart';

class MediaWrapper extends StatelessWidget {
  const MediaWrapper({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.type,
  });

  final Widget child;
  final double width;
  final double height;
  final MediaType type;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContext = ChatContext.of(context);

    final Size? mediaConstraint = chatContext.mediaConstraints[type];
    return Media(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: mediaConstraint!.width,
          maxHeight: mediaConstraint.height,
        ),
        child: AspectRatio(
          aspectRatio: width / height,
          child: child,
        ),
      ),
    );
  }
}

// widget marker for MessageContent
class Media extends SingleChildRenderObjectWidget {
  const Media({
    super.key,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => MediaRender();
}

class MediaRender extends RenderProxyBox {}
