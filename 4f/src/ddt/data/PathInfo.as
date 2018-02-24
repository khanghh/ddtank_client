package ddt.data
{
   import flash.utils.Dictionary;
   
   public class PathInfo extends BaseEventDispatcherInfo
   {
      
      public static var GAME_BOXPIC:int;
      
      public static var LANGUAGE:String = "";
      
      public static var MUSIC_LIST:Array;
      
      public static var GAME_WIDTH:Number = 1000;
      
      public static var GAME_HEIGHT:Number = 600;
      
      public static var SUCIDE_TIME:int = 120;
      
      public static var ISTOPDERIICT:Boolean = false;
      
      public static var isUserAddFriend:Boolean = false;
      
      public static var SERVER_NUMBER:int = 4;
       
      
      public var RECORD_PATH:String = "";
      
      public var FLASHSITE:String = "";
      
      public var BACKUP_FLASHSITE:String = "";
      
      public var SITE:String = "";
      
      public var REQUEST_PATH:String = "";
      
      public var RES_PATH:String = "";
      
      public var MAP_PATH:String = "";
      
      public var STYLE_PATH:String = "style/";
      
      public var RTMP_PATH:String = "";
      
      public var LOGIN_PATH:String = "";
      
      public var USER_NAME:String;
      
      public var FIRSTPAGE:String;
      
      public var REGISTER:String;
      
      public var FILL_PATH:String;
      
      public var ADVANCED_ENABLE:Boolean;
      
      public var EPICLEVEL_ENABLE:Boolean;
      
      private var _CLIENT_DOWNLOAD:String;
      
      public var TRAINER_PATH:String;
      
      public var COUNT_PATH:String;
      
      public var PARTER_ID:String;
      
      public var SITEII:String;
      
      public var PHP_PATH:String;
      
      public var PHP_IMAGE_LINK:Boolean = true;
      
      public var WEB_PLAYER_INFO_PATH:String;
      
      public var OFFICIAL_SITE:String;
      
      public var GAME_FORUM:String;
      
      public var COMMUNITY_FRIEND_PATH:String;
      
      public var COMMUNITY_INVITE_PATH:String;
      
      public var COMMUNITY_FRIEND_LIST_PATH:String;
      
      public var SNS_PATH:String;
      
      public var MICROCOBOL_PATH:String;
      
      public var COMMUNITY_EXIST:Boolean;
      
      public var COMMUNITY_FRIEND_INVITED_SWITCH:Boolean;
      
      public var COMMUNITY_FRIEND_INVITED_ONLINE_SWITCH:Boolean;
      
      public var IS_VISIBLE_EXISTBTN:Boolean;
      
      public var ALLOW_POPUP_FAVORITE:Boolean;
      
      public var FILL_JS_COMMAND_ENABLE:Boolean;
      
      public var FILL_JS_COMMAND_VALUE:String;
      
      public var SERVERLISTINDEX:int = -1;
      
      public var EXTERNAL_INTERFACE_PATH:String;
      
      public var EXTERNAL_INTERFACE_ENABLE:Boolean;
      
      public var FEEDBACK_ENABLE:Boolean;
      
      public var FEEDBACK_TEL_NUMBER:String;
      
      public var SPA_ENABLE:Boolean = true;
      
      public var CIVIL_ENABLE:Boolean = true;
      
      public var CHURCH_ENABLE:Boolean = true;
      
      public var WEEKLY_ENABLE:Boolean = true;
      
      public var ACHIEVE_ENABLE:Boolean = true;
      
      public var FORTH_ENABLE:Boolean = true;
      
      public var STHRENTH_MAX:int = 12;
      
      public var USER_GUILD_ENABLE:Boolean = true;
      
      public var COMMUNITY_MICROBLOG:Boolean = false;
      
      public var COMMUNITY_SINA_SECOND_MICROBLOG:Boolean = false;
      
      public var CHAT_FACE_DISABLED_LIST:Array;
      
      public var FIGHTLIB_ENABLE:Boolean = true;
      
      public var SUIT_ENABLE:Boolean;
      
      public var FRAME_TIME_OVER_TAG:int = 67;
      
      public var FRAME_OVER_COUNT_TAG:int = 25;
      
      public var TRAINER_STANDALONE:Boolean = true;
      
      public var STATISTICS:Boolean = true;
      
      public var EXTERNAL_INTERFACE_PATH_360:String;
      
      public var EXTERNAL_INTERFACE_ENABLE_360:Boolean;
      
      public var DISABLE_TASK_ID:String = "";
      
      public var GIRDATTEST:Boolean;
      
      public var LITTLEGAMEMINLV:int;
      
      public var WEEKLY_SITE:String = "";
      
      public var GRADE_NOTIFICATION:Dictionary;
      
      public var CALL_LOGIN_INTERFAECE:String;
      
      public var TREASURE:Boolean;
      
      public var TREASUREHELPTIMES:int;
      
      public var USER_ACTION_NOTICE:String = "";
      
      public var DUNGEON_OPENLIST:Array;
      
      public var CALLBACK_INTERFACE_PATH:String;
      
      public var CALLBACK_INTERFACE_ENABLE:Boolean = true;
      
      public var IS_SEND_RECORDUSERVERSION:Boolean;
      
      public var IS_SEND_FLASHINFO:Boolean;
      
      public var FLASH_P2P_EBABLE:Boolean = false;
      
      public var FLASH_P2P_KEY:String = "";
      
      public var FLASH_P2P_CIRRUS_URL:String = "";
      
      public var GEMSTONE_ENABLE:Boolean = true;
      
      public var IS_DUO_WAN_SDK_INTERFACE:Boolean;
      
      public var FOOTBALL_ENABLE:Boolean;
      
      public var SMALLMAP_ENABLE:Boolean;
      
      public var SMALLMAP_BORDER_ENABLE:Boolean;
      
      public var SMALLMAP_ALPHA:Boolean;
      
      public var SMALLMAP_POINT_ENABLE:Boolean;
      
      public var SMALLMAP_GRID_ENABLE:Boolean;
      
      public var SMALLMAP_SHAPE_ENABLE:Boolean;
      
      public var VIP_DISCOUNT:Boolean;
      
      public var PK_BTN:Boolean;
      
      public var PETS_EAT:Boolean;
      
      public var MAGICHOUSE:Boolean;
      
      public var GODSYAH_ENABLE:Boolean;
      
      public var FIGHT_TIME:int;
      
      public var GIRLHEAD:Boolean;
      
      public var TRUSTEESHIPVIEW:Boolean;
      
      public var LOGINDEVICE_LINK:String;
      
      public var PLAYERTRANSFER:Boolean;
      
      public var PLAYERTRANSFER_LINK:String;
      
      public var BOMBKing_KILL_CHEAT:Boolean;
      
      public var BOMBKing_KILL_CHEAT_MAP:Object;
      
      public var BEAUTY_PROVE_QQ:String;
      
      public function PathInfo(){super();}
      
      public function get CLIENT_DOWNLOAD() : String{return null;}
      
      public function set CLIENT_DOWNLOAD(param1:String) : void{}
   }
}
