package ddt.manager
{
   import ddt.data.EquipType;
   import ddt.data.PathInfo;
   
   public class PathManager
   {
      
      private static var info:PathInfo;
      
      public static var SITE_MAIN:String = "";
      
      public static var SITE_WEEKLY:String = "";
       
      
      public function PathManager()
      {
         super();
      }
      
      public static function setup(param1:PathInfo) : void
      {
         info = param1;
         SITE_MAIN = info.SITE;
         SITE_WEEKLY = info.WEEKLY_SITE;
      }
      
      public static function getPathInfo() : PathInfo
      {
         return info;
      }
      
      public static function solvePhpPath() : String
      {
         return info.PHP_PATH;
      }
      
      public static function userName() : String
      {
         return info.USER_NAME;
      }
      
      public static function getRequest_path() : String
      {
         return info.REQUEST_PATH;
      }
      
      public static function solveOfficialSitePath() : String
      {
         info.OFFICIAL_SITE = info.OFFICIAL_SITE.replace("{uid}",PlayerManager.Instance.Self.ID);
         return info.OFFICIAL_SITE;
      }
      
      public static function solveGameForum() : String
      {
         info.GAME_FORUM = info.GAME_FORUM.replace("{uid}",PlayerManager.Instance.Self.ID);
         return info.GAME_FORUM;
      }
      
      public static function get solveCommunityFriend() : String
      {
         var _loc1_:String = info.COMMUNITY_FRIEND_PATH;
         return _loc1_;
      }
      
      public static function solveClientDownloadPath() : String
      {
         return info.CLIENT_DOWNLOAD;
      }
      
      public static function solveWebPlayerInfoPath(param1:String, param2:String = "", param3:String = "") : String
      {
         var _loc4_:String = info.WEB_PLAYER_INFO_PATH.replace("{uid}",param1);
         _loc4_ = _loc4_.replace("{code}",param2);
         _loc4_ = _loc4_.replace("{key}",param3);
         return _loc4_;
      }
      
      public static function solveFlvSound(param1:String) : String
      {
         return info.SITE + "sound/" + param1 + ".flv";
      }
      
      public static function solveFirstPage() : String
      {
         return info.FIRSTPAGE;
      }
      
      public static function solveRegister() : String
      {
         return info.REGISTER;
      }
      
      public static function solveLogin() : String
      {
         info.LOGIN_PATH = info.LOGIN_PATH.replace("{nickName}",PlayerManager.Instance.Self.NickName);
         info.LOGIN_PATH = info.LOGIN_PATH.replace("{uid}",PlayerManager.Instance.Self.ID);
         return info.LOGIN_PATH;
      }
      
      public static function solveConfigSite() : String
      {
         return info.SITEII;
      }
      
      public static function solveFillPage() : String
      {
         info.FILL_PATH = info.FILL_PATH.replace("{nickName}",PlayerManager.Instance.Self.NickName);
         info.FILL_PATH = info.FILL_PATH.replace("{uid}",PlayerManager.Instance.Self.ID);
         return info.FILL_PATH;
      }
      
      public static function solveLoginPHP(param1:String) : String
      {
         return info.PHP_PATH.replace("{id}",param1);
      }
      
      public static function checkOpenPHP() : Boolean
      {
         return info.PHP_IMAGE_LINK;
      }
      
      public static function solveTrainerPage() : String
      {
         return info.TRAINER_PATH;
      }
      
      public static function solveWeeklyPath(param1:String) : String
      {
         return info.WEEKLY_SITE + "weekly/" + param1;
      }
      
      public static function solveMapPath(param1:int, param2:String, param3:String) : String
      {
         return info.SITE + "image/map/" + param1.toString() + "/" + param2 + "." + param3;
      }
      
      public static function solveMapSmallView(param1:int) : String
      {
         return info.SITE + "image/map/" + param1.toString() + "/small.png";
      }
      
      public static function solveRequestPath(param1:String = "") : String
      {
         return info.REQUEST_PATH + param1;
      }
      
      public static function solvePropPath(param1:String) : String
      {
         return info.SITE + "image/tool/" + param1 + ".png";
      }
      
      public static function solveMapIconPath(param1:int, param2:int, param3:String = "show1.jpg") : String
      {
         var _loc4_:String = "";
         if(param2 == 0)
         {
            _loc4_ = info.SITE + "image/map/" + param1.toString() + "/icon.png";
         }
         else if(param2 == 1)
         {
            _loc4_ = info.SITE + "image/map/" + param1.toString() + "/samll_map.png";
         }
         else if(param2 == 2)
         {
            _loc4_ = info.SITE + "image/map/" + param1.toString() + "/" + param3;
         }
         else if(param2 == 3)
         {
            _loc4_ = info.SITE + "image/map/" + param1.toString() + "/samll_map_s.jpg";
         }
         return _loc4_;
      }
      
      public static function solveEffortIconPath(param1:String) : String
      {
         var _loc2_:String = "";
         _loc2_ = info.SITE + "image/effort/" + param1 + "/icon.png";
         return _loc2_;
      }
      
      public static function solveFieldPlantPath(param1:String, param2:int) : String
      {
         return info.SITE + "image/farm/Crops/" + param1 + "/crop" + param2 + ".png";
      }
      
      public static function solveSeedPath(param1:String) : String
      {
         return info.SITE + "image/farm/Crops/" + param1 + "/seed.png";
      }
      
      public static function solveCountPath() : String
      {
         return info.COUNT_PATH;
      }
      
      public static function solveParterId() : String
      {
         return info.PARTER_ID;
      }
      
      public static function solveStylePath(param1:Boolean, param2:String, param3:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!param1?"m":"f") + "/" + param2 + "/" + param3 + ".png";
      }
      
      public static function solveArmPath(param1:String, param2:String) : String
      {
         return info.SITE + info.STYLE_PATH + String(param1) + "/" + param2 + ".png";
      }
      
      public static function solveGoodsPath(param1:Number, param2:String, param3:Boolean = true, param4:String = "show", param5:String = "A", param6:String = "1", param7:int = 1, param8:Boolean = false, param9:int = 0, param10:String = "") : String
      {
         var _loc17_:* = null;
         var _loc14_:String = "";
         var _loc15_:String = "";
         var _loc16_:String = "";
         var _loc12_:String = "";
         var _loc18_:String = "";
         var _loc11_:String = "";
         var _loc13_:String = "";
         var _loc19_:String = param4 + ".png";
         if(param2 == "item4")
         {
            _loc17_ = "";
         }
         if(param1 == 7 || param1 == 27 || param1 == 64)
         {
            _loc13_ = "/1";
            _loc14_ = "arm/";
            if(param4.indexOf("icon") == -1)
            {
               _loc12_ = !!param8?"/1":"/0";
            }
            return info.SITE + "image/arm/" + param2 + _loc13_ + _loc12_ + "/" + _loc19_;
         }
         if(param1 == 24 || param1 == 11 || param1 == 65 || param1 == 68 || param1 == 69 || param1 == 72)
         {
            return info.SITE + "image/unfrightprop/" + param2 + "/" + _loc19_;
         }
         if(param1 == 12)
         {
            return info.SITE + "image/task/" + param2 + "/icon.png";
         }
         if(param1 == 16)
         {
            return info.SITE + "image/specialprop/chatBall/" + param2 + "/icon.png";
         }
         if(param1 < 10 || param1 == 13 || param1 == 14 || param1 == 28 || param1 == 29)
         {
            if(param1 == 3)
            {
               if(param4.indexOf("icon") == -1)
               {
                  _loc18_ = "/" + param5;
               }
            }
            _loc14_ = "equip/";
            _loc16_ = EquipType.TYPES[param1] + "/";
            _loc15_ = !!param3?"m/":"f/";
            if(param1 != 8 && param1 != 9 && param1 != 14 && param1 != 28 && param1 != 29)
            {
               if(param4 == "icon")
               {
                  param4 = "icon_" + param6;
                  param6 = "";
               }
               else
               {
                  _loc11_ = "/" + param6;
               }
            }
            else
            {
               _loc15_ = "";
            }
            _loc19_ = param4 + param10 + ".png";
            return info.SITE + "image/" + _loc14_ + _loc15_ + _loc16_ + param2 + _loc11_ + _loc18_ + _loc13_ + _loc12_ + "/" + _loc19_;
         }
         if(param1 == 15)
         {
            return info.SITE + "image/equip/wing/" + param2 + "/" + _loc19_;
         }
         if(param1 == 17 || param1 == 31)
         {
            return info.SITE + "image/equip/offhand/" + param2 + "/icon.png";
         }
         if(param1 == 25)
         {
            return info.SITE + "image/gift/" + param2 + "/icon.png";
         }
         if(param1 == 26)
         {
            return info.SITE + "image/card/" + param2 + "/icon.jpg";
         }
         if(param1 == 18 || param1 == 66)
         {
            return info.SITE + "image/cardbox/" + param2 + "/icon.png";
         }
         if(param1 == 19)
         {
            return info.SITE + "image/equip/recover/" + param2 + "/icon.png";
         }
         if(param1 == 70)
         {
            return info.SITE + "image/equip/amulet/" + param2 + "/" + param10 + "/icon.png";
         }
         if(param1 == 20 || param1 == 53 || param1 == 23 || param1 == 30 || param1 == 40)
         {
            return info.SITE + "image/unfrightprop/" + param2 + "/icon.png";
         }
         if(param1 == 32 || param1 == 36)
         {
            return info.SITE + "image/farm/Crops/" + param2 + "/seed.png";
         }
         if(param1 == 33)
         {
            return info.SITE + "image/farm/Fertilizer/" + param2 + "/icon.png";
         }
         if(param1 == 34 || param1 == 35)
         {
            return info.SITE + "image/unfrightprop/" + param2 + "/icon.png";
         }
         if(param1 == 52)
         {
            return info.SITE + "image/petequip/cloth/" + param2 + "/icon.png";
         }
         if(param1 == 50)
         {
            return info.SITE + "image/petequip/arm/" + param2 + "/icon.png";
         }
         if(param1 == 51)
         {
            return info.SITE + "image/petequip/hat/" + param2 + "/icon.png";
         }
         if(param1 == 61 || param1 == 62 || param1 == 37)
         {
            return info.SITE + "image/unfrightprop/" + param2 + "/" + _loc19_;
         }
         if(param1 == 74)
         {
            return info.SITE + "image/rune/" + param2 + ".png";
         }
         return info.SITE + "image/prop/" + param2 + "/" + _loc19_;
      }
      
      public static function soloveWingPath(param1:String) : String
      {
         return info.SITE + "image/equip/wing/" + param1 + "/wings.swf";
      }
      
      public static function soloveSinpleLightPath(param1:String) : String
      {
         return info.SITE + "image/equip/sinplelight/" + param1 + ".swf";
      }
      
      public static function soloveCircleLightPath(param1:String) : String
      {
         return info.SITE + "image/equip/circlelight/" + param1 + ".swf";
      }
      
      public static function solveConsortiaIconPath(param1:String) : String
      {
         return info.SITE + "image/consortiaicon/" + param1 + ".png";
      }
      
      public static function solveConsortiaMapPath(param1:String) : String
      {
         return info.SITE + "image/consortiamap/" + param1 + ".png";
      }
      
      public static function solveWorldbossBuffPath() : String
      {
         return info.SITE + "image/worldboss/buff/";
      }
      
      public static function getDiceResource() : String
      {
         return info.SITE + "image/dice/";
      }
      
      public static function cellMovieClipSpecialEffectPath(param1:String) : String
      {
         return info.SITE + "image/cellEffect/lv" + param1 + ".swf";
      }
      
      public static function solveSceneCharacterLoaderPath(param1:Number, param2:String, param3:Boolean = true, param4:Boolean = true, param5:String = "1", param6:int = 1, param7:String = "") : String
      {
         var _loc8_:* = null;
         var _loc9_:* = param1;
         if(3 !== _loc9_)
         {
            if(4 !== _loc9_)
            {
               if(6 !== _loc9_)
               {
                  if(5 !== _loc9_)
                  {
                     return info.SITE + "image/virtual/" + (!!param4?"M":"F") + "/" + _loc8_ + "/" + param2 + "/" + param5 + ".png";
                  }
                  _loc8_ = param6 == 1?"clothF":param6 == 2?"cloth":"clothF";
                  param2 = param7;
                  if(param7 == "")
                  {
                     param2 = "default";
                  }
                  if(StateManager.currentStateType == "collectionTaskScene")
                  {
                     return info.SITE + "image/mounts/clothZ/" + (!!param3?"M":"F") + "/" + _loc8_ + "/1/" + param5 + ".png";
                  }
                  return info.SITE + "image/virtual/" + (!!param3?"M":"F") + "/" + _loc8_ + "/" + param2 + "/" + param5 + ".png";
               }
               _loc8_ = "face";
               return info.SITE + "image/virtual/" + (!!param4?"M":"F") + "/" + _loc8_ + "/" + param2 + "/" + param5 + ".png";
            }
            _loc8_ = "eff";
            return info.SITE + "image/virtual/" + (!!param4?"M":"F") + "/" + _loc8_ + "/" + param2 + "/" + param5 + ".png";
         }
         _loc8_ = "hair";
         return info.SITE + "image/virtual/" + (!!param4?"M":"F") + "/" + _loc8_ + "/" + param2 + "/" + param5 + ".png";
      }
      
      public static function solveLitteGameCharacterPath(param1:Number, param2:Boolean, param3:int, param4:int, param5:String = "") : String
      {
         var _loc8_:* = null;
         var _loc7_:String = info.SITE + "image/world/player/" + param3 + "/";
         var _loc6_:* = "";
         var _loc9_:* = param1;
         if(30 !== _loc9_)
         {
            if(6 !== _loc9_)
            {
               if(5 === _loc9_)
               {
                  _loc8_ = "body";
                  _loc6_ = "default";
                  return _loc7_ + (!!param2?"M":"F") + "/" + _loc8_ + "/" + _loc6_ + "/" + param4 + ".png";
               }
            }
            else
            {
               _loc8_ = "face";
               _loc6_ = param5;
               return _loc7_ + (!!param2?"M":"F") + "/" + _loc8_ + "/" + _loc6_ + "/" + param4 + ".png";
            }
         }
         else
         {
            _loc8_ = "effect";
            _loc6_ = "default";
         }
         return _loc7_ + (!!param2?"M":"F") + "/" + _loc8_ + "/" + _loc6_ + "/" + param4 + ".png";
      }
      
      public static function solveBlastPath(param1:String) : String
      {
         return info.SITE + "swf/blast.swf";
      }
      
      public static function solveStyleFullPath(param1:Boolean, param2:String, param3:String, param4:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!param1?"M":"F") + "/" + param2 + "/" + param3 + param4 + "/all.png";
      }
      
      public static function solveStyleHeadPath(param1:Boolean, param2:String, param3:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!param1?"M":"F") + "/" + param2 + "/" + param3 + "/head.png";
      }
      
      public static function solveStylePreviewPath(param1:Boolean, param2:String, param3:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!param1?"M":"F") + "/" + param2 + "/" + param3 + "/pre.png";
      }
      
      public static function solvePath(param1:String) : String
      {
         return info.SITE + param1;
      }
      
      public static function solveWeaponSkillSwf(param1:int) : String
      {
         return solveSkillSwf(param1);
      }
      
      public static function solveSkillSwf(param1:int) : String
      {
         return info.SITE + "image/skill/" + param1 + ".swf";
      }
      
      public static function solveBlastOut(param1:int) : String
      {
         return info.SITE + "image/bomb/blastOut/blastOut" + param1 + ".swf";
      }
      
      public static function solveBullet(param1:int) : String
      {
         return info.SITE + "image/bomb/bullet/bullet" + param1 + ".swf";
      }
      
      public static function solveParticle() : String
      {
         return info.SITE + "image/bomb/partical.xml";
      }
      
      public static function solveShape() : String
      {
         return info.SITE + "image/bome/shape.swf";
      }
      
      public static function solveCraterBrink(param1:int) : String
      {
         return info.SITE + "image/bomb/crater/" + param1 + "/craterBrink.png";
      }
      
      public static function solveCrater(param1:int) : String
      {
         return info.SITE + "image/bomb/crater/" + param1 + "/crater.png";
      }
      
      public static function solveBombSwf(param1:int) : String
      {
         return info.FLASHSITE + "bombs/" + param1 + ".swf";
      }
      
      public static function solveSoundSwf() : String
      {
         return info.FLASHSITE + "audio.swf";
      }
      
      public static function solveSoundSwf2() : String
      {
         return info.FLASHSITE + "audioii.swf";
      }
      
      public static function solveSoundSwf3() : String
      {
         return info.FLASHSITE + "audiolite.swf";
      }
      
      public static function solveSoundSwfBattle() : String
      {
         return info.FLASHSITE + "audiobattle.swf";
      }
      
      public static function solveParticalXml() : String
      {
         return info.FLASHSITE + "partical.xml";
      }
      
      public static function solveShapeSwf() : String
      {
         return info.FLASHSITE + "shape.swf";
      }
      
      public static function solveCatharineSwf() : String
      {
         return info.FLASHSITE + "Catharine.swf";
      }
      
      public static function solveChurchSceneSourcePath(param1:String) : String
      {
         return info.SITE + "image/church/scene/" + param1 + ".swf";
      }
      
      public static function solveGameLivingPath(param1:String) : String
      {
         var _loc2_:String = param1.split(".").join("/");
         return info.SITE + "image/" + _loc2_ + ".swf";
      }
      
      public static function solveWeeklyImagePath(param1:String) : String
      {
         return info.WEEKLY_SITE + "weekly/" + param1;
      }
      
      public static function solveNewHandBuild(param1:String) : String
      {
         return getUIPath() + "/img/trainer/" + param1.slice(0,param1.length - 3) + ".png";
      }
      
      public static function CommnuntyMicroBlog() : Boolean
      {
         return info.COMMUNITY_MICROBLOG;
      }
      
      public static function CommnuntySinaSecondMicroBlog() : Boolean
      {
         return info.COMMUNITY_SINA_SECOND_MICROBLOG;
      }
      
      public static function CommunityInvite() : String
      {
         return info.COMMUNITY_INVITE_PATH;
      }
      
      public static function CommunityFriendList() : String
      {
         return info.COMMUNITY_FRIEND_LIST_PATH;
      }
      
      public static function CommunityExist() : Boolean
      {
         return info.COMMUNITY_EXIST;
      }
      
      public static function CommunityFriendInvitedSwitch() : Boolean
      {
         return info.COMMUNITY_FRIEND_INVITED_SWITCH;
      }
      
      public static function CommunityFriendInvitedOnlineSwitch() : Boolean
      {
         return info.COMMUNITY_FRIEND_INVITED_ONLINE_SWITCH;
      }
      
      public static function isVisibleExistBtn() : Boolean
      {
         return info.IS_VISIBLE_EXISTBTN;
      }
      
      public static function getSnsPath() : String
      {
         return info.SNS_PATH;
      }
      
      public static function getMicrocobolPath() : String
      {
         return info.MICROCOBOL_PATH;
      }
      
      public static function CommunityIcon() : String
      {
         return "CMFriendIcon/icon.png";
      }
      
      public static function CommunitySinaWeibo(param1:String) : String
      {
         return info.SITE + param1;
      }
      
      public static function solveAllowPopupFavorite() : Boolean
      {
         return info.ALLOW_POPUP_FAVORITE;
      }
      
      public static function solveFillJSCommandEnable() : Boolean
      {
         return info.FILL_JS_COMMAND_ENABLE;
      }
      
      public static function solveFillJSCommandValue() : String
      {
         return info.FILL_JS_COMMAND_VALUE;
      }
      
      public static function solveServerListIndex() : int
      {
         return info.SERVERLISTINDEX;
      }
      
      public static function solveSPAEnable() : Boolean
      {
         return info.SPA_ENABLE;
      }
      
      public static function solveCivilEnable() : Boolean
      {
         return info.CIVIL_ENABLE;
      }
      
      public static function solveChurchEnable() : Boolean
      {
         return info.CHURCH_ENABLE;
      }
      
      public static function solveWeeklyEnable() : Boolean
      {
         return info.WEEKLY_ENABLE;
      }
      
      public static function solveAchieveEnable() : Boolean
      {
         return info.ACHIEVE_ENABLE;
      }
      
      public static function solveForthEnable() : Boolean
      {
         return info.FORTH_ENABLE;
      }
      
      public static function solveStrengthMax() : int
      {
         return info.STHRENTH_MAX;
      }
      
      public static function solveUserGuildEnable() : Boolean
      {
         return info.USER_GUILD_ENABLE;
      }
      
      public static function solveFrameTimeOverTag() : int
      {
         return info.FRAME_TIME_OVER_TAG;
      }
      
      public static function solveFrameOverCount() : int
      {
         return info.FRAME_OVER_COUNT_TAG;
      }
      
      public static function solveExternalInterfacePath() : String
      {
         return info.EXTERNAL_INTERFACE_PATH;
      }
      
      public static function ExternalInterface360Path() : String
      {
         return info.EXTERNAL_INTERFACE_PATH_360;
      }
      
      public static function ExternalInterface360Enabel() : Boolean
      {
         return info.EXTERNAL_INTERFACE_ENABLE_360;
      }
      
      public static function solveExternalInterfaceEnabel() : Boolean
      {
         return info.EXTERNAL_INTERFACE_ENABLE;
      }
      
      public static function solveFeedbackEnable() : Boolean
      {
         return info.FEEDBACK_ENABLE;
      }
      
      public static function solveFeedbackTelNumber() : String
      {
         return info.FEEDBACK_TEL_NUMBER;
      }
      
      public static function solveChatFaceDisabledList() : Array
      {
         return info.CHAT_FACE_DISABLED_LIST;
      }
      
      public static function solveASTPath(param1:String) : String
      {
         return info.SITE + "image/world/monster/" + param1 + ".png";
      }
      
      public static function solveLittleGameConfigPath(param1:int) : String
      {
         return info.SITE + "image/tilemap/" + param1 + "/map.bin";
      }
      
      public static function solveLittleGameResPath(param1:int) : String
      {
         return info.SITE + "image/world/map/" + param1 + "/scene.swf";
      }
      
      public static function solveLittleGameObjectPath(param1:String) : String
      {
         return info.SITE + "image/world/" + param1;
      }
      
      public static function solveLittleGameMapPreview(param1:int) : String
      {
         return info.SITE + "image/world/map/" + param1 + "/preview.jpg";
      }
      
      public static function solveBadgePath(param1:int) : String
      {
         return info.SITE + "image/badge/" + param1 + "/icon.png";
      }
      
      public static function solveLeagueRankPath(param1:int) : String
      {
         return info.SITE + "image/leagueRank/" + param1 + "/icon.png";
      }
      
      public static function getUIPath() : String
      {
         var _loc1_:String = info.FLASHSITE + "ui/" + PathInfo.LANGUAGE;
         return _loc1_;
      }
      
      public static function get advancedEnable() : Boolean
      {
         return info.ADVANCED_ENABLE;
      }
      
      public static function getCustomResPath() : String
      {
         var _loc1_:String = getUIPath() + "/customres/";
         return _loc1_;
      }
      
      public static function getBackUpUIPath() : String
      {
         return info.BACKUP_FLASHSITE;
      }
      
      public static function getUIConfigPath(param1:String) : String
      {
         return getUIPath() + "/xml/" + param1 + ".xml";
      }
      
      public static function getLanguagePath() : String
      {
         return getUIPath() + "/" + "language.png";
      }
      
      public static function getBraveDoorDuplicateTemplete(param1:String) : String
      {
         return getCustomResPath() + param1 + ".xml";
      }
      
      public static function getBonesPath(param1:String) : String
      {
         return getUIPath() + "/bones/" + param1 + ".xml";
      }
      
      public static function getGameBonesPath() : String
      {
         return info.FLASHSITE + "gamebones.xml";
      }
      
      public static function getMovingNotificationPath() : String
      {
         return getUIPath() + "/" + "movingNotification.txt";
      }
      
      public static function getLevelRewardPath() : String
      {
         return getUIPath() + "/" + "levelReward.xml";
      }
      
      public static function getExpressionPath() : String
      {
         return getUIPath() + "/swf/" + "expression.swf";
      }
      
      public static function getZhanPath() : String
      {
         return getUIPath() + "/" + "zhanCode.txt";
      }
      
      public static function getCardXMLPath(param1:String) : String
      {
         return param1;
      }
      
      public static function getFightAchieveEnable() : Boolean
      {
         return true;
      }
      
      public static function getFightLibEanble() : Boolean
      {
         return info.FIGHTLIB_ENABLE;
      }
      
      public static function getMonsterPath() : String
      {
         return "monster.swf";
      }
      
      public static function get FLASHSITE() : String
      {
         return info != null?info.FLASHSITE:null;
      }
      
      public static function get TRAINER_STANDALONE() : Boolean
      {
         return info != null && info.TRAINER_STANDALONE;
      }
      
      public static function get isStatistics() : Boolean
      {
         return info.STATISTICS;
      }
      
      public static function get DISABLE_TASK_ID() : Array
      {
         var _loc1_:Array = [];
         if(info == null)
         {
            return _loc1_;
         }
         _loc1_ = info.DISABLE_TASK_ID.split(",");
         return _loc1_;
      }
      
      public static function get LittleGameMinLv() : int
      {
         return info.LITTLEGAMEMINLV;
      }
      
      public static function get solveDungeonOpenList() : Array
      {
         return info.DUNGEON_OPENLIST;
      }
      
      public static function get treasureSwitch() : Boolean
      {
         return info.TREASURE;
      }
      
      public static function get treasureHelpTimes() : int
      {
         return info.TREASUREHELPTIMES;
      }
      
      public static function solvePetGameAssetUrl(param1:String) : String
      {
         return info.SITE + "image/gameasset/" + param1 + ".swf";
      }
      
      public static function getWeatherUrl(param1:int) : String
      {
         return info.SITE + "image/weather/" + param1 + "/1.swf";
      }
      
      public static function solvePetFarmAssetUrl(param1:String) : String
      {
         return info.SITE + "image/" + param1 + ".swf";
      }
      
      public static function solveSkillPicUrl(param1:String) : String
      {
         return info.SITE + "image/petskill/" + param1 + "/icon.png";
      }
      
      public static function solvePetSkillEffect(param1:String) : String
      {
         return info.SITE + "image/skilleffect/" + param1 + ".swf";
      }
      
      public static function solvePetBuff(param1:String) : String
      {
         return info.SITE + "image/buff/" + param1 + "/icon.png";
      }
      
      public static function solvePetIconUrl(param1:String) : String
      {
         return info.SITE + "image/pet/" + param1 + ".png";
      }
      
      public static function solveGradeNotificationPath(param1:int) : String
      {
         return info.GRADE_NOTIFICATION[param1.toString()];
      }
      
      public static function solveWorldBossMapSourcePath(param1:String) : String
      {
         return getUIPath() + "/" + "Map02.swf";
      }
      
      public static function callLoginInterface() : String
      {
         return info.CALL_LOGIN_INTERFAECE;
      }
      
      public static function userActionNotice() : String
      {
         return info.USER_ACTION_NOTICE;
      }
      
      public static function get suitEnable() : Boolean
      {
         return info.SUIT_ENABLE;
      }
      
      public static function callBackInterfacePath() : String
      {
         return info.CALLBACK_INTERFACE_PATH;
      }
      
      public static function callBackEnable() : Boolean
      {
         return info.CALLBACK_INTERFACE_ENABLE;
      }
      
      public static function solveChristmasMonsterPath(param1:String) : String
      {
         return info.SITE + "image/scene/christmas/monsters/" + param1 + ".swf";
      }
      
      public static function solveCollectionTaskSceneSourcePath(param1:String) : String
      {
         return info.SITE + "image/collectiontask/" + param1 + ".swf";
      }
      
      public static function get isSendRecordUserVersion() : Boolean
      {
         if(info.IS_SEND_RECORDUSERVERSION)
         {
            return info.IS_SEND_RECORDUSERVERSION;
         }
         return false;
      }
      
      public static function get isSendFlashInfo() : Boolean
      {
         if(info.IS_SEND_FLASHINFO)
         {
            return info.IS_SEND_FLASHINFO;
         }
         return false;
      }
      
      public static function getParticlesPath() : String
      {
         return info.FLASHSITE + "particales/particales.xml";
      }
      
      public static function get isDuoWanSDKInterface() : Boolean
      {
         if(info.IS_DUO_WAN_SDK_INTERFACE)
         {
            return info.IS_DUO_WAN_SDK_INTERFACE;
         }
         return false;
      }
      
      public static function get flashP2PEbable() : Boolean
      {
         return info.FLASH_P2P_EBABLE;
      }
      
      public static function get flashP2PKey() : String
      {
         return info.FLASH_P2P_KEY;
      }
      
      public static function get flashP2PCirrusUrl() : String
      {
         return info.FLASH_P2P_CIRRUS_URL;
      }
      
      public static function get footballEnable() : Boolean
      {
         return info.FOOTBALL_ENABLE;
      }
      
      public static function petsFormPath(param1:String, param2:int) : String
      {
         return info.SITE + "image/pet/" + param1 + "/icon" + param2 + ".png";
      }
      
      public static function petsAnimationPath(param1:String) : String
      {
         return info.SITE + "image/game/living/" + param1 + ".swf";
      }
      
      public static function solveFurniturePath(param1:String, param2:String) : String
      {
         if(param1 == "floor")
         {
            return info.SITE + "image/house/" + param1 + "/" + param2 + ".jpg";
         }
         if(param1 == "wall")
         {
            return info.SITE + "image/house/" + param1 + "/" + param2 + ".png";
         }
         return info.SITE + "image/house/" + param1 + "/" + param2 + ".swf";
      }
      
      public static function solveHomeFishingPath(param1:int) : String
      {
         return info.SITE + "image/home/fishing/" + param1 + ".png";
      }
      
      public static function getLoaderFileName(param1:String) : String
      {
         var _loc2_:String = param1.replace(/http:\/\/[^\/]+\//g,"");
         return _loc2_.split("?")[0];
      }
      
      public static function smallMapEnable() : Boolean
      {
         return info.SMALLMAP_ENABLE;
      }
      
      public static function smallMapBorderEnable() : Boolean
      {
         return info.SMALLMAP_BORDER_ENABLE;
      }
      
      public static function get fight_time() : int
      {
         return info.FIGHT_TIME;
      }
      
      public static function smallMapAlpha() : Boolean
      {
         return info.SMALLMAP_ALPHA;
      }
      
      public static function get solveGemstoneSwitch() : Boolean
      {
         return info.GEMSTONE_ENABLE;
      }
      
      public static function smallMapPoint() : Boolean
      {
         return info.SMALLMAP_POINT_ENABLE;
      }
      
      public static function smallMapGrid() : Boolean
      {
         return info.SMALLMAP_GRID_ENABLE;
      }
      
      public static function get pkEnable() : Boolean
      {
         return info.PK_BTN;
      }
      
      public static function get eatPetsEnable() : Boolean
      {
         return info.PETS_EAT;
      }
      
      public static function get girdAttestEnable() : Boolean
      {
         return info.GIRDATTEST;
      }
      
      public static function smallMapShape() : Boolean
      {
         return info.SMALLMAP_SHAPE_ENABLE;
      }
      
      public static function setSmallMapEnable(param1:String, param2:int) : void
      {
         var _loc9_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc8_:* = param2;
         var _loc6_:Array = param1.split(",");
         var _loc7_:Array = ["0","SMALLMAP_BORDER_ENABLE","SMALLMAP_ALPHA","SMALLMAP_POINT_ENABLE","SMALLMAP_GRID_ENABLE","SMALLMAP_SHAPE_ENABLE"];
         var _loc5_:Array = [];
         info.SMALLMAP_ENABLE = Boolean(int(_loc6_[0]));
         if(info.SMALLMAP_ENABLE)
         {
            return;
         }
         _loc9_ = 1;
         while(_loc9_ < _loc6_.length)
         {
            _loc3_ = int(_loc6_[_loc9_]);
            info[_loc7_[_loc9_]] = _loc3_;
            if(_loc3_)
            {
               _loc5_.push(_loc7_[_loc9_]);
               _loc4_++;
            }
            _loc9_++;
         }
         if(_loc8_ > 0 && _loc4_ >= _loc8_)
         {
            setRandomSmallMapEnalbe(_loc5_,_loc4_,_loc8_);
         }
      }
      
      public static function getRecordPath() : String
      {
         return info.RECORD_PATH;
      }
      
      private static function setRandomSmallMapEnalbe(param1:Array, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = Math.floor(param2 / 2);
         var _loc5_:int = (param3 - _loc6_) * Math.random() + _loc6_;
         var _loc4_:int = param1.length;
         while(_loc4_)
         {
            _loc4_--;
            param1.push(param1.splice(int(Math.random() * _loc4_),1)[0]);
         }
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(_loc7_ >= _loc5_)
            {
               info[param1[_loc7_]] = false;
            }
            _loc7_++;
         }
      }
      
      public static function get vipDiscountEnable() : Boolean
      {
         return info.VIP_DISCOUNT;
      }
      
      public static function solveGodCardRaisePath(param1:String) : String
      {
         return info.SITE + "image/cardCollect/" + param1 + "/icon.png";
      }
      
      public static function getAreaNameInfoPath() : String
      {
         return getUIPath() + "/" + "AreaNameInfo.xml";
      }
      
      public static function get magichouseEnable() : Boolean
      {
         return info.MAGICHOUSE;
      }
      
      public static function get GodSyahEnable() : Boolean
      {
         return info.GODSYAH_ENABLE;
      }
      
      public static function get girdHeadEnable() : Boolean
      {
         return info.GIRLHEAD;
      }
      
      public static function getPlayerRegressNotificationPath() : String
      {
         return getUIPath() + "/" + "playerRegressNotification.txt";
      }
      
      public static function solveBoguAdventurePath() : String
      {
         return info.SITE + "image/equip/f/suits/suits100/1/game.png";
      }
      
      public static function ManualDebrisIconPath(param1:String) : String
      {
         return info.SITE + "image" + param1 + ".jpg";
      }
      
      public static function ManualDebrisPNGIconPath(param1:String) : String
      {
         return info.SITE + "image" + param1 + ".png";
      }
      
      public static function get getTrusteeshipViewEnable() : Boolean
      {
         return info.TRUSTEESHIPVIEW;
      }
      
      public static function getLoadingDevice() : String
      {
         return info.LOGINDEVICE_LINK;
      }
      
      public static function battleSkillIconPath(param1:String) : String
      {
         return info.SITE + "image/skillfair/" + param1 + ".png";
      }
      
      public static function loginDeviceLink() : String
      {
         return info.LOGINDEVICE_LINK;
      }
      
      public static function getBoneWeaponPath() : String
      {
         return "image/game/bonesWeapon/";
      }
      
      public static function getBoneLivingPath() : String
      {
         return "image/game/bonesLiving/";
      }
      
      public static function getBoneLivingHeadPath(param1:String) : String
      {
         return info.SITE + "image/game/bonesLivingHead/" + param1 + "Head.png";
      }
      
      public static function getBoneLivingBodyPath(param1:String) : String
      {
         return info.SITE + "image/game/bonesLivingBody/" + param1 + "Body.png";
      }
      
      public static function getBeautyProveQQ() : String
      {
         return info.BEAUTY_PROVE_QQ;
      }
      
      public static function getSwfPath(param1:String) : String
      {
         return getUIPath() + "/swf/" + param1 + ".swf";
      }
      
      public static function getXMLPath(param1:String) : String
      {
         return getUIPath() + "/xml/" + param1 + ".xml";
      }
      
      public static function getMornUIPath(param1:String) : String
      {
         return getUIPath() + "/morn/ui/" + param1 + ".ui";
      }
      
      public static function getMornLangPath(param1:String) : String
      {
         return getUIPath() + "/morn/lang/" + param1 + ".xml";
      }
   }
}
