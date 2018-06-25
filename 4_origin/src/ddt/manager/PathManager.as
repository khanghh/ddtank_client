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
      
      public static function setup(i:PathInfo) : void
      {
         info = i;
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
         var path:String = info.COMMUNITY_FRIEND_PATH;
         return path;
      }
      
      public static function solveClientDownloadPath() : String
      {
         return info.CLIENT_DOWNLOAD;
      }
      
      public static function solveWebPlayerInfoPath(uid:String, code:String = "", key:String = "") : String
      {
         var url:String = info.WEB_PLAYER_INFO_PATH.replace("{uid}",uid);
         url = url.replace("{code}",code);
         url = url.replace("{key}",key);
         return url;
      }
      
      public static function solveFlvSound(id:String) : String
      {
         return info.SITE + "sound/" + id + ".flv";
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
      
      public static function solveLoginPHP($loginName:String) : String
      {
         return info.PHP_PATH.replace("{id}",$loginName);
      }
      
      public static function checkOpenPHP() : Boolean
      {
         return info.PHP_IMAGE_LINK;
      }
      
      public static function solveTrainerPage() : String
      {
         return info.TRAINER_PATH;
      }
      
      public static function solveWeeklyPath(str:String) : String
      {
         return info.WEEKLY_SITE + "weekly/" + str;
      }
      
      public static function solveMapPath(id:int, name:String, type:String) : String
      {
         return info.SITE + "image/map/" + id.toString() + "/" + name + "." + type;
      }
      
      public static function solveMapSmallView(id:int) : String
      {
         return info.SITE + "image/map/" + id.toString() + "/small.png";
      }
      
      public static function solveRequestPath(path:String = "") : String
      {
         return info.REQUEST_PATH + path;
      }
      
      public static function solvePropPath(path:String) : String
      {
         return info.SITE + "image/tool/" + path + ".png";
      }
      
      public static function solveMapIconPath(id:int, type:int, missionPic:String = "show1.jpg") : String
      {
         var path:String = "";
         if(type == 0)
         {
            path = info.SITE + "image/map/" + id.toString() + "/icon.png";
         }
         else if(type == 1)
         {
            path = info.SITE + "image/map/" + id.toString() + "/samll_map.png";
         }
         else if(type == 2)
         {
            path = info.SITE + "image/map/" + id.toString() + "/" + missionPic;
         }
         else if(type == 3)
         {
            path = info.SITE + "image/map/" + id.toString() + "/samll_map_s.jpg";
         }
         return path;
      }
      
      public static function solveEffortIconPath(iconUrl:String) : String
      {
         var path:String = "";
         path = info.SITE + "image/effort/" + iconUrl + "/icon.png";
         return path;
      }
      
      public static function solveFieldPlantPath(iconUrl:String, type:int) : String
      {
         return info.SITE + "image/farm/Crops/" + iconUrl + "/crop" + type + ".png";
      }
      
      public static function solveSeedPath(iconUrl:String) : String
      {
         return info.SITE + "image/farm/Crops/" + iconUrl + "/seed.png";
      }
      
      public static function solveCountPath() : String
      {
         return info.COUNT_PATH;
      }
      
      public static function solveParterId() : String
      {
         return info.PARTER_ID;
      }
      
      public static function solveStylePath(sex:Boolean, type:String, path:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!sex?"m":"f") + "/" + type + "/" + path + ".png";
      }
      
      public static function solveArmPath(type:String, path:String) : String
      {
         return info.SITE + info.STYLE_PATH + String(type) + "/" + path + ".png";
      }
      
      public static function solveGoodsPath(category:Number, path:String, sex:Boolean = true, pictype:String = "show", dressHat:String = "A", secondLayer:String = "1", level:int = 1, isBack:Boolean = false, propType:int = 0, stateType:String = "") : String
      {
         var s:* = null;
         var type:String = "";
         var sext:String = "";
         var equiptype:String = "";
         var back:String = "";
         var dresshat:String = "";
         var secondlayer:String = "";
         var levelt:String = "";
         var file:String = pictype + ".png";
         if(path == "item4")
         {
            s = "";
         }
         if(category == 7 || category == 27 || category == 64)
         {
            levelt = "/1";
            type = "arm/";
            if(pictype.indexOf("icon") == -1)
            {
               back = !!isBack?"/1":"/0";
            }
            return info.SITE + "image/arm/" + path + levelt + back + "/" + file;
         }
         if(category == 24 || category == 11 || category == 65 || category == 68 || category == 69 || category == 72 || category == 79)
         {
            return info.SITE + "image/unfrightprop/" + path + "/" + file;
         }
         if(category == 12)
         {
            return info.SITE + "image/task/" + path + "/icon.png";
         }
         if(category == 16)
         {
            return info.SITE + "image/specialprop/chatBall/" + path + "/icon.png";
         }
         if(category < 10 || category == 13 || category == 14 || category == 28 || category == 29)
         {
            if(category == 3)
            {
               if(pictype.indexOf("icon") == -1)
               {
                  dresshat = "/" + dressHat;
               }
            }
            type = "equip/";
            equiptype = EquipType.TYPES[category] + "/";
            sext = !!sex?"m/":"f/";
            if(category != 8 && category != 9 && category != 14 && category != 28 && category != 29)
            {
               if(pictype == "icon")
               {
                  pictype = "icon_" + secondLayer;
                  secondLayer = "";
               }
               else
               {
                  secondlayer = "/" + secondLayer;
               }
            }
            else
            {
               sext = "";
            }
            file = pictype + stateType + ".png";
            return info.SITE + "image/" + type + sext + equiptype + path + secondlayer + dresshat + levelt + back + "/" + file;
         }
         if(category == 15)
         {
            return info.SITE + "image/equip/wing/" + path + "/" + file;
         }
         if(category == 17 || category == 31)
         {
            return info.SITE + "image/equip/offhand/" + path + "/icon.png";
         }
         if(category == 25)
         {
            return info.SITE + "image/gift/" + path + "/icon.png";
         }
         if(category == 26)
         {
            return info.SITE + "image/card/" + path + "/icon.jpg";
         }
         if(category == 18 || category == 66)
         {
            return info.SITE + "image/cardbox/" + path + "/icon.png";
         }
         if(category == 19)
         {
            return info.SITE + "image/equip/recover/" + path + "/icon.png";
         }
         if(category == 70)
         {
            return info.SITE + "image/equip/amulet/" + path + "/" + stateType + "/icon.png";
         }
         if(category == 20 || category == 53 || category == 78 || category == 23 || category == 30 || category == 40)
         {
            return info.SITE + "image/unfrightprop/" + path + "/icon.png";
         }
         if(category == 32 || category == 36)
         {
            return info.SITE + "image/farm/Crops/" + path + "/seed.png";
         }
         if(category == 33)
         {
            return info.SITE + "image/farm/Fertilizer/" + path + "/icon.png";
         }
         if(category == 34 || category == 35)
         {
            return info.SITE + "image/unfrightprop/" + path + "/icon.png";
         }
         if(category == 52)
         {
            return info.SITE + "image/petequip/cloth/" + path + "/icon.png";
         }
         if(category == 50)
         {
            return info.SITE + "image/petequip/arm/" + path + "/icon.png";
         }
         if(category == 51)
         {
            return info.SITE + "image/petequip/hat/" + path + "/icon.png";
         }
         if(category == 61 || category == 62 || category == 37)
         {
            return info.SITE + "image/unfrightprop/" + path + "/" + file;
         }
         if(category == 74)
         {
            return info.SITE + "image/rune/" + path + ".png";
         }
         return info.SITE + "image/prop/" + path + "/" + file;
      }
      
      public static function soloveWingPath(path:String) : String
      {
         return info.SITE + "image/equip/wing/" + path + "/wings.swf";
      }
      
      public static function soloveSinpleLightPath(path:String) : String
      {
         return info.SITE + "image/equip/sinplelight/" + path + ".swf";
      }
      
      public static function soloveCircleLightPath(path:String) : String
      {
         return info.SITE + "image/equip/circlelight/" + path + ".swf";
      }
      
      public static function solveConsortiaIconPath(path:String) : String
      {
         return info.SITE + "image/consortiaicon/" + path + ".png";
      }
      
      public static function solveConsortiaMapPath(path:String) : String
      {
         return info.SITE + "image/consortiamap/" + path + ".png";
      }
      
      public static function solveWorldbossBuffPath() : String
      {
         return info.SITE + "image/worldboss/buff/";
      }
      
      public static function getDiceResource() : String
      {
         return info.SITE + "image/dice/";
      }
      
      public static function cellMovieClipSpecialEffectPath(path:String) : String
      {
         return info.SITE + "image/cellEffect/lv" + path + ".swf";
      }
      
      public static function solveSceneCharacterLoaderPath(categoryID:Number, path:String, playerSex:Boolean = true, sex:Boolean = true, secondLayer:String = "1", direction:int = 1, sceneCharacterLoaderPath:String = "") : String
      {
         var type:* = null;
         var _loc9_:* = categoryID;
         if(3 !== _loc9_)
         {
            if(4 !== _loc9_)
            {
               if(6 !== _loc9_)
               {
                  if(5 !== _loc9_)
                  {
                     return info.SITE + "image/virtual/" + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + secondLayer + ".png";
                  }
                  type = direction == 1?"clothF":direction == 2?"cloth":"clothF";
                  path = sceneCharacterLoaderPath;
                  if(sceneCharacterLoaderPath == "")
                  {
                     path = "default";
                  }
                  if(StateManager.currentStateType == "collectionTaskScene")
                  {
                     return info.SITE + "image/mounts/clothZ/" + (!!playerSex?"M":"F") + "/" + type + "/1/" + secondLayer + ".png";
                  }
                  return info.SITE + "image/virtual/" + (!!playerSex?"M":"F") + "/" + type + "/" + path + "/" + secondLayer + ".png";
               }
               type = "face";
               return info.SITE + "image/virtual/" + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + secondLayer + ".png";
            }
            type = "eff";
            return info.SITE + "image/virtual/" + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + secondLayer + ".png";
         }
         type = "hair";
         return info.SITE + "image/virtual/" + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + secondLayer + ".png";
      }
      
      public static function solveLitteGameCharacterPath(categoryID:Number, sex:Boolean, litteGameId:int, layer:int, picId:String = "") : String
      {
         var type:* = null;
         var mainPath:String = info.SITE + "image/world/player/" + litteGameId + "/";
         var path:* = "";
         var _loc9_:* = categoryID;
         if(30 !== _loc9_)
         {
            if(6 !== _loc9_)
            {
               if(5 === _loc9_)
               {
                  type = "body";
                  path = "default";
                  return mainPath + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + layer + ".png";
               }
            }
            else
            {
               type = "face";
               path = picId;
               return mainPath + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + layer + ".png";
            }
         }
         else
         {
            type = "effect";
            path = "default";
         }
         return mainPath + (!!sex?"M":"F") + "/" + type + "/" + path + "/" + layer + ".png";
      }
      
      public static function solveBlastPath(path:String) : String
      {
         return info.SITE + "swf/blast.swf";
      }
      
      public static function solveStyleFullPath(sex:Boolean, hair:String, body:String, face:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!sex?"M":"F") + "/" + hair + "/" + body + face + "/all.png";
      }
      
      public static function solveStyleHeadPath(sex:Boolean, type:String, style:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!sex?"M":"F") + "/" + type + "/" + style + "/head.png";
      }
      
      public static function solveStylePreviewPath(sex:Boolean, type:String, style:String) : String
      {
         return info.SITE + info.STYLE_PATH + (!!sex?"M":"F") + "/" + type + "/" + style + "/pre.png";
      }
      
      public static function solvePath(path:String) : String
      {
         return info.SITE + path;
      }
      
      public static function solveWeaponSkillSwf(skillid:int) : String
      {
         return solveSkillSwf(skillid);
      }
      
      public static function solveSkillSwf(skillid:int) : String
      {
         return info.SITE + "image/skill/" + skillid + ".swf";
      }
      
      public static function solveBlastOut(id:int) : String
      {
         return info.SITE + "image/bomb/blastOut/blastOut" + id + ".swf";
      }
      
      public static function solveBullet(id:int) : String
      {
         return info.SITE + "image/bomb/bullet/bullet" + id + ".swf";
      }
      
      public static function solveParticle() : String
      {
         return info.SITE + "image/bomb/partical.xml";
      }
      
      public static function solveShape() : String
      {
         return info.SITE + "image/bome/shape.swf";
      }
      
      public static function solveCraterBrink(id:int) : String
      {
         return info.SITE + "image/bomb/crater/" + id + "/craterBrink.png";
      }
      
      public static function solveCrater(id:int) : String
      {
         return info.SITE + "image/bomb/crater/" + id + "/crater.png";
      }
      
      public static function solveBombSwf(bombId:int) : String
      {
         return info.FLASHSITE + "bombs/" + bombId + ".swf";
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
      
      public static function solveChurchSceneSourcePath(path:String) : String
      {
         return info.SITE + "image/church/scene/" + path + ".swf";
      }
      
      public static function solveGameLivingPath(path:String) : String
      {
         var classToPath:String = path.split(".").join("/");
         return info.SITE + "image/" + classToPath + ".swf";
      }
      
      public static function solveWeeklyImagePath(path:String) : String
      {
         return info.WEEKLY_SITE + "weekly/" + path;
      }
      
      public static function solveNewHandBuild(type:String) : String
      {
         return getUIPath() + "/img/trainer/" + type.slice(0,type.length - 3) + ".png";
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
      
      public static function CommunitySinaWeibo(path:String) : String
      {
         return info.SITE + path;
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
      
      public static function solveASTPath(name:String) : String
      {
         return info.SITE + "image/world/monster/" + name + ".png";
      }
      
      public static function solveLittleGameConfigPath(id:int) : String
      {
         return info.SITE + "image/tilemap/" + id + "/map.bin";
      }
      
      public static function solveLittleGameResPath(id:int) : String
      {
         return info.SITE + "image/world/map/" + id + "/scene.swf";
      }
      
      public static function solveLittleGameObjectPath(object:String) : String
      {
         return info.SITE + "image/world/" + object;
      }
      
      public static function solveLittleGameMapPreview(id:int) : String
      {
         return info.SITE + "image/world/map/" + id + "/preview.jpg";
      }
      
      public static function solveBadgePath(id:int) : String
      {
         return info.SITE + "image/badge/" + id + "/icon.png";
      }
      
      public static function solveLeagueRankPath(id:int) : String
      {
         return info.SITE + "image/leagueRank/" + id + "/icon.png";
      }
      
      public static function getUIPath() : String
      {
         var s:String = info.FLASHSITE + "ui/" + PathInfo.LANGUAGE;
         return s;
      }
      
      public static function get advancedEnable() : Boolean
      {
         return info.ADVANCED_ENABLE;
      }
      
      public static function getCustomResPath() : String
      {
         var s:String = getUIPath() + "/customres/";
         return s;
      }
      
      public static function getBackUpUIPath() : String
      {
         return info.BACKUP_FLASHSITE;
      }
      
      public static function getUIConfigPath(module:String) : String
      {
         return getUIPath() + "/xml/" + module + ".xml";
      }
      
      public static function getLanguagePath() : String
      {
         return getUIPath() + "/" + "language.png";
      }
      
      public static function getBraveDoorDuplicateTemplete(module:String) : String
      {
         return getCustomResPath() + module + ".xml";
      }
      
      public static function getBonesPath(name:String) : String
      {
         return getUIPath() + "/bones/" + name + ".xml";
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
      
      public static function getCardXMLPath(xmlName:String) : String
      {
         return xmlName;
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
         var arr:Array = [];
         if(info == null)
         {
            return arr;
         }
         arr = info.DISABLE_TASK_ID.split(",");
         return arr;
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
      
      public static function solvePetGameAssetUrl(asseturl:String) : String
      {
         return info.SITE + "image/gameasset/" + asseturl + ".swf";
      }
      
      public static function getWeatherUrl(id:int) : String
      {
         return info.SITE + "image/weather/" + id + "/1.swf";
      }
      
      public static function solvePetFarmAssetUrl(asseturl:String) : String
      {
         return info.SITE + "image/" + asseturl + ".swf";
      }
      
      public static function solveSkillPicUrl(pic:String) : String
      {
         return info.SITE + "image/petskill/" + pic + "/icon.png";
      }
      
      public static function solvePetSkillEffect(effect:String) : String
      {
         return info.SITE + "image/skilleffect/" + effect + ".swf";
      }
      
      public static function solvePetBuff(buff:String) : String
      {
         return info.SITE + "image/buff/" + buff + "/icon.png";
      }
      
      public static function solvePetIconUrl(folder:String) : String
      {
         return info.SITE + "image/pet/" + folder + ".png";
      }
      
      public static function solveGradeNotificationPath(grade:int) : String
      {
         return info.GRADE_NOTIFICATION[grade.toString()];
      }
      
      public static function solveWorldBossMapSourcePath(path:String) : String
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
      
      public static function solveChristmasMonsterPath(pPath:String) : String
      {
         return info.SITE + "image/scene/christmas/monsters/" + pPath + ".swf";
      }
      
      public static function solveCollectionTaskSceneSourcePath(path:String) : String
      {
         return info.SITE + "image/collectiontask/" + path + ".swf";
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
      
      public static function petsFormPath(path:String, id:int) : String
      {
         return info.SITE + "image/pet/" + path + "/icon" + id + ".png";
      }
      
      public static function petsAnimationPath(path:String) : String
      {
         return info.SITE + "image/game/living/" + path + ".swf";
      }
      
      public static function solveFurniturePath(category:String, path:String) : String
      {
         if(category == "floor")
         {
            return info.SITE + "image/house/" + category + "/" + path + ".jpg";
         }
         if(category == "wall")
         {
            return info.SITE + "image/house/" + category + "/" + path + ".png";
         }
         return info.SITE + "image/house/" + category + "/" + path + ".swf";
      }
      
      public static function solveHomeFishingPath(value:int) : String
      {
         return info.SITE + "image/home/fishing/" + value + ".png";
      }
      
      public static function getLoaderFileName(url:String) : String
      {
         var str:String = url.replace(/http:\/\/[^\/]+\//g,"");
         return str.split("?")[0];
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
      
      public static function setSmallMapEnable(value:String, random:int) : void
      {
         var i:int = 0;
         var enable:Boolean = false;
         var enableCount:int = 0;
         var maxCount:* = random;
         var enableList:Array = value.split(",");
         var key:Array = ["0","SMALLMAP_BORDER_ENABLE","SMALLMAP_ALPHA","SMALLMAP_POINT_ENABLE","SMALLMAP_GRID_ENABLE","SMALLMAP_SHAPE_ENABLE"];
         var openKey:Array = [];
         info.SMALLMAP_ENABLE = Boolean(int(enableList[0]));
         if(info.SMALLMAP_ENABLE)
         {
            return;
         }
         i = 1;
         while(i < enableList.length)
         {
            enable = int(enableList[i]);
            info[key[i]] = enable;
            if(enable)
            {
               openKey.push(key[i]);
               enableCount++;
            }
            i++;
         }
         if(maxCount > 0 && enableCount >= maxCount)
         {
            setRandomSmallMapEnalbe(openKey,enableCount,maxCount);
         }
      }
      
      public static function getRecordPath() : String
      {
         return info.RECORD_PATH;
      }
      
      private static function setRandomSmallMapEnalbe(openKey:Array, enableCount:int, maxCount:int) : void
      {
         var i:int = 0;
         var minCount:int = Math.floor(enableCount / 2);
         var randomCount:int = (maxCount - minCount) * Math.random() + minCount;
         var index:int = openKey.length;
         while(index)
         {
            index--;
            openKey.push(openKey.splice(int(Math.random() * index),1)[0]);
         }
         for(i = 0; i < openKey.length; )
         {
            if(i >= randomCount)
            {
               info[openKey[i]] = false;
            }
            i++;
         }
      }
      
      public static function get vipDiscountEnable() : Boolean
      {
         return info.VIP_DISCOUNT;
      }
      
      public static function solveGodCardRaisePath(pic:String) : String
      {
         return info.SITE + "image/cardCollect/" + pic + "/icon.png";
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
      
      public static function ManualDebrisIconPath(pic:String) : String
      {
         return info.SITE + "image" + pic + ".jpg";
      }
      
      public static function ManualDebrisPNGIconPath(pic:String) : String
      {
         return info.SITE + "image" + pic + ".png";
      }
      
      public static function get getTrusteeshipViewEnable() : Boolean
      {
         return info.TRUSTEESHIPVIEW;
      }
      
      public static function getLoadingDevice() : String
      {
         return info.LOGINDEVICE_LINK;
      }
      
      public static function battleSkillIconPath(pic:String) : String
      {
         return info.SITE + "image/skillfair/" + pic + ".png";
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
      
      public static function getBoneLivingHeadPath(id:String) : String
      {
         return info.SITE + "image/game/bonesLivingHead/" + id + "Head.png";
      }
      
      public static function getBoneLivingBodyPath(id:String) : String
      {
         return info.SITE + "image/game/bonesLivingBody/" + id + "Body.png";
      }
      
      public static function getBeautyProveQQ() : String
      {
         return info.BEAUTY_PROVE_QQ;
      }
      
      public static function getSwfPath(name:String) : String
      {
         return getUIPath() + "/swf/" + name + ".swf";
      }
      
      public static function getXMLPath(name:String) : String
      {
         return getUIPath() + "/xml/" + name + ".xml";
      }
      
      public static function getMornUIPath(name:String) : String
      {
         return getUIPath() + "/morn/ui/" + name + ".ui";
      }
      
      public static function getMornLangPath(name:String) : String
      {
         return getUIPath() + "/morn/lang/" + name + ".xml";
      }
      
      public static function get OldPlayerTransferEnable() : Boolean
      {
         return info.OLDPLAYER_TRANSFER;
      }
   }
}
