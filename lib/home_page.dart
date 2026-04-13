class _HomePageState extends State<HomePage> {
  final FCMService _fcmService = FCMService();

  // Default values shown before any message arrives
  String statusText = 'Waiting for a cloud message';
  String imagePath = 'assets/images/default.png';

  @override
  void initState() {
    super.initState();

    // Initialize FCM and define what happens when any message arrives
    _fcmService.initialize(onData: (message) {
      setState(() {
        // Map notification title to the status label
        // Falls back to a generic string if title is missing
        statusText = message.notification?.title ?? 'Payload received';

        // Map the 'asset' key from the data payload to an image path
        // Falls back to default.png if the key is missing or misspelled
        imagePath = 'assets/images/${message.data['asset'] ?? 'default'}.png';
      });
    });
  }
}