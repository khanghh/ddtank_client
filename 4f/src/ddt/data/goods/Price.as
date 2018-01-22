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
      
      public function Price(param1:int, param2:int){super();}
      
      public function clone() : Price{return null;}
      
      public function get Value() : int{return 0;}
      
      public function set Unit(param1:int) : void{}
      
      public function get Unit() : int{return 0;}
      
      public function get UnitToString() : String{return null;}
   }
}
