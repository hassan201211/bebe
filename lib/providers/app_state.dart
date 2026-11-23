import 'dart:math';
import 'package:flutter/material.dart';
import '../models/gift_card.dart';
import '../models/order.dart';
import '../core/colors.dart';

class AppState extends ChangeNotifier {
  String userName = 'أحمد العراقي';
  String userPhone = '+964 770 123 4567';
  bool isLoggedIn = true;
  int walletBalance = 125000;
  String selectedCategory = 'الكل';
  String searchQuery = '';

  final List<OrderItem> _orders = [
    OrderItem(
      id: 'NABD-88219',
      cardTitle: 'آسياسيل 70,000 د.ع',
      cardSubtitle: 'Asiacell_70000IQD',
      usdValue: 50,
      paidAmountIQD: 70000,
      code: 'ASIA-7712-9901-4412',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      brandColor: AppColors.asiacellRed,
      category: 'اتصالات',
    ),
    OrderItem(
      id: 'NABD-81204',
      cardTitle: 'شدات ببجي موبايل',
      cardSubtitle: 'PUBG_660_UC',
      usdValue: 10,
      paidAmountIQD: 14000,
      code: 'PBG-7741-2098-1123',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      brandColor: AppColors.pubgDark,
      category: 'ألعاب',
    ),
  ];

  List<OrderItem> get orders => List.unmodifiable(_orders);

