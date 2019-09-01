class ChatModel {
  final String name;
  final String message;
  final String time;

  ChatModel({this.name, this.message, this.time});
}

List<ChatModel> chatOverviewMockData = [
  ChatModel(
      name: "Peter R",
      message: "Hey Flutter, You are so amazing !",
      time: "15:30",
  ),
  ChatModel(
      name: "John Doe",
      message: "Hey I have hacked whatsapp!",
      time: "17:30",
  ),
  ChatModel(
      name: "Mike Ross",
      message: "Wassup !",
      time: "5:00",
  ),
  ChatModel(
      name: "Bob",
      message: "I'm good!",
      time: "10:30",
  ),
  ChatModel(
      name: "Barry Allen",
      message: "I'm the fastest man alive!",
      time: "12:30",
  ),
  ChatModel(
      name: "Joe West",
      message: "Hey Flutter, You are so cool !",
      time: "15:30",
  ),
];
