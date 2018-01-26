package ddt.view.chat
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.Helpers;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import newTitle.NewTitleManager;
   import redEnvelope.view.RedEnvelopeItem;
   import road7th.utils.StringHelper;
   
   public class ChatFormats
   {
      
      public static const CHAT_COLORS:Array = [2358015,16751360,16740090,4970320,8423901,16777215,16776960,16776960,16776960,16777215,5035345,16724787,16777011,16777215,16711846,16711680,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,10170623,13369599];
      
      public static const BIG_BUGGLE_COLOR:Array = [11408476,16635586,15987916,16514727,12053748];
      
      public static const BIG_BUGGLE_TYPE_STRING:Array = ["Mối tình đầu","Chúc mừng sinh nhật","Lá lành đùm lá rách","Vua thách đấu","Đời không đối thủ","Noen vui vẻ "];
      
      public static const TITLE_COLORS:Array = [11423743,54015,16731330,16743936];
      
      public static const CLICK_CHANNEL:int = 0;
      
      public static const CLICK_GOODS:int = 2;
      
      public static const CLICK_USERNAME:int = 1;
      
      public static const CLICK_DIFF_ZONE:int = 4;
      
      public static const CLICK_INVENTORY_GOODS:int = 3;
      
      public static const CLICK_EFFORT:int = 100;
      
      public static const CLICK_FASTINVITE:int = 101;
      
      public static const CLICK_ENTERHUIKUI_ACTIVITY:int = 102;
      
      public static const CLICK_INVITE_OLD_PLAYER:int = 103;
      
      public static const CLICK_LANTERN_BEGIN:int = 104;
      
      public static const CLICK_TIME_GIFTPACK:int = 105;
      
      public static const CLICK_NO_TIP:int = 106;
      
      public static const CLICK_SIMPLE_TOLINK:int = 99;
      
      public static const CLICK_FASTAUCTION:int = 107;
      
      public static const AVATAR_COLLECTION_TIP:int = 108;
      
      public static const CLICK_INVITE_WAKE:int = 109;
      
      public static const CLICK_FARMBOSS_FULLLEVEL:int = 110;
      
      public static const GOTO_RED_PACKAGE:int = 111;
      
      public static var CLICK_ACT_TIP:int = 1000;
      
      public static const NEWYEARFOOD:int = 888;
      
      public static const REDENVELOPE:int = 999;
      
      public static const HORESRACE:int = 889;
      
      public static const GMCHAT:int = 890;
      
      public static const GOTO_CONSORTIA_BACK_PACKAGE:int = 112;
      
      public static const GOTO_CONSORTIA_DOMAIN_SCENE:int = 113;
      
      public static const COMPLATE_TASK:int = 114;
      
      public static const CARD_CAO:int = 5;
      
      public static const CLICK_CARD_INFO:int = 6;
      
      public static const Channel_Set:Object = {
         0:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.big"),
         1:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.small"),
         2:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private"),
         3:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.consortia"),
         4:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.ream"),
         5:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         9:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         12:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.cross"),
         13:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         15:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.crossBugle"),
         25:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current")
      };
      
      public static var hasYaHei:Boolean;
      
      private static var _formats:Dictionary;
      
      private static var _styleSheet:StyleSheet;
      
      private static var _gameStyleSheet:StyleSheet;
      
      private static var _styleSheetData:Dictionary;
      
      private static var _chatData:ChatData;
      
      private static const unacceptableChar:Array = ["\"","\'","<",">"];
      
      private static const IN_GAME:uint = 1;
      
      private static const NORMAL:uint = 0;
       
      
      public function ChatFormats(){super();}
      
      public static function formatChatStyle(param1:ChatData) : void{}
      
      public static function formatComplexChatStyle(param1:ChatData) : void{}
      
      public static function creatBracketsTag(param1:String, param2:int, param3:Array = null, param4:ChatData = null) : String{return null;}
      
      public static function creatGoodTag(param1:String, param2:int, param3:int, param4:int, param5:Boolean, param6:ChatData = null, param7:String = "", param8:int = -1) : String{return null;}
      
      public static function getColorByChannel(param1:int) : int{return 0;}
      
      public static function getColorByBigBuggleType(param1:int) : int{return 0;}
      
      public static function getTagsByChannel(param1:ChatData) : Array{return null;}
      
      public static function getTagsByQuality(param1:int) : Array{return null;}
      
      public static function getTextFormatByChannel(param1:int) : TextFormat{return null;}
      
      public static function setup() : void{}
      
      public static function get styleSheet() : StyleSheet{return null;}
      
      public static function get gameStyleSheet() : StyleSheet{return null;}
      
      private static function getBigBuggleTypeString(param1:int) : String{return null;}
      
      private static function creatChannelTag(param1:int, param2:int = 0, param3:ChatData = null) : String{return null;}
      
      private static function creatContentTag(param1:ChatData) : String{return null;}
      
      private static function creatSenderTag(param1:ChatData) : String{return null;}
      
      public static function replaceUnacceptableChar(param1:String) : String{return null;}
      
      private static function creatStyleObject(param1:int, param2:uint = 0) : Object{return null;}
      
      private static function setupFormat() : void{}
      
      private static function setupStyle() : void{}
   }
}
