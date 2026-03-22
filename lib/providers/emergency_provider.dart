import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/emergency.dart';
import '../utils/app_constants.dart';

class EmergencyProvider extends ChangeNotifier {
  final List<Emergency> _emergencies = [
    // Bleeding
    const Emergency(
      id: "bleeding",
      title: "Severe Bleeding",
      icon: "💉",
      color: "#D32F2F",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Stay Calm & Assess",
          description:
              "Keep the injured person calm and still. Quickly assess how severe the bleeding is. Do not remove any object that is embedded in the wound.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Apply Direct Pressure",
          description:
              "Press firmly on the wound using a clean cloth, bandage, or clothing. Use the heel of your hand. Apply steady, firm pressure without lifting.",
          image: "bleeding_2",
        ),
        EmergencyStep(
          step: 3,
          title: "Maintain Pressure",
          description:
              "Keep pressing for at least 10–15 minutes without peeking. If blood soaks through, add more material on top — do not remove the first layer.",
          image: "bleeding_3",
        ),
        EmergencyStep(
          step: 4,
          title: "Elevate the Wound",
          description:
              "If the wound is on a limb and no bone is broken, raise it above the level of the heart. This reduces blood flow to the area.",
          image: "bleeding_4",
        ),
        EmergencyStep(
          step: 5,
          title: "Call for Help",
          description:
              "If bleeding does not stop after 15 minutes of continuous pressure, or if the wound is very deep, call emergency services immediately.",
          image: "bleeding_5",
        ),
      ],
    ),

    // Breathing
    const Emergency(
      id: "breathing",
      title: "Breathing Difficulty",
      icon: "🫁",
      color: "#1565C0",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Check Responsiveness",
          description:
              "Tap the person's shoulder and shout 'Are you OK?' If they don't respond, call emergency services immediately.",
          image: "breathing_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Open the Airway",
          description:
              "Tilt the head back gently and lift the chin up. This opens the airway. Look, listen, and feel for breathing for up to 10 seconds.",
          image: "breathing_2",
        ),
        EmergencyStep(
          step: 3,
          title: "Begin Rescue Breaths",
          description:
              "Pinch the nose shut. Seal your mouth over theirs. Give 2 slow breaths, each lasting about 1 second. Watch for chest rise.",
          image: "breathing_3",
        ),
        EmergencyStep(
          step: 4,
          title: "Start CPR If Needed",
          description:
              "If there is no pulse, begin chest compressions. Push hard and fast in the center of the chest — about 100–120 compressions per minute.",
          image: "breathing_4",
        ),
        EmergencyStep(
          step: 5,
          title: "Continue Until Help Arrives",
          description:
              "Alternate 30 chest compressions with 2 rescue breaths. Continue until the person breathes on their own or emergency services take over.",
          image: "breathing_5",
        ),
      ],
    ),

    // Burns
    const Emergency(
      id: "burns",
      title: "Burns",
      icon: "🔥",
      color: "#E65100",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Stop the Burning",
          description:
              "Remove the person from the source of the burn. If clothing is on fire, stop-drop-and-roll. Remove smoldering clothing unless stuck to skin.",
          image: "burns_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Cool the Burn",
          description:
              "Cool the burn under cool (not cold) running water for at least 10–20 minutes. This reduces pain and limits tissue damage. Do NOT use ice.",
          image: "burns_2",
        ),
        EmergencyStep(
          step: 3,
          title: "Remove Jewelry",
          description:
              "Gently remove rings, watches, or tight items near the burned area before swelling begins. Do not pull off anything stuck to the skin.",
          image: "burns_3",
        ),
        EmergencyStep(
          step: 4,
          title: "Cover the Burn",
          description:
              "Cover loosely with a clean non-fluffy material, like cling wrap or a clean plastic bag. Do not use cotton wool or anything that may stick.",
          image: "burns_3",
        ),
        EmergencyStep(
          step: 5,
          title: "Seek Medical Help",
          description:
              "Get medical help for burns larger than a palm, on the face/hands/feet/genitals, or if the skin is charred or white. Call emergency services.",
          image: "burns_3",
        ),
      ],
    ),

    // Heart Attack
    const Emergency(
      id: "heart_attack",
      title: "Heart Attack",
      icon: "❤️",
      color: "#880E4F",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Recognize the Signs",
          description:
              "Watch for: chest pain or pressure, pain spreading to arm/jaw/neck, shortness of breath, sweating, nausea, or lightheadedness. Act fast — every minute matters.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Call Emergency Services",
          description:
              "Call 112 immediately. Do not drive to the hospital unless absolutely necessary. Give your exact location and describe symptoms clearly.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Help Them Sit",
          description:
              "Help the person sit down in a comfortable position, ideally on the floor with knees bent. Loosen tight clothing around the neck and chest.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Give Aspirin If Available",
          description:
              "If the person is not allergic to aspirin and can swallow, give one adult aspirin (325mg) or four low-dose aspirins (81mg each). Ask them to chew it.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Prepare for CPR",
          description:
              "If the person becomes unresponsive and stops breathing normally, begin CPR immediately. Push hard and fast in the center of the chest until help arrives.",
          image: "heart_1",
        ),
      ],
    ),

    // Stroke
    const Emergency(
      id: "stroke",
      title: "Stroke",
      icon: "🧠",
      color: "#6A1B9A",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Recognize FAST Signs",
          description:
              "F – Face drooping. A – Arm weakness. S – Speech difficulty. T – Time to call emergency immediately.",
          image: "stroke_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Call Emergency Services",
          description:
              "Call emergency services immediately. Note the time symptoms started. Fast treatment reduces brain damage.",
          image: "stroke_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Keep Them Comfortable",
          description:
              "Lay the person on their side with head slightly raised. Loosen tight clothing and keep them calm.",
          image: "stroke_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Do NOT Give Food or Drink",
          description:
              "They may choke due to swallowing difficulty. Wait for medical professionals.",
          image: "stroke_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Monitor Breathing",
          description:
              "If they become unconscious and stop breathing, begin CPR until help arrives.",
          image: "stroke_1",
        ),
      ],
    ),

    // Electric Shock
    const Emergency(
      id: "electric_shock",
      title: "Electric Shock",
      icon: "⚡",
      color: "#F9A825",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Do NOT Touch Directly",
          description:
              "Do not touch the person while they are in contact with electricity. You may get shocked too.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Turn Off Power Source",
          description:
              "Switch off the main power supply or unplug the device if safe to do so.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Use Non-Conductive Object",
          description:
              "If power cannot be turned off, use wood, plastic, or cloth to separate the person from the source.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Check Breathing",
          description:
              "If unconscious, check breathing and pulse. Begin CPR if necessary.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Seek Immediate Medical Help",
          description:
              "Electric injuries may cause internal damage. Always seek medical attention.",
          image: "bleeding_1",
        ),
      ],
    ),

    // Chocking
    const Emergency(
      id: "choking",
      title: "Choking (Adult)",
      icon: "😮‍💨",
      color: "#00897B",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Ask if They Can Speak",
          description:
              "If they cannot cough, speak, or breathe, immediate action is required.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Give 5 Back Blows",
          description:
              "Stand behind them and deliver 5 firm blows between shoulder blades using the heel of your hand.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Give 5 Abdominal Thrusts",
          description:
              "Place your fist above the navel and push inward and upward quickly. Repeat 5 times.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Repeat Until Object Comes Out",
          description:
              "Alternate 5 back blows and 5 thrusts until breathing resumes.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 5,
          title: "If Unconscious, Start CPR",
          description:
              "Carefully lower them to the ground and begin CPR. Call emergency services immediately.",
          image: "bleeding_1",
        ),
      ],
    ),

    // Snake Bite
    const Emergency(
      id: "snake_bite",
      title: "Snake Bite",
      icon: "🐍",
      color: "#2E7D32",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Stay Calm",
          description:
              "Keep the person calm and still to slow venom spread. Panic increases heart rate.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Immobilize the Limb",
          description:
              "Keep the bitten area still and below heart level. Use a splint if possible.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Remove Tight Items",
          description:
              "Remove rings, watches, or tight clothing before swelling starts.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Do NOT Cut or Suck",
          description:
              "Do not cut the wound or attempt to suck venom. This causes more harm.",
          image: "bleeding_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Get Emergency Help Immediately",
          description:
              "Transport to hospital immediately. Anti-venom treatment is required urgently.",
          image: "bleeding_1",
        ),
      ],
    ),

    // Heat Stroke
    const Emergency(
      id: "heat_stroke",
      title: "Heat Stroke",
      icon: "☀️",
      color: "#EF6C00",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Move to Cool Area",
          description:
              "Move the person to shade or an air-conditioned place immediately.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Remove Excess Clothing",
          description: "Loosen or remove heavy clothing to help body cooling.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Cool the Body",
          description:
              "Use cool water, wet cloths, or ice packs on neck, armpits, and groin.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Give Water If Conscious",
          description:
              "Provide cool water slowly. Do not give caffeine or energy drinks.",
          image: "heart_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Call Emergency Services",
          description:
              "Heat stroke is life-threatening. Get medical help immediately.",
          image: "heart_1",
        ),
      ],
    ),

    // Posiioning
    const Emergency(
      id: "poisoning",
      title: "Poisoning",
      icon: "☠️",
      color: "#37474F",
      steps: [
        EmergencyStep(
          step: 1,
          title: "Check Responsiveness",
          description:
              "If unconscious or not breathing, begin CPR and call emergency services immediately.",
          image: "breathing_1",
        ),
        EmergencyStep(
          step: 2,
          title: "Identify the Poison",
          description:
              "Look for containers, plants, or substances nearby to identify the poison.",
          image: "breathing_1",
        ),
        EmergencyStep(
          step: 3,
          title: "Do NOT Force Vomiting",
          description:
              "Do not force vomiting unless medical professionals instruct you.",
          image: "breathing_1",
        ),
        EmergencyStep(
          step: 4,
          title: "Rinse Mouth if Chemical",
          description:
              "If poison is chemical, rinse mouth gently with water. Do not swallow.",
          image: "breathing_1",
        ),
        EmergencyStep(
          step: 5,
          title: "Call Emergency Services",
          description:
              "Provide age, weight, substance taken, and time of exposure.",
          image: "breathing_1",
        ),
      ],
    ),
  ];

  List<Emergency> get emergencies => List.unmodifiable(_emergencies);

  // ───────────────── TTS Engine ─────────────────
  final FlutterTts _tts = FlutterTts();
  bool _ttsInitialized = false;

  // ───────────────── State ─────────────────
  Emergency? _currentEmergency;
  int _currentStepIndex = 0;
  bool _isSpeaking = false;
  bool _voiceEnabled = true;

  Emergency? get emergency => _currentEmergency;
  int get currentStepIndex => _currentStepIndex;
  bool get isSpeaking => _isSpeaking;
  bool get voiceEnabled => _voiceEnabled;

  // ───────────────── Derived Getters ─────────────────

  EmergencyStep? get currentStep {
    final e = _currentEmergency;
    if (e == null || e.steps.isEmpty) return null;
    if (_currentStepIndex < 0 || _currentStepIndex >= e.steps.length) {
      return null;
    }
    return e.steps[_currentStepIndex];
  }

  int get totalSteps => _currentEmergency?.steps.length ?? 0;
  bool get isFirstStep => _currentStepIndex <= 0;
  bool get isLastStep => _currentEmergency == null
      ? true
      : _currentStepIndex >= _currentEmergency!.steps.length - 1;

  double get progress =>
      totalSteps == 0 ? 0 : (_currentStepIndex + 1) / totalSteps;

  // ───────────────── Initialization ─────────────────

  Future<void> _initTTS() async {
    if (_ttsInitialized) return;

    try {
      await _tts.setLanguage(AppConstants.ttsLanguage);
      await _tts.setSpeechRate(AppConstants.ttsRate);
      await _tts.setVolume(AppConstants.ttsVolume);
      await _tts.setPitch(AppConstants.ttsPitch);

      _tts.setCompletionHandler(() {
        _isSpeaking = false;
        notifyListeners();
      });

      _tts.setErrorHandler((msg) {
        debugPrint('❌ TTS Error: $msg');
        _isSpeaking = false;
        notifyListeners();
      });

      _ttsInitialized = true;
    } catch (e) {
      debugPrint('❌ TTS Init Failed: $e');
    }
  }

  Future<void> startEmergency({
    required Emergency emergency,
    required bool voiceEnabled,
  }) async {
    _currentEmergency = emergency;
    _voiceEnabled = voiceEnabled;
    _currentStepIndex = 0;
    _isSpeaking = false;

    await _initTTS();
    notifyListeners();
  }

  // ───────────────── Navigation ─────────────────

  void nextStep() {
    if (isLastStep) return;
    _stopSpeakingInternal();
    _currentStepIndex++;
    notifyListeners();
  }

  void previousStep() {
    if (isFirstStep) return;
    _stopSpeakingInternal();
    _currentStepIndex--;
    notifyListeners();
  }

  void goToStep(int index) {
    if (_currentEmergency == null) return;
    if (index < 0 || index >= totalSteps) return;

    _stopSpeakingInternal();
    _currentStepIndex = index;
    notifyListeners();
  }

  void restart() {
    _stopSpeakingInternal();
    _currentStepIndex = 0;
    notifyListeners();
  }

  // ───────────────── Voice Controls ─────────────────

  Future<void> toggleReadAloud() async {
    if (!_voiceEnabled) return;

    if (_isSpeaking) {
      await stopSpeaking();
    } else {
      await speakCurrentStep();
    }
  }

  Future<void> speakCurrentStep() async {
    if (!_voiceEnabled || _isSpeaking) return;

    final step = currentStep;
    if (step == null) return;

    try {
      _isSpeaking = true;
      notifyListeners();

      final text = '${step.title}. ${step.description}';
      await _tts.speak(text);
    } catch (e) {
      debugPrint('❌ Speak failed: $e');
      _isSpeaking = false;
      notifyListeners();
    }
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
    _isSpeaking = false;
    notifyListeners();
  }

  void _stopSpeakingInternal() {
    if (_isSpeaking) {
      _tts.stop();
      _isSpeaking = false;
    }
  }

  // ───────────────── Utilities ─────────────────

  Emergency? findById(String id) {
    try {
      return _emergencies.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Emergency> search(String query) {
    final q = query.toLowerCase();
    return _emergencies
        .where((e) => e.title.toLowerCase().contains(q))
        .toList();
  }

  Color getEmergencyColor(Emergency e) {
    return Color(int.parse(e.color.replaceFirst('#', '0xFF')));
  }

  // ───────────────── Cleanup ─────────────────

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
