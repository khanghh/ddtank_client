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
      
      private function __reloadXML(event:PkgEvent) : void
      {
         var num:int = 0;
         var loader:* = null;
         var pkg:PackageIn = event.pkg;
         num = pkg.readInt();
         switch(int(num) - 1)
         {
            case 0:
               loader = LoaderCreate.Instance.creatItemTempleteReload();
               break;
            case 1:
               loader = LoaderCreate.Instance.creatQuestTempleteReload();
         }
         if(loader)
         {
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private function __onUIModuleLoadError(event:UIModuleEvent) : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ddt.StartupResourceLoader.Error.LoadModuleError",event.module),LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         alert.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         LeavePageManager.leaveToLoginPath();
      }
      
      public function get progress() : int
      {
         var starlingProgress:int = 0;
         if(_starlingQueueLoader)
         {
            starlingProgress = _starlingQueueLoader.getCompletePrecent() * 10;
         }
         if(_loaderQueue == null)
         {
            return starlingProgress + int(_uimoduleProgress * 35) + 40;
         }
         if(_queueIsComplete)
         {
            return 99;
         }
         var percent:int = starlingProgress + _uimoduleProgress * 35 + _requestCompleted / _loaderQueue.length * 15 + 40;
         return percent > 99?99:percent;
      }
      
      public function start(mode:int) : void
      {
         _currentMode = mode;
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
      
      private function __onLoadLanZipComplete(event:LoaderEvent) : void
      {
         var temp:ByteArray = event.loader.content;
         analyMd5(temp);
      }
      
      private function zipLoad(content:ByteArray) : void
      {
         var zip:FZip = new FZip();
         zip.addEventListener("complete",__onZipParaComplete);
         zip.loadBytes(content);
      }
      
      private function analyMd5(content:ByteArray) : void
      {
         var temp:* = null;
         if(ComponentSetting.USEMD5 && (ComponentSetting.md5Dic["language.png"] || hasHead(content)))
         {
            if(compareMD5(content))
            {
               temp = new ByteArray();
               content.position = 37;
               content.readBytes(temp);
               zipLoad(temp);
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
            zipLoad(content);
         }
      }
      
      private function hasHead(temp:ByteArray) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var road7Byte:ByteArray = new ByteArray();
         road7Byte.writeUTFBytes(ComponentSetting.swf_head);
         road7Byte.position = 0;
         temp.position = 0;
         while(road7Byte.bytesAvailable > 0)
         {
            source = road7Byte.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function compareMD5(temp:ByteArray) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var md5Bytes:ByteArray = new ByteArray();
         md5Bytes.writeUTFBytes(ComponentSetting.md5Dic["language.png"]);
         md5Bytes.position = 0;
         temp.position = 5;
         while(md5Bytes.bytesAvailable > 0)
         {
            source = md5Bytes.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function __onZipParaComplete(event:Event) : void
      {
         if(_languageLoader)
         {
            _languageLoader.removeEventListener("complete",__onLoadLanZipComplete);
         }
         var zip:FZip = event.currentTarget as FZip;
         zip.removeEventListener("complete",__onZipParaComplete);
         var file:FZipFile = zip.getFileAt(0);
         var content:String = file.content.toString();
         LanguageMgr.setup(content);
         BonesLoaderManager.instance.addEventListener("bonesstylecompelete",__onLoaderBonesComplete);
         BonesLoaderManager.instance.loadBonesStyle("bones",PathManager.getBonesPath("bones"));
         BonesLoaderManager.instance.loadBonesStyle("gamebones",PathManager.getBonesPath("gamebones"));
      }
      
      private function __onLoaderBonesComplete(e:BonesLoaderEvent) : void
      {
         var loaderQueue:* = null;
         if(e.data as String == "bones")
         {
            BonesLoaderManager.instance.removeEventListener("bonesstylecompelete",__onLoaderBonesComplete);
            BoneMovieFactory.instance.setup();
            if(_currentMode > 0)
            {
               loaderQueue = new QueueLoader();
               loaderQueue.addLoader(LoaderCreate.Instance.creatZhanLoader());
               loaderQueue.addEventListener("complete",__onLoadLanguageComplete);
               loaderQueue.start();
            }
            else
            {
               dispatchEvent(new StartupEvent("coreSetupLoadComplete"));
            }
         }
      }
      
      private function __onLoadLanguageComplete(event:Event) : void
      {
         var loaderQueue:QueueLoader = event.currentTarget as QueueLoader;
         loaderQueue.removeEventListener("complete",__onLoadLanguageComplete);
         _starlingQueueLoader = new StarlingQueueLoader();
         var path:String = PathManager.getUIPath();
         var imagePath:String = PathManager.SITE_MAIN;
         _starlingQueueLoader.load([{"url":path + "/starling/hall_scene/hall_scene.png"},{"url":path + "/starling/hall_scene/hall_scene.xml"},{
            "url":imagePath + "image/title/title.png",
            "useType":2,
            "module":"none"
         },{
            "url":imagePath + "image/title/title.xml",
            "useType":2,
            "module":"none"
         },{"url":path + "/starling/default/default_resource.png"},{"url":path + "/starling/default/default_resource.xml"}],onStarlingQueueComplete);
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
      
      private function __onUIModuleProgress(event:UIModuleEvent) : void
      {
         var i:* = 0;
         var uiType:* = null;
         var loader:BaseLoader = event.loader;
         var loaderNumTotal:int = 35;
         if(event.module == "roadcomponent")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "coreiconandtip")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "ddtcorescalebitmap")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "chat")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "chatii")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "playertip")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "enthrall")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "trainer")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "trainerui")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "ddthall")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "ddthallmain")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "ddthallIcon")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "toolbar")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "ddtawardsystem")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(event.module == "uigeneral")
         {
            setLoaderProgressArr(event.module,loader.progress);
         }
         if(!_progressArr)
         {
            return;
         }
         var num:* = 0;
         var total:uint = _progressArr.length;
         for(i = uint(0); i < total; )
         {
            uiType = _progressArr[i];
            num = Number(num + _progressArr[uiType]);
            i++;
         }
         _uimoduleProgress = num / total;
      }
      
      private function setLoaderProgressArr($name:String, num:Number = 0) : void
      {
         if(!_progressArr)
         {
            _progressArr = [];
         }
         if(_progressArr.indexOf($name) < 0)
         {
            _progressArr.push($name);
            _progressArr[$name] = num;
         }
         else
         {
            _progressArr[$name] = num;
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
         var loaderQueue:QueueLoader = new QueueLoader();
         loaderQueue.addLoader(LoaderCreate.Instance.creatVoteSubmit());
         SendVersion();
         loaderQueue.addLoader(LoaderCreate.Instance.creatBallInfoLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.creatParticlesLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.creatFriendListLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.creatMyacademyPlayerListLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.getMyConsortiaData());
         loaderQueue.addLoader(LoaderCreate.Instance.createCalendarRequest());
         loaderQueue.addLoader(MailManager.Instance.getAllEmailLoader());
         loaderQueue.addLoader(MailManager.Instance.getSendedEmailLoader());
         loaderQueue.addLoader(ConsortionModelManager.Instance.getLevelUpInfo());
         loaderQueue.addLoader(LoaderCreate.Instance.creatFeedbackInfoLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.createConsortiaLoader());
         loaderQueue.addLoader(LoaderCreate.Instance.creatItemTempleteReload());
         loaderQueue.start();
      }
      
      private function __onSetupSourceLoadComplete(event:Event) : void
      {
         var queue:QueueLoader = event.currentTarget as QueueLoader;
         queue.removeEventListener("complete",__onSetupSourceLoadComplete);
         queue.removeEventListener("change",__onSetupSourceLoadChange);
         queue.dispose();
         queue = null;
         _queueIsComplete = true;
         dispatchEvent(new StartupEvent("coreSetupLoadComplete"));
      }
      
      private function __onUIMoudleComplete(event:UIModuleEvent) : void
      {
         if(event.module == "trainer" || event.module == "trainerui" || event.module == "trainerfirstgame")
         {
            if(event.module == "trainer")
            {
               _trainerComplete = true;
            }
            if(event.module == "trainerui")
            {
               _trainerUIComplete = true;
            }
            if(event.module == "trainerfirstgame")
            {
               _trainerFristComplete = true;
            }
            if(_trainerComplete && _trainerUIComplete && _trainerFristComplete)
            {
               dispatchEvent(new Event("userGuildResourceComplete"));
            }
         }
         if(event.module == "ddtawardsystem")
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
            addLoader(LoaderCreate.Instance.createTotemUpGradeTemplateLoader());
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
         if(event.module == "newopenguide")
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
      
      private function addLoader(loader:BaseLoader) : void
      {
         _loaderQueue.addLoader(loader);
      }
      
      private function __onSetupSourceLoadChange(event:Event) : void
      {
         _requestCompleted = (event.currentTarget as QueueLoader).completeCount;
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
      
      private function addUIModlue(ui:String) : void
      {
         UIModuleLoader.Instance.addUIModlue(ui);
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
         var myContextMenu:ContextMenu = new ContextMenu();
         myContextMenu.hideBuiltInItems();
         var item:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.share"));
         item.separatorBefore = true;
         myContextMenu.customItems.push(item);
         item.addEventListener("menuItemSelect",onQQMSNClick);
         var item1:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.collection"));
         item1.separatorBefore = true;
         myContextMenu.customItems.push(item1);
         item1.addEventListener("menuItemSelect",addFavClick);
         var item2:ContextMenuItem = new ContextMenuItem(LanguageMgr.GetTranslation("Crazytank.supply"));
         item2.addEventListener("menuItemSelect",goPayClick);
         myContextMenu.customItems.push(item2);
         myContextMenu.builtInItems.zoom = true;
         return myContextMenu;
      }
      
      private function onQQMSNClick(e:ContextMenuEvent) : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("getLocationUrl","");
         }
      }
      
      public function receivedFromJavaScript(str:String) : void
      {
         _receivedFromJavaScriptII(str);
      }
      
      private function _receivedFromJavaScriptII(str:String) : void
      {
         System.setClipboard(str);
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("crazytank.copyOK"),"","",false,false,false,2);
         alert.addEventListener("response",_response);
      }
      
      private function SendVersion() : void
      {
         var varialbes:URLVariables = new URLVariables();
         var urlLoader:URLLoader = new URLLoader();
         varialbes.version = Capabilities.version.split(" ")[1];
         var request:URLRequest = new URLRequest(PathManager.solveRequestPath("UpdateVersion.ashx"));
         request.method = "POST";
         request.data = varialbes;
         urlLoader.load(request);
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
         var varialbes:URLVariables = new URLVariables();
         var urlLoader:URLLoader = new URLLoader();
         varialbes.Version = Capabilities.version.split(" ")[1];
         varialbes.Sys = Capabilities.os;
         varialbes.UserName = PlayerManager.Instance.Account.Account;
         var request:URLRequest = new URLRequest(PathManager.solveRequestPath("RecordUserVersion.ashx"));
         request.method = "POST";
         request.data = varialbes;
         urlLoader.load(request);
      }
      
      private function sendUserVersion() : void
      {
         SendRecordManager.Instance.setUp();
      }
      
      private function addFavClick(e:ContextMenuEvent) : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("addToFavorite","");
         }
      }
      
      private function goPayClick(e:ContextMenuEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",_response);
         ObjectUtils.disposeObject(evt.target);
      }
      
      public function reloadGodSyah(pkg:PackageIn) : void
      {
         var loader:* = null;
         var type:int = pkg.readInt();
         SyahManager.Instance.isOpen = pkg.readBoolean();
         if(SyahManager.Instance.isOpen)
         {
            loader = LoaderCreate.Instance.creatGodSyahLoader(type);
            if(loader)
            {
               LoaderManager.Instance.startLoad(loader);
            }
         }
         else
         {
            SyahManager.Instance.stopSyah();
         }
      }
   }
}
