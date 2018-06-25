package ddt.manager{   import ddt.data.EquipType;   import ddt.data.PathInfo;      public class PathManager   {            private static var info:PathInfo;            public static var SITE_MAIN:String = "";            public static var SITE_WEEKLY:String = "";                   public function PathManager() { super(); }
            public static function setup(i:PathInfo) : void { }
            public static function getPathInfo() : PathInfo { return null; }
            public static function solvePhpPath() : String { return null; }
            public static function userName() : String { return null; }
            public static function getRequest_path() : String { return null; }
            public static function solveOfficialSitePath() : String { return null; }
            public static function solveGameForum() : String { return null; }
            public static function get solveCommunityFriend() : String { return null; }
            public static function solveClientDownloadPath() : String { return null; }
            public static function solveWebPlayerInfoPath(uid:String, code:String = "", key:String = "") : String { return null; }
            public static function solveFlvSound(id:String) : String { return null; }
            public static function solveFirstPage() : String { return null; }
            public static function solveRegister() : String { return null; }
            public static function solveLogin() : String { return null; }
            public static function solveConfigSite() : String { return null; }
            public static function solveFillPage() : String { return null; }
            public static function solveLoginPHP($loginName:String) : String { return null; }
            public static function checkOpenPHP() : Boolean { return false; }
            public static function solveTrainerPage() : String { return null; }
            public static function solveWeeklyPath(str:String) : String { return null; }
            public static function solveMapPath(id:int, name:String, type:String) : String { return null; }
            public static function solveMapSmallView(id:int) : String { return null; }
            public static function solveRequestPath(path:String = "") : String { return null; }
            public static function solvePropPath(path:String) : String { return null; }
            public static function solveMapIconPath(id:int, type:int, missionPic:String = "show1.jpg") : String { return null; }
            public static function solveEffortIconPath(iconUrl:String) : String { return null; }
            public static function solveFieldPlantPath(iconUrl:String, type:int) : String { return null; }
            public static function solveSeedPath(iconUrl:String) : String { return null; }
            public static function solveCountPath() : String { return null; }
            public static function solveParterId() : String { return null; }
            public static function solveStylePath(sex:Boolean, type:String, path:String) : String { return null; }
            public static function solveArmPath(type:String, path:String) : String { return null; }
            public static function solveGoodsPath(category:Number, path:String, sex:Boolean = true, pictype:String = "show", dressHat:String = "A", secondLayer:String = "1", level:int = 1, isBack:Boolean = false, propType:int = 0, stateType:String = "") : String { return null; }
            public static function soloveWingPath(path:String) : String { return null; }
            public static function soloveSinpleLightPath(path:String) : String { return null; }
            public static function soloveCircleLightPath(path:String) : String { return null; }
            public static function solveConsortiaIconPath(path:String) : String { return null; }
            public static function solveConsortiaMapPath(path:String) : String { return null; }
            public static function solveWorldbossBuffPath() : String { return null; }
            public static function getDiceResource() : String { return null; }
            public static function cellMovieClipSpecialEffectPath(path:String) : String { return null; }
            public static function solveSceneCharacterLoaderPath(categoryID:Number, path:String, playerSex:Boolean = true, sex:Boolean = true, secondLayer:String = "1", direction:int = 1, sceneCharacterLoaderPath:String = "") : String { return null; }
            public static function solveLitteGameCharacterPath(categoryID:Number, sex:Boolean, litteGameId:int, layer:int, picId:String = "") : String { return null; }
            public static function solveBlastPath(path:String) : String { return null; }
            public static function solveStyleFullPath(sex:Boolean, hair:String, body:String, face:String) : String { return null; }
            public static function solveStyleHeadPath(sex:Boolean, type:String, style:String) : String { return null; }
            public static function solveStylePreviewPath(sex:Boolean, type:String, style:String) : String { return null; }
            public static function solvePath(path:String) : String { return null; }
            public static function solveWeaponSkillSwf(skillid:int) : String { return null; }
            public static function solveSkillSwf(skillid:int) : String { return null; }
            public static function solveBlastOut(id:int) : String { return null; }
            public static function solveBullet(id:int) : String { return null; }
            public static function solveParticle() : String { return null; }
            public static function solveShape() : String { return null; }
            public static function solveCraterBrink(id:int) : String { return null; }
            public static function solveCrater(id:int) : String { return null; }
            public static function solveBombSwf(bombId:int) : String { return null; }
            public static function solveSoundSwf() : String { return null; }
            public static function solveSoundSwf2() : String { return null; }
            public static function solveSoundSwf3() : String { return null; }
            public static function solveSoundSwfBattle() : String { return null; }
            public static function solveParticalXml() : String { return null; }
            public static function solveShapeSwf() : String { return null; }
            public static function solveCatharineSwf() : String { return null; }
            public static function solveChurchSceneSourcePath(path:String) : String { return null; }
            public static function solveGameLivingPath(path:String) : String { return null; }
            public static function solveWeeklyImagePath(path:String) : String { return null; }
            public static function solveNewHandBuild(type:String) : String { return null; }
            public static function CommnuntyMicroBlog() : Boolean { return false; }
            public static function CommnuntySinaSecondMicroBlog() : Boolean { return false; }
            public static function CommunityInvite() : String { return null; }
            public static function CommunityFriendList() : String { return null; }
            public static function CommunityExist() : Boolean { return false; }
            public static function CommunityFriendInvitedSwitch() : Boolean { return false; }
            public static function CommunityFriendInvitedOnlineSwitch() : Boolean { return false; }
            public static function isVisibleExistBtn() : Boolean { return false; }
            public static function getSnsPath() : String { return null; }
            public static function getMicrocobolPath() : String { return null; }
            public static function CommunityIcon() : String { return null; }
            public static function CommunitySinaWeibo(path:String) : String { return null; }
            public static function solveAllowPopupFavorite() : Boolean { return false; }
            public static function solveFillJSCommandEnable() : Boolean { return false; }
            public static function solveFillJSCommandValue() : String { return null; }
            public static function solveServerListIndex() : int { return 0; }
            public static function solveSPAEnable() : Boolean { return false; }
            public static function solveCivilEnable() : Boolean { return false; }
            public static function solveChurchEnable() : Boolean { return false; }
            public static function solveWeeklyEnable() : Boolean { return false; }
            public static function solveAchieveEnable() : Boolean { return false; }
            public static function solveForthEnable() : Boolean { return false; }
            public static function solveStrengthMax() : int { return 0; }
            public static function solveUserGuildEnable() : Boolean { return false; }
            public static function solveFrameTimeOverTag() : int { return 0; }
            public static function solveFrameOverCount() : int { return 0; }
            public static function solveExternalInterfacePath() : String { return null; }
            public static function ExternalInterface360Path() : String { return null; }
            public static function ExternalInterface360Enabel() : Boolean { return false; }
            public static function solveExternalInterfaceEnabel() : Boolean { return false; }
            public static function solveFeedbackEnable() : Boolean { return false; }
            public static function solveFeedbackTelNumber() : String { return null; }
            public static function solveChatFaceDisabledList() : Array { return null; }
            public static function solveASTPath(name:String) : String { return null; }
            public static function solveLittleGameConfigPath(id:int) : String { return null; }
            public static function solveLittleGameResPath(id:int) : String { return null; }
            public static function solveLittleGameObjectPath(object:String) : String { return null; }
            public static function solveLittleGameMapPreview(id:int) : String { return null; }
            public static function solveBadgePath(id:int) : String { return null; }
            public static function solveLeagueRankPath(id:int) : String { return null; }
            public static function getUIPath() : String { return null; }
            public static function get advancedEnable() : Boolean { return false; }
            public static function getCustomResPath() : String { return null; }
            public static function getBackUpUIPath() : String { return null; }
            public static function getUIConfigPath(module:String) : String { return null; }
            public static function getLanguagePath() : String { return null; }
            public static function getBraveDoorDuplicateTemplete(module:String) : String { return null; }
            public static function getBonesPath(name:String) : String { return null; }
            public static function getGameBonesPath() : String { return null; }
            public static function getMovingNotificationPath() : String { return null; }
            public static function getLevelRewardPath() : String { return null; }
            public static function getExpressionPath() : String { return null; }
            public static function getZhanPath() : String { return null; }
            public static function getCardXMLPath(xmlName:String) : String { return null; }
            public static function getFightAchieveEnable() : Boolean { return false; }
            public static function getFightLibEanble() : Boolean { return false; }
            public static function getMonsterPath() : String { return null; }
            public static function get FLASHSITE() : String { return null; }
            public static function get TRAINER_STANDALONE() : Boolean { return false; }
            public static function get isStatistics() : Boolean { return false; }
            public static function get DISABLE_TASK_ID() : Array { return null; }
            public static function get LittleGameMinLv() : int { return 0; }
            public static function get solveDungeonOpenList() : Array { return null; }
            public static function get treasureSwitch() : Boolean { return false; }
            public static function get treasureHelpTimes() : int { return 0; }
            public static function solvePetGameAssetUrl(asseturl:String) : String { return null; }
            public static function getWeatherUrl(id:int) : String { return null; }
            public static function solvePetFarmAssetUrl(asseturl:String) : String { return null; }
            public static function solveSkillPicUrl(pic:String) : String { return null; }
            public static function solvePetSkillEffect(effect:String) : String { return null; }
            public static function solvePetBuff(buff:String) : String { return null; }
            public static function solvePetIconUrl(folder:String) : String { return null; }
            public static function solveGradeNotificationPath(grade:int) : String { return null; }
            public static function solveWorldBossMapSourcePath(path:String) : String { return null; }
            public static function callLoginInterface() : String { return null; }
            public static function userActionNotice() : String { return null; }
            public static function get suitEnable() : Boolean { return false; }
            public static function callBackInterfacePath() : String { return null; }
            public static function callBackEnable() : Boolean { return false; }
            public static function solveChristmasMonsterPath(pPath:String) : String { return null; }
            public static function solveCollectionTaskSceneSourcePath(path:String) : String { return null; }
            public static function get isSendRecordUserVersion() : Boolean { return false; }
            public static function get isSendFlashInfo() : Boolean { return false; }
            public static function getParticlesPath() : String { return null; }
            public static function get isDuoWanSDKInterface() : Boolean { return false; }
            public static function get flashP2PEbable() : Boolean { return false; }
            public static function get flashP2PKey() : String { return null; }
            public static function get flashP2PCirrusUrl() : String { return null; }
            public static function get footballEnable() : Boolean { return false; }
            public static function petsFormPath(path:String, id:int) : String { return null; }
            public static function petsAnimationPath(path:String) : String { return null; }
            public static function solveFurniturePath(category:String, path:String) : String { return null; }
            public static function solveHomeFishingPath(value:int) : String { return null; }
            public static function getLoaderFileName(url:String) : String { return null; }
            public static function smallMapEnable() : Boolean { return false; }
            public static function smallMapBorderEnable() : Boolean { return false; }
            public static function get fight_time() : int { return 0; }
            public static function smallMapAlpha() : Boolean { return false; }
            public static function get solveGemstoneSwitch() : Boolean { return false; }
            public static function smallMapPoint() : Boolean { return false; }
            public static function smallMapGrid() : Boolean { return false; }
            public static function get pkEnable() : Boolean { return false; }
            public static function get eatPetsEnable() : Boolean { return false; }
            public static function get girdAttestEnable() : Boolean { return false; }
            public static function smallMapShape() : Boolean { return false; }
            public static function setSmallMapEnable(value:String, random:int) : void { }
            public static function getRecordPath() : String { return null; }
            private static function setRandomSmallMapEnalbe(openKey:Array, enableCount:int, maxCount:int) : void { }
            public static function get vipDiscountEnable() : Boolean { return false; }
            public static function solveGodCardRaisePath(pic:String) : String { return null; }
            public static function getAreaNameInfoPath() : String { return null; }
            public static function get magichouseEnable() : Boolean { return false; }
            public static function get GodSyahEnable() : Boolean { return false; }
            public static function get girdHeadEnable() : Boolean { return false; }
            public static function getPlayerRegressNotificationPath() : String { return null; }
            public static function solveBoguAdventurePath() : String { return null; }
            public static function ManualDebrisIconPath(pic:String) : String { return null; }
            public static function ManualDebrisPNGIconPath(pic:String) : String { return null; }
            public static function get getTrusteeshipViewEnable() : Boolean { return false; }
            public static function getLoadingDevice() : String { return null; }
            public static function battleSkillIconPath(pic:String) : String { return null; }
            public static function loginDeviceLink() : String { return null; }
            public static function getBoneWeaponPath() : String { return null; }
            public static function getBoneLivingPath() : String { return null; }
            public static function getBoneLivingHeadPath(id:String) : String { return null; }
            public static function getBoneLivingBodyPath(id:String) : String { return null; }
            public static function getBeautyProveQQ() : String { return null; }
            public static function getSwfPath(name:String) : String { return null; }
            public static function getXMLPath(name:String) : String { return null; }
            public static function getMornUIPath(name:String) : String { return null; }
            public static function getMornLangPath(name:String) : String { return null; }
            public static function get OldPlayerTransferEnable() : Boolean { return false; }
   }}