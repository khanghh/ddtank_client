package roomLoading.view
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelController;
   import ddt.data.BallInfo;
   import ddt.loader.MapLoader;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.TrainerLoader;
   import ddt.manager.BallManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.GameNeedPetSkillInfo;
   import gameCommon.model.Player;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import labyrinth.LabyrinthManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import sevenDouble.SevenDoubleManager;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   import worldboss.WorldBossManager;
   
   public class RoomLoadingView extends Sprite implements Disposeable
   {
      
      protected static const DELAY_TIME:int = 1000;
       
      
      protected var _bg:Bitmap;
      
      protected var _gameInfo:GameInfo;
      
      protected var _versus:RoomLoadingVersusItem;
      
      protected var _countDownTxt:RoomLoadingCountDownNum;
      
      protected var _battleField:RoomLoadingBattleFieldItem;
      
      protected var _tipsItem:RoomLoadingTipsItem;
      
      protected var _viewerItem:RoomLoadingViewerItem;
      
      protected var _dungeonMapItem:RoomLoadingDungeonMapItem;
      
      protected var _characterItems:Vector.<RoomLoadingCharacterItem>;
      
      protected var _countDownTimer:Timer;
      
      protected var _selfFinish:Boolean;
      
      protected var _trainerLoad:TrainerLoader;
      
      protected var _startTime:Number;
      
      protected var _chatViewBg:Image;
      
      protected var blueIdx:int = 1;
      
      protected var redIdx:int = 1;
      
      protected var blueCharacterIndex:int = 1;
      
      protected var redCharacterIndex:int = 1;
      
      protected var blueBig:RoomLoadingCharacterItem;
      
      protected var redBig:RoomLoadingCharacterItem;
      
      protected var _leaving:Boolean = false;
      
      protected var _amountOfFinishedPlayer:int = 0;
      
      protected var _hasLoadedFinished:DictionaryData;
      
      protected var _delayBeginTime:Number = 0;
      
      private var _cancelLink:FilterFrameText;
      
      protected var _unloadedmsg:String = "";
      
      public function RoomLoadingView(param1:GameInfo)
      {
         _hasLoadedFinished = new DictionaryData();
         super();
         _gameInfo = param1;
         init();
      }
      
      protected function init() : void
      {
         if(NewHandGuideManager.Instance.mapID == 111)
         {
            _startTime = new Date().getTime();
         }
         TimeManager.Instance.enterFightTime = new Date().getTime();
         LevelRewardManager.Instance.hide();
         _characterItems = new Vector.<RoomLoadingCharacterItem>();
         KeyboardShortcutsManager.Instance.forbiddenFull();
         if(_gameInfo.gameMode == 121)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.roomloading.survival.vsBg");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.roomloading.vsBg");
         }
         var _loc2_:int = RoomManager.Instance.current.gameMode;
         _versus = ComponentFactory.Instance.creatCustomObject("roomLoading.VersusItem",[RoomManager.Instance.current.gameMode]);
         _countDownTxt = ComponentFactory.Instance.creatCustomObject("roomLoading.CountDownItem");
         _battleField = ComponentFactory.Instance.creatCustomObject("roomLoading.BattleFieldItem",[_gameInfo.mapIndex]);
         _tipsItem = ComponentFactory.Instance.creatCustomObject("roomLoading.TipsItem");
         _viewerItem = ComponentFactory.Instance.creatCustomObject("roomLoading.ViewerItem");
         _chatViewBg = ComponentFactory.Instance.creatComponentByStylename("roomloading.ChatViewBg");
         _selfFinish = false;
         addChild(_bg);
         addChild(_chatViewBg);
         addChild(_versus);
         addChild(_countDownTxt);
         addChild(_battleField);
         addChild(_tipsItem);
         initLoadingItems();
         if(_gameInfo.gameMode == 7 || _gameInfo.gameMode == 31 || _gameInfo.gameMode == 4 || _gameInfo.gameMode == 8 || _gameInfo.gameMode == 10 || _gameInfo.gameMode == 17 || _gameInfo.gameMode == 19 || _gameInfo.gameMode == 24 || _gameInfo.gameMode == 25 || _gameInfo.gameMode == 40 || _gameInfo.gameMode == 50 || _gameInfo.gameMode == 31 || _gameInfo.gameMode == 52 || _gameInfo.gameMode == 55 || _gameInfo.gameMode == 55 || _gameInfo.gameMode == 47 || _gameInfo.gameMode == 49 || _gameInfo.gameMode == 151 || _gameInfo.gameMode == 155)
         {
            if(!redBig)
            {
               _dungeonMapItem = ComponentFactory.Instance.creatCustomObject("roomLoading.DungeonMapItem");
            }
         }
         if(_dungeonMapItem)
         {
            addChild(_dungeonMapItem);
         }
         var _loc1_:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 25 || RoomManager.Instance.current.type == 43 || RoomManager.Instance.current.type == 123?94:64;
         _countDownTimer = new Timer(1000,_loc1_);
         _countDownTimer.addEventListener("timer",__countDownTick);
         _countDownTimer.addEventListener("timerComplete",__countDownComplete);
         _countDownTimer.start();
         StateManager.currentStateType = "gameLoading";
         if(NewHandGuideManager.Instance.mapID == 112)
         {
            NoviceDataManager.instance.saveNoviceData(360,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(BombKingManager.instance.Recording)
         {
            addCancelLink();
         }
      }
      
      private function addCancelLink() : void
      {
         _cancelLink = ComponentFactory.Instance.creatComponentByStylename("room.roomLoading.cancelLook");
         _cancelLink.htmlText = LanguageMgr.GetTranslation("bombKing.roomLoading.cancelLookTxt");
         _cancelLink.mouseEnabled = true;
         addChild(_cancelLink);
         _cancelLink.addEventListener("link",__onCancelLinkClick);
      }
      
      private function deleteCancelLink() : void
      {
         if(_cancelLink)
         {
            _cancelLink.removeEventListener("link",__onCancelLinkClick);
            _cancelLink.dispose();
            _cancelLink = null;
         }
      }
      
      private function __onCancelLinkClick(param1:TextEvent) : void
      {
         BombKingControl.instance.reset();
         StateManager.setState("main");
      }
      
      protected function initLoadingItems() : void
      {
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc13_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:int = _gameInfo.roomPlayers.length;
         _loc12_ = _gameInfo.roomPlayers;
         loadingBombAsset();
         var _loc15_:int = 0;
         var _loc14_:* = _loc12_;
         for each(var _loc1_ in _loc12_)
         {
            if(PlayerManager.Instance.Self.ID == _loc1_.playerInfo.ID)
            {
               _loc9_ = _loc1_.team;
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = _loc12_;
         for each(var _loc2_ in _loc12_)
         {
            if(!_loc2_.isViewer)
            {
               if(_loc2_.team == 1)
               {
                  _loc7_++;
                  §§push(_loc7_);
               }
               else
               {
                  _loc11_++;
                  §§push(int(_loc11_));
               }
               §§pop();
               if(!(RoomManager.Instance.current.type == 0 && _loc2_.team != _loc9_))
               {
                  IMManager.Instance.saveRecentContactsID(_loc2_.playerInfo.ID);
               }
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc3_ = _gameInfo.roomPlayers[_loc10_];
            _loc3_.addEventListener("progressChange",__onLoadingFinished);
            if(_loc3_.isViewer)
            {
               if(contains(_tipsItem))
               {
                  removeChild(_tipsItem);
               }
               addChild(_viewerItem);
            }
            else
            {
               _loc13_ = new RoomLoadingCharacterItem(_loc3_,RoomManager.Instance.current.type == 121);
               _loc4_ = _gameInfo.findLivingByPlayerID(_loc3_.playerInfo.ID,_loc3_.playerInfo.ZoneID);
               if(RoomManager.Instance.current.type == 121)
               {
                  setSurvivalRoomItemPos(_loc13_,_loc4_.team);
                  setSurvivalCharacter(_loc4_,_loc13_,_loc4_.team - 1);
               }
               else
               {
                  initRoomItem(_loc13_);
                  initCharacter(_loc4_,_loc13_);
               }
               _loc5_ = _loc4_.playerInfo.currentPet;
               loadingPetAsset(_loc5_);
               _loc6_ = _loc3_.horseSkillEquipList;
               loadingHorseAsset(_loc6_);
            }
            _loc10_++;
         }
         if(blueBig)
         {
            addChild(blueBig);
         }
         if(redBig)
         {
            addChild(redBig);
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            loadingNeededMovies();
            loadingPetSkillAsset();
         }
         _gameInfo.loaderMap = new MapLoader(MapManager.getMapInfo(_gameInfo.mapIndex));
         _gameInfo.loaderMap.load();
         laodingTrainer();
         BuffManager.loadBuffTemplate();
      }
      
      protected function laodingTrainer() : void
      {
         switch(int(NewHandGuideManager.Instance.mapID) - 111)
         {
            case 0:
               _trainerLoad = new TrainerLoader("1");
               break;
            case 1:
               _trainerLoad = new TrainerLoader("2");
               break;
            case 2:
               _trainerLoad = new TrainerLoader("3");
               break;
            case 3:
               _trainerLoad = new TrainerLoader("4");
               break;
            case 4:
               _trainerLoad = new TrainerLoader("5");
               break;
            case 5:
               _trainerLoad = new TrainerLoader("6");
         }
         if(_trainerLoad)
         {
            _trainerLoad.load();
         }
      }
      
      protected function loadingPetSkillAsset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _gameInfo.neededPetSkillResource;
         for each(var _loc1_ in _gameInfo.neededPetSkillResource)
         {
            _loc1_.startLoad();
         }
      }
      
      protected function loadingNeededMovies() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _gameInfo.neededMovies.length)
         {
            if(_gameInfo.neededMovies[_loc1_].type == 1)
            {
               _gameInfo.neededMovies[_loc1_].startLoad();
            }
            _loc1_++;
         }
      }
      
      protected function loadingBombAsset() : void
      {
         var _loc1_:Array = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb(_loc1_);
         if(!StartupResourceLoader.firstEnterHall)
         {
            LoadBombManager.Instance.loadSpecialBomb();
         }
         LoadBombManager.Instance.loadOutBomb(_gameInfo.getOutBombsIdList());
         if(_gameInfo.roomType == 120)
         {
            LoadBombManager.Instance.loadSceneEffectBomb();
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect("effect070"),4);
         }
      }
      
      protected function loadingPetAsset(param1:PetInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(param1.GameAssetUrl),4);
            var _loc6_:int = 0;
            var _loc5_:* = param1.equipdSkills;
            for each(var _loc4_ in param1.equipdSkills)
            {
               if(_loc4_ > 0)
               {
                  _loc3_ = PetSkillManager.getSkillByID(_loc4_);
                  if(_loc3_.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(_loc3_.EffectPic),4);
                  }
                  if(_loc3_.NewBallID != -1)
                  {
                     _loc2_ = BallManager.instance.findBall(_loc3_.NewBallID);
                     _loc2_.loadBombAsset();
                     _loc2_.loadCraterBitmap();
                  }
               }
            }
         }
      }
      
      protected function loadingHorseAsset(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_ > 0)
            {
               _loc4_ = HorseManager.instance.getHorseSkillInfoById(_loc3_);
               if(_loc4_.EffectPic)
               {
                  LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(_loc4_.EffectPic),4);
               }
               if(_loc4_.NewBallID != -1)
               {
                  _loc2_ = BallManager.instance.findBall(_loc4_.NewBallID);
                  _loc2_.loadBombAsset();
                  _loc2_.loadCraterBitmap();
               }
            }
         }
      }
      
      private function setSurvivalCharacter(param1:Player, param2:RoomLoadingCharacterItem, param3:int) : void
      {
         var _loc5_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var _loc4_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         param1.movie = param2.info.movie;
         param1.character = param2.info.character;
         param1.character.showGun = false;
         param1.character.showWing = false;
         if(param3 % 2 == 0)
         {
            param2.appear(blueCharacterIndex.toString());
            param2.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
            PositionUtils.setPos(param2.displayMc,"asset.roomloading.SurvivalCharacterLeftPos");
         }
         else
         {
            param2.appear(redCharacterIndex.toString());
            param2.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
            PositionUtils.setPos(param2.displayMc,"asset.roomloading.SurvivalCharacterRightPos");
         }
         param1.character.show(false,-1);
         param1.movie.show(true,-1);
      }
      
      private function setSurvivalRoomItemPos(param1:RoomLoadingCharacterItem, param2:int) : void
      {
         PositionUtils.setPos(param1,"asset.roomLoading.CharacterItemSurvivalPos_" + param2.toString());
         param1.addWeapon(true,-1);
         _characterItems.push(param1);
         addChild(param1);
      }
      
      protected function __onLoadingFinished(param1:Event) : void
      {
         var _loc2_:RoomPlayer = param1.currentTarget as RoomPlayer;
         if(_loc2_.progress < 100 || _hasLoadedFinished.hasKey(_loc2_))
         {
            return;
         }
         _amountOfFinishedPlayer = Number(_amountOfFinishedPlayer) + 1;
         _hasLoadedFinished.add(_loc2_,_loc2_);
         if(_amountOfFinishedPlayer == _gameInfo.roomPlayers.length)
         {
            leave();
         }
      }
      
      protected function initCharacter(param1:Player, param2:RoomLoadingCharacterItem) : void
      {
         var _loc4_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var _loc3_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         param1.movie = param2.info.movie;
         param1.character = param2.info.character;
         param1.character.showGun = false;
         param1.character.showWing = false;
         if(param2.info.team == 1)
         {
            if(param1.isSelf || blueCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.BigCharacterBluePos");
               param1.character.showWithSize(false,-1,_loc4_.width,_loc4_.height);
            }
            else
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.SmallCharacterBluePos");
               param1.character.show(false,-1);
            }
            param2.appear(blueCharacterIndex.toString());
            param2.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            if(param1.isSelf || redCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 2)
            {
               param1.character.showWithSize(false,-1,_loc4_.width,_loc4_.height);
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.BigCharacterRedPos");
            }
            else
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.SmallCharacterRedPos");
               param1.character.show(false,-1);
            }
            param2.appear(redCharacterIndex.toString());
            param2.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         param1.movie.show(true,-1);
      }
      
      protected function initRoomItem(param1:RoomLoadingCharacterItem) : void
      {
         var _loc2_:* = null;
         if(param1.info.team == 1)
         {
            if(param1.info.isSelf || blueIdx == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(param1,"asset.roomLoading.CharacterItemBluePos_1");
               _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemBlueFromPos_1");
               blueBig = param1;
               param1.addWeapon(false,-1);
               if(_gameInfo.selfGamePlayer.team != 1)
               {
                  blueIdx = Number(blueIdx) + 1;
               }
            }
            else
            {
               if(blueIdx == 1)
               {
                  blueIdx = Number(blueIdx) + 1;
               }
               PositionUtils.setPos(param1,"asset.roomLoading.CharacterItemBluePos_" + blueIdx.toString());
               _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemBlueFromPos_" + blueIdx.toString());
               blueIdx = Number(blueIdx) + 1;
               param1.addWeapon(true,-1);
            }
         }
         else if(param1.info.isSelf || redIdx == 1 && _gameInfo.selfGamePlayer.team != 2)
         {
            PositionUtils.setPos(param1,"asset.roomLoading.CharacterItemRedPos_1");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemRedFromPos_1");
            redBig = param1;
            param1.addWeapon(false,1);
            if(_gameInfo.selfGamePlayer.team != 2)
            {
               redIdx = Number(redIdx) + 1;
            }
         }
         else
         {
            if(redIdx == 1)
            {
               redIdx = Number(redIdx) + 1;
            }
            PositionUtils.setPos(param1,"asset.roomLoading.CharacterItemRedPos_" + redIdx.toString());
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemRedFromPos_" + redIdx.toString());
            redIdx = Number(redIdx) + 1;
            param1.addWeapon(true,1);
         }
         _characterItems.push(param1);
         addChild(param1);
      }
      
      protected function leave() : void
      {
         if(!_leaving)
         {
            _characterItems.forEach(function(param1:RoomLoadingCharacterItem, param2:int, param3:Vector.<RoomLoadingCharacterItem>):void
            {
               param1.disappear(param1.index.toString());
            });
            if(_dungeonMapItem)
            {
               _dungeonMapItem.disappear();
            }
            _leaving = true;
         }
      }
      
      protected function __countDownTick(param1:TimerEvent) : void
      {
         _selfFinish = checkProgress();
         _countDownTxt.updateNum();
         if(_selfFinish)
         {
            dispatchEvent(new Event("complete"));
            if(NewHandGuideManager.Instance.mapID == 111)
            {
               WeakGuildManager.Instance.timeStatistics(1,_startTime);
            }
         }
      }
      
      protected function __countDownComplete(param1:TimerEvent) : void
      {
         var _loc2_:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11?94:64;
         if(_countDownTimer.currentCount == _loc2_ && RoomManager.Instance.current.type == 14)
         {
            WorldBossManager.IsSuccessStartGame = false;
            StateManager.setState("main");
            return;
         }
         if(!_selfFinish)
         {
            if(RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1 || RoomManager.Instance.current.type == 16 || RoomManager.Instance.current.type == 25)
            {
               StateManager.setState("roomlist");
            }
            else if(RoomManager.Instance.current.type == 10)
            {
               StateManager.setState("main");
            }
            else if(RoomManager.Instance.current.type == 5)
            {
               StateManager.setState("main");
            }
            else if(RoomManager.Instance.current.type == 14)
            {
               WorldBossManager.IsSuccessStartGame = false;
               StateManager.setState("worldboss");
            }
            else if(RoomManager.Instance.current.type == 15)
            {
               StateManager.setState("main",LabyrinthManager.Instance.show);
            }
            else if(RoomManager.Instance.current.type == 17)
            {
               StateManager.setState("consortia",ConsortionModelController.Instance.openBossFrame);
            }
            else if(RoomManager.Instance.current.type == 19)
            {
               StateManager.setState("main");
            }
            else if(RoomManager.Instance.current.type == 20)
            {
               GameInSocketOut.sendSingleRoomBegin(5);
            }
            else if(RoomManager.Instance.current.type == 31)
            {
               if(SevenDoubleManager.instance.isStart)
               {
                  StateManager.setState("sevenDoubleScene");
               }
               else if(EscortManager.instance.isStart)
               {
                  StateManager.setState("escort");
               }
               else if(DrgnBoatManager.instance.isStart)
               {
                  StateManager.setState("drgnBoat");
               }
               else
               {
                  StateManager.setState("main");
               }
            }
            else if(RoomManager.Instance.current.type == 43 || RoomManager.Instance.current.type == 44 || RoomManager.Instance.current.type == 45 || RoomManager.Instance.current.type == 46)
            {
               StateManager.setState("main");
            }
            else if(RoomManager.Instance.current.type == 51)
            {
               StateManager.setState("main");
            }
            else if(RoomManager.Instance.current.type == 67)
            {
               StateManager.setState("main");
            }
            else
            {
               StateManager.setState("dungeon");
            }
            SocketManager.Instance.out.sendErrorMsg(_unloadedmsg);
         }
         else if(BombKingManager.instance.Recording)
         {
            StateManager.setState("main");
         }
      }
      
      protected function checkAnimationIsFinished() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characterItems;
         for each(var _loc1_ in _characterItems)
         {
            if(!_loc1_.isAnimationFinished)
            {
               return false;
            }
         }
         if(_delayBeginTime <= 0)
         {
            _delayBeginTime = new Date().time;
         }
         return true;
      }
      
      protected function checkProgress() : Boolean
      {
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc14_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc17_:* = null;
         var _loc13_:* = null;
         var _loc11_:int = 0;
         _unloadedmsg = "";
         var _loc1_:int = 0;
         var _loc9_:int = 0;
         if(_gameInfo == null)
         {
            _gameInfo = GameControl.Instance.Current;
         }
         var _loc23_:int = 0;
         var _loc22_:* = _gameInfo.roomPlayers;
         for each(var _loc12_ in _gameInfo.roomPlayers)
         {
            if(!_loc12_.isViewer)
            {
               _loc10_ = GameControl.Instance.Current;
               _loc5_ = _gameInfo.findLivingByPlayerID(_loc12_.playerInfo.ID,_loc12_.playerInfo.ZoneID);
               if(LoadBombManager.Instance.getLoadBombComplete(_loc12_.currentWeapInfo))
               {
                  _loc9_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadBombComplete(info.currentWeapInfo) false" + LoadBombManager.Instance.getUnloadedBombString(_loc12_.currentWeapInfo) + "\n");
               }
               _loc1_++;
               _loc7_ = _loc5_.playerInfo.currentPet;
               if(_loc7_)
               {
                  if(_loc7_.assetReady)
                  {
                     _loc9_++;
                  }
                  _loc1_++;
                  var _loc19_:int = 0;
                  var _loc18_:* = _loc7_.equipdSkills;
                  for each(var _loc4_ in _loc7_.equipdSkills)
                  {
                     if(_loc4_ > 0)
                     {
                        _loc14_ = PetSkillManager.getSkillByID(_loc4_);
                        if(_loc14_.EffectPic)
                        {
                           if(ModuleLoader.hasDefinition(_loc14_.EffectClassLink))
                           {
                              _loc9_++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(skill.EffectClassLink):" + _loc14_.EffectClassLink + " false\n");
                           }
                           _loc1_++;
                        }
                        if(_loc14_.NewBallID != -1)
                        {
                           _loc3_ = BallManager.instance.findBall(_loc14_.NewBallID);
                           if(_loc3_.isComplete())
                           {
                              _loc9_++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("BallManager.findBall(skill.NewBallID):" + _loc14_.NewBallID + "false\n");
                           }
                           _loc1_++;
                        }
                     }
                  }
               }
               if(_gameInfo.roomType == 18 && _gameInfo.gameMode == 20)
               {
                  _loc8_ = _loc12_.battleSkillEquipList;
               }
               else
               {
                  _loc8_ = _loc12_.horseSkillEquipList;
               }
               var _loc21_:int = 0;
               var _loc20_:* = _loc8_;
               for each(var _loc16_ in _loc8_)
               {
                  if(_loc16_ > 0)
                  {
                     _loc17_ = HorseManager.instance.getHorseSkillInfoById(_loc16_);
                     if(_loc17_.EffectPic)
                     {
                        if(ModuleLoader.hasDefinition(_loc17_.EffectClassLink))
                        {
                           _loc9_++;
                        }
                        else
                        {
                           _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(horseSkillInfo.EffectClassLink):" + _loc17_.EffectClassLink + " false\n");
                        }
                        _loc1_++;
                     }
                     if(_loc17_.NewBallID != -1)
                     {
                        _loc13_ = BallManager.instance.findBall(_loc17_.NewBallID);
                        if(_loc13_.isComplete())
                        {
                           _loc9_++;
                        }
                        else
                        {
                           _unloadedmsg = _unloadedmsg + ("BallManager.findBall(horseSkillInfo.NewBallID):" + _loc17_.NewBallID + "false\n");
                        }
                        _loc1_++;
                     }
                  }
               }
               continue;
            }
         }
         _loc11_ = 0;
         while(_loc11_ < _gameInfo.neededMovies.length)
         {
            if(_gameInfo.neededMovies[_loc11_].type == 1)
            {
               if(LoadBombManager.Instance.getLivingBombComplete(_gameInfo.neededMovies[_loc11_].bombId))
               {
                  _loc9_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLivingBombComplete(_gameInfo.neededMovies[i].bombId):" + _gameInfo.neededMovies[_loc11_].bombId + " false\n");
               }
               _loc1_++;
            }
            _loc11_++;
         }
         var _loc25_:int = 0;
         var _loc24_:* = _gameInfo.neededPetSkillResource;
         for each(var _loc6_ in _gameInfo.neededPetSkillResource)
         {
            if(_loc6_.effect)
            {
               if(ModuleLoader.hasDefinition(_loc6_.effectClassLink))
               {
                  _loc9_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(" + _loc6_.effectClassLink + ") false\n");
               }
               _loc1_++;
            }
         }
         if(_gameInfo.loaderMap.completed)
         {
            _loc9_++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("_gameInfo.loaderMap.completed false,id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         _loc1_++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete())
            {
               _loc9_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadSpecialBombComplete() false  " + LoadBombManager.Instance.getUnloadedSpecialBombString() + "\n");
            }
            _loc1_++;
         }
         if(_trainerLoad)
         {
            if(_trainerLoad.completed)
            {
               _loc9_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "_trainerLoad.completed false\n";
            }
            _loc1_++;
         }
         if(BuffManager.buffTemplateData)
         {
            _loc9_++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + "buffTemplateData false\n";
         }
         _loc1_++;
         var _loc15_:* = Number(int(_loc9_ / _loc1_ * 100));
         var _loc2_:* = _loc1_ == _loc9_;
         if(_loc2_ && (!checkAnimationIsFinished() || !checkIsEnoughDelayTime()))
         {
            _loc15_ = 99;
            _loc2_ = false;
         }
         GameInSocketOut.sendLoadingProgress(_loc15_);
         RoomManager.Instance.current.selfRoomPlayer.progress = _loc15_;
         return _loc2_;
      }
      
      protected function checkIsEnoughDelayTime() : Boolean
      {
         var _loc1_:Number = new Date().time;
         return _loc1_ - _delayBeginTime >= 1000;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         KeyboardShortcutsManager.Instance.cancelForbidden();
         _countDownTimer.removeEventListener("timer",__countDownTick);
         _countDownTimer.removeEventListener("timerComplete",__countDownComplete);
         _countDownTimer.stop();
         _countDownTimer = null;
         ObjectUtils.disposeObject(_trainerLoad);
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_chatViewBg);
         ObjectUtils.disposeObject(_versus);
         ObjectUtils.disposeObject(_countDownTxt);
         ObjectUtils.disposeObject(_battleField);
         ObjectUtils.disposeObject(_tipsItem);
         ObjectUtils.disposeObject(_viewerItem);
         ObjectUtils.disposeObject(_cancelLink);
         var _loc4_:int = 0;
         var _loc3_:* = _gameInfo.roomPlayers;
         for each(var _loc1_ in _gameInfo.roomPlayers)
         {
            _loc1_.removeEventListener("progressChange",__onLoadingFinished);
         }
         _loc2_ = 0;
         while(_loc2_ < _characterItems.length)
         {
            TweenMax.killTweensOf(_characterItems[_loc2_]);
            _characterItems[_loc2_].dispose();
            _characterItems[_loc2_] = null;
            _loc2_++;
         }
         if(_dungeonMapItem)
         {
            ObjectUtils.disposeObject(_dungeonMapItem);
            _dungeonMapItem = null;
         }
         deleteCancelLink();
         _characterItems = null;
         _trainerLoad = null;
         _bg = null;
         _chatViewBg = null;
         _cancelLink = null;
         _gameInfo = null;
         _versus = null;
         _countDownTxt = null;
         _battleField = null;
         _tipsItem = null;
         _countDownTimer = null;
         _viewerItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