  // قائمة البطاقات المتوافقة مع الشاشات السابقة
  final List<GiftCardItem> allCards = [
    const GiftCardItem(
      id: 'psn-25',
      title: 'بطاقة بلايستيشن ستور',
      titleEn: 'PlayStation Store - \$25 USD',
      subtitle: 'PlayStation Store - \$25 USD',
      brand: 'PlayStation',
      primaryColor: AppColors.playstationBlue,
      accentColor: Color(0xFF0072CE),
      category: 'بلايستيشن',
      isBestSeller: true,
      hasInstantDelivery: true,
      description:
          'اشحن 25 دولاراً إلى رصيد حسابك الأمريكي، واستمتع بالآلاف من الألعاب والإضافات والاشتراكات.',
      termsWarning:
          'قبل ما تشتري: تأكد أن منطقة حسابك في الولايات المتحدة (أمريكي).',
      denominations: [
        DenominationOption(
            usdValue: 10,
            iqdPrice: 15000,
            code: 'PlayStation_10USD',
            title: 'بلايستيشن 10\$'),
        DenominationOption(
            usdValue: 25,
            iqdPrice: 37500,
            code: 'PlayStation_25USD',
            title: 'بلايستيشن 25\$'),
        DenominationOption(
            usdValue: 50,
            iqdPrice: 75000,
            code: 'PlayStation_50USD',
            title: 'بلايستيشن 50\$'),
        DenominationOption(
            usdValue: 100,
            iqdPrice: 150000,
            code: 'PlayStation_100USD',
            title: 'بلايستيشن 100\$'),
      ],
    ),
    const GiftCardItem(
      id: 'xbox-15',
      title: 'بطاقة إكس بوكس',
      titleEn: 'Xbox Gift Card - \$15 USD',
      subtitle: 'Xbox Gift Card - \$15 USD',
      brand: 'Xbox',
      primaryColor: AppColors.xboxGreen,
      accentColor: Color(0xFF107C10),
      category: 'إكس بوكس',
      isBestSeller: true,
      hasInstantDelivery: true,
      description:
          'اشحن رصيد حساب مايكروسوفت أو إكس بوكس لشراء أحدث الألعاب والاشتراكات.',
      termsWarning: 'تأكد أن منطقة حساب الإكس بوكس متوافقة مع بطاقة الشحن.',
      denominations: [
        DenominationOption(
            usdValue: 10,
            iqdPrice: 15000,
            code: 'Xbox_10_USD',
            title: 'إكس بوكس 10\$'),
        DenominationOption(
            usdValue: 15,
            iqdPrice: 22500,
            code: 'Xbox_15_USD',
            title: 'إكس بوكس 15\$'),
        DenominationOption(
            usdValue: 25,
            iqdPrice: 37500,
            code: 'Xbox_25_USD',
            title: 'إكس بوكس 25\$'),
      ],
    ),
    const GiftCardItem(
      id: 'steam-20',
      title: 'بطاقة ستيم والت',
      titleEn: 'Steam Wallet - \$20 USD',
      subtitle: 'Steam Wallet - \$20 USD',
      brand: 'Steam',
      primaryColor: AppColors.steamDark,
      accentColor: Color(0xFF2A475E),
      category: 'ستيم',
      isBestSeller: true,
      hasInstantDelivery: true,
      description: 'اشحن محفظة ستيم والعب آلاف الألعاب على منصة الحاسوب PC.',
      termsWarning: 'بطاقات ستيم عالمية وتتحول تلقائياً لعملة متجرك المعتمدة.',
      denominations: [
        DenominationOption(
            usdValue: 10,
            iqdPrice: 15000,
            code: 'Steam_10USD',
            title: 'ستيم 10\$'),
        DenominationOption(
            usdValue: 20,
            iqdPrice: 30000,
            code: 'Steam_20USD',
            title: 'ستيم 20\$'),
        DenominationOption(
            usdValue: 50,
            iqdPrice: 75000,
            code: 'Steam_50USD',
            title: 'ستيم 50\$'),
      ],
    ),
    const GiftCardItem(
      id: 'pubg-660',
      title: 'شدات ببجي موبايل',
      titleEn: 'PUBG Mobile - 660 UC',
      subtitle: 'PUBG Mobile - 660 UC',
      brand: 'PUBG Mobile',
      primaryColor: AppColors.pubgDark,
      accentColor: Color(0xFFB45309),
      category: 'ببجي موبايل',
      isBestSeller: true,
      hasInstantDelivery: true,
      description: 'اشحن الرويال باس والأسلحة المطورة في ببجي موبايل.',
      termsWarning: 'يرجى التأكد من استرداد الكود عبر موقع Midasbuy الرسمي.',
      denominations: [
        DenominationOption(
            usdValue: 1, iqdPrice: 1500, code: 'Pubg_60_UC', title: '60 UC'),
        DenominationOption(
            usdValue: 5, iqdPrice: 7000, code: 'Pubg_325_UC', title: '325 UC'),
        DenominationOption(
            usdValue: 10,
            iqdPrice: 14000,
            code: 'Pubg_660_UC',
            title: '660 UC'),
      ],
    ),
    const GiftCardItem(
      id: 'zain-iq',
      title: 'كارت شحن زين العراق',
      titleEn: 'Zain Iraq - 10,000 IQD',
      subtitle: 'كارت تعبئة رصيد زين',
      brand: 'Zain',
      primaryColor: AppColors.zainSilver,
      accentColor: Color(0xFF831843),
      category: 'رصيد محلي',
      region: 'العراق 🇮🇶',
      description: 'كارت تعبئة رصيد خطوط زين العراق للمكالمات وباقات الإنترنت.',
      termsWarning: 'يتم الشحن بطلب *101*رقم_الكارت# واتصال.',
      denominations: [
        DenominationOption(
            usdValue: 5,
            iqdPrice: 5000,
            code: 'Zain_5000IQD',
            title: '5,000 د.ع'),
        DenominationOption(
            usdValue: 10,
            iqdPrice: 10000,
            code: 'Zain_10000IQD',
            title: '10,000 د.ع'),
        DenominationOption(
            usdValue: 25,
            iqdPrice: 25000,
            code: 'Zain_25000IQD',
            title: '25,000 د.ع'),
      ],
    ),
    const GiftCardItem(
      id: 'asiacell-iq',
      title: 'كارت شحن آسياسيل',
      titleEn: 'Asiacell - 10,000 IQD',
      subtitle: 'كارت تعبئة رصيد آسيا',
      brand: 'Asiacell',
      primaryColor: AppColors.asiacellRed,
      accentColor: Color(0xFF991B1B),
      category: 'رصيد محلي',
      region: 'العراق 🇮🇶',
      description:
          'كارت تعبئة رصيد شبكة آسياسيل لتجديد الباقات والرصيد الأساسي.',
      termsWarning: 'يتم الشحن بطلب *133*رقم_الكارت# واتصال.',
      denominations: [
        DenominationOption(
            usdValue: 50,
            iqdPrice: 70000,
            code: 'Asiacell_70000IQD',
            title: '70,000 د.ع',
            graphicType: 'red_network'),
        DenominationOption(
            usdValue: 10,
            iqdPrice: 12000,
            code: 'Asiacell_Max_12000',
            title: 'MAX 12,000 د.ع',
            graphicType: 'max_card'),
        DenominationOption(
            usdValue: 40,
            iqdPrice: 50000,
            code: 'Asiacell_50000IQD',
            title: '50,000 د.ع',
            graphicType: 'martyr_monument'),
        DenominationOption(
            usdValue: 8,
            iqdPrice: 10000,
            code: 'Asiacell_10000IQD',
            title: '10,000 د.ع'),
        DenominationOption(
            usdValue: 4,
            iqdPrice: 5000,
            code: 'Asiacell_5000IQD',
            title: '5,000 د.ع'),
      ],
    ),
  ];

