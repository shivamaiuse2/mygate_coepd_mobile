import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:mygate_coepd/theme/app_theme.dart';

class MultilingualSupportScreen extends StatefulWidget {
  const MultilingualSupportScreen({super.key});

  @override
  State<MultilingualSupportScreen> createState() => _MultilingualSupportScreenState();
}

class _MultilingualSupportScreenState extends State<MultilingualSupportScreen> {
  String _selectedLanguage = 'English';
  bool _voiceEnabled = true;

  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'native': 'English',
      'flag': '🇺🇸',
    },
    {
      'code': 'hi',
      'name': 'Hindi',
      'native': 'हिंदी',
      'flag': '🇮🇳',
    },
    {
      'code': 'kn',
      'name': 'Kannada',
      'native': 'ಕನ್ನಡ',
      'flag': '🇮🇳',
    },
    {
      'code': 'gu',
      'name': 'Gujarati',
      'native': 'ગુજરાતી',
      'flag': '🇮🇳',
    },
    {
      'code': 'ta',
      'name': 'Tamil',
      'native': 'தமிழ்',
      'flag': '🇮🇳',
    },
    {
      'code': 'te',
      'name': 'Telugu',
      'native': 'తెలుగు',
      'flag': '🇮🇳',
    },
  ];

  final List<Map<String, dynamic>> _commonPhrases = [
    {
      'english': 'Welcome',
      'translation': '',
    },
    {
      'english': 'Please wear a mask',
      'translation': '',
    },
    {
      'english': 'Please provide your ID',
      'translation': '',
    },
    {
      'english': 'Please wait for approval',
      'translation': '',
    },
    {
      'english': 'You may proceed',
      'translation': '',
    },
    {
      'english': 'Thank you, visit again',
      'translation': '',
    },
  ];

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to $language'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Multilingual Support'),
              actions: [
                IconButton(
                  onPressed: () {
                    // Refresh action
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language Selection
                  const Text(
                    'Select Language',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Voice Assistance',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Switch(
                                value: _voiceEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _voiceEnabled = value;
                                  });
                                },
                                activeThumbColor: AppTheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Enable voice assistance for real-time translation',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Language List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _languages.length,
                    itemBuilder: (context, index) {
                      final language = _languages[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Text(
                            language['flag'],
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(language['name']),
                          subtitle: Text(language['native']),
                          trailing: _selectedLanguage == language['name']
                              ? const Icon(Icons.check, color: AppTheme.primary)
                              : null,
                          onTap: () => _changeLanguage(language['name']),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Common Phrases
                  const Text(
                    'Common Security Phrases',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select a language to see translations',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ..._commonPhrases.map(
                              (phrase) => Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      phrase['english'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      _getTranslation(phrase['english']),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Language Info
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Multilingual Features',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            '• Supports 6 regional languages\n'
                            '• Real-time voice translation\n'
                            '• Text-to-speech for common phrases\n'
                            '• Easy language switching\n'
                            '• Offline language support',
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Note: Language changes will be applied throughout the application.',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  String _getTranslation(String englishPhrase) {
    // In a real app, this would fetch translations from a service
    switch (_selectedLanguage) {
      case 'Hindi':
        return _getHindiTranslation(englishPhrase);
      case 'Kannada':
        return _getKannadaTranslation(englishPhrase);
      case 'Gujarati':
        return _getGujaratiTranslation(englishPhrase);
      case 'Tamil':
        return _getTamilTranslation(englishPhrase);
      case 'Telugu':
        return _getTeluguTranslation(englishPhrase);
      default:
        return englishPhrase;
    }
  }

  String _getHindiTranslation(String phrase) {
    final Map<String, String> translations = {
      'Welcome': 'स्वागत है',
      'Please wear a mask': 'कृपया मास्क पहनें',
      'Please provide your ID': 'कृपया अपना पहचान पत्र प्रदान करें',
      'Please wait for approval': 'अनुमोदन के लिए कृपया प्रतीक्षा करें',
      'You may proceed': 'आप आगे बढ़ सकते हैं',
      'Thank you, visit again': 'धन्यवाद, फिर से आएं',
    };
    return translations[phrase] ?? phrase;
  }

  String _getKannadaTranslation(String phrase) {
    final Map<String, String> translations = {
      'Welcome': 'ಸುಸ್ವಾಗತ',
      'Please wear a mask': 'ದಯವಿಟ್ಟು ಮಾಸ್ಕ್ ಧರಿಸಿ',
      'Please provide your ID': 'ದಯವಿಟ್ಟು ನಿಮ್ಮ ಐಡಿ ಒದಗಿಸಿ',
      'Please wait for approval': 'ದಯವಿಟ್ಟು ಅನುಮೋದನೆಗಾಗಿ ಕಾಯಿರಿ',
      'You may proceed': 'ನೀವು ಮುಂದುವರಿಯಬಹುದು',
      'Thank you, visit again': 'ಧನ್ಯವಾದಗಳು, ಮತ್ತೆ ಭೇಟಿ ನೀಡಿ',
    };
    return translations[phrase] ?? phrase;
  }

  String _getGujaratiTranslation(String phrase) {
    final Map<String, String> translations = {
      'Welcome': 'આપનું સ્વાગત છે',
      'Please wear a mask': 'કૃપા કરીને માસ્ક પહેરો',
      'Please provide your ID': 'કૃપા કરીને તમારો આઈડી આપો',
      'Please wait for approval': 'કૃપા કરીને મંજૂરી માટે રાહ જુઓ',
      'You may proceed': 'તમે આગળ વધી શકો છો',
      'Thank you, visit again': 'આભાર, ફરીથી મુલાકાત લો',
    };
    return translations[phrase] ?? phrase;
  }

  String _getTamilTranslation(String phrase) {
    final Map<String, String> translations = {
      'Welcome': 'நல்வரவு',
      'Please wear a mask': 'தயவுசெய்து முகமூடி அணியுங்கள்',
      'Please provide your ID': 'உங்கள் ஐடியை வழங்கவும்',
      'Please wait for approval': 'அங்கீகாரத்திற்காக காத்திருக்கவும்',
      'You may proceed': 'நீங்கள் தொடரலாம்',
      'Thank you, visit again': 'நன்றி, மீண்டும் வருக',
    };
    return translations[phrase] ?? phrase;
  }

  String _getTeluguTranslation(String phrase) {
    final Map<String, String> translations = {
      'Welcome': 'సుస్వాగతం',
      'Please wear a mask': 'దయచేసి మాస్క్ ధరించండి',
      'Please provide your ID': 'దయచేసి మీ ఐడి ఇవ్వండి',
      'Please wait for approval': 'దయచేసి ఆమోదం కోసం వేచి ఉండండి',
      'You may proceed': 'మీరు కొనసాగవచ్చు',
      'Thank you, visit again': 'ధన్యవాదాలు, మళ్లీ సందర్శించండి',
    };
    return translations[phrase] ?? phrase;
  }
}