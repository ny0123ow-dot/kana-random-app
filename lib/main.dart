import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: KanaRandomPage());
}

class KanaRandomPage extends StatefulWidget {
  const KanaRandomPage({super.key});
  @override
  State<KanaRandomPage> createState() => _KanaRandomPageState();
}

class _KanaRandomPageState extends State<KanaRandomPage> {
  // ===== 行（清音） =====
  final Map<String, List<String>> hiraRows = const {
    "あ行(fila a)": ["あ", "い", "う", "え", "お"],
    "か行(fila ka)": ["か", "き", "く", "け", "こ"],
    "さ行(fila sa)": ["さ", "し", "す", "せ", "そ"],
    "た行(fila ta)": ["た", "ち", "つ", "て", "と"],
    "な行(fila na)": ["な", "に", "ぬ", "ね", "の"],
    "は行(fila ha)": ["は", "ひ", "ふ", "へ", "ほ"],
    "ま行(fila ma)": ["ま", "み", "む", "め", "も"],
    "や行(fila ya)": ["や", "ゆ", "よ"],
    "ら行(fila ra)": ["ら", "り", "る", "れ", "ろ"],
    "わ行(fila wa)": ["わ", "を", "ん"],
  };

  final Map<String, List<String>> kataRows = const {
    "ア行(fila a)": ["ア", "イ", "ウ", "エ", "オ"],
    "カ行(fila ka)": ["カ", "キ", "ク", "ケ", "コ"],
    "サ行(fila sa)": ["サ", "シ", "ス", "セ", "ソ"],
    "タ行(fila ta)": ["タ", "チ", "ツ", "テ", "ト"],
    "ナ行(fila na)": ["ナ", "ニ", "ヌ", "ネ", "ノ"],
    "ハ行(fila ha)": ["ハ", "ヒ", "フ", "ヘ", "ホ"],
    "マ行(fila ma)": ["マ", "ミ", "ム", "メ", "モ"],
    "ヤ行(fila ya)": ["ヤ", "ユ", "ヨ"],
    "ラ行(fila ra)": ["ラ", "リ", "ル", "レ", "ロ"],
    "ワ行(fila wa)": ["ワ", "ヲ", "ン"],
  };

  // ===== 濁音・半濁音（行で選択） =====
  final Map<String, List<String>> hiraDakuonRows = const {
    "が行(fila ga)": ["が", "ぎ", "ぐ", "げ", "ご"],
    "ざ行(fila za)": ["ざ", "じ", "ず", "ぜ", "ぞ"],
    "だ行(fila da)": ["だ", "ぢ", "づ", "で", "ど"],
    "ば行(fila ba)": ["ば", "び", "ぶ", "べ", "ぼ"],
    "ぱ行(fila pa)": ["ぱ", "ぴ", "ぷ", "ぺ", "ぽ"],
    "ゔ": ["ゔ"],
  };

  final Map<String, List<String>> kataDakuonRows = const {
    "ガ行(fila ga)": ["ガ", "ギ", "グ", "ゲ", "ゴ"],
    "ザ行(fila za)": ["ザ", "ジ", "ズ", "ゼ", "ゾ"],
    "ダ行(fila da)": ["ダ", "ヂ", "ヅ", "デ", "ド"],
    "バ行(fila ba)": ["バ", "ビ", "ブ", "ベ", "ボ"],
    "パ行(fila pa)": ["パ", "ピ", "プ", "ペ", "ポ"],
    "ヴ": ["ヴ"],
  };

  // ===== 拗音（行で選択） =====
  final Map<String, List<String>> hiraYoonRows = const {
    "きゃ行(fila kya)": ["きゃ", "きゅ", "きょ"],
    "ぎゃ行(fila gya)": ["ぎゃ", "ぎゅ", "ぎょ"],
    "しゃ行(fila sha)": ["しゃ", "しゅ", "しょ"],
    "じゃ行(fila ja)": ["じゃ", "じゅ", "じょ"],
    "ちゃ行(fila cha)": ["ちゃ", "ちゅ", "ちょ"],
    "ぢゃ行(fila dya)": ["ぢゃ", "ぢゅ", "ぢょ"],
    "にゃ行(fila nya)": ["にゃ", "にゅ", "にょ"],
    "ひゃ行(fila hya)": ["ひゃ", "ひゅ", "ひょ"],
    "びゃ行(fila bya)": ["びゃ", "びゅ", "びょ"],
    "ぴゃ行(fila pya)": ["ぴゃ", "ぴゅ", "ぴょ"],
    "みゃ行(fila mya)": ["みゃ", "みゅ", "みょ"],
    "りゃ行(fila rya)": ["りゃ", "りゅ", "りょ"],
  };

