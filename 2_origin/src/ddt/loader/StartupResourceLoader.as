package ddt.loader
{
   import GodSyah.SyahManager;
   import SendRecord.SendRecordManager;
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.events.PkgEvent;
   import ddt.events.StartupEvent;
   import ddt.manager.DesktopManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import email.MailManager;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import road7th.StarlingPre;
   import road7th.comm.PackageIn;
   import starling.loader.StarlingQueueLoader;
   
   public class StartupResourceLoader extends EventDispatcher
   {
      
      public static const NEWBIE:int = 1;
      
      public static const NORMAL:int = 2;
      
      public static const USER_GUILD_RESOURCE_COMPLETE:String = "userGuildResourceComplete";
      
      private static var _instance:StartupResourceLoader;
      
      public static var firstEnterHall:Boolean = false;
       
      
      private var _currentMode:int = 0;
      
      private var starlingPre:StarlingPre;
      
      private var _languageLoader:BaseLoader;
      
      private var _languagePath:String;
      
      private var _isSecondLoad:Boolean = false;
      
      private var _starlingQueueLoader:StarlingQueueLoader;
      
      private var _uimoduleProgress:Number;
      
      private var _progressArr:Array;
      
      private var _trainerComplete:Boolean;
      
      private var _trainerUIComplete:Boolean;
      
      private var _trainerFristComplete:Boolean;
      
      public var _queueIsComplete:Boolean;
      
      private var _loaderQueue:QueueLoader;
      
      private var _requestCompleted:int;
      
      public function StartupResourceLoader()
      {
         super();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIMoudleComplete);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onUIModuleProgress);
         UIModuleLoader.Instance.addEventListener("uiModuleError",__onUIModuleLoadError);
         SocketManager.Instance.addEventListener(PkgEvent.format(139),__reloadXML);
      }
      
      public static function get Instance() : StartupResourceLoader
      {
         if(_instance == null)
         {
            _instance = new StartupResourceLoader();
         }
         return _instance;
      }
      
      private function __reloadXML(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         _loc2_ = _loc4_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               _loc3_ = LoaderCreate.Instance.creatItemTempleteReload();
               break;
            case 1:
               _loc3_ = LoaderCreate.Instance.creatQuestTempleteReload();
         }
         if(_loc3_)
         {
            LoadResourceManager.Instance.startLoad(_loc3_);
         }
      }
      
      private function __onUIModuleLoadError(param1:UIModuleEvent) : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ddt.StartupResourceLoader.Error.LoadModuleError",param1.module),LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         LeavePageManager.leaveToLoginPath();
      }
      
      public function get progress() : int
      {
         var _loc2_:int = 0;
         if(_starlingQueueLoader)
         {
            _loc2_ = _starlingQueueLoader.getCompletePrecent() * 10;
         }
         if(_loaderQueue == null)
         {
            return _loc2_ + int(_uimoduleProgress * 35) + 40;
         }
         if(_queueIsComplete)
         {
            return 99;
         }
         var _loc1_:int = _loc2_ + _uimoduleProgress * 35 + _requestCompleted / _loaderQueue.length * 15 + 40;
         return _loc1_ > 99?99:_loc1_;
      }
      
      public function start(param1:int) : void
      {
         _currentMode = param1;
         if(starlingPre)
         {
            return;
         }
         starlingPre = new StarlingPre();
         starlingPre.start(StageReferance.stage,loadLanguage);
      }
      
      private function loadLanguage() : void
      {
         _languagePath = PathManager.getLanguagePath();
         _languageLoader = LoadResourceManager.Instance.createLoader(_languagePath,3);
         _languageLoader.addEventListener("complete",__onLoadLanZipComplete);
         LoadResourceManager.Instance.startLoad(_languageLoader);
      }
      
      private function __onLoadLanZipComplete(param1:LoaderEvent) : void
      {
         var _loc2_:ByteArray = param1.loader.content;
         analyMd5(_loc2_);
      }
      
      private function zipLoad(param1:ByteArray) : void
      {
         var _loc2_:FZip = new FZip();
         _loc2_.addEventListener("complete",__onZipParaComplete);
         _loc2_.loadBytes(param1);
      }
      
      private function analyMd5(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         if(ComponentSetting.USEMD5 && (ComponentSetting.md5Dic["language.png"] || hasHead(param1)))
         {
            if(compareMD5(param1))
            {
               _loc2_ = new ByteArray();
               param1.position = 37;
               param1.readBytes(_loc2_);
               zipLoad(_loc2_);
            }
            else
            {
               if(_isSecondLoad)
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("alert",_languagePath + ":is old");
                  }
               }
               else
               {
                  _languagePath = _languagePath.replace(ComponentSetting.FLASHSITE,ComponentSetting.BACKUP_FLASHSITE);
                  _languageLoader.url = _languagePath + "?rnd=" + Math.random();
                  _languageLoader.isLoading = false;
                  _languageLoader.loadFromWeb();
               }
               _isSecondLoad = true;
            }
         }
         else
         {
            zipLoad(param1);
         }
      }
      
      private function hasHead(param1:ByteArray) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(ComponentSetting.swf_head);
         _loc2_.position = 0;
         param1.position = 0;
         while(_loc2_.bytesAvailable > 0)
         {
            _loc3_ = _loc2_.readByte();
            _loc4_ = param1.readByte();
            if(_loc3_ != _loc4_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function compareMD5(param1:ByteArray) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(ComponentSetting.md5Dic["language.png"]);
         _loc4_.position = 0;
         param1.position = 5;
         while(_loc4_.bytesAvailable > 0)
         {
            _loc2_ = _loc4_.readByte();
            _loc3_ = param1.readByte();
            if(_loc2_ != _loc3_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function __onZipParaComplete(param1:Event) : void
      {
         if(_languageLoader)
         {
            _languageLoader.removeEventListener("complete",__onLoadLanZipComplete);
         }
         var _loc3_:FZip = param1.currentTarget as FZip;
         _loc3_.removeEventListener("complete",__onZipParaComplete);
         var _loc4_:FZipFile = _loc3_.getFileAt(0);
         var _loc2_:String = _loc4_.content.toString();
         LanguageMgr.setup(_loc2_);
         BonesLoaderManager.instance.addEventListener("bonesstylecompelete",__onLoaderBonesComplete);
         BonesLoaderManager.instance.loadBonesStyle("bones",PathManager.getBonesPath("bones"));
         BonesLoaderManager.instance.loadBonesStyle("gamebones",PathManager.getBonesPath("gamebones"));
      }
      
      private function __onLoaderBonesComplete(param1:BonesLoaderEvent) : void
      {
         var _loc2_:* = null;
         if(param1.data as String == "bones")
         {
            BonesLoaderManager.instance.removeEventListener("bonesstylecompelete",__onLoaderBonesComplete);
            BoneMovieFactory.instance.setup();
            if(_currentMode > 0)
            {
               _loc2_ = new QueueLoader();
               _loc2_.addLoader(LoaderCreate.Instance.creatZhanLoader());
               _loc2_.addEventListener("complete",__onLoadLanguageComplete);
               _loc2_.start();
            }
            else
            {
               dispatchEvent(new StartupEvent("coreSetupLoadComplete"));
            }
         }
      }
      
      private function __onLoadLanguageComplete(param1:Event) : void
      {
         var _loc2_:QueueLoader = param1.currentTarget as QueueLoader;
         _loc2_.removeEventListener("complete",__onLoadLanguageComplete);
         _starlingQueueLoader = new StarlingQueueLoader();
         var _loc4_:String = PathManager.getUIPath();
         var _loc3_:String = PathManager.SITE_MAIN;
         _starlingQueueLoader.load([{"url":_loc4_ + "/starling/hall_scene/hall_scene.png"},{"url":_loc4_ + "/starling/hall_scene/hall_scene.xml"},{
            "url":_loc3_ + "image/title/title.png",
            "useType":2,
            "module":"none"
         },{
            "url":_loc3_ + "image/title/title.xml",
            "useType":2,
            "module":"none"
         },{"url":_loc4_ + "/starling/default/default_resource.png"},{"url":_loc4_ + "/starling/default/default_resource.xml"}],onStarlingQueueComplete);
      }
      
      private function onStarlingQueueComplete() : void
      {
         if(_currentMode == 1)
         {
            newBieXML();
         }
         else
         {
            loadUIModule();
         }
         _setStageRightMouse();
      }
      
      private function __onUIModuleProgress(param1:UIModuleEvent) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = null;
         var _loc4_:BaseLoader = param1.loader;
         var _loc5_:int = 35;
         if(param1.module == "roadcomponent")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "coreiconandtip")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "ddtcorescalebitmap")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "chat")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "chatii")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "playertip")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "enthrall")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "trainer")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "trainerui")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "ddthall")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "ddthallmain")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "ddthallIcon")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "toolbar")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "ddtawardsystem")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(param1.module == "uigeneral")
         {
            setLoaderProgressArr(param1.module,_loc4_.progress);
         }
         if(!_progressArr)
         {
            return;
         }
         var _loc3_:* = 0;
         var _loc2_:uint = _progressArr.length;
         _loc7_ = uint(0);
         while(_loc7_ < _loc2_)
         {
            _loc6_ = _progressArr[_loc7_];
            _loc3_ = Number(_loc3_ + _progressArr[_loc6_]);
            _loc7_++;
         }
         _uimoduleProgress = _loc3_ / _loc2_;
      }
      
      private function setLoaderProgressArr(param1:String, param2:Number = 0) : void
      {
         if(!_progressArr)
         {
            _progressArr = [];
         }
         if(_progressArr.indexOf(param1) < 0)
         {
            _progressArr.push(param1);
            _progressArr[param1] = param2;
         }
         else
         {
            _progressArr[param1] = param2;
         }
      }
      
      public function addUserGuildResource() : void
      {
         UIModuleLoader.Instance.addUIModlue("trainer");
         UIModuleLoader.Instance.addUIModlue("trainerfirstgame");
         UIModuleLoader.Instance.addUIModlue("trainerui");
      }
      
      public function finishLoadingProgress() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIMoudleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIModuleProgress);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onUIModuleLoadError);
         dispatchEvent(new Event("complete"));
      }
      
      public function startLoadRelatedInfo() : void
      {
         var _loc1_:QueueLoader = new QueueLoader();
         _loc1_.addLoader(LoaderCreate.Instance.creatVoteSubmit());
         SendVersion();
         _loc1_.addLoader(LoaderCreate.Instance.creatBallInfoLoader());
         _loc1_.addLoader(LoaderCreate.Instance.creatParticlesLoader());
         _loc1_.addLoader(LoaderCreate.Instance.creatFriendListLoader());
         _loc1_.addLoader(LoaderCreate.Instance.creatMyacademyPlayerListLoader());
         _loc1_.addLoader(LoaderCreate.Instance.getMyConsortiaData());
         _loc1_.addLoader(LoaderCreate.Instance.createCalendarRequest());
         _loc1_.addLoader(MailManager.Instance.getAllEmailLoader());
         _loc1_.addLoader(MailManager.Instance.getSendedEmailLoader());
         _loc1_.addLoader(ConsortionModelManager.Instance.getLevelUpInfo());
         _loc1_.addLoader(LoaderCreate.Instance.creatFeedbackInfoLoader());
         _loc1_.addLoader(LoaderCreate.Instance.createConsortiaLoader());
         _loc1_.addLoader(LoaderCreate.Instance.creatItemTempleteReload());
         _loc1_.start();
      }
      
      private function __onSetupSourceLoadComplete(param1:Event) : void
      {
         var _loc2_:QueueLoader = param1.currentTarget as QueueLoader;
         _loc2_.removeEventListener("complete",__onSetupSourceLoadComplete);
         _loc2_.removeEventListener("change",__onSetupSourceLoadChange);
         _loc2_.dispose();
         _loc2_ = null;
         _queueIsComplete = true;
         dispatchEvent(new StartupEvent("coreSetupLoadComplete"));
      }
      
      private function __onUIMoudleComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "trainer" || param1.module == "trainerui" || param1.module == "trainerfirstgame")
         {
            if(param1.module == "trainer")
            {
               _trainerComplete = true;
            }
            if(param1.module == "trainerui")
            {
               _trainerUIComplete = true;
            }
            if(param1.module == "trainerfirstgame")
            {
               _trainerFristComplete = true;
            }
            if(_trainerComplete && _trainerUIComplete && _trainerFristComplete)
            {
               dispatchEvent(new Event("userGuildResourceComplete"));
            }
         }
         if(param1.module == "ddtawardsystem")
         {
            LoaderSavingManager.saveFilesToLocal();
            dispatchEvent(new StartupEvent("coreUILoadComplete"));
            _loaderQueue = new QueueLoader();
            _queueIsComplete = false;
            _loaderQueue.addEventListener("change",__onSetupSourceLoadChange);
            _loaderQueue.addEventListener("complete",__onSetupSourceLoadComplete);
            addLoader(LoaderCreate.Instance.creatActiveInfoLoader());
            addLoader(LoaderCreate.Instance.creatItemTempleteLoader());
            addLoader(LoaderCreate.Instance.creatGoodCategoryLoader());
            addLoader(LoaderCreate.Instance.creatShopTempleteLoader());
            addLoader(LoaderCreate.Instance.createCardSetsSortRule());
            addLoader(LoaderCreate.Instance.createCardSetsProperties());
            addLoader(ConsortionModelManager.Instance.loadSkillInfoList());
            addLoader(LoaderCreate.Instance.creatServerListLoader());
            addLoader(LoaderCreate.Instance.creatSelectListLoader());
            addLoader(LoaderCreate.Instance.creatQuestTempleteLoader());
            addLoader(LoaderCreate.Instance.creatUserBoxInfoLoader());
            addLoader(LoaderCreate.Instance.creatBoxTempInfoLoader());
            addLoader(LoaderCreate.Instance.creatDailyInfoLoader());
            addLoader(LoaderCreate.Instance.creatShopSortLoader());
            addLoader(LoaderCreate.Instance.creatMapInfoLoader());
            addLoader(LoaderCreate.Instance.creatDungeonInfoLoader());
            addLoader(LoaderCreate.Instance.creatOpenMapInfoLoader());
            addLoader(LoaderCreate.Instance.creatExpericenceAnalyzeLoader());
            addLoader(LoaderCreate.Instance.creatWeaponBallAnalyzeLoader());
            addLoader(LoaderCreate.Instance.createWishInfoLader());
            addLoader(LoaderCreate.Instance.creatServerConfigLoader());
            addLoader(LoaderCreate.Instance.creatPetInfoLoader());
            addLoader(LoaderCreate.Instance.creatPetSkillLoader());
            addLoader(LoaderCreate.Instance.createActivitySystemItemsLoader());
            addLoader(LoaderCreate.Instance.createCityOccupationSystemsLoader());
            addLoader(LoaderCreate.Instance.creatPetConfigLoader());
            addLoader(LoaderCreate.Instance.createStoreEquipConfigLoader());
            addLoader(LoaderCreate.Instance.creatCardGrooveLoader());
            addLoader(LoaderCreate.Instance.creatCardTemplateLoader());
            addLoader(LoaderCreate.Instance.createBeadTemplateLoader());
            addLoader(LoaderCreate.Instance.createBeadAdvanceTemplateLoader());
            addLoader(LoaderCreate.Instance.creatShopDisCountRealTimesLoader());
            addLoader(LoaderCreate.Instance.creatHallIcon());
            addLoader(LoaderCreate.Instance.createTotemTemplateLoader());
            addLoader(LoaderCreate.Instance.creatActiveLoader());
            addLoader(LoaderCreate.Instance.creatActivePointLoader());
            addLoader(LoaderCreate.Instance.creatWondActiveLoader());
            addLoader(LoaderCreate.Instance.createBraveDoorDuplicateTemplate());
            addLoader(LoaderCreate.Instance.creatBallInfoLoader());
            addLoader(LoaderCreate.Instance.createCommunalActiveLoader());
            addLoader(LoaderCreate.Instance.createEnergyDataLoader());
            addLoader(LoaderCreate.Instance.loadWonderfulActivityXml());
            addLoader(LoaderCreate.Instance.getPetsFormDataLoader());
            addLoader(LoaderCreate.Instance.loadMagicStoneTemplate());
            addLoader(LoaderCreate.Instance.createHorseSkillDataLoader());
            addLoader(LoaderCreate.Instance.createNewTitleDataLoader());
            addLoader(LoaderCreate.Instance.createEnchantMagicInfoLoader());
            addLoader(LoaderCreate.Instance.createFineSuitInfoLoader());
            addLoader(LoaderCreate.Instance.createHorseTemplateDataLoader());
            addLoader(LoaderCreate.Instance.createHorseSkillGetDataLoader());
            addLoader(LoaderCreate.Instance.creatRingSystemLoader());
            addLoader(LoaderCreate.Instance.creatGuardCoreLevelTemplate());
            addLoader(LoaderCreate.Instance.creatGuardCoreTemplate());
            addLoader(LoaderCreate.Instance.createLoadPetMoePropertyLoader());
            addLoader(LoaderCreate.Instance.accumulativeLoginLoader());
            addLoader(LoaderCreate.Instance.createCaddyAwardsLoader());
            addLoader(LoaderCreate.Instance.createConsortiaBossTemplateLoader());
            addLoader(LoaderCreate.Instance.createMagicBoxDataLoader());
            if(PathManager.suitEnable)
            {
               addLoader(LoaderCreate.Instance.creatSuitTempleteLoader());
               addLoader(LoaderCreate.Instance.creatEquipSuitTempleteLoader());
            }
            if(PathManager.GodSyahEnable)
            {
               addLoader(LoaderCreate.Instance.creatGodSyahLoader());
            }
            addLoader(LoaderCreate.Instance.creatParticlesLoader());
            addLoader(LoaderCreate.Instance.createCampBattleAwardGoodsLoader());
            addLoader(LoaderCreate.Instance.createCardAchievementTemplate());
            addLoader(LoaderCreate.Instance.createHorseAmuletTemplate());
            addLoader(LoaderCreate.Instance.createAvatarCollectionItemDataLoader());
            addLoader(LoaderCreate.Instance.createManualItemData());
            addLoader(LoaderCreate.Instance.createEquipAmuletTemplate());
            addLoader(LoaderCreate.Instance.createEquipAmuletGradeTemplate());
            addLoader(LoaderCreate.Instance.createEquipAmuletPhaseTemplate());
            addLoader(LoaderCreate.Instance.createDDTKingWayTemplate());
            addLoader(LoaderCreate.Instance.createEvolutionData());
            addLoader(LoaderCreate.Instance.creatOneYuanBuyGoodsLoader());
            addLoader(LoaderCreate.Instance.createBattleSkillTemplate());
            addLoader(LoaderCreate.Instance.creatOneYuanBuySaleItemLoader());
            addLoader(LoaderCreate.Instance.createEquipGhostLoader());
            addLoader(LoaderCreate.Instance.createMinesDropLoader());
            addLoader(LoaderCreate.Instance.createMinesLevelLoader());
            addLoader(LoaderCreate.Instance.createMarkChipLoader());
            addLoader(LoaderCreate.Instance.createMarkSuitLoader());
            addLoader(LoaderCreate.Instance.createMarkSetLoader());
            _loaderQueue.start();
         }
         if(param1.module == "newopenguide")
         {
            dispatchEvent(new Event("RegisterUIModuleComplete"));
         }
      }
      
      private function newBieXML() : void
      {
         _loaderQueue = new QueueLoader();
         _queueIsComplete = false;
         _loaderQueue.addEventListener("change",__onSetupSourceLoadChange);
         _loaderQueue.addEventListener("complete",__onSetupSourceLoadComplete);
         addLoader(LoaderCreate.Instance.creatActiveInfoLoader());
         addLoader(LoaderCreate.Instance.creatItemTempleteLoader());
         addLoader(LoaderCreate.Instance.creatGoodCategoryLoader());
         addLoader(LoaderCreate.Instance.creatShopTempleteLoader());
         addLoader(LoaderCreate.Instance.creatServerListLoader());
         addLoader(LoaderCreate.Instance.creatSelectListLoader());
         addLoader(LoaderCreate.Instance.creatQuestTempleteLoader());
         addLoader(LoaderCreate.Instance.creatMapInfoLoader());
         addLoader(LoaderCreate.Instance.creatDungeonInfoLoader());
         addLoader(LoaderCreate.Instance.creatOpenMapInfoLoader());
         addLoader(LoaderCreate.Instance.creatExpericenceAnalyzeLoader());
         addLoader(LoaderCreate.Instance.creatWeaponBallAnalyzeLoader());
         addLoader(LoaderCreate.Instance.creatServerConfigLoader());
         addLoader(LoaderCreate.Instance.creatHallIcon());
         addLoader(LoaderCreate.Instance.creatBallInfoLoader());
         addLoader(LoaderCreate.Instance.creatParticlesLoader());
         addLoader(LoaderCreate.Instance.createStoreEquipConfigLoader());
         addLoader(LoaderCreate.Instance.loadWonderfulActivityXml());
         addLoader(LoaderCreate.Instance.createCommunalActiveLoader());
         addLoader(LoaderCreate.Instance.creatShopSortLoader());
         addLoader(LoaderCreate.Instance.creatActiveLoader());
         addLoader(LoaderCreate.Instance.creatActivePointLoader());
         addLoader(LoaderCreate.Instance.createEnergyDataLoader());
         addLoader(LoaderCreate.Instance.createActivitySystemItemsLoader());
         addLoader(LoaderCreate.Instance.createCityOccupationSystemsLoader());
         addLoader(LoaderCreate.Instance.creatShopDisCountRealTimesLoader());
         addLoader(LoaderCreate.Instance.creatUserBoxInfoLoader());
         addLoader(LoaderCreate.Instance.creatBoxTempInfoLoader());
         addLoader(LoaderCreate.Instance.createCardSetsSortRule());
         addLoader(LoaderCreate.Instance.createCardSetsProperties());
         addLoader(LoaderCreate.Instance.createNewTitleDataLoader());
         addLoader(LoaderCreate.Instance.loadMagicStoneTemplate());
         addLoader(LoaderCreate.Instance.creatPetInfoLoader());
         addLoader(LoaderCreate.Instance.creatPetSkillLoader());
         addLoader(LoaderCreate.Instance.creatPetConfigLoader());
         addLoader(LoaderCreate.Instance.createHorseSkillDataLoader());
         addLoader(LoaderCreate.Instance.createEnchantMagicInfoLoader());
         addLoader(LoaderCreate.Instance.createFineSuitInfoLoader());
         addLoader(LoaderCreate.Instance.createHorseTemplateDataLoader());
         addLoader(LoaderCreate.Instance.createHorseSkillGetDataLoader());
         addLoader(LoaderCreate.Instance.createTotemTemplateLoader());
         addLoader(LoaderCreate.Instance.creatCardGrooveLoader());
         addLoader(LoaderCreate.Instance.creatCardTemplateLoader());
         addLoader(LoaderCreate.Instance.createBeadTemplateLoader());
         addLoader(LoaderCreate.Instance.creatRingSystemLoader());
         addLoader(LoaderCreate.Instance.creatGuardCoreLevelTemplate());
         addLoader(LoaderCreate.Instance.creatGuardCoreTemplate());
         addLoader(LoaderCreate.Instance.createLoadPetMoePropertyLoader());
         if(PathManager.GodSyahEnable)
         {
            addLoader(LoaderCreate.Instance.creatGodSyahLoader());
         }
         addLoader(LoaderCreate.Instance.createCardAchievementTemplate());
         addLoader(LoaderCreate.Instance.createHorseAmuletTemplate());
         addLoader(LoaderCreate.Instance.createAvatarCollectionItemDataLoader());
         addLoader(LoaderCreate.Instance.createEquipAmuletTemplate());
         addLoader(LoaderCreate.Instance.createEquipAmuletGradeTemplate());
         addLoader(LoaderCreate.Instance.createEquipAmuletPhaseTemplate());
         addLoader(LoaderCreate.Instance.createDDTKingWayTemplate());
         addLoader(LoaderCreate.Instance.createMinesDropLoader());
         addLoader(LoaderCreate.Instance.createMinesLevelLoader());
         _loaderQueue.start();
      }
      
      private function addLoader(param1:BaseLoader) : void
      {
         _loaderQueue.addLoader(param1);
      }
      
      private function __onSetupSourceLoadChange(param1:Event) : void
      {
         _requestCompleted = (param1.currentTarget as QueueLoader).completeCount;
      }
      
      public function addRegisterUIModule() : void
      {
         firstEnterHall = true;
         addUIModlue("uicomponent");
         addUIModlue("uigeneral");
         addUIModlue("roadcomponent");
         addUIModlue("firstcore");
         addUIModlue("ddtcorescalebitmap");
         addUIModlue("chat");
         addUIModlue("enthrall");
         addUIModlue("trainerfirstgame");
         addUIModlue("trainerui");
         addUIModlue("toolbar");
         addUIModlue("ddtcoreii");
         addUIModlue("systemopenprompt");
         addUIModlue("ddthall");
         addUIModlue("ddthallmain");
         addUIModlue("ddthallIcon");
         addUIModlue("ddtcorei");
         addUIModlue("coreiconandtip");
         addUIModlue("playertip");
         addUIModlue("chatii");
         addUIModlue("trainer");
         addUIModlue("newopenguide");
         setLoaderProgressArr("uicomponent");
         setLoaderProgressArr("uigeneral");
         setLoaderProgressArr("roadcomponent");
         setLoaderProgressArr("firstcore");
         setLoaderProgressArr("ddtcorescalebitmap");
         setLoaderProgressArr("chat");
         setLoaderProgressArr("enthrall");
         setLoaderProgressArr("trainerfirstgame");
         setLoaderProgressArr("trainerui");
         setLoaderProgressArr("toolbar");
         setLoaderProgressArr("ddtcoreii");
         setLoaderProgressArr("systemopenprompt");
         setLoaderProgressArr("ddthall");
         setLoaderProgressArr("ddthallmain");
         setLoaderProgressArr("ddthallIcon");
         setLoaderProgressArr("ddtcorei");
         setLoaderProgressArr("coreiconandtip");
         setLoaderProgressArr("playertip");
         setLoaderProgressArr("chatii");
         setLoaderProgressArr("trainer");
         setLoaderProgressArr("newopenguide");
      }
      
      public function addThirdGameUI() : void
      {
         firstEnterHall = false;
         UIModuleLoader.Instance.addUIModlue("ddthall");
         UIModuleLoader.Instance.addUIModlue("ddthallmain");
         UIModuleLoader.Instance.addUIModlue("ddthallIcon");
         UIModuleLoader.Instance.addUIModlue("ddtcorei");
         UIModuleLoader.Instance.addUIModlue("ddtcoreii");
         UIModuleLoader.Instance.addUIModlue("systemopenprompt");
         UIModuleLoader.Instance.addUIModlue("ddtcorescalebitmap");
         UIModuleLoader.Instance.addUIModlue("coreiconandtip");
         UIModuleLoader.Instance.addUIModlue("chatii");
         UIModuleLoader.Instance.addUIModlue("trainer");
         UIModuleLoader.Instance.addUIModlue("playertip");
         UIModuleLoader.Instance.addUIModlue("uigeneral");
         UIModuleLoader.Instance.addUIModlue("ddtawardsystem");
      }
      
      private function loadUIModule() : void
      {
         if(_currentMode == 2)
         {
            addUIModlue("uicomponent");
            addUIModlue("uigeneral");
            addUIModlue("roadcomponent");
            addUIModlue("ddtcorescalebitmap");
            addUIModlue("trainer");
            addUIModlue("coreiconandtip");
            addUIModlue("firstcore");
            addUIModlue("ddtcorei");
            addUIModlue("ddtim");
            addUIModlue("ddtcoreii");
            addUIModlue("systemopenprompt");
            addUIModlue("chat");
            addUIModlue("chatii");
            addUIModlue("playertip");
            addUIModlue("enthrall");
            addUIModlue("ddthall");
            addUIModlue("ddthallmain");
            addUIModlue("ddthallIcon");
            addUIModlue("wonderfulactivity");
            addUIModlue("toolbar");
            addUIModlue("newopenguide");
            addUIModlue("newversionguide");
            addUIModlue("ddtawardsystem");
            setLoaderProgressArr("uicomponent");
            setLoaderProgressArr("uigeneral");
            setLoaderProgressArr("roadcomponent");
            setLoaderProgressArr("coreiconandtip");
            setLoaderProgressArr("ddtcorescalebitmap");
            setLoaderProgressArr("firstcore");
            setLoaderProgressArr("ddtcorei");
            setLoaderProgressArr("ddtim");
            setLoaderProgressArr("ddtcoreii");
            setLoaderProgressArr("systemopenprompt");
            setLoaderProgressArr("chat");
            setLoaderProgressArr("chatii");
            setLoaderProgressArr("playertip");
            setLoaderProgressArr("enthrall");
            setLoaderProgressArr("ddthall");
            setLoaderProgressArr("ddthallmain");
            setLoaderProgressArr("ddthallIcon");
            setLoaderProgressArr("toolbar");
            setLoaderProgressArr("newopenguide");
            setLoaderProgressArr("newversionguide");
            setLoaderProgressArr("ddtawardsystem");
         }
      }
      
      public function addFirstGameNotStartupNeededResource() : void
      {
         UIModuleLoader.Instance.addUIModlue("ddtroomloading");
         UIModuleLoader.Instance.addUIModlue("gameiii");
      }
      
      public function addNotStartupNeededResource() : void
      {
      }
      
      private function addUIModlue(param1:String) : void
      {
         UIModuleLoader.Instance.addUIModlue(param1);
      }
      
      private function _setStageRightMouse() : void
      {
         LayerManager.Instance.getLayerByType(7).contextMenu = creatRightMenu();
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.addCallback("sendSwfNowUrl",receivedFromJavaScript);
         }
      }
      
      private function creatRightMenu() : ContextMenu
      {
         var _loc4_:ContextMenu = new ContextMenu();
         _loc4_.hideBuiltInItems();
         var _loc3_:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.share"));
         _loc3_.separatorBefore = true;
         _loc4_.customItems.push(_loc3_);
         _loc3_.addEventListener("menuItemSelect",onQQMSNClick);
         var _loc2_:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.collection"));
         _loc2_.separatorBefore = true;
         _loc4_.customItems.push(_loc2_);
         _loc2_.addEventListener("menuItemSelect",addFavClick);
         var _loc1_:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.supply"));
         _loc1_.addEventListener("menuItemSelect",goPayClick);
         _loc4_.customItems.push(_loc1_);
         _loc4_.builtInItems.zoom = true;
         return _loc4_;
      }
      
      private function onQQMSNClick(param1:ContextMenuEvent) : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("getLocationUrl","");
         }
      }
      
      public function receivedFromJavaScript(param1:String) : void
      {
         _receivedFromJavaScriptII(param1);
      }
      
      private function _receivedFromJavaScriptII(param1:String) : void
      {
         System.setClipboard(param1);
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("crazytank.copyOK"),"","",false,false,false,2);
         _loc2_.addEventListener("response",_response);
      }
      
      private function SendVersion() : void
      {
         var _loc3_:URLVariables = new URLVariables();
         var _loc1_:URLLoader = new URLLoader();
         _loc3_.version = Capabilities.version.split(" ")[1];
         var _loc2_:URLRequest = new URLRequest(PathManager.solveRequestPath("UpdateVersion.ashx"));
         _loc2_.method = "POST";
         _loc2_.data = _loc3_;
         _loc1_.load(_loc2_);
         if(PathManager.isSendRecordUserVersion)
         {
            sendRecordUserVersion();
         }
         if(PathManager.isSendFlashInfo && !SharedManager.Instance.flashInfoExist)
         {
            sendUserVersion();
         }
      }
      
      private function sendRecordUserVersion() : void
      {
         var _loc3_:URLVariables = new URLVariables();
         var _loc1_:URLLoader = new URLLoader();
         _loc3_.Version = Capabilities.version.split(" ")[1];
         _loc3_.Sys = Capabilities.os;
         _loc3_.UserName = PlayerManager.Instance.Account.Account;
         var _loc2_:URLRequest = new URLRequest(PathManager.solveRequestPath("RecordUserVersion.ashx"));
         _loc2_.method = "POST";
         _loc2_.data = _loc3_;
         _loc1_.load(_loc2_);
      }
      
      private function sendUserVersion() : void
      {
         SendRecordManager.Instance.setUp();
      }
      
      private function addFavClick(param1:ContextMenuEvent) : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("addToFavorite","");
         }
      }
      
      private function goPayClick(param1:ContextMenuEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_response);
         ObjectUtils.disposeObject(param1.target);
      }
      
      public function reloadGodSyah(param1:PackageIn) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = param1.readInt();
         SyahManager.Instance.isOpen = param1.readBoolean();
         if(SyahManager.Instance.isOpen)
         {
            _loc2_ = LoaderCreate.Instance.creatGodSyahLoader(_loc3_);
            if(_loc2_)
            {
               LoaderManager.Instance.startLoad(_loc2_);
            }
         }
         else
         {
            SyahManager.Instance.stopSyah();
         }
      }
   }
}
