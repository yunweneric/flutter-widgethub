String switch01Code = '''import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiscloseSwitcher extends StatefulWidget {
  const DiscloseSwitcher({super.key});

  @override
  State<DiscloseSwitcher> createState() => _DiscloseSwitcherState();
}

class _DiscloseSwitcherState extends State<DiscloseSwitcher> {
  bool isOn = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600;
    final theme = Theme.of(context);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: isTablet ? constraints.maxWidth * 0.3 : constraints.maxWidth * 0.8,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isOn ? Colors.grey.withOpacity(0.2) : Colors.transparent,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
              child: AnimatedSize(
                alignment: isOn ? Alignment.topRight : Alignment.topCenter,
                duration: const Duration(milliseconds: 2000),
                curve: Curves.elasticOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SwitchListTile.adaptive(
                      activeColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                      tileColor: const Color.fromARGB(125, 33, 107, 243).withOpacity(0.05),
                      value: isOn,
                      title: Row(
                        children: [
                          SvgPicture.string(svgIcon, color: theme.highlightColor),
                          const SizedBox(width: 10),
                          const Text(
                            "Predictive Completion",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onChanged: (val) {
                        setState(() => isOn = !isOn);
                      },
                    ),
                    if (isOn)
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(
                              color: theme.highlightColor,
                            ),
                            onChanged: (val) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                          const Text(
                            "Enable Inline Prediction",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

String svgIcon =
    """<svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="512" height="512" x="0" y="0" viewBox="0 0 32 32" style="enable-background:new 0 0 512 512" xml:space="preserve" class=""><g><path d="m13.294 7.436.803 2.23a8.835 8.835 0 0 0 5.316 5.316l2.23.803a.229.229 0 0 1 0 .43l-2.23.803a8.835 8.835 0 0 0-5.316 5.316l-.803 2.23a.229.229 0 0 1-.43 0l-.803-2.23a8.835 8.835 0 0 0-5.316-5.316l-2.23-.803a.229.229 0 0 1 0-.43l2.23-.803a8.835 8.835 0 0 0 5.316-5.316l.803-2.23a.228.228 0 0 1 .43 0zM23.332 2.077l.407 1.129a4.477 4.477 0 0 0 2.692 2.692l1.129.407a.116.116 0 0 1 0 .218l-1.129.407a4.477 4.477 0 0 0-2.692 2.692l-.407 1.129a.116.116 0 0 1-.218 0l-.407-1.129a4.477 4.477 0 0 0-2.692-2.692l-1.129-.407a.116.116 0 0 1 0-.218l1.129-.407a4.477 4.477 0 0 0 2.692-2.692l.407-1.129a.116.116 0 0 1 .218 0zM23.332 21.25l.407 1.129a4.477 4.477 0 0 0 2.692 2.692l1.129.407a.116.116 0 0 1 0 .218l-1.129.407a4.477 4.477 0 0 0-2.692 2.692l-.407 1.129a.116.116 0 0 1-.218 0l-.407-1.129a4.477 4.477 0 0 0-2.692-2.692l-1.129-.407a.116.116 0 0 1 0-.218l1.129-.407a4.477 4.477 0 0 0 2.692-2.692l.407-1.129c.037-.102.182-.102.218 0z" fill="#000000" opacity="1" data-original="#000000" class=""></path></g></svg>""";
''';
