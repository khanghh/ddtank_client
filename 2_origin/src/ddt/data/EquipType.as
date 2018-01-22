package ddt.data
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import enchant.EnchantManager;
   
   public class EquipType
   {
      
      public static const T_SBUGLE:int = 11101;
      
      public static const T_BBUGLE:int = 11102;
      
      public static const T_CBUGLE:int = 11100;
      
      public static const T_ALL_PROP:int = 10200;
      
      public static const COLORCARD:int = 11999;
      
      public static const REWORK_NAME:int = 11994;
      
      public static const WISHBEAD_ATTACK:int = 11560;
      
      public static const WISHBEAD_DEFENSE:int = 11561;
      
      public static const WISHBEAD_AGILE:int = 11562;
      
      public static const CONSORTIA_REWORK_NAME:int = 11993;
      
      public static const BATTLE_TEAM_RENAME_CARD:int = 12604;
      
      public static const CHANGE_SEX:int = 11569;
      
      public static const VIPCARD:int = 11992;
      
      public static const VIPCARD_TEST:int = 11991;
      
      public static const BRAVERY:int = 201531;
      
      public static const SPE_BOSS:int = 12578;
      
      public static const VIP_SEND_TICKET:int = 12568;
      
      public static const VIP_USE_TICKET:int = 12569;
      
      public static const TRANSFER_PROP:int = 34101;
      
      public static const CHANGE_COLOR_SHELL:int = 11999;
      
      public static const RESTRO_CARD:int = 12511;
      
      public static const MEDAL:int = -300;
      
      public static const GIFT:int = -300;
      
      public static const EXP:int = 11107;
      
      public static const GOLD_BOX:int = 11233;
      
      public static const EXALT_ROCK:int = 11150;
      
      public static const ROULETTE_BOX:int = 112019;
      
      public static const VIP_COIN:int = 112109;
      
      public static const ROULETTE_KEY:int = 11444;
      
      public static const BOMB_KING_BLESS:int = 112222;
      
      public static const SILVER_BLESS:int = 112223;
      
      public static const GOLD_BLESS:int = 112224;
      
      public static const SILVER_TOY:int = 1222010;
      
      public static const GOLD_TOY:int = 1222110;
      
      public static const FOOTBALL_NORMAL_TICKET_ID:int = 201279;
      
      public static const FOOTBALL_HARD_TICKET_ID:int = 201280;
      
      public static const FOOTBALL_HERO_TICKET_ID:int = 201281;
      
      public static const Silver_Caddy:int = 112100;
      
      public static const Qiang_SHI:int = 11025;
      
      public static const Gold_Caddy:int = 112101;
      
      public static const TREASURE_CADDY:int = 2000;
      
      public static const CADDY:int = 112047;
      
      public static const GOLD_CADDY:int = 112101;
      
      public static const SILVER_CADDY:int = 112100;
      
      public static const CADDY_KEY:int = 11456;
      
      public static const CADDY_BAGI:int = 112054;
      
      public static const CADDY_BAGII:int = 112055;
      
      public static const CADDY_BAGIII:int = 112056;
      
      public static const BEAD_ATTRIBUTE:int = 313500;
      
      public static const BEAD_ATTACK:int = 311500;
      
      public static const BEAD_DEFENSE:int = 312500;
      
      public static const MYSTICAL_CARDBOX:int = 112150;
      
      public static const MY_CARDBOX:int = 112108;
      
      public static const SILVER_CARDBOX:int = 1120538;
      
      public static const GOLD_CARDBOX:int = 1120539;
      
      public static const MANUAL_CARDBOX:int = 1120640;
      
      public static const CARDSOUL_BOX:int = 20150;
      
      public static const OFFER_PACK_I:int = 11252;
      
      public static const OFFER_PACK_II:int = 11257;
      
      public static const OFFER_PACK_III:int = 11258;
      
      public static const OFFER_PACK_IV:int = 11259;
      
      public static const OFFER_PACK_V:int = 11260;
      
      public static const EXP_PILL_I:int = 11901;
      
      public static const EXP_PILL_II:int = 11902;
      
      public static const EXP_PILL_III:int = 11903;
      
      public static const EXP_PILL_IV:int = 11904;
      
      public static const EXP_PILL_V:int = 11905;
      
      public static const CITY_BATTLE_I:int = 400014;
      
      public static const CITY_BATTLE_II:int = 400015;
      
      public static const CITY_BATTLE_III:int = 400016;
      
      public static const CITY_BATTLE_IV:int = 400017;
      
      public static const CITY_BATTLE_V:int = 400018;
      
      public static const CITY_BATTLE_VI:int = 400019;
      
      public static const CITY_BATTLE_VII:int = 400020;
      
      public static const ADDLOTTERY_COUNT:int = 12535;
      
      public static const DOUBLE_CARD_RENOWN:int = 11955;
      
      public static const DOUBLE_CARD_CONTRIBUTE:int = 11956;
      
      public static const Caddy_Good:int = 11907;
      
      public static const Save_Life:int = 11908;
      
      public static const Agility_Get:int = 11909;
      
      public static const ReHealth:int = 11910;
      
      public static const Train_Good:int = 11911;
      
      public static const Level_Try:int = 11912;
      
      public static const Card_Get:int = 11913;
      
      public static const NATION_WORD:int = 11961;
      
      public static const DDTKING_WORD:int = 11965;
      
      public static const NATIONAL_WORD_2015:int = 11967;
      
      public static const FREE_PROP_CARD:int = 11995;
      
      public static const DOUBLE_EXP_CARD:int = 11998;
      
      public static const DOUBLE_GESTE_CARD:int = 11997;
      
      public static const PREVENT_KICK:int = 11996;
      
      public static const CHANGE_NAME_CARD:int = 11994;
      
      public static const CONSORTIA_CHANGE_NAME_CARD:int = 11993;
      
      public static const Pay_Buff:int = -1;
      
      public static const STRENGTH_GIFT_BAG:int = 112051100;
      
      public static const VIP_GIFT_BAG:int = 112164;
      
      public static const SYMBLE:int = 11020;
      
      public static const LUCKY:int = 11018;
      
      public static const STRENGTH_STONE4:int = 11023;
      
      public static const STRENGTH_STONE_NEW:int = 11025;
      
      public static const WEDDING_RING:int = 9022;
      
      public static const PIAN_OPENHOLE_STONE:int = 11034;
      
      public static const SKY_OPENHOLE_STONE:int = 11036;
      
      public static const GND_OPENHOLE_STONE:int = 11035;
      
      public static const BADLUCK_STONE:int = 11550;
      
      public static const TEXP_LV_I:int = 40001;
      
      public static const TEXP_LV_II:int = 40002;
      
      public static const TEXP_LV_III:int = 40003;
      
      public static const MAGIC_TEXP_LV_I:int = 40005;
      
      public static const MAGIC_TEXP_LV_II:int = 40006;
      
      public static const DEFAULT_WEAPON:int = 70016;
      
      public static const HEAD:uint = 1;
      
      public static const GLASS:uint = 2;
      
      public static const HAIR:uint = 3;
      
      public static const EFF:uint = 4;
      
      public static const CLOTH:uint = 5;
      
      public static const FACE:uint = 6;
      
      public static const ARM:uint = 7;
      
      public static const ARMLET:uint = 8;
      
      public static const RING:uint = 9;
      
      public static const FRIGHTPROP:uint = 10;
      
      public static const UNFRIGHTPROP:uint = 11;
      
      public static const TASK:uint = 12;
      
      public static const SUITS:uint = 13;
      
      public static const NECKLACE:uint = 14;
      
      public static const WING:uint = 15;
      
      public static const CHATBALL:uint = 16;
      
      public static const OFFHAND:int = 17;
      
      public static const SPECIAL:int = 31;
      
      public static const CARDBOX:int = 18;
      
      public static const SPECIALCARDBOX:int = 66;
      
      public static const HEALSTONE:int = 19;
      
      public static const TEXP:int = 20;
      
      public static const TEXP_TASK:int = 23;
      
      public static const TITLE_CARD:int = 24;
      
      public static const ACTIVE_TASK:int = 30;
      
      public static const TEMPWEAPON:int = 27;
      
      public static const TEMPARMLET:uint = 28;
      
      public static const TEMPRING:uint = 29;
      
      public static const TEMP_OFFHAND:uint = 31;
      
      public static const GIFTGOODS:int = 25;
      
      public static const CARDEQUIP:int = 26;
      
      public static const CATHARINE:int = 21;
      
      public static const EFFECT:int = 30;
      
      public static const SEED:int = 32;
      
      public static const MANURE:int = 33;
      
      public static const FOOD:int = 34;
      
      public static const PET_EGG:int = 35;
      
      public static const VEGETABLE:int = 36;
      
      public static const HOME_ADORN:int = 37;
      
      public static const BADGE:int = 40;
      
      public static const PET_EQUIP_CLOTH:int = 52;
      
      public static const PET_EQUIP_HEAD:int = 51;
      
      public static const PET_EQUIP_ARM:int = 50;
      
      public static const MAGIC_STONE:int = 61;
      
      public static const CALL_CARD:int = 62;
      
      public static const GRADE_BUY:int = 63;
      
      public static const ARM_SHELL:int = 64;
      
      public static const GETFRIENDPACK:int = 65;
      
      public static const GIVING:int = 100;
      
      public static const MAGIC_TEXP:int = 53;
      
      public static const HORSE_AMULET_BOX:int = 68;
      
      public static const HORSE_AMULET:int = 69;
      
      public static const EQUIP_AMULET:int = 70;
      
      public static const EXPLORER_MANUAL:int = 72;
      
      public static const EXPLORER_PAGE_MANUAL:int = 71;
      
      public static const MARK_CHIP:int = 74;
      
      public static const SUPER_PET_EXP_FOOD:int = 334102;
      
      public static const EASY_TICKET_ID:int = 200619;
      
      public static const NORMAL_TICKET_ID:int = 200620;
      
      public static const HARD_TICKET_ID:int = 200621;
      
      public static const HERO_TICKET_ID:int = 200622;
      
      public static const EPIC_TICKET_ID:int = 201105;
      
      public static const TYPES:Array = ["","head","glass","hair","eff","cloth","face","arm","armlet","ring","","","","suits","necklace","wing","chatBall","","","","","","","","","","","","armlet","ring"];
      
      public static const PARTNAME:Array = ["",LanguageMgr.GetTranslation("tank.data.EquipType.head"),LanguageMgr.GetTranslation("tank.data.EquipType.glass"),LanguageMgr.GetTranslation("tank.data.EquipType.hair"),LanguageMgr.GetTranslation("tank.data.EquipType.face"),LanguageMgr.GetTranslation("tank.data.EquipType.clothing"),LanguageMgr.GetTranslation("tank.data.EquipType.eye"),LanguageMgr.GetTranslation("tank.data.EquipType.weapon"),LanguageMgr.GetTranslation("tank.data.EquipType.bangle"),LanguageMgr.GetTranslation("tank.data.EquipType.finger"),LanguageMgr.GetTranslation("tank.data.EquipType.tool"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),"",LanguageMgr.GetTranslation("tank.data.EquipType.suit"),LanguageMgr.GetTranslation("tank.data.EquipType.necklace"),LanguageMgr.GetTranslation("tank.data.EquipType.decorate"),LanguageMgr.GetTranslation("tank.data.EquipType.paopao"),LanguageMgr.GetTranslation("tank.data.EquipType.offhand"),"",LanguageMgr.GetTranslation("tank.manager.ItemManager.aid"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.manager.ItemManager.cigaretteAsh"),"",LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.manager.ItemManager.gift"),"",LanguageMgr.GetTranslation("tank.data.EquipType.tempweapon"),LanguageMgr.GetTranslation("tank.data.EquipType.TEMPARMLET"),LanguageMgr.GetTranslation("tank.data.EquipType.tempTEMPRING"),LanguageMgr.GetTranslation("tank.data.EquipType.prop"),LanguageMgr.GetTranslation("tank.data.EquipType.offhand"),LanguageMgr.GetTranslation("tank.data.EquipType.seed"),LanguageMgr.GetTranslation("tank.data.EquipType.manure"),LanguageMgr.GetTranslation("tank.data.EquipType.food"),LanguageMgr.GetTranslation("tank.data.EquipType.petEgg"),LanguageMgr.GetTranslation("tank.data.EquipType.vegetable"),LanguageMgr.GetTranslation("tank.data.EquipType.homeAdorn"),"","",LanguageMgr.GetTranslation("tank.data.EquipType.leagueBadge"),"",LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),"","","","","","",LanguageMgr.GetTranslation("tank.data.EquipType.petTool"),LanguageMgr.GetTranslation("tank.data.EquipType.petHead"),LanguageMgr.GetTranslation("tank.data.EquipType.petClothing"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),"","","","","","","",LanguageMgr.GetTranslation("tank.data.EquipType.magicStone"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.data.gradeBuy.box"),LanguageMgr.GetTranslation("tank.data.EquipType.armShell"),LanguageMgr.GetTranslation("tank.data.EquipType.normal"),LanguageMgr.GetTranslation("tank.data.EquipType.specialCardBox"),"",LanguageMgr.GetTranslation("tank.data.EquipType.amuletBox"),LanguageMgr.GetTranslation("tank.data.EquipType.amulet"),LanguageMgr.GetTranslation("tank.data.EquipType.equipAmulet"),"",LanguageMgr.GetTranslation("tank.data.EquipType.manualBox"),LanguageMgr.GetTranslation("tank.room.borden"),"","","","","","","",LanguageMgr.GetTranslation("tank.data.EquipType.mines")];
      
      private static const dressAbleIDs:Array = [1,2,3,4,5,6,13,15];
      
      private static const DrillCategoryID:int = 11;
      
      private static const DrillCategotyProperty:String = "16";
      
      public static const HoleMaxExp:int = 100;
      
      public static const HoleMaxLevel:int = 4;
      
      public static const CUCAO:int = -200;
      
      public static const PUTONG:int = -200;
      
      public static const YOUXIU:int = -200;
      
      public static const JINGLIANG:int = -200;
      
      private static const AttributeBeadLv1:int = 313199;
      
      private static const AttributeBeadLv2:int = 313299;
      
      private static const AttributeBeadLv3:int = 313399;
      
      private static const AttributeBeadLv4:int = 313499;
      
      private static const AttackBeadLv1:int = 311199;
      
      private static const AttackBeadLv2:int = 311299;
      
      private static const AttackBeadLv3:int = 311399;
      
      private static const AttackBeadLv4:int = 311499;
      
      private static const DefenceBeadLv1:int = 312199;
      
      private static const DefenceBeadLv2:int = 312299;
      
      private static const DefenceBeadLv3:int = 312399;
      
      private static const DefenceBeadLv4:int = 312499;
      
      public static const LaserBomdID:int = 11196;
      
      public static const FLY_CD:int = 2;
      
      public static const FLY_ENERGY:int = 150;
      
      public static const ADD_TWO_ATTACK:int = 10001;
      
      public static const ADD_ONE_ATTACK:int = 10002;
      
      public static const THREEKILL:int = 10003;
      
      public static const FLY:int = 10006;
      
      public static const Angle:int = 17001;
      
      public static const TrueAngle:int = 17002;
      
      public static const TrueAngleI:int = 17101;
      
      public static const ExllenceAngle:int = 17005;
      
      public static const ExllenceAngleI:int = 17007;
      
      public static const ExllenceAngleII:int = 17100;
      
      public static const FlyAngle:int = 17000;
      
      public static const FlyAngleI:int = 17010;
      
      public static const MagicBook:int = 17006;
      
      public static const GoldenFootball:int = 17011;
      
      public static const LightShield:int = 17012;
      
      public static const TrueShield:int = 17003;
      
      public static const ExcellentShield:int = 17004;
      
      public static const CaptainShield:int = 17012;
      
      public static const AresShield:int = 17013;
      
      public static const WishKingBlessing:int = 17200;
      
      public static const CardMaxLv:int = 30;
      
      public static const GuildBomb:int = 10017;
      
      public static const Hiding:int = 10010;
      
      public static const HidingGroup:int = 10011;
      
      public static const HealthGroup:int = 10009;
      
      public static const Health:int = 10012;
      
      public static const Freeze:int = 10015;
      
      public static const LABYINTH_DOBLE_AWARD:int = 11916;
      
      public static const LABYINTH_DOBLE_AWARD_GOODS_ID:int = 1191601;
      
      public static const LABYINTH_DOBLE_AWARD2:int = 11178;
      
      public static const LABYINTH_DOBLE_AWARD_GOODS_ID2:int = 1117801;
      
      public static const DOUBLE_PRESTIGE:int = 11955;
      
      public static const CELEBRATION_BOX:int = 112255;
      
      public static const CELEBRATION_KEY:int = 11658;
      
      public static const BATTLE_COMPANION:int = 112262;
      
      public static const MIDAUTUMN_PACKS:int = 112323;
      
      public static const NECKLACE_PTETROCHEM_STONE:int = 11160;
      
      public static const GEMSTONE:int = 100100;
      
      public static const CHRISTMAS_TIMER:int = 201145;
      
      public static const HORSE_UP_ITEM:int = 11164;
      
      public static const HORSE_SKILL_UP_ITEM:int = 11165;
      
      public static const ENERGY_SOLUTION:int = 11918;
      
      public static const DOUBLE_CONTRIBUTE:int = 11956;
      
      public static const RANDOM_SUIT:int = 11966;
      
      public static const MAGPIE_MOBILITY:int = 11959;
      
      public static const INSECT_CAKE:int = 11958;
      
      public static const INSECT_WHISTLE:int = 11968;
      
      public static const PRIMARY_IMMOLATION:int = 11176;
      
      public static const HIGH_IMMOLATION:int = 11177;
      
      public static const FREE_LOTTERY_TICKET:int = 12535;
      
      public static const ENGERY_POTION:int = 1120435;
      
      public static const LOVE_CHOCOLATE:int = 12536;
      
      public static const FEELINGLY:int = 12537;
      
      public static const GUARD_CORE:int = 12540;
      
      public static const MEMORY_GAME_CARD:int = 1120433;
      
      public static const SANXIAO_CARD:int = 1120434;
      
      public static const LUCKYSTAR_ID:int = 201192;
      
      public static const DDPLAY_COIN:int = 201310;
      
      public static const EVERYDAYGIFTRECORD:int = 222222222;
      
      public static const MAGICHOUSE_MAGICPOTION:int = 201489;
      
      public static const FUZHUDAOJU:int = 80;
      
      public static const DEED_ITEM:int = 201368;
      
      public static const SURPRISE_ROULETTE_BOX:int = 190000;
      
      public static const ZODIACCARD:int = 201582;
      
      public static const VIPCARD_TEST3:int = 11914;
      
      public static const DDQY_GOU_YU_ID:int = 12543;
      
      public static const DDQY_BOX_KEY_ID:int = 12544;
      
      public static const DDQY_GOU_YU_BOX_ID:int = 1120462;
      
      public static const DDQY_DIAN_QUAN_BOX_ID:int = 1120463;
      
      public static const DDQY_BOX_ID:int = 1120464;
      
      public static const REST_TEXP:int = 12545;
      
      public static const SNOWBALL_ID:int = 201144;
      
      public static const MAGICHOUSE_ID:int = 29995;
      
      public static const CONSORTIA_BADGE:int = 12567;
      
      public static const WISH_STONE:int = 101010;
      
      public static const SPIRIT_WILL_STONE:int = 101011;
      
      public static const EVOLVE_STONE:int = 12572;
      
      public static const EQUIP_GHOST_LUCKY:int = 11185;
      
      public static const EQUIP_GHOST_STONE:int = 11186;
      
      public static const GOD_UNIVERSAL_CARD:int = 13;
      
      public static const ROOMBORDENBOX:int = 43;
      
      public static const ROOMBORDENTYPE:int = 73;
       
      
      public function EquipType()
      {
         super();
      }
      
      public static function getPropNameByType(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return "composestone";
            case 1:
               return "StrengthStoneCell";
            case 2:
               return "symbol";
            case 3:
               return "sbugle";
            case 4:
               return "bbugle";
            case 5:
               return "packages";
            case 6:
               return "symbol";
            case 7:
               return "other";
         }
      }
      
      public static function dressAble(param1:ItemTemplateInfo) : Boolean
      {
         if(dressAbleIDs.indexOf(param1.CategoryID) != -1)
         {
            return true;
         }
         return false;
      }
      
      public static function isRongLing(param1:ItemTemplateInfo) : Boolean
      {
         return param1.FusionType != 0 && param1.FusionRate > 0;
      }
      
      public static function isJewelryOrRing(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 8 || param1.CategoryID == 9;
      }
      
      public static function isCards(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 26;
      }
      
      public static function isWeddingRing(param1:ItemTemplateInfo) : Boolean
      {
         var _loc2_:* = param1.TemplateID;
         if(9022 !== _loc2_)
         {
            if(9122 !== _loc2_)
            {
               if(9222 !== _loc2_)
               {
                  if(9322 !== _loc2_)
                  {
                     if(9422 !== _loc2_)
                     {
                        if(9522 !== _loc2_)
                        {
                           return false;
                        }
                     }
                     addr11:
                     return true;
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      public static function isEditable(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID <= 6 && param1.CategoryID >= 1)
         {
            if(param1.Property6 == "0")
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isPropertyWater(param1:ItemTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.CategoryID == 11 && (int(param1.Property1) >= 74 && int(param1.Property1) <= 80) || param1.TemplateID >= 1120098 && param1.TemplateID <= 1120101)
         {
            return true;
         }
         return false;
      }
      
      public static function canBeUsed(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID == 11 && param1.Property1 == "5" && param1.Property2 != "0")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "21")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "100")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "115")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "37")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "24")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "26")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "39")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "101")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "45")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "47")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "82")
         {
            return true;
         }
         if(param1.CategoryID == 11 && (param1.Property1 == "27" || param1.Property1 == "29"))
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "110")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "1100")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "112")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "113")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "25")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "104")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "106")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "107")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "108")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "130")
         {
            return true;
         }
         if(param1.CategoryID == 65 && int(param1.Property8) > 0)
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "116")
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "121")
         {
            return true;
         }
         if(param1.CategoryID == 62 && (param1.Property1 == "1" || param1.Property1 == "0"))
         {
            return true;
         }
         if((param1.CategoryID == 20 || param1.CategoryID == 53) && param1.Property1 == "0")
         {
            return true;
         }
         if(isPropertyWater(param1))
         {
            return true;
         }
         if(isStrengthStone(param1))
         {
            return true;
         }
         if(isComposeStone(param1))
         {
            return true;
         }
         if(param1.CategoryID == 18)
         {
            return true;
         }
         if(param1.CategoryID == 23)
         {
            return true;
         }
         if(param1.CategoryID == 24)
         {
            return true;
         }
         if(param1.CategoryID == 35)
         {
            return true;
         }
         if(param1.CategoryID == 11569)
         {
            return true;
         }
         if(param1.CategoryID == 37)
         {
            return true;
         }
         if(param1.CategoryID == 66)
         {
            return true;
         }
         if(param1.CategoryID == 73)
         {
            return true;
         }
         var _loc2_:* = param1.TemplateID;
         if(34101 !== _loc2_)
         {
            if(11999 !== _loc2_)
            {
               if(11995 !== _loc2_)
               {
                  if(11998 !== _loc2_)
                  {
                     if(11997 !== _loc2_)
                     {
                        if(11996 !== _loc2_)
                        {
                           if(11907 !== _loc2_)
                           {
                              if(11908 !== _loc2_)
                              {
                                 if(11909 !== _loc2_)
                                 {
                                    if(11910 !== _loc2_)
                                    {
                                       if(11911 !== _loc2_)
                                       {
                                          if(11912 !== _loc2_)
                                          {
                                             if(11913 !== _loc2_)
                                             {
                                                if(11994 !== _loc2_)
                                                {
                                                   if(11993 !== _loc2_)
                                                   {
                                                      if(12604 !== _loc2_)
                                                      {
                                                         if(11992 !== _loc2_)
                                                         {
                                                            if(11991 !== _loc2_)
                                                            {
                                                               if(11914 !== _loc2_)
                                                               {
                                                                  if(11560 !== _loc2_)
                                                                  {
                                                                     if(11561 !== _loc2_)
                                                                     {
                                                                        if(11562 !== _loc2_)
                                                                        {
                                                                           if(11569 !== _loc2_)
                                                                           {
                                                                              if(12568 !== _loc2_)
                                                                              {
                                                                                 if(12569 !== _loc2_)
                                                                                 {
                                                                                    if(100100 !== _loc2_)
                                                                                    {
                                                                                       if(11164 !== _loc2_)
                                                                                       {
                                                                                          if(11165 !== _loc2_)
                                                                                          {
                                                                                             if(12535 !== _loc2_)
                                                                                             {
                                                                                                if(201582 !== _loc2_)
                                                                                                {
                                                                                                   if(12536 !== _loc2_)
                                                                                                   {
                                                                                                      if(12537 !== _loc2_)
                                                                                                      {
                                                                                                         if(11966 !== _loc2_)
                                                                                                         {
                                                                                                            if(12545 !== _loc2_)
                                                                                                            {
                                                                                                               return false;
                                                                                                            }
                                                                                                         }
                                                                                                         addr529:
                                                                                                         return true;
                                                                                                      }
                                                                                                      addr528:
                                                                                                      §§goto(addr529);
                                                                                                   }
                                                                                                   addr527:
                                                                                                   §§goto(addr528);
                                                                                                }
                                                                                                addr526:
                                                                                                §§goto(addr527);
                                                                                             }
                                                                                             addr525:
                                                                                             §§goto(addr526);
                                                                                          }
                                                                                          addr524:
                                                                                          §§goto(addr525);
                                                                                       }
                                                                                       addr523:
                                                                                       §§goto(addr524);
                                                                                    }
                                                                                    addr522:
                                                                                    §§goto(addr523);
                                                                                 }
                                                                                 addr521:
                                                                                 §§goto(addr522);
                                                                              }
                                                                              addr520:
                                                                              §§goto(addr521);
                                                                           }
                                                                           addr519:
                                                                           §§goto(addr520);
                                                                        }
                                                                        addr518:
                                                                        §§goto(addr519);
                                                                     }
                                                                     addr517:
                                                                     §§goto(addr518);
                                                                  }
                                                                  addr516:
                                                                  §§goto(addr517);
                                                               }
                                                               addr515:
                                                               §§goto(addr516);
                                                            }
                                                            addr514:
                                                            §§goto(addr515);
                                                         }
                                                         addr513:
                                                         §§goto(addr514);
                                                      }
                                                      addr512:
                                                      §§goto(addr513);
                                                   }
                                                   addr511:
                                                   §§goto(addr512);
                                                }
                                                addr510:
                                                §§goto(addr511);
                                             }
                                             addr509:
                                             §§goto(addr510);
                                          }
                                          addr508:
                                          §§goto(addr509);
                                       }
                                       addr507:
                                       §§goto(addr508);
                                    }
                                    addr506:
                                    §§goto(addr507);
                                 }
                                 addr505:
                                 §§goto(addr506);
                              }
                              addr504:
                              §§goto(addr505);
                           }
                           addr503:
                           §§goto(addr504);
                        }
                        addr502:
                        §§goto(addr503);
                     }
                     addr501:
                     §§goto(addr502);
                  }
                  addr500:
                  §§goto(addr501);
               }
               addr499:
               §§goto(addr500);
            }
            addr498:
            §§goto(addr499);
         }
         §§goto(addr498);
      }
      
      public static function isEquipBoolean(param1:ItemTemplateInfo) : Boolean
      {
         var _loc2_:* = param1.CategoryID;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(7 !== _loc2_)
                           {
                              if(8 !== _loc2_)
                              {
                                 if(9 !== _loc2_)
                                 {
                                    if(13 !== _loc2_)
                                    {
                                       if(14 !== _loc2_)
                                       {
                                          if(15 !== _loc2_)
                                          {
                                             if(16 !== _loc2_)
                                             {
                                                if(17 !== _loc2_)
                                                {
                                                   if(18 !== _loc2_)
                                                   {
                                                      if(70 !== _loc2_)
                                                      {
                                                         if(40 !== _loc2_)
                                                         {
                                                            return false;
                                                         }
                                                      }
                                                      addr22:
                                                      return true;
                                                   }
                                                   addr21:
                                                   §§goto(addr22);
                                                }
                                                addr20:
                                                §§goto(addr21);
                                             }
                                             addr19:
                                             §§goto(addr20);
                                          }
                                          addr18:
                                          §§goto(addr19);
                                       }
                                       addr17:
                                       §§goto(addr18);
                                    }
                                    addr16:
                                    §§goto(addr17);
                                 }
                                 addr15:
                                 §§goto(addr16);
                              }
                              addr14:
                              §§goto(addr15);
                           }
                           addr13:
                           §§goto(addr14);
                        }
                        addr12:
                        §§goto(addr13);
                     }
                     addr11:
                     §§goto(addr12);
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      public static function isHealStone(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 19;
      }
      
      public static function isFusion(param1:ItemTemplateInfo) : Boolean
      {
         return param1.FusionType != 0 && param1.FusionRate > 0;
      }
      
      public static function isStrengthStone(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID != 11)
         {
            return false;
         }
         if(param1.Property1 == "2" || param1.Property1 == "35")
         {
            return true;
         }
         return false;
      }
      
      public static function isExaltStone(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID != 11)
         {
            return false;
         }
         if(param1.Property1 == "2" || param1.Property1 == "45")
         {
            return true;
         }
         return false;
      }
      
      public static function isSymbol(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID != 11)
         {
            return false;
         }
         if(param1.Property1 == "3")
         {
            return true;
         }
         return false;
      }
      
      public static function isBugle(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 11101 || param1.TemplateID == 11102;
      }
      
      public static function isEquip(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID >= 1 && param1.CategoryID < 10 && param1.CategoryID != 7)
         {
            return true;
         }
         return false;
      }
      
      public static function isHead(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 1;
      }
      
      public static function isCloth(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 5;
      }
      
      public static function isAvatar(param1:int) : Boolean
      {
         return [1,2,3,4,5,6,13,15].indexOf(param1) != -1;
      }
      
      public static function isArm(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 7 || param1.CategoryID == 27;
      }
      
      public static function canEquip(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID >= 1 && param1.CategoryID <= 9 || param1.CategoryID >= 13 && param1.CategoryID <= 17)
         {
            return true;
         }
         var _loc2_:* = param1.CategoryID;
         if(27 !== _loc2_)
         {
            if(28 !== _loc2_)
            {
               if(29 !== _loc2_)
               {
                  if(31 !== _loc2_)
                  {
                     if(40 !== _loc2_)
                     {
                        if(50 !== _loc2_)
                        {
                           if(51 !== _loc2_)
                           {
                              if(52 !== _loc2_)
                              {
                                 if(64 !== _loc2_)
                                 {
                                    if(70 !== _loc2_)
                                    {
                                       if(19 !== _loc2_)
                                       {
                                          return false;
                                       }
                                    }
                                    addr45:
                                    return true;
                                 }
                                 addr44:
                                 §§goto(addr45);
                              }
                              addr43:
                              §§goto(addr44);
                           }
                           addr42:
                           §§goto(addr43);
                        }
                        addr41:
                        §§goto(addr42);
                     }
                     addr40:
                     §§goto(addr41);
                  }
                  addr39:
                  §§goto(addr40);
               }
               addr38:
               §§goto(addr39);
            }
            addr37:
            §§goto(addr38);
         }
         §§goto(addr37);
      }
      
      public static function isChest(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property1 == "6";
      }
      
      public static function isMissionGoods(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property1 == "10";
      }
      
      public static function isProp(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 10 || param1.CategoryID == 11;
      }
      
      public static function isBelongToPropBag(param1:ItemTemplateInfo) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:* = param1.CategoryID;
         if(10 !== _loc2_)
         {
            if(11 !== _loc2_)
            {
               if(12 !== _loc2_)
               {
                  if(20 !== _loc2_)
                  {
                     if(53 !== _loc2_)
                     {
                        if(23 !== _loc2_)
                        {
                           if(30 !== _loc2_)
                           {
                              if(34 !== _loc2_)
                              {
                                 if(35 !== _loc2_)
                                 {
                                    if(62 !== _loc2_)
                                    {
                                       if(80 !== _loc2_)
                                       {
                                          if(65 !== _loc2_)
                                          {
                                             if(68 !== _loc2_)
                                             {
                                                if(71 !== _loc2_)
                                                {
                                                   if(72 !== _loc2_)
                                                   {
                                                      return false;
                                                   }
                                                }
                                                addr25:
                                                return true;
                                             }
                                             addr24:
                                             §§goto(addr25);
                                          }
                                          addr23:
                                          §§goto(addr24);
                                       }
                                       addr22:
                                       §§goto(addr23);
                                    }
                                    addr21:
                                    §§goto(addr22);
                                 }
                                 addr20:
                                 §§goto(addr21);
                              }
                              addr19:
                              §§goto(addr20);
                           }
                           addr18:
                           §§goto(addr19);
                        }
                        addr17:
                        §§goto(addr18);
                     }
                     addr16:
                     §§goto(addr17);
                  }
                  addr15:
                  §§goto(addr16);
               }
               addr14:
               §§goto(addr15);
            }
            addr13:
            §§goto(addr14);
         }
         §§goto(addr13);
      }
      
      public static function isTask(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 12;
      }
      
      public static function isPackage(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID == 11 && (param1.Property1 == "6" || param1.Property1 == "114"))
         {
            return true;
         }
         if(param1.CategoryID == 68 || param1.CategoryID == 72)
         {
            return true;
         }
         return false;
      }
      
      public static function isGetPackage(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 65 && int(param1.Property8) > 0;
      }
      
      public static function isFireworks(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 12549 || param1.TemplateID == 12550 || param1.TemplateID == 12551 || param1.TemplateID == 12552 || param1.TemplateID == 12553;
      }
      
      public static function isBatchOnlyDouble(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && (param1.Property1 == "26" || param1.Property1 == "110");
      }
      
      public static function isOpenBatch(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID == 11 && (param1.Property1 == "12" || param1.Property1 == "13" || param1.Property1 == "21"))
         {
            return true;
         }
         if(param1.TemplateID == 12535)
         {
            return true;
         }
         return false;
      }
      
      public static function isCanBatchHandler(param1:InventoryItemInfo) : Boolean
      {
         return param1 && param1.Property4 == "2" && param1.Count > 1;
      }
      
      public static function isPetEgg(param1:int) : Boolean
      {
         return param1 == 35;
      }
      
      public static function isPetSpeciallFood(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 334100;
      }
      
      public static function isSpecilPackage(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property2 == "6";
      }
      
      public static function isCardBox(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 18 && param1.TemplateID != 20150;
      }
      
      public static function isCardSoule(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 18 || param1.CategoryID == 66;
      }
      
      public static function placeToCategeryId(param1:int) : int
      {
         switch(int(param1) - 7)
         {
            case 0:
            case 1:
               return 8;
            case 2:
            case 3:
               return 9;
            default:
            default:
            default:
            default:
            default:
            default:
            default:
            default:
            default:
               return param1 + 1;
            case 13:
               return 64;
         }
      }
      
      public static function isArmShellSpring(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 64 && param1.TemplateID == 10073;
      }
      
      public static function CategeryIdToPlace(param1:int, param2:int = -1) : Array
      {
         var _loc3_:* = param1;
         if(8 !== _loc3_)
         {
            if(28 !== _loc3_)
            {
               if(9 !== _loc3_)
               {
                  if(29 !== _loc3_)
                  {
                     if(13 !== _loc3_)
                     {
                        if(14 !== _loc3_)
                        {
                           if(15 !== _loc3_)
                           {
                              if(16 !== _loc3_)
                              {
                                 if(17 !== _loc3_)
                                 {
                                    if(31 !== _loc3_)
                                    {
                                       if(27 !== _loc3_)
                                       {
                                          if(40 !== _loc3_)
                                          {
                                             if(64 !== _loc3_)
                                             {
                                                if(50 !== _loc3_)
                                                {
                                                   if(51 !== _loc3_)
                                                   {
                                                      if(52 !== _loc3_)
                                                      {
                                                         if(70 !== _loc3_)
                                                         {
                                                            return [param1 - 1];
                                                         }
                                                         return [18];
                                                      }
                                                      return [param2];
                                                   }
                                                   return [param2];
                                                }
                                                return [param2];
                                             }
                                             return [20];
                                          }
                                          return [17];
                                       }
                                       return [6];
                                    }
                                 }
                                 return [15];
                              }
                              return [14];
                           }
                           return [13];
                        }
                        return [12];
                     }
                     return [11];
                  }
               }
               return [9,10];
            }
         }
         return [7,8];
      }
      
      public static function hasSkin(param1:int) : Boolean
      {
         return param1 == 6 || param1 == 5;
      }
      
      public static function getRongLingEquipLevel(param1:ItemTemplateInfo) : int
      {
         if(isRongLing(param1))
         {
            return int(param1.Property1);
         }
         return 0;
      }
      
      public static function isCaddy(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.TemplateID == 112047 || param1.TemplateID == 112100 || param1.TemplateID == 112101)
         {
            return true;
         }
         return false;
      }
      
      public static function isBless(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.TemplateID == 112222 || param1.TemplateID == 112224 || param1.TemplateID == 112223)
         {
            return true;
         }
         return false;
      }
      
      public static function isValuableEquip(param1:ItemTemplateInfo) : Boolean
      {
         var _loc2_:InventoryItemInfo = param1 as InventoryItemInfo;
         if(_loc2_)
         {
            if(_loc2_.CategoryID == 27 || _loc2_.CategoryID == 28 || _loc2_.CategoryID == 29 || _loc2_.CategoryID == 31)
            {
               return true;
            }
            if(_loc2_.CategoryID == 1 || _loc2_.CategoryID == 5 || _loc2_.CategoryID == 7 || _loc2_.CategoryID == 17)
            {
               if(_loc2_.StrengthenLevel >= 7)
               {
                  return true;
               }
            }
            if(_loc2_.CategoryID == 8 || _loc2_.CategoryID == 9)
            {
               if(int(_loc2_.Property1) >= 3)
               {
                  return true;
               }
            }
            if(_loc2_.MagicLevel >= EnchantManager.instance.infoVec.length)
            {
               return true;
            }
            if(_loc2_.CategoryID == 70)
            {
               if(_loc2_.StrengthenLevel >= 20)
               {
                  return true;
               }
            }
            return false;
         }
         return false;
      }
      
      public static function isDrill(param1:InventoryItemInfo) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.CategoryID == 11 && param1.Property1 == "16";
      }
      
      public static function isBead(param1:int) : Boolean
      {
         return param1 == 31;
      }
      
      public static function filterEquiqItemId(param1:int) : int
      {
         switch(int(param1) - -4)
         {
            case 0:
               param1 = -200;
               break;
            case 1:
               param1 = -200;
               break;
            case 2:
               param1 = -200;
               break;
            case 3:
               param1 = -200;
         }
         return param1;
      }
      
      public static function canBringUp(param1:ItemTemplateInfo) : Boolean
      {
         $info = param1;
         isNotWeddingRing = function(param1:ItemTemplateInfo):Boolean
         {
            var _loc2_:* = param1.TemplateID;
            if(9022 !== _loc2_)
            {
               if(9122 !== _loc2_)
               {
                  if(9222 !== _loc2_)
                  {
                     if(9322 !== _loc2_)
                     {
                        if(9422 !== _loc2_)
                        {
                           if(9522 !== _loc2_)
                           {
                              return true;
                           }
                        }
                        addr9:
                        return false;
                     }
                     addr8:
                     §§goto(addr9);
                  }
                  addr7:
                  §§goto(addr8);
               }
               addr6:
               §§goto(addr7);
            }
            §§goto(addr6);
         };
         if(($info.CategoryID == 8 || $info.CategoryID == 9) && isNotWeddingRing($info))
         {
            return true;
         }
         return false;
      }
      
      public static function isMagicStone(param1:int) : Boolean
      {
         return param1 == 61;
      }
      
      public static function isAttackBead(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property2 == "1";
      }
      
      public static function isDefenceBead(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property2 == "2";
      }
      
      public static function isAttributeBead(param1:ItemTemplateInfo) : Boolean
      {
         return param1.Property2 == "3";
      }
      
      public static function isDynamicWeapon(param1:int) : Boolean
      {
         var _loc2_:* = param1;
         if(7144 !== _loc2_)
         {
            if(71441 !== _loc2_)
            {
               if(71442 !== _loc2_)
               {
                  if(71443 !== _loc2_)
                  {
                     if(71444 !== _loc2_)
                     {
                        if(7145 !== _loc2_)
                        {
                           if(71451 !== _loc2_)
                           {
                              if(71452 !== _loc2_)
                              {
                                 if(71453 !== _loc2_)
                                 {
                                    if(71454 !== _loc2_)
                                    {
                                       return false;
                                    }
                                 }
                                 addr14:
                                 return true;
                              }
                              addr13:
                              §§goto(addr14);
                           }
                           addr12:
                           §§goto(addr13);
                        }
                        addr11:
                        §§goto(addr12);
                     }
                     addr10:
                     §§goto(addr11);
                  }
                  addr9:
                  §§goto(addr10);
               }
               addr8:
               §§goto(addr9);
            }
            addr7:
            §§goto(addr8);
         }
         §§goto(addr7);
      }
      
      public static function isBeadFromSmelt(param1:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmeltByID(param1.TemplateID);
      }
      
      public static function isBeadFromSmeltByID(param1:int) : Boolean
      {
         return BeadModel.getInstance().isBeadFromSmelt(param1);
      }
      
      public static function isAttackBeadFromSmeltByID(param1:int) : Boolean
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         if(_loc2_)
         {
            return BeadModel.getInstance().isAttackBead(_loc2_);
         }
         return false;
      }
      
      public static function isDefenceBeadFromSmeltByID(param1:int) : Boolean
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         if(_loc2_)
         {
            return BeadModel.getInstance().isDefenceBead(_loc2_);
         }
         return false;
      }
      
      public static function isAttributeBeadFromSmeltByID(param1:int) : Boolean
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         if(_loc2_)
         {
            return BeadModel.getInstance().isAttributeBead(_loc2_);
         }
         return false;
      }
      
      public static function isOfferPackage(param1:ItemTemplateInfo) : Boolean
      {
         switch(int(param1.TemplateID) - 11252)
         {
            case 0:
               return true;
            default:
            default:
            default:
            default:
            case 5:
            case 6:
            case 7:
            case 8:
               return false;
         }
      }
      
      public static function isBeadNeedOpen(param1:ItemTemplateInfo) : Boolean
      {
         if(isBeadFromSmelt(param1))
         {
            return true;
         }
         var _loc2_:* = param1.TemplateID;
         if(311500 !== _loc2_)
         {
            if(313500 !== _loc2_)
            {
               if(312500 !== _loc2_)
               {
                  return false;
               }
            }
            addr14:
            return true;
         }
         §§goto(addr14);
      }
      
      public static function isComposeStone(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && param1.Property1 == "1";
      }
      
      public static function isFusionFormula(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && param1.Property1 == "8";
      }
      
      public static function isCaddyCanBay(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 112047;
      }
      
      public static function isTimeBox(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && param1.Property1 == "6" && param1.Property2 == "4";
      }
      
      public static function isAngel(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 17001 || param1.TemplateID == 17002 || param1.TemplateID == 17101 || param1.TemplateID == 17005 || param1.TemplateID == 17011 || param1.TemplateID == 17000 || param1.TemplateID == 17010 || param1.TemplateID == 17100 || param1.TemplateID == 17007;
      }
      
      public static function isShield(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 17003 || param1.TemplateID == 17004 || param1.TemplateID == 17013;
      }
      
      public static function isWishKingBlessing(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 17200;
      }
      
      public static function isArmShell(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 64;
      }
      
      public static function isArmShellTotem(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 64 && param1.TemplateID == 10083;
      }
      
      public static function isArmShellClip(param1:ItemTemplateInfo) : Boolean
      {
         return param1.TemplateID == 13000;
      }
      
      public static function isArmShellStone(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && int(param1.Property1) == 1;
      }
      
      public static function isArmShellResetStone(param1:ItemTemplateInfo) : Boolean
      {
         return param1.CategoryID == 11 && int(param1.Property1) == 1;
      }
      
      public static function hasPropAnimation(param1:ItemTemplateInfo) : String
      {
         switch(int(param1.TemplateID) - 10009)
         {
            case 0:
               return "health";
            case 1:
            case 2:
            case 3:
               return "hiding";
            default:
            default:
               return null;
            case 6:
               return "freeze";
         }
      }
   }
}
