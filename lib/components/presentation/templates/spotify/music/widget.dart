import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../shared/theme.dart';

class SpotifyMusicPlayer extends StatelessWidget {
  const SpotifyMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'Now playing',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.string(PlayerIcons.back, width: 28, height: 28),
              onPressed: () {},
              splashRadius: 24,
            ),
            actions: [
              IconButton(
                icon: RotatedBox(
                  quarterTurns: 1,
                  child: SvgPicture.string(PlayerIcons.more, width: 28, height: 28),
                ),
                onPressed: () {},
                splashRadius: 24,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Album Art
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Song Info & Heart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bad Guy',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Billie Eilish',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFB3B3B3),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: SvgPicture.string(PlayerIcons.heart, width: 32, height: 32),
                        onPressed: () {},
                        splashRadius: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Slider(
                        value: 145.0,
                        min: 0.0,
                        max: 242.0,
                        onChanged: (value) {},
                        activeColor: theme.primaryColor,
                        inactiveColor: const Color(0xFF535353),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('2:25', style: TextStyle(color: Color(0xFFB3B3B3))),
                          Text('4:02', style: TextStyle(color: Color(0xFFB3B3B3))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.string(PlayerIcons.repeat, width: 28, height: 28),
                        onPressed: () {},
                        splashRadius: 24,
                      ),
                      IconButton(
                        icon: SvgPicture.string(PlayerIcons.previous, width: 36, height: 36),
                        onPressed: () {},
                        splashRadius: 28,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: SvgPicture.string(PlayerIcons.pause, width: 36, height: 36),
                          onPressed: () {},
                          splashRadius: 36,
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.string(PlayerIcons.next, width: 36, height: 36),
                        onPressed: () {},
                        splashRadius: 28,
                      ),
                      IconButton(
                        icon: SvgPicture.string(PlayerIcons.shuffle, width: 28, height: 28),
                        onPressed: () {},
                        splashRadius: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Lyrics
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      SvgPicture.string(PlayerIcons.arrowUp, width: 28, height: 28),
                      const Text('Lyrics', style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PlayerIcons {
  static const String back =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M14.528 7.53269C14.8222 7.24111 14.8243 6.76624 14.5327 6.47204C14.2411 6.17784 13.7662 6.17573 13.472 6.46731L11.6773 8.2461C11.0013 8.91604 10.4489 9.46359 10.0571 9.95146C9.64963 10.4588 9.35469 10.9737 9.27591 11.5918C9.24136 11.8629 9.24136 12.1371 9.27591 12.4082C9.35469 13.0263 9.64963 13.5412 10.0571 14.0485C10.4489 14.5364 11.0013 15.084 11.6773 15.7539L13.472 17.5327C13.7662 17.8243 14.2411 17.8222 14.5327 17.528C14.8243 17.2338 14.8222 16.7589 14.528 16.4673L12.765 14.72C12.0495 14.0109 11.5587 13.5228 11.2266 13.1093C10.904 12.7076 10.7933 12.4496 10.7639 12.2185C10.7454 12.0734 10.7454 11.9266 10.7639 11.7815C10.7933 11.5504 10.904 11.2924 11.2266 10.8907C11.5587 10.4772 12.0495 9.98914 12.765 9.28L14.528 7.53269Z" fill="#DDDDDD"/>
</svg>
''';
  static const String more =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="5" cy="12" r="2" fill="white"/><circle cx="12" cy="12" r="2" fill="white"/><circle cx="19" cy="12" r="2" fill="white"/></svg>''';
  static const String heart =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M20.3115 4.46071C17.9773 2.08032 15.2743 3.08425 13.6007 4.14593C12.655 4.74582 11.345 4.74582 10.3993 4.14593C8.72564 3.08427 6.02272 2.08035 3.68853 4.46072C-1.85249 10.1114 7.64988 21 12 21C16.3502 21 25.8525 10.1114 20.3115 4.46071Z" stroke="#6C6C6C" stroke-width="1.5" stroke-linecap="round"/>
</svg>
''';
  static const String repeat =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M15.7803 2.46967C15.4874 2.17678 15.0125 2.17678 14.7196 2.46967C14.4267 2.76256 14.4267 3.23744 14.7196 3.53033L15.4393 4.25L10.8381 4.24998C9.13186 4.24971 8.09064 4.24955 7.22312 4.53142C5.47261 5.1002 4.10017 6.47263 3.5314 8.22315C3.24952 9.09067 3.24969 10.1319 3.24996 11.8382V12.1618C3.24969 13.8681 3.24952 14.9093 3.5314 15.7768C3.6594 16.1708 4.08251 16.3864 4.47645 16.2584C4.87039 16.1304 5.08598 15.7073 4.95798 15.3133C4.75923 14.7016 4.74997 13.9197 4.74997 12C4.74997 10.0803 4.75923 9.29839 4.95798 8.68668C5.37838 7.39282 6.39279 6.37841 7.68665 5.95801C8.29836 5.75925 9.08032 5.75 11 5.75H15.1784L14.5198 6.29883C14.2016 6.56401 14.1586 7.03693 14.4238 7.35514C14.689 7.67335 15.1619 7.71634 15.4801 7.45117L16.8889 6.27719C17.2731 5.95697 17.4839 5.5078 17.5146 5.05027C17.547 4.5677 17.3796 4.06894 17.006 3.69537L15.7803 2.46967Z" fill="#6D6D6D"/>
<path d="M20.4685 8.22315C20.3405 7.82921 19.9174 7.61362 19.5235 7.74162C19.1296 7.86962 18.914 8.29274 19.042 8.68668C19.2407 9.29839 19.25 10.0803 19.25 12C19.25 13.9197 19.2407 14.7016 19.042 15.3133C18.6216 16.6072 17.6072 17.6216 16.3133 18.042C15.7016 18.2407 14.9196 18.25 13 18.25H11C10.0327 18.25 9.35438 18.2478 8.84071 18.2199L9.5303 17.5303C9.8232 17.2374 9.8232 16.7626 9.5303 16.4697C9.23741 16.1768 8.76254 16.1768 8.46964 16.4697L7.24395 17.6954C6.97569 17.9636 6.81256 18.2982 6.755 18.6453C6.65771 19.2321 6.8623 19.8616 7.36106 20.2772L8.76983 21.4512C9.08804 21.7163 9.56096 21.6733 9.82614 21.3551C10.0913 21.0369 10.0483 20.564 9.73011 20.2988L9.04884 19.7311C9.55813 19.7502 10.1454 19.7501 10.8442 19.75H13.1618C14.8681 19.7503 15.9093 19.7504 16.7768 19.4686C18.5273 18.8998 19.8998 17.5274 20.4685 15.7768C20.7504 14.9093 20.7503 13.8681 20.75 12.1618V11.8382C20.7503 10.1319 20.7504 9.09067 20.4685 8.22315Z" fill="#6D6D6D"/>
</svg>
''';
  static const String previous =
      '''<svg width="26" height="26" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M6.22919 6.5C6.22919 6.05127 5.86542 5.6875 5.41669 5.6875C4.96796 5.6875 4.60419 6.05127 4.60419 6.5V19.5C4.60419 19.9487 4.96796 20.3125 5.41669 20.3125C5.86542 20.3125 6.22919 19.9487 6.22919 19.5L6.22919 6.5Z" fill="#A7A7A7"/>
<path d="M16.7783 5.7027C16.045 5.62429 15.3158 5.85736 14.5338 6.22432C13.7555 6.58953 12.8028 7.14923 11.5995 7.85613L11.5251 7.89984C10.3216 8.60685 9.36886 9.16651 8.66904 9.66959C7.96458 10.176 7.4064 10.6993 7.11011 11.3765C6.65777 12.4102 6.65777 13.5898 7.11011 14.6235C7.4064 15.3007 7.96458 15.824 8.66904 16.3304C9.36886 16.8335 10.3215 17.3931 11.5251 18.1001L11.5995 18.1439C12.8028 18.8508 13.7555 19.4105 14.5338 19.7757C15.3158 20.1426 16.045 20.3757 16.7783 20.2973C17.8959 20.1778 18.9068 19.5818 19.5623 18.6637C19.9905 18.0641 20.1559 17.313 20.2344 16.4424C20.3125 15.5755 20.3125 14.4574 20.3125 13.0422V12.9578C20.3125 11.5426 20.3125 10.4245 20.2344 9.55759C20.1559 8.68698 19.9905 7.93591 19.5623 7.33628C18.9068 6.41824 17.8959 5.82222 16.7783 5.7027Z" fill="#A7A7A7"/>
</svg>
''';
  static const String play =
      '''<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="18" cy="18" r="18" fill="#1ED760"/><polygon points="14,11 27,18 14,25" fill="black"/></svg>''';
  static const String pause =
      '''<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="18" cy="18" r="18" fill="#1ED760"/><rect x="13" y="12" width="3" height="12" rx="1.5" fill="black"/><rect x="20" y="12" width="3" height="12" rx="1.5" fill="black"/></svg>''';
  static const String next =
      '''<svg width="26" height="26" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M21.3958 6.5C21.3958 6.05127 21.0321 5.6875 20.5833 5.6875C20.1346 5.6875 19.7708 6.05127 19.7708 6.5V19.5C19.7708 19.9487 20.1346 20.3125 20.5833 20.3125C21.0321 20.3125 21.3958 19.9487 21.3958 19.5V6.5Z" fill="#A7A7A7"/>
<path d="M14.4006 7.85615C13.1973 7.14925 12.2445 6.58954 11.4662 6.22433C10.6842 5.85736 9.95498 5.62429 9.22177 5.7027C8.10414 5.82222 7.09321 6.41824 6.43768 7.33628C6.00952 7.93591 5.84415 8.68698 5.76565 9.55759C5.68749 10.4245 5.68749 11.5426 5.6875 12.9578V13.0422C5.68749 14.4574 5.68749 15.5755 5.76565 16.4424C5.84414 17.313 6.00952 18.0641 6.43768 18.6637C7.0932 19.5818 8.10414 20.1778 9.22177 20.2973C9.95497 20.3757 10.6842 20.1426 11.4662 19.7757C12.2445 19.4105 13.1972 18.8508 14.4005 18.1439L14.4749 18.1002C15.6785 17.3932 16.6312 16.8335 17.331 16.3304C18.0354 15.824 18.5936 15.3007 18.8899 14.6235C19.3423 13.5898 19.3423 12.4102 18.8899 11.3765C18.5936 10.6993 18.0354 10.176 17.331 9.6696C16.6312 9.16651 15.6785 8.60686 14.4749 7.89985L14.4006 7.85615Z" fill="#A7A7A7"/>
</svg>
''';
  static const String shuffle =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M18.7803 3.46967C18.4874 3.17678 18.0126 3.17678 17.7197 3.46967C17.4268 3.76256 17.4268 4.23744 17.7197 4.53033L18.444 5.25467C16.6098 5.32853 14.9151 6.27533 13.8916 7.81047L8.8603 15.3575C8.07207 16.5398 6.74508 17.25 5.32408 17.25H5C4.58579 17.25 4.25 17.5858 4.25 18C4.25 18.4142 4.58579 18.75 5 18.75H5.32408C7.24661 18.75 9.04194 17.7892 10.1084 16.1895L15.1397 8.64252C15.8273 7.61106 16.925 6.93895 18.1374 6.7842L17.5199 7.29883C17.2017 7.56401 17.1587 8.03693 17.4238 8.35514C17.689 8.67335 18.1619 8.71634 18.4801 8.45117L19.8889 7.27719C20.2732 6.95697 20.4839 6.5078 20.5146 6.05027C20.5471 5.5677 20.3796 5.06894 20.006 4.69537L18.7803 3.46967Z" fill="#6D6D6D"/>
<path d="M5 5.25C4.58579 5.25 4.25 5.58579 4.25 6C4.25 6.41421 4.58579 6.75 5 6.75H5.32408C6.74508 6.75 8.07206 7.46018 8.86029 8.64252C9.09006 8.98717 9.55571 9.0803 9.90036 8.85054C10.245 8.62077 10.3381 8.15512 10.1084 7.81047C9.04194 6.21083 7.24661 5.25 5.32408 5.25H5Z" fill="#6D6D6D"/>
<path d="M15.1397 15.3575C14.9099 15.0128 14.4443 14.9197 14.0996 15.1495C13.755 15.3792 13.6619 15.8449 13.8916 16.1895C14.8699 17.6569 16.4614 18.5867 18.2019 18.7305L17.5199 19.2988C17.2017 19.564 17.1587 20.0369 17.4238 20.3551C17.689 20.6733 18.1619 20.7163 18.4801 20.4512L19.8889 19.2772C20.2732 18.957 20.4839 18.5078 20.5146 18.0503C20.5471 17.5677 20.3796 17.0689 20.006 16.6954L18.7803 15.4697C18.4874 15.1768 18.0126 15.1768 17.7197 15.4697C17.4268 15.7626 17.4268 16.2374 17.7197 16.5303L18.4324 17.243C17.1044 17.167 15.8827 16.472 15.1397 15.3575Z" fill="#6D6D6D"/>
</svg>

''';
  static const String arrowUp =
      '''<svg width="31" height="31" viewBox="0 0 31 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M21.2703 18.7652C21.6469 19.1452 22.2603 19.148 22.6403 18.7714C23.0203 18.3947 23.023 17.7814 22.6464 17.4013L20.3488 15.0831C19.4835 14.21 18.7762 13.4964 18.146 12.9903C17.4907 12.4641 16.8256 12.0831 16.0272 11.9813C15.6771 11.9367 15.3229 11.9367 14.9728 11.9813C14.1744 12.0831 13.5093 12.4641 12.854 12.9903C12.2238 13.4964 11.5166 14.21 10.6512 15.0831L8.35362 17.4013C7.97699 17.7814 7.97972 18.3947 8.35973 18.7714C8.73973 19.148 9.35311 19.1452 9.72974 18.7652L11.9867 16.4881C12.9026 15.5639 13.533 14.9299 14.0672 14.501C14.586 14.0843 14.9193 13.9413 15.2178 13.9033C15.4052 13.8794 15.5948 13.8794 15.7822 13.9033C16.0807 13.9413 16.414 14.0843 16.9328 14.501C17.467 14.9299 18.0974 15.5639 19.0133 16.4881L21.2703 18.7652Z" fill="#8C8989"/>
</svg>
''';
}
