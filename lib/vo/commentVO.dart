class CommentVO{
  final String imgName;
  final String cupName;
  final String id;
  final String time;
  final String content;

  CommentVO({
    required this.imgName,
    required this.cupName,
    required this.id,
    required this.time,
    required this.content
  });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      'imgName':imgName,
      'cupName':cupName,
      'id':id,
      'time':time,
      'content':content
    };
  }
}