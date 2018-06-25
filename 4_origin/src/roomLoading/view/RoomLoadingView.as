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
      
      public function RoomLoadingView($info:GameInfo)
      {
         _hasLoadedFinished = new DictionaryData();
         super();
         _gameInfo = $info;
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
         var mode:int = RoomManager.Instance.current.gameMode;
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
         if(_gameInfo.gameMode == 7 || _gameInfo.gameMode == 31 || _gameInfo.gameMode == 4 || _gameInfo.gameMode == 8 || _gameInfo.gameMode == 10 || _gameInfo.gameMode == 17 || _gameInfo.gameMode == 19 || _gameInfo.gameMode == 24 || _gameInfo.gameMode == 25 || _gameInfo.gameMode == 40 || _gameInfo.gameMode == 50 || _gameInfo.gameMode == 31 || _gameInfo.gameMode == 52 || _gameInfo.gameMode == 55 || _gameInfo.gameMode == 55 || _gameInfo.gameMode == 70 || _gameInfo.gameMode == 47 || _gameInfo.gameMode == 49 || _gameInfo.gameMode == 151 || _gameInfo.gameMode == 155)
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
         var time:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 25 || RoomManager.Instance.current.type == 43 || RoomManager.Instance.current.type == 123?94:64;
         _countDownTimer = new Timer(1000,time);
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
      
      private function __onCancelLinkClick(event:TextEvent) : void
      {
         BombKingControl.instance.reset();
         StateManager.setState("main");
      }
      
      protected function initLoadingItems() : void
      {
         var blueLen:int = 0;
         var redLen:int = 0;
         var roomPlayers:* = null;
         var team:int = 0;
         var i:int = 0;
         var roomPlayer:* = null;
         var item:* = null;
         var gameplayer:* = null;
         var currentPet:* = null;
         var horseSkillEquipList:* = null;
         var len:int = _gameInfo.roomPlayers.length;
         roomPlayers = _gameInfo.roomPlayers;
         loadingBombAsset();
         var _loc15_:int = 0;
         var _loc14_:* = roomPlayers;
         for each(var rp1 in roomPlayers)
         {
            if(PlayerManager.Instance.Self.ID == rp1.playerInfo.ID)
            {
               team = rp1.team;
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = roomPlayers;
         for each(var rp in roomPlayers)
         {
            if(!rp.isViewer)
            {
               if(rp.team == 1)
               {
                  blueLen++;
                  §§push(blueLen);
               }
               else
               {
                  redLen++;
                  §§push(int(redLen));
               }
               §§pop();
               if(!(RoomManager.Instance.current.type == 0 && rp.team != team))
               {
                  IMManager.Instance.saveRecentContactsID(rp.playerInfo.ID);
               }
            }
         }
         for(i = 0; i < len; )
         {
            roomPlayer = _gameInfo.roomPlayers[i];
            roomPlayer.addEventListener("progressChange",__onLoadingFinished);
            if(roomPlayer.isViewer)
            {
               if(contains(_tipsItem))
               {
                  removeChild(_tipsItem);
               }
               addChild(_viewerItem);
            }
            else
            {
               item = new RoomLoadingCharacterItem(roomPlayer,RoomManager.Instance.current.type == 121);
               gameplayer = _gameInfo.findLivingByPlayerID(roomPlayer.playerInfo.ID,roomPlayer.playerInfo.ZoneID);
               if(RoomManager.Instance.current.type == 121)
               {
                  setSurvivalRoomItemPos(item,gameplayer.team);
                  setSurvivalCharacter(gameplayer,item,gameplayer.team - 1);
               }
               else
               {
                  initRoomItem(item);
                  initCharacter(gameplayer,item);
               }
               currentPet = gameplayer.playerInfo.currentPet;
               loadingPetAsset(currentPet);
               horseSkillEquipList = roomPlayer.horseSkillEquipList;
               loadingHorseAsset(horseSkillEquipList);
            }
            i++;
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
         for each(var skillRes in _gameInfo.neededPetSkillResource)
         {
            skillRes.startLoad();
         }
      }
      
      protected function loadingNeededMovies() : void
      {
         var j:int = 0;
         for(j = 0; j < _gameInfo.neededMovies.length; )
         {
            if(_gameInfo.neededMovies[j].type == 1)
            {
               _gameInfo.neededMovies[j].startLoad();
            }
            j++;
         }
      }
      
      protected function loadingBombAsset() : void
      {
         var roomPlayers:Array = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb(roomPlayers);
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
      
      protected function loadingPetAsset(currentPet:PetInfo) : void
      {
         var skill:* = null;
         var ball:* = null;
         if(currentPet)
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(currentPet.GameAssetUrl),4);
            var _loc6_:int = 0;
            var _loc5_:* = currentPet.equipdSkills;
            for each(var skillid in currentPet.equipdSkills)
            {
               if(skillid > 0)
               {
                  skill = PetSkillManager.getSkillByID(skillid);
                  if(skill.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(skill.EffectPic),4);
                  }
                  if(skill.NewBallID != -1)
                  {
                     ball = BallManager.instance.findBall(skill.NewBallID);
                     ball.loadBombAsset();
                     ball.loadCraterBitmap();
                  }
               }
            }
         }
      }
      
      protected function loadingHorseAsset(horseSkillEquipList:Array) : void
      {
         var horseSkillInfo:* = null;
         var ball2:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = horseSkillEquipList;
         for each(var horseSkillId in horseSkillEquipList)
         {
            if(horseSkillId > 0)
            {
               horseSkillInfo = HorseManager.instance.getHorseSkillInfoById(horseSkillId);
               if(horseSkillInfo.EffectPic)
               {
                  LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(horseSkillInfo.EffectPic),4);
               }
               if(horseSkillInfo.NewBallID != -1)
               {
                  ball2 = BallManager.instance.findBall(horseSkillInfo.NewBallID);
                  ball2.loadBombAsset();
                  ball2.loadCraterBitmap();
               }
            }
         }
      }
      
      private function setSurvivalCharacter(gameplayer:Player, item:RoomLoadingCharacterItem, index:int) : void
      {
         var size:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var suitSize:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         gameplayer.movie = item.info.movie;
         gameplayer.character = item.info.character;
         gameplayer.character.showGun = false;
         gameplayer.character.showWing = false;
         if(index % 2 == 0)
         {
            item.appear(blueCharacterIndex.toString());
            item.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
            PositionUtils.setPos(item.displayMc,"asset.roomloading.SurvivalCharacterLeftPos");
         }
         else
         {
            item.appear(redCharacterIndex.toString());
            item.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
            PositionUtils.setPos(item.displayMc,"asset.roomloading.SurvivalCharacterRightPos");
         }
         gameplayer.character.show(false,-1);
         gameplayer.movie.show(true,-1);
      }
      
      private function setSurvivalRoomItemPos(item:RoomLoadingCharacterItem, index:int) : void
      {
         PositionUtils.setPos(item,"asset.roomLoading.CharacterItemSurvivalPos_" + index.toString());
         item.addWeapon(true,-1);
         _characterItems.push(item);
         addChild(item);
      }
      
      protected function __onLoadingFinished(event:Event) : void
      {
         var player:RoomPlayer = event.currentTarget as RoomPlayer;
         if(player.progress < 100 || _hasLoadedFinished.hasKey(player))
         {
            return;
         }
         _amountOfFinishedPlayer = Number(_amountOfFinishedPlayer) + 1;
         _hasLoadedFinished.add(player,player);
         if(_amountOfFinishedPlayer == _gameInfo.roomPlayers.length)
         {
            leave();
         }
      }
      
      protected function initCharacter(gameplayer:Player, item:RoomLoadingCharacterItem) : void
      {
         var size:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var suitSize:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         gameplayer.movie = item.info.movie;
         gameplayer.character = item.info.character;
         gameplayer.character.showGun = false;
         gameplayer.character.showWing = false;
         if(item.info.team == 1)
         {
            if(gameplayer.isSelf || blueCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.BigCharacterBluePos");
               gameplayer.character.showWithSize(false,-1,size.width,size.height);
            }
            else
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.SmallCharacterBluePos");
               gameplayer.character.show(false,-1);
            }
            item.appear(blueCharacterIndex.toString());
            item.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            if(gameplayer.isSelf || redCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 2)
            {
               gameplayer.character.showWithSize(false,-1,size.width,size.height);
               PositionUtils.setPos(item.displayMc,"asset.roomloading.BigCharacterRedPos");
            }
            else
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.SmallCharacterRedPos");
               gameplayer.character.show(false,-1);
            }
            item.appear(redCharacterIndex.toString());
            item.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         gameplayer.movie.show(true,-1);
      }
      
      protected function initRoomItem(item:RoomLoadingCharacterItem) : void
      {
         var fromPos:* = null;
         if(item.info.team == 1)
         {
            if(item.info.isSelf || blueIdx == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(item,"asset.roomLoading.CharacterItemBluePos_1");
               fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemBlueFromPos_1");
               blueBig = item;
               item.addWeapon(false,-1);
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
               PositionUtils.setPos(item,"asset.roomLoading.CharacterItemBluePos_" + blueIdx.toString());
               fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemBlueFromPos_" + blueIdx.toString());
               blueIdx = Number(blueIdx) + 1;
               item.addWeapon(true,-1);
            }
         }
         else if(item.info.isSelf || redIdx == 1 && _gameInfo.selfGamePlayer.team != 2)
         {
            PositionUtils.setPos(item,"asset.roomLoading.CharacterItemRedPos_1");
            fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemRedFromPos_1");
            redBig = item;
            item.addWeapon(false,1);
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
            PositionUtils.setPos(item,"asset.roomLoading.CharacterItemRedPos_" + redIdx.toString());
            fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.CharacterItemRedFromPos_" + redIdx.toString());
            redIdx = Number(redIdx) + 1;
            item.addWeapon(true,1);
         }
         _characterItems.push(item);
         addChild(item);
      }
      
      protected function leave() : void
      {
         if(!_leaving)
         {
            _characterItems.forEach(function(item:RoomLoadingCharacterItem, index:int, array:Vector.<RoomLoadingCharacterItem>):void
            {
               item.disappear(item.index.toString());
            });
            if(_dungeonMapItem)
            {
               _dungeonMapItem.disappear();
            }
            _leaving = true;
         }
      }
      
      protected function __countDownTick(evt:TimerEvent) : void
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
      
      protected function __countDownComplete(event:TimerEvent) : void
      {
         var tempTime:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11?94:64;
         if(_countDownTimer.currentCount == tempTime && RoomManager.Instance.current.type == 14)
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
         for each(var item in _characterItems)
         {
            if(!item.isAnimationFinished)
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
         var gameInfoTest:* = null;
         var gameplayer:* = null;
         var currentPet:* = null;
         var skill:* = null;
         var ball:* = null;
         var horseSkillEquipList:* = null;
         var horseSkillInfo:* = null;
         var ball2:* = null;
         var i:int = 0;
         _unloadedmsg = "";
         var total:int = 0;
         var finished:int = 0;
         if(_gameInfo == null)
         {
            _gameInfo = GameControl.Instance.Current;
         }
         var _loc23_:int = 0;
         var _loc22_:* = _gameInfo.roomPlayers;
         for each(var info in _gameInfo.roomPlayers)
         {
            if(!info.isViewer)
            {
               gameInfoTest = GameControl.Instance.Current;
               gameplayer = _gameInfo.findLivingByPlayerID(info.playerInfo.ID,info.playerInfo.ZoneID);
               if(LoadBombManager.Instance.getLoadBombComplete(info.currentWeapInfo))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadBombComplete(info.currentWeapInfo) false" + LoadBombManager.Instance.getUnloadedBombString(info.currentWeapInfo) + "\n");
               }
               total++;
               currentPet = gameplayer.playerInfo.currentPet;
               if(currentPet)
               {
                  if(currentPet.assetReady)
                  {
                     finished++;
                  }
                  total++;
                  var _loc19_:int = 0;
                  var _loc18_:* = currentPet.equipdSkills;
                  for each(var skillid in currentPet.equipdSkills)
                  {
                     if(skillid > 0)
                     {
                        skill = PetSkillManager.getSkillByID(skillid);
                        if(skill.EffectPic)
                        {
                           if(ModuleLoader.hasDefinition(skill.EffectClassLink))
                           {
                              finished++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(skill.EffectClassLink):" + skill.EffectClassLink + " false\n");
                           }
                           total++;
                        }
                        if(skill.NewBallID != -1)
                        {
                           ball = BallManager.instance.findBall(skill.NewBallID);
                           if(ball.isComplete())
                           {
                              finished++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("BallManager.findBall(skill.NewBallID):" + skill.NewBallID + "false\n");
                           }
                           total++;
                        }
                     }
                  }
               }
               if(_gameInfo.roomType == 18 && _gameInfo.gameMode == 20)
               {
                  horseSkillEquipList = info.battleSkillEquipList;
               }
               else
               {
                  horseSkillEquipList = info.horseSkillEquipList;
               }
               var _loc21_:int = 0;
               var _loc20_:* = horseSkillEquipList;
               for each(var horseSkillId in horseSkillEquipList)
               {
                  if(horseSkillId > 0)
                  {
                     horseSkillInfo = HorseManager.instance.getHorseSkillInfoById(horseSkillId);
                     if(horseSkillInfo.EffectPic)
                     {
                        if(ModuleLoader.hasDefinition(horseSkillInfo.EffectClassLink))
                        {
                           finished++;
                        }
                        else
                        {
                           _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(horseSkillInfo.EffectClassLink):" + horseSkillInfo.EffectClassLink + " false\n");
                        }
                        total++;
                     }
                     if(horseSkillInfo.NewBallID != -1)
                     {
                        ball2 = BallManager.instance.findBall(horseSkillInfo.NewBallID);
                        if(ball2.isComplete())
                        {
                           finished++;
                        }
                        else
                        {
                           _unloadedmsg = _unloadedmsg + ("BallManager.findBall(horseSkillInfo.NewBallID):" + horseSkillInfo.NewBallID + "false\n");
                        }
                        total++;
                     }
                  }
               }
               continue;
            }
         }
         for(i = 0; i < _gameInfo.neededMovies.length; )
         {
            if(_gameInfo.neededMovies[i].type == 1)
            {
               if(LoadBombManager.Instance.getLivingBombComplete(_gameInfo.neededMovies[i].bombId))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLivingBombComplete(_gameInfo.neededMovies[i].bombId):" + _gameInfo.neededMovies[i].bombId + " false\n");
               }
               total++;
            }
            i++;
         }
         var _loc25_:int = 0;
         var _loc24_:* = _gameInfo.neededPetSkillResource;
         for each(var skillRes in _gameInfo.neededPetSkillResource)
         {
            if(skillRes.effect)
            {
               if(ModuleLoader.hasDefinition(skillRes.effectClassLink))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(" + skillRes.effectClassLink + ") false\n");
               }
               total++;
            }
         }
         if(_gameInfo.loaderMap.completed)
         {
            finished++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("_gameInfo.loaderMap.completed false,id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         total++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete())
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadSpecialBombComplete() false  " + LoadBombManager.Instance.getUnloadedSpecialBombString() + "\n");
            }
            total++;
         }
         if(_trainerLoad)
         {
            if(_trainerLoad.completed)
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "_trainerLoad.completed false\n";
            }
            total++;
         }
         if(BuffManager.buffTemplateData)
         {
            finished++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + "buffTemplateData false\n";
         }
         total++;
         var pro:* = Number(int(finished / total * 100));
         var res:* = total == finished;
         if(res && (!checkAnimationIsFinished() || !checkIsEnoughDelayTime()))
         {
            pro = 99;
            res = false;
         }
         GameInSocketOut.sendLoadingProgress(pro);
         RoomManager.Instance.current.selfRoomPlayer.progress = pro;
         return res;
      }
      
      protected function checkIsEnoughDelayTime() : Boolean
      {
         var time:Number = new Date().time;
         return time - _delayBeginTime >= 1000;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         for each(var rp in _gameInfo.roomPlayers)
         {
            rp.removeEventListener("progressChange",__onLoadingFinished);
         }
         for(i = 0; i < _characterItems.length; )
         {
            TweenMax.killTweensOf(_characterItems[i]);
            _characterItems[i].dispose();
            _characterItems[i] = null;
            i++;
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