  // الأقسام للتوافق
  List<AppSection> get sections => [
        AppSection(
          id: 'playstation',
          name: 'بلايستيشن',
          englishName: 'PlayStation',
          icon: Icons.sports_esports_rounded,
          primaryColor: AppColors.playstationBlue,
          accentColor: const Color(0xFF0072CE),
          badgeText: '4 فئات شحن',
          description: 'بطاقات ستور واشتراكات للحسابات الأمريكية',
          cards: allCards.where((c) => c.category == 'بلايستيشن').toList(),
        ),
        AppSection(
          id: 'xbox',
          name: 'إكس بوكس',
          englishName: 'Xbox',
          icon: Icons.videogame_asset_rounded,
          primaryColor: AppColors.xboxGreen,
          accentColor: const Color(0xFF0D5E0D),
          badgeText: 'ألعاب وGame Pass',
          description: 'رصيد حساب مايكروسوفت واشتراكات التمت',
          cards: allCards.where((c) => c.category == 'إكس بوكس').toList(),
        ),
        AppSection(
          id: 'local',
          name: 'رصيد محلي (العراق)',
          englishName: 'Iraq Telecom',
          icon: Icons.phone_android_rounded,
          primaryColor: AppColors.asiacellRed,
          accentColor: AppColors.zainSilver,
          badgeText: 'زين • آسيا • كورك',
          description: 'كروت تعبئة رصيد الخطوط العراقية فورياً',
          cards: allCards.where((c) => c.category == 'رصيد محلي').toList(),
        ),
      ];

