package ddt.data.goods
{
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   
   public class Price
   {
      
      public static var ONLYMONEY:Boolean = false;
      
      public static var ONLYDDT_MONEY:Boolean = false;
      
      public static const MONEY2:int = -8;
      
      public static const MONEY3:int = -9;
      
      public static const MONEY:int = -1;
      
      public static const DDT_MONEY:int = -2;
      
      public static const NEW_DDT_MONEY:int = -11;
      
      public static const GOLD:int = -3;
      
      public static const GESTE:int = -4;
      
      public static const SCORE:int = -6;
      
      public static const WORLDBOSS_SCORE:int = -7;
      
      public static const HARD_CURRENCY:int = -9;
      
      public static const LEAGUE:int = -1000;
      
      public static const LIGHT_STONE:int = -11;
      
      public static const FISH_SCORE:int = -2000;
      
      public static const PET_STONE:int = -12;
      
      public static const ARM_SHELLCLIP:int = 13000;
      
      public static const BADGE:int = 12567;
      
      public static const LIGHT_STONE_STRING:String = LanguageMgr.GetTranslation("buried.alertInfo.ligthStone");
      
      public static const BOTHMONEYTOSTRING:String = LanguageMgr.GetTranslation("bothMoney");
      
      public static const MONEYTOSTRING:String = LanguageMgr.GetTranslation("money");
      
      public static const BANDMONEYTOSTRING:String = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
      
      public static const MEDALMONEYTOSTRING:String = LanguageMgr.GetTranslation("medalMoney");
      
      public static const DDTMONEYTOSTRING:String = LanguageMgr.GetTranslation("ddtMoney");
      
      public static const GOLDTOSTRING:String = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.gold");
      
      public static const GESTETOSTRING:String = LanguageMgr.GetTranslation("gongxun");
      
      public static const SCORETOSTRING:String = LanguageMgr.GetTranslation("tank.gameover.takecard.score");
      
      public static const PETSCORETOSTRING:String = LanguageMgr.GetTranslation("ddt.farm.petScore");
      
      public static const HARD_CURRENCY_TO_STRING:String = LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthShopFrame.text1");
      
      public static const LEAGUESTRING:String = LanguageMgr.GetTranslation("ddt.league.moneyTypeTxt");
      
      public static const TREASURELOST_STONE:String = LanguageMgr.GetTranslation("treasureLost.treasurelostStone");
      
      public static const FISH_SCORE_STRING:String = LanguageMgr.GetTranslation("home.fishing.fishScore");
      
      public static const ARM_SHELLCLIP_STRING:String = LanguageMgr.GetTranslation("ddt.armShellClip.moneyTypeTxt");
      
      public static const BADGE_STRING:String = LanguageMgr.GetTranslation("badge");
       
      
      private var _value:int;
      
      private var _unit:int;
      
      public function Price(value:int, unit:int)
      {
         super();
         _value = value;
         _unit = unit;
      }
      
      public function clone() : Price
      {
         return new Price(_value,_unit);
      }
      
      public function get Value() : int
      {
         return _value;
      }
      
      public function set Unit(num:int) : void
      {
         _unit = num;
      }
      
      public function get Unit() : int
      {
         return _unit;
      }
      
      public function get UnitToString() : String
      {
         if(_unit == -8)
         {
            ONLYMONEY = true;
            ONLYDDT_MONEY = false;
            return MONEYTOSTRING;
         }
         if(_unit == -9)
         {
            ONLYDDT_MONEY = true;
            ONLYMONEY = false;
            return DDTMONEYTOSTRING;
         }
         ONLYDDT_MONEY = false;
         ONLYMONEY = false;
         if(_unit == -1)
         {
            return BOTHMONEYTOSTRING;
         }
         if(_unit == -3)
         {
            return GOLDTOSTRING;
         }
         if(_unit == -4)
         {
            return GESTETOSTRING;
         }
         if(_unit == -6 || _unit == -7)
         {
            return SCORETOSTRING;
         }
         if(_unit == -2)
         {
            return MEDALMONEYTOSTRING;
         }
         if(_unit == -11)
         {
            return DDTMONEYTOSTRING;
         }
         if(_unit == -9)
         {
            return HARD_CURRENCY_TO_STRING;
         }
         if(_unit == -2000)
         {
            return FISH_SCORE_STRING;
         }
         if(_unit == -11)
         {
            return LIGHT_STONE_STRING;
         }
         if(_unit == -1000)
         {
            return LEAGUESTRING;
         }
         if(_unit == 13000)
         {
            return ARM_SHELLCLIP_STRING;
         }
         if(ItemManager.Instance.getTemplateById(_unit))
         {
            return ItemManager.Instance.getTemplateById(_unit).Name;
         }
         if(_unit == 12567)
         {
            return BADGE_STRING;
         }
         return LanguageMgr.GetTranslation("wrongUnit");
      }
   }
}