  final Map<String, List<String>> kataYoonRows = const {
    "キャ行(fila kya)": ["キャ", "キュ", "キョ"],
    "ギャ行(fila gya)": ["ギャ", "ギュ", "ギョ"],
    "シャ行(fila sha)": ["シャ", "シュ", "ショ"],
    "ジャ行(fila ja)": ["ジャ", "ジュ", "ジョ"],
    "チャ行(fila cha)": ["チャ", "チュ", "チョ"],
    "ヂャ行(fila dya)": ["ヂャ", "ヂュ", "ヂョ"],
    "ニャ行(fila nya)": ["ニャ", "ニュ", "ニョ"],
    "ヒャ行(fila hya)": ["ヒャ", "ヒュ", "ヒョ"],
    "ビャ行(fila bya)": ["ビャ", "ビュ", "ビョ"],
    "ピャ行(fila pya)": ["ピャ", "ピュ", "ピョ"],
    "ミャ行(fila mya)": ["ミャ", "ミュ", "ミョ"],
    "リャ行(fila rya)": ["リャ", "リュ", "リョ"],
  };

  // ===== 画面状態 =====
  String current = "あ";

  bool useHira = true;
  bool useKata = false;
  bool includeDakuon = false;
  bool includeYoon = false;

  late Map<String, bool> hiraRowEnabled;
  late Map<String, bool> kataRowEnabled;

  late Map<String, bool> hiraDakuonRowEnabled;
  late Map<String, bool> kataDakuonRowEnabled;

  late Map<String, bool> hiraYoonRowEnabled;
  late Map<String, bool> kataYoonRowEnabled;

  // ===== TTS =====
  final FlutterTts tts = FlutterTts();

  Future<void> _initTts() async {
    await tts.setLanguage('ja-JP');

    // ここを調整すると「短い」感が減る
    await tts.setSpeechRate(0.30); // 0.25〜0.45で好み
    await tts.setPitch(1.0);
    await tts.setVolume(1.0);

    // 最後まで喋らせやすくする（効かない環境でもOK）
    await tts.awaitSpeakCompletion(true);
  }

  Future<void> speakCurrent() async {
    await tts.stop();
    await tts.speak(current);
  }