  // قائمة المتاجر والعلامات التجارية المطابقة للصورة 2
  List<BrandStoreItem> get brandStores => [
        const BrandStoreItem(
          id: 'zain',
          name: 'زين العراق',
          englishName: 'Zain',
          category: 'اتصالات عراقية',
          themeColor: Color(0xFF5A1E52),
          bannerType: 'zain',
          imageAsset: 'assets/logos/zain.png',
          denominations: [
            DenominationOption(
              usdValue: 5,
              iqdPrice: 5000,
              code: 'Zain_5000IQD',
              title: 'كارت شحن 5,000 د.ع',
              imageAsset: 'assets/cards/zain_5000.png',
            ),
            DenominationOption(
              usdValue: 10,
              iqdPrice: 10000,
              code: 'Zain_10000IQD',
              title: 'كارت شحن 10,000 د.ع',
              imageAsset: 'assets/cards/zain_10000.png',
            ),
            DenominationOption(
              usdValue: 25,
              iqdPrice: 25000,
              code: 'Zain_25000IQD',
              title: 'كارت شحن 25,000 د.ع',
              imageAsset: 'assets/cards/zain_25000.png',
            ),
            DenominationOption(
              usdValue: 50,
              iqdPrice: 50000,
              code: 'Zain_50000IQD',
              title: 'كارت شحن 50,000 د.ع',
              imageAsset: 'assets/cards/zain_50000.png',
            ),
            DenominationOption(
              usdValue: 100,
              iqdPrice: 100000,
              code: 'Zain_100000IQD',
              title: 'كارت شحن 100,000 د.ع',
              imageAsset: 'assets/cards/zain_100000.png',
            ),
          ],
        ),
        const BrandStoreItem(
          id: 'asiacell',
          name: 'آسياسيل',
          englishName: 'Asiacell',
          category: 'اتصالات عراقية',
          themeColor: Color(0xFFD61F26),
          bannerType: 'asiacell',
          imageAsset: 'assets/logos/asiacell.png',
          denominations: [
            DenominationOption(
              usdValue: 50,
              iqdPrice: 70000,
              code: 'Asiacell_70000IQD',
              title: 'تعبئة رصيد اتصال 70,000 د.ع',
              graphicType: 'red_network',
              imageAsset: 'assets/cards/asiacell_70000.png',
            ),
            DenominationOption(
              usdValue: 10,
              iqdPrice: 12000,
              code: 'Asiacell_Max_12000',
              title: 'MAX CARD 12,000 د.ع 5GB',
              graphicType: 'max_card',
              imageAsset: 'assets/cards/asiacell_12000.png',
            ),
            DenominationOption(
              usdValue: 40,
              iqdPrice: 50000,
              code: 'Asiacell_50000IQD',
              title: '50,000 دينار نصب الشهيد',
              graphicType: 'martyr_monument',
              imageAsset: 'assets/cards/asiacell_50000.png',
            ),
            DenominationOption(
              usdValue: 20,
              iqdPrice: 25000,
              code: 'Asiacell_25000IQD',
              title: 'تعبئة رصيد 25,000 د.ع',
              graphicType: 'red_network',
              imageAsset: 'assets/cards/asiacell_25000.png',
            ),
            DenominationOption(
              usdValue: 8,
              iqdPrice: 10000,
              code: 'Asiacell_10000IQD',
              title: 'تعبئة رصيد 10,000 د.ع',
              graphicType: 'red_network',
              imageAsset: 'assets/cards/asiacell_10000.png',
            ),
            DenominationOption(
              usdValue: 4,
              iqdPrice: 5000,
              code: 'Asiacell_5000IQD',
              title: 'تعبئة رصيد 5,000 د.ع',
              graphicType: 'red_network',
              imageAsset: 'assets/cards/asiacell_5000.png',
            ),
          ],
        ),
        const BrandStoreItem(
          id: 'iraqcell',
          name: 'عراق سيل',
          englishName: 'IraqCell',
          category: 'اتصالات عراقية',
          themeColor: Color(0xFF1E3A8A),
          bannerType: 'iraqcell',
          imageAsset: 'assets/logos/iraqcell.png',
          denominations: [
            DenominationOption(
              usdValue: 5,
              iqdPrice: 5000,
              code: 'IraqCell_5000IQD',
              title: 'رصيد عراق سيل 5,000 د.ع',
              imageAsset: 'assets/cards/iraqcell_5000.png',
            ),
            DenominationOption(
              usdValue: 10,
              iqdPrice: 10000,
              code: 'IraqCell_10000IQD',
              title: 'رصيد عراق سيل 10,000 د.ع',
              imageAsset: 'assets/cards/iraqcell_10000.png',
            ),
            DenominationOption(
              usdValue: 25,
              iqdPrice: 25000,
              code: 'IraqCell_25000IQD',
              title: 'رصيد عراق سيل 25,000 د.ع',
              imageAsset: 'assets/cards/iraqcell_25000.png',
            ),
          ],
        ),
        const BrandStoreItem(
          id: 'korek',
          name: 'كورك تيليكوم',
          englishName: 'KOREK',
          category: 'اتصالات عراقية',
          themeColor: Color(0xFF0070BA),
          bannerType: 'korek',
          imageAsset: 'assets/logos/korek.png',
          denominations: [
            DenominationOption(
              usdValue: 5,
              iqdPrice: 5000,
              code: 'Korek_5000IQD',
              title: 'كارت شحن كورك 5,000 د.ع',
              imageAsset: 'assets/cards/korek_5000.png',
            ),
            DenominationOption(
              usdValue: 10,
              iqdPrice: 10000,
              code: 'Korek_10000IQD',
              title: 'كارت شحن كورك 10,000 د.ع',
              imageAsset: 'assets/cards/korek_10000.png',
            ),
            DenominationOption(
              usdValue: 25,
              iqdPrice: 25000,
              code: 'Korek_25000IQD',
              title: 'كارت شحن كورك 25,000 د.ع',
              imageAsset: 'assets/cards/korek_25000.png',
            ),
            DenominationOption(
              usdValue: 50,
              iqdPrice: 50000,
              code: 'Korek_50000IQD',
              title: 'كارت شحن كورك 50,000 د.ع',
              imageAsset: 'assets/cards/korek_50000.png',
            ),
          ],
        ),
        const BrandStoreItem(
          id: 'pubg',
          name: 'ببجي موبايل',
          englishName: 'Pubg',
          category: 'ألعاب وشحن',
          themeColor: Color(0xFF1E1B4B),
          bannerType: 'pubg',
          imageAsset: 'assets/logos/pubg.png',
          denominations: [
            DenominationOption(
              usdValue: 1,
              iqdPrice: 1500,
              code: 'Pubg_60_UC',
              title: 'شدات ببجي 60 UC',
              imageAsset: 'assets/cards/pubg_60.png',
            ),
            DenominationOption(
              usdValue: 5,
              iqdPrice: 7000,
              code: 'Pubg_325_UC',
              title: 'شدات ببجي 325 UC',
              imageAsset: 'assets/cards/pubg_325.png',
            ),
            DenominationOption(
              usdValue: 10,
              iqdPrice: 14000,
              code: 'Pubg_660_UC',
              title: 'شدات ببجي 660 UC (رويال باس)',
              imageAsset: 'assets/cards/pubg_660.png',
            ),
            DenominationOption(
              usdValue: 25,
              iqdPrice: 35000,
              code: 'Pubg_1800_UC',
              title: 'شدات ببجي 1800 UC',
              imageAsset: 'assets/cards/pubg_1800.png',
            ),
            DenominationOption(
              usdValue: 50,
              iqdPrice: 70000,
              code: 'Pubg_3850_UC',
              title: 'شدات ببجي 3850 UC',
              imageAsset: 'assets/cards/pubg_3850.png',
            ),
            DenominationOption(
              usdValue: 100,
              iqdPrice: 140000,
              code: 'Pubg_8100_UC',
              title: 'شدات ببجي 8100 UC',
              imageAsset: 'assets/cards/pubg_8100.png',
            ),
          ],
        ),
        const BrandStoreItem(
          id: 'alkafeel',
          name: 'الكفيل أمنية',
          englishName: 'AlkafeelOmnnea',
          category: 'اتصالات عراقية',
          themeColor: Color(0xFFDC2626),
          bannerType: 'alkafeel',
          denominations: [
            DenominationOption(
                usdValue: 5,
                iqdPrice: 5000,
                code: 'Alkafeel_5000IQD',
                title: 'كارت الكفيل 5,000 د.ع'),
            DenominationOption(
                usdValue: 10,
                iqdPrice: 10000,
                code: 'Alkafeel_10000IQD',
                title: 'كارت الكفيل 10,000 د.ع'),
          ],
        ),
        const BrandStoreItem(
          id: 'xbox',
          name: 'إكس بوكس',
          englishName: 'Xbox',
          category: 'ألعاب وشحن',
          themeColor: Color(0xFF107C10),
          bannerType: 'xbox',
          denominations: [
            DenominationOption(
                usdValue: 10,
                iqdPrice: 15000,
                code: 'Xbox_10_USD',
                title: 'بطاقة إكس بوكس 10\$'),
            DenominationOption(
                usdValue: 15,
                iqdPrice: 22500,
                code: 'Xbox_15_USD',
                title: 'بطاقة إكس بوكس 15\$'),
            DenominationOption(
                usdValue: 25,
                iqdPrice: 37500,
                code: 'Xbox_25_USD',
                title: 'بطاقة إكس بوكس 25\$'),
            DenominationOption(
                usdValue: 50,
                iqdPrice: 75000,
                code: 'Xbox_50_USD',
                title: 'بطاقة إكس بوكس 50\$'),
          ],
        ),
        const BrandStoreItem(
          id: 'razer',
          name: 'رايزر جولد',
          englishName: 'Razer Global',
          category: 'ألعاب وشحن',
          themeColor: Color(0xFF0A0A0A),
          bannerType: 'razer',
          denominations: [
            DenominationOption(
                usdValue: 5,
                iqdPrice: 7500,
                code: 'Razer_5_USD',
                title: 'رايزر جولد 5\$ عالمي'),
            DenominationOption(
                usdValue: 10,
                iqdPrice: 15000,
                code: 'Razer_10_USD',
                title: 'رايزر جولد 10\$ عالمي'),
            DenominationOption(
                usdValue: 20,
                iqdPrice: 30000,
                code: 'Razer_20_USD',
                title: 'رايزر جولد 20\$ عالمي'),
            DenominationOption(
                usdValue: 50,
                iqdPrice: 75000,
                code: 'Razer_50_USD',
                title: 'رايزر جولد 50\$ عالمي'),
          ],
        ),
        const BrandStoreItem(
          id: 'playstation',
          name: 'بلايستيشن ستور',
          englishName: 'PlayStation',
          category: 'ألعاب وشحن',
          themeColor: Color(0xFF003791),
          bannerType: 'playstation',
          denominations: [
            DenominationOption(
                usdValue: 10,
                iqdPrice: 15000,
                code: 'PlayStation_10USD',
                title: 'بلايستيشن 10\$ أمريكي'),
            DenominationOption(
                usdValue: 25,
                iqdPrice: 37500,
                code: 'PlayStation_25USD',
                title: 'بلايستيشن 25\$ أمريكي'),
            DenominationOption(
                usdValue: 50,
                iqdPrice: 75000,
                code: 'PlayStation_50USD',
                title: 'بلايستيشن 50\$ أمريكي'),
            DenominationOption(
                usdValue: 100,
                iqdPrice: 150000,
                code: 'PlayStation_100USD',
                title: 'بلايستيشن 100\$ أمريكي'),
          ],
        ),
        const BrandStoreItem(
          id: 'steam',
          name: 'ستيم والت',
          englishName: 'Steam',
          category: 'ألعاب وشحن',
          themeColor: Color(0xFF171A21),
          bannerType: 'steam',
          denominations: [
            DenominationOption(
                usdValue: 10,
                iqdPrice: 15000,
                code: 'Steam_10USD',
                title: 'ستيم 10\$ عالمي'),
            DenominationOption(
                usdValue: 20,
                iqdPrice: 30000,
                code: 'Steam_20USD',
                title: 'ستيم 20\$ عالمي'),
            DenominationOption(
                usdValue: 50,
                iqdPrice: 75000,
                code: 'Steam_50USD',
                title: 'ستيم 50\$ عالمي'),
          ],
        ),
        const BrandStoreItem(
          id: 'apple',
          name: 'آبل آيتونز',
          englishName: 'Apple iTunes',
          category: 'متاجر وبطاقات',
          themeColor: Color(0xFF1E293B),
          bannerType: 'apple',
          denominations: [
            DenominationOption(
                usdValue: 10,
                iqdPrice: 15000,
                code: 'Apple_10USD',
                title: 'آبل ستور 10\$ أمريكي'),
            DenominationOption(
                usdValue: 15,
                iqdPrice: 22500,
                code: 'Apple_15USD',
                title: 'آبل ستور 15\$ أمريكي'),
            DenominationOption(
                usdValue: 25,
                iqdPrice: 37500,
                code: 'Apple_25USD',
                title: 'آبل ستور 25\$ أمريكي'),
          ],
        ),
      ];

