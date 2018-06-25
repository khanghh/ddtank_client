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
      
      public static function paras(config:XML, loaderInfo:LoaderInfo, username:String) : void
      {
         var notification:* = null;
         var grade:* = null;
         var site:* = null;
         var pathInfo:PathInfo = new PathInfo();
         pathInfo.SITEII = String(loaderInfo.parameters["site"]);
         if(pathInfo.SITEII == "undefined")
         {
            pathInfo.SITEII = "";
         }
         var _loc13_:* = config.SITE.@value;
         BonesLoaderManager.SITE_MAIN = _loc13_;
         pathInfo.SITE = _loc13_;
         pathInfo.WEEKLY_SITE = config.WEEKLYSITE.@value;
         pathInfo.BACKUP_FLASHSITE = config.BACKUP_FLASHSITE.@value;
         _loc13_ = config.FLASHSITE.@value;
         BonesLoaderManager.FLASHSITE = _loc13_;
         pathInfo.FLASHSITE = _loc13_;
         pathInfo.RECORD_PATH = config.RECORD_PATH.@value;
         pathInfo.COMMUNITY_FRIEND_PATH = config.COMMUNITY_FRIEND_PATH.@value;
         if(config.COMMUNITY_MICROBLOG.hasOwnProperty("@value"))
         {
            pathInfo.COMMUNITY_MICROBLOG = StringUtils.converBoolean(config.COMMUNITY_MICROBLOG.@value);
         }
         if(config.COMMUNITY_SINA_SECOND_MICROBLOG.hasOwnProperty("@value"))
         {
            pathInfo.COMMUNITY_SINA_SECOND_MICROBLOG = StringUtils.converBoolean(config.COMMUNITY_SINA_SECOND_MICROBLOG.@value);
         }
         if(config.COMMUNITY_FRIEND_PATH.hasOwnProperty("@isUser"))
         {
            PathInfo.isUserAddFriend = StringUtils.converBoolean(config.COMMUNITY_FRIEND_PATH.@isUser);
         }
         pathInfo.USER_NAME = username;
         pathInfo.STYLE_PATH = config.STYLE_PATH.@value;
         pathInfo.FIRSTPAGE = config.FIRSTPAGE.@value;
         pathInfo.REGISTER = config.REGISTER.@value;
         pathInfo.REQUEST_PATH = config.REQUEST_PATH.@value;
         pathInfo.FILL_PATH = String(config.FILL_PATH.@value).replace("{user}",username);
         pathInfo.FILL_PATH = pathInfo.FILL_PATH.replace("{site}",pathInfo.SITEII);
         pathInfo.LOGIN_PATH = String(config.LOGIN_PATH.@value).replace("{user}",username);
         pathInfo.LOGIN_PATH = pathInfo.LOGIN_PATH.replace("{site}",pathInfo.SITEII);
         pathInfo.OFFICIAL_SITE = config.OFFICIAL_SITE.@value;
         pathInfo.GAME_FORUM = config.GAME_FORUM.@value;
         pathInfo.LITTLEGAMEMINLV = config.LITTLEGAMEMINLV.@value;
         pathInfo.BOMBKing_KILL_CHEAT = StringUtils.converBoolean(config.BOMBKing_KILL_CHEAT.@value);
         if(config.LOGIN_PATH.hasOwnProperty("@siteName"))
         {
            StatisticManager.siteName = config.LOGIN_PATH.@siteName;
         }
         pathInfo.TRAINER_STANDALONE = String(config.TRAINER_STANDALONE.@value) == "false"?false:true;
         pathInfo.TRAINER_PATH = config.TRAINER_PATH.@value;
         pathInfo.COUNT_PATH = config.COUNT_PATH.@value;
         pathInfo.PARTER_ID = config.PARTER_ID.@value;
         if(!config.STATISTIC.hasOwnProperty("@value"))
         {
         }
         var sucideTime:int = config.SUCIDE_TIME.@value;
         if(sucideTime > 0)
         {
            PathInfo.SUCIDE_TIME = sucideTime * 1000;
         }
         var boxStyle:int = config.BOX_STYLE.@value;
         if(boxStyle != 0)
         {
         }
         pathInfo.PHP_PATH = config.PHP.@site;
         if(config.PHP.hasOwnProperty("@link"))
         {
            pathInfo.PHP_IMAGE_LINK = StringUtils.converBoolean(config.PHP.@link);
         }
         pathInfo.WEB_PLAYER_INFO_PATH = config.PHP.@infoPath;
         if(config.PHP.hasOwnProperty("@isShow"))
         {
            PlayerManager.isShowPHP = StringUtils.converBoolean(config.PHP.@isShow);
         }
         if(config.PHP.hasOwnProperty("@link"))
         {
            pathInfo.PHP_IMAGE_LINK = StringUtils.converBoolean(config.PHP.@link);
         }
         PathInfo.MUSIC_LIST = String(config.MUSIC_LIST.@value).split(",");
         PathInfo.LANGUAGE = String(config.LANGUAGE.@value);
         var list:XMLList = config.POLICY_FILES.file;
         var _loc15_:int = 0;
         var _loc14_:* = list;
         for each(var f in list)
         {
            Security.loadPolicyFile(f.@value);
         }
         if(config.GAME_BOXPIC.hasOwnProperty("@value"))
         {
            PathInfo.GAME_BOXPIC = config.GAME_BOXPIC.@value;
         }
         if(config.ISTOPDERIICT.hasOwnProperty("@value"))
         {
            PathInfo.ISTOPDERIICT = StringUtils.converBoolean(config.ISTOPDERIICT.@value);
         }
         pathInfo.COMMUNITY_INVITE_PATH = config.COMMUNITY_INVITE_PATH.@value;
         pathInfo.MICROCOBOL_PATH = config.COMMUNITY_FRIEND_LIST_PATH.@microcobolPath;
         if(config.COMMUNITY_FRIEND_LIST_PATH.hasOwnProperty("@isexistBtnVisble"))
         {
            pathInfo.IS_VISIBLE_EXISTBTN = StringUtils.converBoolean(config.COMMUNITY_FRIEND_LIST_PATH.@isexistBtnVisble);
         }
         pathInfo.ALLOW_POPUP_FAVORITE = String(config.ALLOW_POPUP_FAVORITE.@value) == "true"?true:false;
         if(config.FILL_JS_COMMAND.hasOwnProperty("@enable"))
         {
            pathInfo.FILL_JS_COMMAND_ENABLE = StringUtils.converBoolean(config.FILL_JS_COMMAND.@enable);
         }
         if(config.FILL_JS_COMMAND.hasOwnProperty("@value"))
         {
            pathInfo.FILL_JS_COMMAND_VALUE = config.FILL_JS_COMMAND.@value;
         }
         if(config.MINLEVELDUPLICATE.hasOwnProperty("@value"))
         {
            GameManager.MinLevelDuplicate = config.MINLEVELDUPLICATE.@value;
         }
         pathInfo.FIGHTLIB_ENABLE = StringUtils.converBoolean(config.FIGHTLIB.@value);
         if(config.MODULE != null && config.MODULE.SPA != null && config.MODULE.SPA.hasOwnProperty("@enable"))
         {
            pathInfo.SPA_ENABLE = config.MODULE.SPA.@enable != "false";
         }
         if(config.MODULE != null && config.MODULE.CIVIL != null && config.MODULE.CIVIL.hasOwnProperty("@enable"))
         {
            pathInfo.CIVIL_ENABLE = config.MODULE.CIVIL.@enable != "false";
         }
         if(config.MODULE != null && config.MODULE.CHURCH != null && config.MODULE.CHURCH.hasOwnProperty("@enable"))
         {
            pathInfo.CHURCH_ENABLE = config.MODULE.CHURCH.@enable != "false";
         }
         if(config.MODULE != null && config.MODULE.WEEKLY != null && config.MODULE.WEEKLY.hasOwnProperty("@enable"))
         {
            pathInfo.WEEKLY_ENABLE = config.MODULE.WEEKLY.@enable != "false";
         }
         if(config.FORTH_ENABLE.hasOwnProperty("@value"))
         {
            pathInfo.FORTH_ENABLE = config.FORTH_ENABLE.@value != "false";
         }
         if(config.STHRENTH_MAX.hasOwnProperty("@value"))
         {
            pathInfo.STHRENTH_MAX = int(config.STHRENTH_MAX.@value);
         }
         if(config.USER_GUILD_ENABLE.hasOwnProperty("@value"))
         {
            pathInfo.USER_GUILD_ENABLE = StringUtils.converBoolean(config.USER_GUILD_ENABLE.@value);
         }
         if(config.ACHIEVE_ENABLE.hasOwnProperty("@value"))
         {
            pathInfo.ACHIEVE_ENABLE = config.ACHIEVE_ENABLE.@value != "false";
         }
         if(config.CHAT_FACE != null && config.CHAT_FACE.DISABLED_LIST != null && config.CHAT_FACE.DISABLED_LIST.hasOwnProperty("@list"))
         {
            pathInfo.CHAT_FACE_DISABLED_LIST = String(config.CHAT_FACE.DISABLED_LIST.@list).split(",");
         }
         if(config.STATISTICS.hasOwnProperty("@enable"))
         {
            pathInfo.STATISTICS = config.STATISTICS.@enable != "false";
         }
         if(config.USER_GUIDE.hasOwnProperty("@value") || true)
         {
         }
         if(config.GAME_FRAME_CONFIG != null && config.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG != null && config.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG.hasOwnProperty("@value"))
         {
            pathInfo.FRAME_TIME_OVER_TAG = int(config.GAME_FRAME_CONFIG.FRAME_TIME_OVER_TAG.@value);
         }
         if(config.GAME_FRAME_CONFIG != null && config.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG != null && config.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG.hasOwnProperty("@value"))
         {
            pathInfo.FRAME_OVER_COUNT_TAG = int(config.GAME_FRAME_CONFIG.FRAME_OVER_COUNT_TAG.@value);
         }
         if(config.EXTERNAL_INTERFACE_360 != null && config.EXTERNAL_INTERFACE_360.hasOwnProperty("@value"))
         {
            pathInfo.EXTERNAL_INTERFACE_PATH_360 = String(config.EXTERNAL_INTERFACE_360.@value);
         }
         if(config.EXTERNAL_INTERFACE_360 != null && config.EXTERNAL_INTERFACE_360.hasOwnProperty("@enable"))
         {
            pathInfo.EXTERNAL_INTERFACE_ENABLE_360 = config.EXTERNAL_INTERFACE_360.@enable != "false";
         }
         if(config.GRADE_NOTIFICATION != null && config.GRADE_NOTIFICATION.NOTIFICATION != null)
         {
            notification = config.GRADE_NOTIFICATION.NOTIFICATION;
            var _loc17_:int = 0;
            var _loc16_:* = notification;
            for each(var noti in notification)
            {
               if(!(!noti.hasOwnProperty("@grade") || !noti.hasOwnProperty("@site")))
               {
                  grade = noti.@grade;
                  site = noti.@site;
                  if(!(grade == "" || site == ""))
                  {
                     pathInfo.GRADE_NOTIFICATION[grade] = site;
                  }
               }
            }
         }
         if(config.CALL_PATH != null && config.CALL_PATH.hasOwnProperty("@value"))
         {
            pathInfo.CALL_LOGIN_INTERFAECE = config.CALL_PATH.@value;
         }
         if(config.USER_ACTION_NOTICE != null && config.USER_ACTION_NOTICE.hasOwnProperty("@value"))
         {
            pathInfo.USER_ACTION_NOTICE = config.USER_ACTION_NOTICE.@value;
         }
         if(config.CALLBACK_INTERFACE != null && config.CALLBACK_INTERFACE.hasOwnProperty("@path"))
         {
            pathInfo.CALLBACK_INTERFACE_PATH = config.CALLBACK_INTERFACE.@path;
         }
         if(config.CALLBACK_INTERFACE != null && config.CALLBACK_INTERFACE.hasOwnProperty("@enable"))
         {
            pathInfo.CALLBACK_INTERFACE_ENABLE = config.CALLBACK_INTERFACE.@enable;
         }
         if(StringUtils.trim(config.DUNGEON_OPENLIST.@value) != "")
         {
            pathInfo.DUNGEON_OPENLIST = StringUtils.trim(config.DUNGEON_OPENLIST.@value).split(",");
         }
         if(config.DUO_WAN_YY_VIP != null && config.DUO_WAN_YY_VIP.hasOwnProperty("@value"))
         {
            YYVipManager.YY_VIP_TAG = int(config.DUO_WAN_YY_VIP.@value);
         }
         if(config.DUO_WAN_YY_VIP_OPEN_URL != null && config.DUO_WAN_YY_VIP_OPEN_URL.hasOwnProperty("@value"))
         {
            YYVipManager.VIP_OPEN_URL = config.DUO_WAN_YY_VIP_OPEN_URL.@value;
         }
         if(config.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW != null && config.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW.hasOwnProperty("@value"))
         {
            YYVipManager.YY_VIP_SHOW_OPEN_VIEW = config.DUO_WAN_YY_VIP_SHOW_OPEN_VIEW.@value;
         }
         if(config.LOCK_SETTING != null && config.LOCK_SETTING.hasOwnProperty("@value"))
         {
            BaglockedManager.LOCK_SETTING = config.LOCK_SETTING.@value;
         }
         if(config.GAME_CAN_NOT_EXIT_SEND_LOG != null && config.GAME_CAN_NOT_EXIT_SEND_LOG.hasOwnProperty("@value"))
         {
            GameManager.GAME_CAN_NOT_EXIT_SEND_LOG = config.GAME_CAN_NOT_EXIT_SEND_LOG.@value;
         }
         if(config.IS_SEND_RECORDUSERVERSION != null && config.IS_SEND_RECORDUSERVERSION.hasOwnProperty("@value"))
         {
            pathInfo.IS_SEND_RECORDUSERVERSION = config.IS_SEND_RECORDUSERVERSION.@value == "true";
         }
         if(config.IS_SEND_FLASHINFO != null && config.IS_SEND_FLASHINFO.hasOwnProperty("@value"))
         {
            pathInfo.IS_SEND_FLASHINFO = config.IS_SEND_FLASHINFO.@value == "true";
         }
         if(config.FLASH_P2P != null)
         {
            if(config.FLASH_P2P.hasOwnProperty("@ebable"))
            {
               pathInfo.FLASH_P2P_EBABLE = config.FLASH_P2P.@ebable == "true";
            }
            if(config.FLASH_P2P.hasOwnProperty("@key"))
            {
               pathInfo.FLASH_P2P_KEY = config.FLASH_P2P.@key;
            }
            if(config.FLASH_P2P.hasOwnProperty("@url"))
            {
               pathInfo.FLASH_P2P_CIRRUS_URL = config.FLASH_P2P.@url;
            }
         }
         if(config.TREASURE.hasOwnProperty("@enable"))
         {
            pathInfo.TREASURE = config.TREASURE.@enable != "false";
            pathInfo.TREASUREHELPTIMES = int(config.TREASURE.@times);
         }
         else
         {
            pathInfo.TREASURE = true;
            pathInfo.TREASUREHELPTIMES = 5;
         }
         if(config.GEMSTONE.hasOwnProperty("@enable"))
         {
            pathInfo.GEMSTONE_ENABLE = config.GEMSTONE.@enable != "false";
         }
         if(config.IS_DUO_WAN_SDK_INTERFACE != null && config.IS_DUO_WAN_SDK_INTERFACE.hasOwnProperty("@value"))
         {
            pathInfo.IS_DUO_WAN_SDK_INTERFACE = config.IS_DUO_WAN_SDK_INTERFACE.@value == "true";
         }
         if(StringUtils.trim(config.DUNGEON_OPENLIST.@advancedEnable) != "")
         {
            pathInfo.ADVANCED_ENABLE = config.DUNGEON_OPENLIST.@advancedEnable != "false";
         }
         if(StringUtils.trim(config.DUNGEON_OPENLIST.@epicLevelEnable) != "")
         {
            pathInfo.EPICLEVEL_ENABLE = config.DUNGEON_OPENLIST.@epicLevelEnable != "false";
         }
         if(StringUtils.trim(config.DUNGEON_OPENLIST.@footballEnable) != "")
         {
            pathInfo.FOOTBALL_ENABLE = config.DUNGEON_OPENLIST.@footballEnable != "false";
         }
         if(config.PK_BTN.hasOwnProperty("@enable"))
         {
            pathInfo.PK_BTN = config.PK_BTN.@enable == "true";
         }
         if(config.SUIT.hasOwnProperty("@enable"))
         {
            pathInfo.SUIT_ENABLE = config.SUIT.@enable != "false";
         }
         if(config.PETS_EAT != null && config.PETS_EAT.hasOwnProperty("@enable"))
         {
            pathInfo.PETS_EAT = config.PETS_EAT.@enable == "true";
         }
         if(config.MAGICHOUSE != null && config.MAGICHOUSE.hasOwnProperty("@enable"))
         {
            pathInfo.MAGICHOUSE = config.MAGICHOUSE.@enable != "false";
         }
         if(config.GODSYAH.hasOwnProperty("@enable"))
         {
            pathInfo.GODSYAH_ENABLE = config.GODSYAH.@enable == "true";
         }
         if(config.GIRDATTEST.hasOwnProperty("@enable"))
         {
            pathInfo.GIRDATTEST = config.GIRDATTEST.@enable != "false";
         }
         if(config.FIGHT_TIME != null && config.FIGHT_TIME.hasOwnProperty("@count"))
         {
            pathInfo.FIGHT_TIME = config.FIGHT_TIME.@count;
         }
         if(config.GIRLHEAD.hasOwnProperty("@enable"))
         {
            pathInfo.GIRLHEAD = config.GIRLHEAD.@enable != "false";
         }
         if(config.TRUSTEESHIPVIEW != null && config.TRUSTEESHIPVIEW.hasOwnProperty("@enable"))
         {
            pathInfo.TRUSTEESHIPVIEW = config.TRUSTEESHIPVIEW.@enable != "false";
         }
         if(config.LOGIN_DEVICE != null)
         {
            pathInfo.LOGINDEVICE_LINK = config.LOGIN_DEVICE.@link;
         }
         if(config.PLAYERTRANSFER.hasOwnProperty("@enable"))
         {
            pathInfo.PLAYERTRANSFER = config.PLAYERTRANSFER.@enable == "true";
            pathInfo.PLAYERTRANSFER_LINK = config.PLAYERTRANSFER.@link;
         }
         if(config.BEAUTY_PROVE_QQ && config.BEAUTY_PROVE_QQ.hasOwnProperty("@value"))
         {
            pathInfo.BEAUTY_PROVE_QQ = String(config.BEAUTY_PROVE_QQ.@value);
         }
         if(config.OLDPLAYER_TRANSFER_SERVER.hasOwnProperty("@enable"))
         {
            pathInfo.OLDPLAYER_TRANSFER = config.OLDPLAYER_TRANSFER_SERVER.@enable == "true";
         }
         PathManager.setup(pathInfo);
      }
   }
}