  @override
  void initState() {
    super.initState();

    _initTts(); // initStateではawaitしない

    // 初期は全行ON
    hiraRowEnabled = {for (final k in hiraRows.keys) k: true};
    kataRowEnabled = {for (final k in kataRows.keys) k: true};

    // 濁音も初期は全行ON
    hiraDakuonRowEnabled = {for (final k in hiraDakuonRows.keys) k: true};
    kataDakuonRowEnabled = {for (final k in kataDakuonRows.keys) k: true};

    // 拗音も初期は全行ON
    hiraYoonRowEnabled = {for (final k in hiraYoonRows.keys) k: true};
    kataYoonRowEnabled = {for (final k in kataYoonRows.keys) k: true};
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  void setAllSeionRows(bool value) {
    setState(() {
      for (final k in hiraRowEnabled.keys) {
        hiraRowEnabled[k] = value;
      }
      for (final k in kataRowEnabled.keys) {
        kataRowEnabled[k] = value;
      }
    });
  }

  void setAllDakuonRows(bool value) {
    setState(() {
      for (final k in hiraDakuonRowEnabled.keys) {
        hiraDakuonRowEnabled[k] = value;
      }
      for (final k in kataDakuonRowEnabled.keys) {
        kataDakuonRowEnabled[k] = value;
      }
    });
  }

  void setAllYoonRows(bool value) {
    setState(() {
      for (final k in hiraYoonRowEnabled.keys) {
        hiraYoonRowEnabled[k] = value;
      }
      for (final k in kataYoonRowEnabled.keys) {
        kataYoonRowEnabled[k] = value;
      }
    });
  }

  void generate() {
    final chars = <String>[];

    if (useHira) {
      for (final entry in hiraRows.entries) {
        if (hiraRowEnabled[entry.key] == true) chars.addAll(entry.value);
      }
      if (includeDakuon) {
        for (final entry in hiraDakuonRows.entries) {
          if (hiraDakuonRowEnabled[entry.key] == true)
            chars.addAll(entry.value);
        }
      }
      if (includeYoon) {
        for (final entry in hiraYoonRows.entries) {
          if (hiraYoonRowEnabled[entry.key] == true) chars.addAll(entry.value);
        }
      }
    }

    if (useKata) {
      for (final entry in kataRows.entries) {
        if (kataRowEnabled[entry.key] == true) chars.addAll(entry.value);
      }
      if (includeDakuon) {
        for (final entry in kataDakuonRows.entries) {
          if (kataDakuonRowEnabled[entry.key] == true)
            chars.addAll(entry.value);
        }
      }
      if (includeYoon) {
        for (final entry in kataYoonRows.entries) {
          if (kataYoonRowEnabled[entry.key] == true) chars.addAll(entry.value);
        }
      }
    }

    if (chars.isEmpty) return;

    setState(() {
      current = chars[Random().nextInt(chars.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("かなランダム")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Image.asset(
                'assets/images/japonazologo.png',
                width: 280,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),

              // 文字 + 発音ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(current, style: const TextStyle(fontSize: 120)),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    iconSize: 48,
                    onPressed: speakCurrent,
                    tooltip: '発音',
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SwitchListTile(
                title: const Text("ひらがな(hiragana)"),
                value: useHira,
                onChanged: (v) => setState(() => useHira = v),
              ),
              SwitchListTile(
                title: const Text("カタカナ(katakana)"),
                value: useKata,
                onChanged: (v) => setState(() => useKata = v),
              ),
              SwitchListTile(
                title: const Text("濁音・半濁音(dakuon/handakuon)"),
                value: includeDakuon,
                onChanged: (v) => setState(() => includeDakuon = v),
              ),
              SwitchListTile(
                title: const Text("拗音(youon)"),
                value: includeYoon,
                onChanged: (v) => setState(() => includeYoon = v),
              ),

              const Divider(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => setAllSeionRows(true),
                      child: const Text("全選択(seleccionar todo)"),
                    ),
                    ElevatedButton(
                      onPressed: generate,
                      child: const Text("ランダム生成(generar aleatoriamente)"),
                    ),
                    OutlinedButton(
                      onPressed: () => setAllSeionRows(false),
                      child: const Text("全解除(deseleccionar todo)"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              if (useHira) ...[
                const Text("ひらがな（elegir la fila）"),
                ...hiraRows.keys.map((row) {
                  return CheckboxListTile(
                    dense: true,
                    title: Text(row),
                    value: hiraRowEnabled[row] ?? true,
                    onChanged: (v) =>
                        setState(() => hiraRowEnabled[row] = v ?? false),
                  );
                }),
              ],

              if (useKata) ...[
                const Text("カタカナ（elegir la fila）"),
                ...kataRows.keys.map((row) {
                  return CheckboxListTile(
                    dense: true,
                    title: Text(row),
                    value: kataRowEnabled[row] ?? true,
                    onChanged: (v) =>
                        setState(() => kataRowEnabled[row] = v ?? false),
                  );
                }),
              ],

              const Divider(),

              if (includeDakuon) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () => setAllDakuonRows(true),
                        child: const Text("seleccionar todo"),
                      ),
                      OutlinedButton(
                        onPressed: () => setAllDakuonRows(false),
                        child: const Text("deseleccionar todo"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                if (useHira) ...[
                  const Text("hiragana dakuon/handakuon（elegir la fila）"),
                  ...hiraDakuonRows.keys.map((row) {
                    return CheckboxListTile(
                      dense: true,
                      title: Text(row),
                      value: hiraDakuonRowEnabled[row] ?? true,
                      onChanged: (v) => setState(
                        () => hiraDakuonRowEnabled[row] = v ?? false,
                      ),
                    );
                  }),
                ],
                if (useKata) ...[
                  const Text("katakana dakuon/handakuon（elegir la fila）"),
                  ...kataDakuonRows.keys.map((row) {
                    return CheckboxListTile(
                      dense: true,
                      title: Text(row),
                      value: kataDakuonRowEnabled[row] ?? true,
                      onChanged: (v) => setState(
                        () => kataDakuonRowEnabled[row] = v ?? false,
                      ),
                    );
                  }),
                ],
                const Divider(),
              ],

              if (includeYoon) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () => setAllYoonRows(true),
                        child: const Text("拗音 全選択"),
                      ),
                      OutlinedButton(
                        onPressed: () => setAllYoonRows(false),
                        child: const Text("拗音 全解除"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                if (useHira) ...[
                  const Text("hiragana youon（elegir la fila）"),
                  ...hiraYoonRows.keys.map((row) {
                    return CheckboxListTile(
                      dense: true,
                      title: Text(row),
                      value: hiraYoonRowEnabled[row] ?? true,
                      onChanged: (v) =>
                          setState(() => hiraYoonRowEnabled[row] = v ?? false),
                    );
                  }),
                ],
                if (useKata) ...[
                  const Text("katakana youon（elegir la fila）"),
                  ...kataYoonRows.keys.map((row) {
                    return CheckboxListTile(
                      dense: true,
                      title: Text(row),
                      value: kataYoonRowEnabled[row] ?? true,
                      onChanged: (v) =>
                          setState(() => kataYoonRowEnabled[row] = v ?? false),
                    );
                  }),
                ],
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