  List<GiftCardItem> get filteredCards {
    return allCards.where((card) {
      final matchesCategory =
          selectedCategory == 'الكل' || card.category == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          card.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          card.titleEn.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<BrandStoreItem> get filteredBrands {
    return brandStores.where((brand) {
      final matchesCategory =
          selectedCategory == 'الكل' || brand.category == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          brand.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          brand.englishName.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSelectedCategory(String category) => setCategory(category);

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void rechargeWallet(int amount) {
    walletBalance += amount;
    notifyListeners();
  }

  void addFunds(int amount) => rechargeWallet(amount);

  bool canAfford(int amount) => walletBalance >= amount;

  OrderItem? executePurchase({
    required GiftCardItem card,
    required DenominationOption denomination,
  }) {
    final price = denomination.iqdPrice;
    if (!canAfford(price)) return null;

    walletBalance -= price;

    final randomId = Random().nextInt(90000) + 10000;
    final code = 'NABD-${_randomChunk()}-${_randomChunk()}';

    final order = OrderItem(
      id: 'NABD-$randomId',
      cardTitle: card.title,
      cardSubtitle: denomination.displayCode,
      usdValue: denomination.usdValue,
      paidAmountIQD: price,
      code: code,
      timestamp: DateTime.now(),
      brandColor: card.primaryColor,
      category: card.category,
    );

    _orders.insert(0, order);
    notifyListeners();
    return order;
  }

  String _randomChunk() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random();
    return String.fromCharCodes(
      Iterable.generate(4, (_) => chars.codeUnitAt(rand.nextInt(chars.length))),
    );
  }

  static String formatIQD(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }
    return '${buffer.toString().split('').reversed.join()} د.ع';
  }
}
