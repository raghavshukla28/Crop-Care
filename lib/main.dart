import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';

class DiseaseDetection extends StatefulWidget {
  @override
  _DiseaseDetectionState createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
    );
    print(res);  // Should print "success" if the model loads successfully
  }

  Future<void> runModel(String imagePath) async {
    var results = await Tflite.runModelOnImage(
      path: imagePath,  // Path to the image (from the camera or gallery)
      imageMean: 0.0,   // Adjust based on your model's preprocessing
      imageStd: 255.0,  // Adjust based on your model's preprocessing
    );
    print(results);  // Results from the prediction
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Detection'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call your function to capture image and run the model
            // For example: runModel('path_to_image');
          },
          child: Text('Detect Disease'),
        ),
      ),
    );
  }
}

void main() {
  runApp(CropDiseaseDetectionApp());
}

class CropDiseaseDetectionApp extends StatefulWidget {
  @override
  _CropDiseaseDetectionAppState createState() => _CropDiseaseDetectionAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final _CropDiseaseDetectionAppState? state = context.findAncestorStateOfType<_CropDiseaseDetectionAppState>();
    state?.setLocale(newLocale);
  }
}

class _CropDiseaseDetectionAppState extends State<CropDiseaseDetectionApp> {
  Locale _locale = AppLocalizations.en;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'TENSOR',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.lightGreen[50],
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: HomeScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [AppLocalizations.en, AppLocalizations.hi],
    );
  }
}

class AppLocalizations {
  static final Map<String, String> _localizedStrings = {
    'home_title': 'TENSOR',
    'about_project': 'About Project',
    'about_project_content': 'This project helps detect crop diseases.',
    'about_team': 'About Team',
    'technologies_used': 'Technologies Used',
    'technologies_content': 'Flutter, Dart, AI models',
    'change_language': 'Change Language',
    'ok': 'OK',
    'cancel': 'Cancel',
    'weather_tab': 'Weather Report',
    'cultivation_tab': 'Cultivation Tips',
    'check_disease': 'Check for Diseases',
    'chat_with_gpt': 'Chat with GPT',
    'hindi': 'हिन्दी',
    'english': 'English',
    'home_title_hi': 'टेन्सर',
    'about_project_hi': 'परियोजना के बारे में',
    'about_project_content_hi': 'यह परियोजना फसल रोगों का पता लगाने में मदद करती है।',
    'about_team_hi': 'टीम के बारे में',
    'technologies_used_hi': 'प्रयुक्त प्रौद्योगिकियाँ',
    'technologies_content_hi': 'फ्लटर, डार्ट, एआई मॉडल्स',
    'change_language_hi': 'भाषा बदलें',
    'ok_hi': 'ठीक है',
    'cancel_hi': 'रद्द करें',
    'weather_tab_hi': 'मौसम रिपोर्ट',
    'cultivation_tab_hi': 'खेती के सुझाव',
    'check_disease_hi': 'रोग के लिए जाँचें',
    'chat_with_gpt_hi': 'जीपीटी से चैट करें',
    'hindi_hi': 'हिन्दी',
    'english_hi': 'अंग्रेज़ी',
  };

  static String of(BuildContext context, String key) {
    Locale locale = Localizations.localeOf(context);
    return locale.languageCode == 'hi' ? _localizedStrings[key + '_hi']! : _localizedStrings[key]!;
  }

