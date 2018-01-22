package ddt.data
{
   import baglocked.BaglockedManager;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StatisticManager;
   import flash.display.LoaderInfo;
   import flash.system.Security;
   import game.GameManager;
   import yyvip.YYVipManager;
   
   public class ConfigParaser
   {
       
      
      public function ConfigParaser()
      {
         super();
      }
      
      public static function paras(param1:XML, param2:LoaderInfo, param3:String) : void
      {
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc12_:PathInfo = new PathInfo();
         _loc12_.SITEII = String(param2.parameters["site"]);
         if(_loc12_.SITEII == "undefined")
         {
            _loc12_.SITEII = "";
         }
         var _loc13_:* = param1.SITE.@value;
         BonesLoaderManager.SITE_MAIN = _loc13_;
         _loc12_.SITE = _loc13_;
         _loc12_.WEEKLY_SITE = param1.WEEKLYSITE.@value;
         _loc12_.BACKUP_FLASHSITE = param1.BACKUP_FLASHSITE.@value;
         _loc13_ = param1.FLASHSITE.@value;
         BonesLoaderManager.FLASHSITE = _loc13_;
         _loc12_.FLASHSITE = _loc13_;
         _loc12_.RECORD_PATH = param1.RECORD_PATH.@value;
         _loc12_.COMMUNITY_FRIEND_PATH = param1.COMMUNITY_FRIEND_PATH.@value;
         if(param1.COMMUNITY_MICROBLOG.hasOwnProperty("@value"))
         {
            _loc12_.COMMUNITY_MICROBLOG = StringUtils.converBoolean(param1.COMMUNITY_MICROBLOG.@value);
         }
         if(param1.COMMUNITY_SINA_SECOND_MICROBLOG.hasOwnProperty("@value"))
         {
            _loc12_.COMMUNITY_SINA_SECOND_MICROBLOG = StringUtils.converBoolean(param1.COMMUNITY_SINA_SECOND_MICROBLOG.@value);
         }
         if(param1.COMMUNITY_FRIEND_PATH.hasOwnProperty("@isUser"))
         {
            PathInfo.isUserAddFriend = StringUtils.converBoolean(param1.COMMUNITY_FRIEND_PATH.@isUser);
         }
         _loc12_.USER_NAME = param3;
         _loc12_.STYLE_PATH = param1.STYLE_PATH.@value;
         _loc12_.FIRSTPAGE = param1.FIRSTPAGE.@value;
         _loc12_.REGISTER = param1.REGISTER.@value;
         _loc12_.REQUEST_PATH = param1.REQUEST_PATH.@value;
         _loc12_.FILL_PATH = String(param1.FILL_PATH.@value).replace("{user}",param3);
         _loc12_.FILL_PATH = _loc12_.FILL_PATH.replace("{site}",_loc12_.SITEII);
         _loc12_.LOGIN_PATH = String(param1.LOGIN_PATH.@value).replace("{user}",param3);
         _loc12_.LOGIN_PATH = _loc12_.LOGIN_PATH.replace("{site}",_loc12_.SITEII);
         _loc12_.OFFICIAL_SITE = param1.OFFICIAL_SITE.@value;
         _loc12_.GAME_FORUM = param1.GAME_FORUM.@value;
         _loc12_.LITTLEGAMEMINLV = param1.LITTLEGAMEMINLV.@value;
         _loc12_.BOMBKing_KILL_CHEAT = StringUtils.converBoolean(param1.BOMBKing_KILL_CHEAT.@value);
         if(param1.LOGIN_PATH.hasOwnProperty("@siteName"))
         {
            StatisticManager.siteName = param1.LOGIN_PATH.@siteName;
         }
         _loc12_.TRAINER_STANDALONE = String(param1.TRAINER_STANDALONE.@value) == "false"?false:true;
         _loc12_.TRAINER_PATH = param1.TRAINER_PATH.@value;
         _loc12_.COUNT_PATH = param1.COUNT_PATH.@value;
         _loc12_.PARTER_ID = param1.PARTER_ID.@value;
         if(!param1.STATISTIC.hasOwnProperty("@value"))
         {
         }
         var _loc11_:int = param1.SUCIDE_TIME.@value;
         if(_loc11_ > 0)
         {
            PathInfo.SUCIDE_TIME = _loc11_ * 1000;
         }
         var _loc6_:int = param1.BOX_STYLE.@value;
         if(_loc6_ != 0)
         {
         }
         _loc12_.PHP_PATH = param1.PHP.@site;
         if(param1.PHP.hasOwnProperty("@link"))
         {
            _loc12_.PHP_IMAGE_LINK = StringUtils.converBoolean(param1.PHP.@link);
         }
         _loc12_.WEB_PLAYER_INFO_PATH = param1.PHP.@infoPath;
         if(param1.PHP.hasOwnProperty("@isShow"))
         {
            PlayerManager.isShowPHP = StringUtils.converBoolean(param1.PHP.@isShow);
         }
         if(param1.PHP.hasOwnProperty("@link"))
         {
            _loc12_.PHP_IMAGE_LINK = StringUtils.converBoolean(param1.PHP.@link);
         }
         PathInfo.MUSIC_LIST = String(param1.MUSIC_LIST.@value).split(",");
         PathInfo.LANGUAGE = String(param1.LANGUAGE.@value);
         var _loc10_:XMLList = param1.POLICY_FILES.file;
         var _loc15_:int = 0;
         var _loc14_:* = _loc10_;
         for each(var _loc5_ in _loc10_)
         {
            Security.loadPolicyFile(_loc5_.@value);
         }
         if(param1.GAME_BOXPIC.hasOwnProperty("@value"))
         {
            PathInfo.GAME_BOXPIC = param1.GAME_BOXPIC.@value;
         }
         if(param1.ISTOPDERIICT.hasOwnProperty("@value"))
         {
            PathInfo.ISTOPDERIICT = StringUtils.converBoolean(param1.ISTOPDERIICT.@value);
         }
         _loc12_.COMMUNITY_INVITE_PATH = param1.COMMUNITY_INVITE_PATH.@value;
         _loc12_.MICROCOBOL_PATH = param1.COMMUNITY_FRIEND_LIST_PATH.@microcobolPath;
         if(param1.COMMUNITY_FRIEND_LIST_PATH.hasOwnProperty("@isexistBtnVisble"))
         {
            _loc12_.IS_VISIBLE_EXISTBTN = StringUtils.converBoolean(param1.COMMUNITY_FRIEND_LIST_PATH.@isexistBtnVisble);
         }
         _loc12_.ALLOW_POPUP_FAVORITE = String(param1.ALLOW_POPUP_FAVORITE.@value) == "true"?true:false;
         if(param1.FILL_JS_COMMAND.hasOwnProperty("@enable"))
         {
            _loc12_.FILL_JS_COMMAND_ENABLE = StringUtils.converBoolean(param1.FILL_JS_COMMAND.@enable);
         }
         if(param1.FILL_JS_COMMAND.hasOwnProperty("@value"))
         {
            _loc12_.FILL_JS_COMMAND_VALUE = param1.FILL_JS_COMMAND.@value;
         }
         if(param1.MINLEVELDUPLICATE.hasOwnProperty("@value"))
         {
            GameManager.MinLevelDuplicate = param1.MINLEVELDUPLICATE.@value;
         }
         _loc12_.FIGHTLIB_ENABLE = StringUtils.converBoolean(param1.FIGHTLIB.@value);
         if(param1.MODULE != null && param1.MODULE.SPA != null && param1.MODULE.SPA.hasOwnProperty("@enable"))
         {
            _loc12_.SPA_ENABLE = param1.MODULE.SPA.@enable != "false";
         }
         if(param1.MODULE != null && param1.MODULE.CIVIL != null && param1.MODULE.CIVIL.hasOwnProperty("@enable"))
         {
            _loc12_.CIVIL_ENABLE = param1.MODULE.CIVIL.@enable != "false";
         }
         if(param1.MODULE != null && param1.MODULE.CHURCH != null && param1.MODULE.CHURCH.hasOwnProperty("@enable"))
         {
            _loc12_.CHURCH_ENABLE = param1.MODULE.CHURCH.@enable != "false";
         }
         if(param1.MODULE != null && param1.MODULE.WEEKLY != null && param1.MODULE.WEEKLY.hasOwnProperty("@enable"))
         {
            _loc12_.WEEKLY_ENABLE = param1.MODULE.WEEKLY.@enable != "false";
         }
         if(param1.FORTH_ENABLE.hasOwnProperty("@value"))
         {
            _loc12_.FORTH_ENABLE = param1.FORTH_ENABLE.@value != "false";
         }
         if(param1.STHRENTH_MAX.hasOwnProperty("@value"))
         {
            _loc12_.STHRENTH_MAX = int(param1.STHRENTH_MAX.@value);
         }
         if(param1.USER_GUILD_ENABLE.hasOwnProperty("@value"))
         {
            _loc12_.USER_GUILD_ENABLE = StringUtils.converBoolean(param1.USER_GUILD_ENABLE.@value);
         }
         if(param1.ACHIEVE_ENABLE.hasOwnProperty("@value"))
         {
            _loc12_.ACHIEVE_ENABLE = param1.ACHIEVE_ENABLE.@value != "false";
         }
         if(param1.CHAT_FACE != null && param1.CHAT_FACE.DISABLED_LIST != null && param1.CHAT_FACE.DISABLED_LIST.hasOwnProperty("@list"))
         {
            _loc12_.CHAT_FACE_DISABLED_LIST = String(param1.CHAT_FACE.DISABLED_LIST.@list).split(",");
         }
         if(param1.STATISTICS.hasOwnProperty("@enable"))
         {
            _loc12_.STATISTICS = param1.STATISTICS.@enable != "false";
         }
         if(param1.USER_GUIDE.hasOwnProperty("@value") || true)
         {
         }
         if(param1.GAME_FRAME_CONFIG != null && param1.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG != null && param1.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG.hasOwnProperty("@value"))
         {
            _loc12_.FRAME_TIME_OVER_TAG = int(param1.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG.@value);
         }
         if(param1.GAME_FRAME_CONFIG != null && param1.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG != null && param1.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG.hasOwnProperty("@value"))
         {
            _loc12_.FRAME_OVER_COUNT_TAG = int(param1.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG.@value);
         }
         if(param1.EXTERNAL_INTERFACE_360 != null && param1.EXTERNAL_INTERFACE_360.hasOwnProperty("@value"))
         {
            _loc12_.EXTERNAL_INTERFACE_PATH_360 = String(param1.EXTERNAL_INTERFACE_360.@value);
         }
         if(param1.EXTERNAL_INTERFACE_360 != null && param1.EXTERNAL_INTERFACE_360.hasOwnProperty("@enable"))
         {
            _loc12_.EXTERNAL_INTERFACE_ENABLE_360 = param1.EXTERNAL_INTERFACE_360.@enable != "false";
         }
         if(param1.GRADE_NOTIFICATION != null && param1.GRADE_NOTIFICATION.NOTIFICATION != null)
         {
            _loc8_ = param1.GRADE_NOTIFICATION.NOTIFICATION;
            var _loc17_:int = 0;
            var _loc16_:* = _loc8_;
            for each(var _loc9_ in _loc8_)
            {
               if(!(!_loc9_.hasOwnProperty("@grade") || !_loc9_.hasOwnProperty("@site")))
               {
                  _loc7_ = _loc9_.@grade;
                  _loc4_ = _loc9_.@site;
                  if(!(_loc7_ == "" || _loc4_ == ""))
                  {
                     _loc12_.GRADE_NOTIFICATION[_loc7_] = _loc4_;
                  }
               }
            }
         }
         if(param1.CALL_PATH != null && param1.CALL_PATH.hasOwnProperty("@value"))
         {
            _loc12_.CALL_LOGIN_INTERFAECE = param1.CALL_PATH.@value;
         }
         if(param1.USER_ACTION_NOTICE != null && param1.USER_ACTION_NOTICE.hasOwnProperty("@value"))
         {
            _loc12_.USER_ACTION_NOTICE = param1.USER_ACTION_NOTICE.@value;
         }
         if(param1.CALLBACK_INTERFACE != null && param1.CALLBACK_INTERFACE.hasOwnProperty("@path"))
         {
            _loc12_.CALLBACK_INTERFACE_PATH = param1.CALLBACK_INTERFACE.@path;
         }
         if(param1.CALLBACK_INTERFACE != null && param1.CALLBACK_INTERFACE.hasOwnProperty("@enable"))
         {
            _loc12_.CALLBACK_INTERFACE_ENABLE = param1.CALLBACK_INTERFACE.@enable;
         }
         if(StringUtils.trim(param1.DUNGEON_OPENLIST.@value) != "")
         {
            _loc12_.DUNGEON_OPENLIST = StringUtils.trim(param1.DUNGEON_OPENLIST.@value).split(",");
         }
         if(param1.DUO_WAN_YY_VIP != null && param1.DUO_WAN_YY_VIP.hasOwnProperty("@value"))
         {
            YYVipManager.YY_VIP_TAG = int(param1.DUO_WAN_YY_VIP.@value);
         }
         if(param1.DUO_WAN_YY_VIP_OPEN_URL != null && param1.DUO_WAN_YY_VIP_OPEN_URL.hasOwnProperty("@value"))
         {
            YYVipManager.VIP_OPEN_URL = param1.DUO_WAN_YY_VIP_OPEN_URL.@value;
         }
         if(param1.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW != null && param1.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW.hasOwnProperty("@value"))
         {
            YYVipManager.YY_VIP_SHOW_OPEN_VIEW = param1.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW.@value;
         }
         if(param1.LOCK_SETTING != null && param1.LOCK_SETTING.hasOwnProperty("@value"))
         {
            BaglockedManager.LOCK_SETTING = param1.LOCK_SETTING.@value;
         }
         if(param1.GAME_CAN_NOT_EXIT_SEND_LOG != null && param1.GAME_CAN_NOT_EXIT_SEND_LOG.hasOwnProperty("@value"))
         {
            GameManager.GAME_CAN_NOT_EXIT_SEND_LOG = param1.GAME_CAN_NOT_EXIT_SEND_LOG.@value;
         }
         if(param1.IS_SEND_RECORDUSERVERSION != null && param1.IS_SEND_RECORDUSERVERSION.hasOwnProperty("@value"))
         {
            _loc12_.IS_SEND_RECORDUSERVERSION = param1.IS_SEND_RECORDUSERVERSION.@value == "true";
         }
         if(param1.IS_SEND_FLASHINFO != null && param1.IS_SEND_FLASHINFO.hasOwnProperty("@value"))
         {
            _loc12_.IS_SEND_FLASHINFO = param1.IS_SEND_FLASHINFO.@value == "true";
         }
         if(param1.FLASH_P2P != null)
         {
            if(param1.FLASH_P2P.hasOwnProperty("@ebable"))
            {
               _loc12_.FLASH_P2P_EBABLE = param1.FLASH_P2P.@ebable == "true";
            }
            if(param1.FLASH_P2P.hasOwnProperty("@key"))
            {
               _loc12_.FLASH_P2P_KEY = param1.FLASH_P2P.@key;
            }
            if(param1.FLASH_P2P.hasOwnProperty("@url"))
            {
               _loc12_.FLASH_P2P_CIRRUS_URL = param1.FLASH_P2P.@url;
            }
         }
         if(param1.TREASURE.hasOwnProperty("@enable"))
         {
            _loc12_.TREASURE = param1.TREASURE.@enable != "false";
            _loc12_.TREASUREHELPTIMES = int(param1.TREASURE.@times);
         }
         else
         {
            _loc12_.TREASURE = true;
            _loc12_.TREASUREHELPTIMES = 5;
         }
         if(param1.GEMSTONE.hasOwnProperty("@enable"))
         {
            _loc12_.GEMSTONE_ENABLE = param1.GEMSTONE.@enable != "false";
         }
         if(param1.IS_DUO_WAN_SDK_INTERFACE != null && param1.IS_DUO_WAN_SDK_INTERFACE.hasOwnProperty("@value"))
         {
            _loc12_.IS_DUO_WAN_SDK_INTERFACE = param1.IS_DUO_WAN_SDK_INTERFACE.@value == "true";
         }
         if(StringUtils.trim(param1.DUNGEON_OPENLIST.@advancedEnable) != "")
         {
            _loc12_.ADVANCED_ENABLE = param1.DUNGEON_OPENLIST.@advancedEnable != "false";
         }
         if(StringUtils.trim(param1.DUNGEON_OPENLIST.@epicLevelEnable) != "")
         {
            _loc12_.EPICLEVEL_ENABLE = param1.DUNGEON_OPENLIST.@epicLevelEnable != "false";
         }
         if(StringUtils.trim(param1.DUNGEON_OPENLIST.@footballEnable) != "")
         {
            _loc12_.FOOTBALL_ENABLE = param1.DUNGEON_OPENLIST.@footballEnable != "false";
         }
         if(param1.PK_BTN.hasOwnProperty("@enable"))
         {
            _loc12_.PK_BTN = param1.PK_BTN.@enable == "true";
         }
         if(param1.SUIT.hasOwnProperty("@enable"))
         {
            _loc12_.SUIT_ENABLE = param1.SUIT.@enable != "false";
         }
         if(param1.PETS_EAT != null && param1.PETS_EAT.hasOwnProperty("@enable"))
         {
            _loc12_.PETS_EAT = param1.PETS_EAT.@enable == "true";
         }
         if(param1.MAGICHOUSE != null && param1.MAGICHOUSE.hasOwnProperty("@enable"))
         {
            _loc12_.MAGICHOUSE = param1.MAGICHOUSE.@enable != "false";
         }
         if(param1.GODSYAH.hasOwnProperty("@enable"))
         {
            _loc12_.GODSYAH_ENABLE = param1.GODSYAH.@enable == "true";
         }
         if(param1.GIRDATTEST.hasOwnProperty("@enable"))
         {
            _loc12_.GIRDATTEST = param1.GIRDATTEST.@enable != "false";
         }
         if(param1.FIGHT_TIME != null && param1.FIGHT_TIME.hasOwnProperty("@count"))
         {
            _loc12_.FIGHT_TIME = param1.FIGHT_TIME.@count;
         }
         if(param1.GIRLHEAD.hasOwnProperty("@enable"))
         {
            _loc12_.GIRLHEAD = param1.GIRLHEAD.@enable != "false";
         }
         if(param1.TRUSTEESHIPVIEW != null && param1.TRUSTEESHIPVIEW.hasOwnProperty("@enable"))
         {
            _loc12_.TRUSTEESHIPVIEW = param1.TRUSTEESHIPVIEW.@enable != "false";
         }
         if(param1.LOGIN_DEVICE != null)
         {
            _loc12_.LOGINDEVICE_LINK = param1.LOGIN_DEVICE.@link;
         }
         if(param1.PLAYERTRANSFER.hasOwnProperty("@enable"))
         {
            _loc12_.PLAYERTRANSFER = param1.PLAYERTRANSFER.@enable == "true";
            _loc12_.PLAYERTRANSFER_LINK = param1.PLAYERTRANSFER.@link;
         }
         if(param1.BEAUTY_PROVE_QQ && param1.BEAUTY_PROVE_QQ.hasOwnProperty("@value"))
         {
            _loc12_.BEAUTY_PROVE_QQ = String(param1.BEAUTY_PROVE_QQ.@value);
         }
         PathManager.setup(_loc12_);
      }
   }
}
