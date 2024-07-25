import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomEmojiContainer extends StatelessWidget {
  const CustomEmojiContainer({
    super.key,
    required this.emoji,
    required this.child,
    required this.style,
  });

  final String emoji;
  final Widget child;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return _EmojiRenderObject(
      children: <Widget>[
        Text('🚫', style: style),
        child,
      ],
    );
  }
}

class _EmojiRenderObject extends MultiChildRenderObjectWidget {
  const _EmojiRenderObject({super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BodyRenderBox();
  }
}

class _BodyRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _EmojiParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _EmojiParentData> {
  _BodyRenderBox();

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _EmojiParentData) {
      child.parentData = _EmojiParentData();
    }
  }

  @override
  void performLayout() {
    assert(childCount == 2);
    final RenderBox renderParagraph = firstChild!;
    assert(renderParagraph is RenderParagraph);
    renderParagraph.layout(constraints, parentUsesSize: true);

    final Size newSize = constraints.constrain(
      Size(renderParagraph.size.height, renderParagraph.size.height),
    );
    size = newSize;

    lastChild!.layout(BoxConstraints.tight(newSize));

    getParentData(renderParagraph).offset = Offset(
      (renderParagraph.size.height - renderParagraph.size.width) / 2,
      0,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox child = lastChild!;
    final _EmojiParentData childParentData = getParentData(child);
    context.paintChild(child, childParentData.offset + offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  _EmojiParentData getParentData(RenderBox box) =>
      box.parentData as _EmojiParentData;
}

class _EmojiParentData extends ContainerBoxParentData<RenderBox> {}