  static const Locale en = Locale('en');
  static const Locale hi = Locale('hi');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => [AppLocalizations.en, AppLocalizations.hi].contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final strings = (String key) => AppLocalizations.of(context, key);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings('home_title')!),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'aboutProject') {
                _showAboutProjectDialog(context, strings);
              } else if (value == 'aboutTeam') {
                _showAboutTeamDialog(context, strings);
              } else if (value == 'technologiesUsed') {
                _showTechnologiesUsedDialog(context, strings);
              } else if (value == 'changeLanguage') {
                _changeLanguage(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'aboutProject',
                  child: Text(strings('about_project')!),
                ),
                PopupMenuItem(
                  value: 'aboutTeam',
                  child: Text(strings('about_team')!),
                ),
                PopupMenuItem(
                  value: 'technologiesUsed',
                  child: Text(strings('technologies_used')!),
                ),
                PopupMenuItem(
                  value: 'changeLanguage',
                  child: Text(strings('change_language')!),
                ),
              ];
            },
          ),
        ],
      ),
      body: GridView(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0, // Make buttons square
        ),
        children: [
          _buildButton(context, strings('weather_tab')!, Icons.wb_sunny, _showWeatherScreen),
          _buildButton(context, strings('cultivation_tab')!, Icons.grass, _showCultivationTipsScreen),
          _buildButton(context, strings('check_disease')!, Icons.camera_alt, _openCamera),
          _buildButton(context, strings('chat_with_gpt')!, Icons.chat, _showChatGPTScreen), // New Button for ChatGPT
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        backgroundColor: Colors.green, // Button color
        padding: EdgeInsets.all(16.0),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50.0, color: Colors.white),
          SizedBox(height: 8.0),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ],
      ),
    );
  }

  void _showWeatherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherForecastScreen()),
    );
  }

  void _showCultivationTipsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CultivationTipsScreen()),
    );
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bool? keepPhoto = await _showConfirmDialog(
          context, 'Use this photo?', 'Would you like to keep this photo?');

      if (keepPhoto == true) {
        final bool? sendToDatabase = await _showConfirmDialog(
            context, 'Send to Database?', 'Would you like to send this photo to the database?');

        if (sendToDatabase == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Photo sent to database!')),
          );
        }
      }
    }
  }

  Future<bool?> _showConfirmDialog(BuildContext context, String title, String content) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context, 'cancel')!),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context, 'ok')!),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAboutProjectDialog(BuildContext context, Function(String) strings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strings('about_project')!),
          content: Text(strings('about_project_content')!),
          actions: [
            TextButton(
              child: Text(strings('ok')!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAboutTeamDialog(BuildContext context, Function(String) strings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strings('about_team')!),
          content: Text('Tensor Team'),
          actions: [
            TextButton(
              child: Text(strings('ok')!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTechnologiesUsedDialog(BuildContext context, Function(String) strings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strings('technologies_used')!),
          content: Text(strings('technologies_content')!),
          actions: [
            TextButton(
              child: Text(strings('ok')!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context, 'change_language')!),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context, 'english')!),
              onPressed: () {
                CropDiseaseDetectionApp.setLocale(context, AppLocalizations.en);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context, 'hindi')!),
              onPressed: () {
                CropDiseaseDetectionApp.setLocale(context, AppLocalizations.hi);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showChatGPTScreen() {
    // You can use Flutter's `url_launcher` package to link to ChatGPT or implement in-app functionality.
    launch('https://openai.com/chatgpt'); // Replace this with in-app GPT functionality if needed
  }
}

// Additional screens like WeatherForecastScreen and CultivationTipsScreen...


void _showChatGPTScreen() {
  const chatGptUrl = 'https://chat.openai.com/'; // URL for ChatGPT
  launchUrl(Uri.parse(chatGptUrl));
}

void _changeLanguage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context, 'change_language')!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context, 'english')!),
              onTap: () {
                CropDiseaseDetectionApp.setLocale(context, AppLocalizations.en);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context, 'hindi')!),
              onTap: () {
                CropDiseaseDetectionApp.setLocale(context, AppLocalizations.hi);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context, 'cancel')!),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class CustomSidebarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'App Navigation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Weather Forecast'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WeatherForecastScreen(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.agriculture),
            title: Text('Cultivation Tips'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CultivationTipsScreen(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to the settings screen or any other screen you want
            },
          ),
        ],
      ),
    );
  }
}


class WeatherForecastScreen extends StatelessWidget {
  final String apiKey = '881a7acb81b2492892850006240509';
  final String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=Lucknow,IN&appid=881a7acb81b2492892850006240509&units=metric';

  Future<Map<String, dynamic>> _fetchWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'temperature': data['main']['temp'],
        'condition': data['weather'][0]['description'],
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context, 'weather_tab')!),
      ),
      drawer: CustomSidebarDrawer(), // Add this line
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weatherData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: ${weatherData['temperature']}°C'),
                  Text('Condition: ${weatherData['condition']}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class CultivationTipsScreen extends StatelessWidget {
  final List<String> cultivationTips = [
    "Tip 1: Test your soil before planting to ensure proper nutrient levels.",
    "Tip 2: Rotate crops annually to prevent soil depletion and pest buildup.",
    "Tip 3: Use organic compost to enrich soil and promote healthy plant growth.",
    "Tip 4: Water plants early in the morning to minimize evaporation.",
    "Tip 5: Mulch your garden to retain moisture and reduce weed growth.",
    "Tip 6: Choose native plants that are adapted to your local climate.",
    "Tip 7: Prune plants regularly to encourage growth and remove dead or diseased branches.",
    "Tip 8: Use drip irrigation to conserve water and deliver it directly to plant roots.",
    "Tip 9: Plant cover crops to protect soil during off-season.",
    "Tip 10: Use natural predators to control pests instead of chemical pesticides.",
    "Tip 11: Incorporate green manure crops to add organic matter to the soil.",
    "Tip 12: Practice crop spacing to allow sufficient air circulation and reduce disease.",
    "Tip 13: Keep tools clean and sanitized to prevent the spread of plant diseases.",
    "Tip 14: Regularly scout for pests and diseases to address issues early.",
    "Tip 15: Use trellises and supports for climbing plants to maximize space.",
    "Tip 16: Select disease-resistant plant varieties to reduce the risk of crop loss.",
    "Tip 17: Use intercropping techniques to improve soil health and yield.",
    "Tip 18: Avoid working with wet soil to prevent soil compaction.",
    "Tip 19: Apply fertilizers based on soil test results for optimal plant nutrition.",
    "Tip 20: Control weeds by hand-pulling or using natural herbicides.",
    "Tip 21: Apply lime to acidic soils to improve pH levels.",
    "Tip 22: Practice conservation tillage to minimize soil disturbance.",
    "Tip 23: Grow a diverse range of crops to improve ecosystem stability.",
    "Tip 24: Monitor weather conditions to plan irrigation and protect crops from frost.",
    "Tip 25: Use row covers to protect plants from pests and extreme weather.",
    "Tip 26: Avoid over-fertilization to prevent nutrient runoff and water contamination.",
    "Tip 27: Harvest crops at their peak for the best flavor and nutritional value.",
    "Tip 28: Use companion planting to enhance growth and deter pests.",
    "Tip 29: Regularly check irrigation systems for leaks and efficiency.",
    "Tip 30: Manage plant residue after harvest to improve soil structure.",
    "Tip 31: Use organic mulch, such as straw or wood chips, to improve soil health.",
    "Tip 32: Practice proper crop rotation to avoid pest and disease buildup.",
    "Tip 33: Use pheromone traps to monitor and control insect populations.",
    "Tip 34: Apply compost tea to boost soil microbial activity.",
    "Tip 35: Avoid planting in low-lying areas to reduce the risk of flooding.",
    "Tip 36: Implement integrated pest management (IPM) strategies.",
    "Tip 37: Ensure proper drainage in fields to prevent waterlogging.",
    "Tip 38: Use shade nets to protect sensitive plants from intense sunlight.",
    "Tip 39: Encourage beneficial insects like bees for pollination.",
    "Tip 40: Regularly rotate livestock grazing areas to maintain pasture health.",
    "Tip 41: Monitor soil moisture levels to avoid over- or under-watering.",
    "Tip 42: Use greenhouses or polytunnels to extend the growing season.",
    "Tip 43: Train climbing plants vertically to save space in small gardens.",
    "Tip 44: Incorporate biochar into soil to improve water retention and nutrient availability.",
    "Tip 45: Create windbreaks to protect crops from strong winds.",
    "Tip 46: Use reflective mulches to increase light availability to plants.",
    "Tip 47: Keep records of planting dates, weather, and harvests for future reference.",
    "Tip 48: Implement strip cropping to reduce erosion and improve water infiltration.",
    "Tip 49: Use natural fertilizers, like fish emulsion or seaweed extract, for nutrient-rich soil.",
    "Tip 50: Space plants properly to reduce competition for nutrients and light.",
    "Tip 51: Use raised beds to improve drainage and reduce soil compaction.",
    "Tip 52: Regularly inspect plants for signs of stress or disease.",
    "Tip 53: Apply organic matter, like manure, to improve soil fertility.",
    "Tip 54: Use biodegradable mulch to add organic material to the soil as it decomposes.",
    "Tip 55: Avoid planting the same crops in the same spot each year to prevent soil-borne diseases.",
    "Tip 56: Utilize water harvesting techniques to capture rainwater for irrigation.",
    "Tip 57: Maintain a diverse habitat around the farm to support wildlife and beneficial insects.",
    "Tip 58: Use cover crops, like clover, to fix nitrogen in the soil.",
    "Tip 59: Monitor and manage soil pH levels for optimal plant growth.",
    "Tip 60: Use row covers or insect netting to protect crops from pests.",
    "Tip 61: Rotate livestock species to manage pasture health and reduce parasite loads.",
    "Tip 62: Compost plant residues to recycle nutrients back into the soil.",
    "Tip 63: Use deep-rooted plants to improve soil structure and bring nutrients to the surface.",
    "Tip 64: Avoid tilling soil too frequently to preserve its structure and microbial life.",
    "Tip 65: Practice no-till farming to reduce soil erosion and improve water retention.",
    "Tip 66: Ensure crops receive sufficient sunlight by removing overhanging branches.",
    "Tip 67: Regularly test soil for nutrient levels and adjust fertilization accordingly.",
    "Tip 68: Use intercropping to reduce the spread of pests and diseases.",
    "Tip 69: Implement agroforestry practices to improve biodiversity and soil health.",
    "Tip 70: Use bio-inoculants to promote beneficial soil microbes.",
    "Tip 71: Plant drought-resistant crop varieties in arid regions.",
    "Tip 72: Avoid overgrazing pastures to prevent soil degradation.",
    "Tip 73: Use hedgerows to provide habitat for beneficial insects and wildlife.",
    "Tip 74: Test irrigation water quality to avoid soil salinization.",
    "Tip 75: Use organic pest control methods, like neem oil, to protect plants.",
    "Tip 76: Create a crop rotation plan to maintain soil health and fertility.",
    "Tip 77: Use organic mulches to suppress weeds and improve soil moisture retention.",
    "Tip 78: Implement contour farming to reduce soil erosion on slopes.",
    "Tip 79: Ensure livestock have access to clean water and shade.",
    "Tip 80: Monitor plant growth stages and adjust care accordingly.",
    "Tip 81: Use biological controls, like ladybugs, to manage aphid populations.",
    "Tip 82: Test soil texture to determine its suitability for different crops.",
    "Tip 83: Practice water-efficient irrigation techniques, like drip irrigation.",
    "Tip 84: Use floating row covers to protect seedlings from frost.",
    "Tip 85: Apply foliar sprays to provide nutrients directly to plant leaves.",
    "Tip 86: Rotate cover crops to improve soil fertility and break pest cycles.",
    "Tip 87: Use soil amendments, like gypsum, to improve soil structure.",
    "Tip 88: Mulch around fruit trees to conserve moisture and prevent weed growth.",
    "Tip 89: Regularly calibrate equipment to ensure accurate application of inputs.",
    "Tip 90: Use organic weed control methods, like vinegar or boiling water.",
    "Tip 91: Practice agroecology to integrate natural processes into farming systems.",
    "Tip 92: Incorporate legumes into crop rotations to fix nitrogen in the soil.",
    "Tip 93: Use soil testing to create a custom fertilization plan.",
    "Tip 94: Implement rotational grazing to improve pasture health.",
    "Tip 95: Plant trees or shrubs as windbreaks to protect crops from wind damage.",
    "Tip 96: Use low-till or no-till practices to maintain soil structure.",
    "Tip 97: Harvest crops early in the morning when they are freshest.",
    "Tip 98: Use biological fungicides to control plant diseases naturally.",
    "Tip 99: Regularly clean and maintain tools to prolong their life and effectiveness.",
    "Tip 100: Plan for crop succession to ensure continuous harvest throughout the growing season."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context, 'cultivation_tab')!),
      ),
      drawer: CustomSidebarDrawer(), // Add this line
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: cultivationTips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                cultivationTips[index],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}