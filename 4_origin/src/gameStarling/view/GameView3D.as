package gameStarling.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import christmas.ChristmasCoreManager;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BallInfo;
   import ddt.data.EquipType;
   import ddt.data.FightAchievModel;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.events.PhyobjEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LogManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PageInterfaceManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.StatisticManager;
   import ddt.states.BaseStateView;
   import ddt.utils.MenoryUtil;
   import ddt.utils.PositionUtils;
   import ddt.view.BackgoundView;
   import ddt.view.PropItemView;
   import demonChiYou.DemonChiYouManager;
   import dragonBones.events.AnimationEvent;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import game.GameManager;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.GameMessageTipManager;
   import gameCommon.IGameView;
   import gameCommon.SkillManager;
   import gameCommon.TryAgain;
   import gameCommon.model.Bomb;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameNeedMovieInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.MissionAgainInfo;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   import gameCommon.objects.ActivityDungeonNextView;
   import gameCommon.objects.AnimationObject;
   import gameCommon.view.AchieveAnimation;
   import gameCommon.view.EnergyView;
   import gameCommon.view.control.LiveState;
   import gameCommon.view.experience.ExpView;
   import gameStarling.actions.ChangeBallAction;
   import gameStarling.actions.ChangeNpcAction;
   import gameStarling.actions.ChangePlayerAction;
   import gameStarling.actions.GameOverAction;
   import gameStarling.actions.MissionOverAction;
   import gameStarling.actions.PickBoxAction;
   import gameStarling.actions.PrepareShootAction;
   import gameStarling.actions.SceneEffectShootBombAction;
   import gameStarling.actions.ViewEachObjectAction;
   import gameStarling.objects.BombAction3D;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.objects.GameSimpleBoss3D;
   import gameStarling.objects.GameSmallEnemy3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.objects.SimpleBox3D;
   import gameStarling.objects.SimpleObject3D;
   import hall.GameLoadingManager;
   import org.aswing.KeyboardManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.AutoDisappear;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import sevenDouble.SevenDoubleManager;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class GameView3D extends GameViewBase3D implements IGameView
   {
       
      
      private const ZXC_OFFSET:int = 24;
      
      protected var _msg:String = "";
      
      protected var _tipItems:Dictionary;
      
      protected var _tipLayers:DisplayObjectContainer;
      
      protected var _result:ExpView;
      
      private var _gameLivingArr:Array;
      
      private var _gameLivingIdArr:Array;
      
      private var _objectDic:DictionaryData;
      
      private var _evtArray:Array;
      
      private var _evtFuncArray:Array;
      
      private var _animationArray:Array;
      
      private var _terraces:Dictionary;
      
      private var _firstEnter:Boolean = false;
      
      private var _soundPlayFlag:Boolean;
      
      private var _ignoreSmallEnemy:Boolean;
      
      private var _boxArr:Array;
      
      private var finished:int = 0;
      
      private var total:int = 0;
      
      private var props:Array;
      
      private var _logTimer:Timer;
      
      private var _missionAgain:MissionAgainInfo;
      
      protected var _expView:ExpView;
      
      protected var _expGameBg:Image;
      
      private var _isPVPover:Boolean;
      
      public function GameView3D()
      {
         props = [10611,10612,10613];
         _evtArray = [GameControl.Instance.addLivingEvtVec,GameControl.Instance.setPropertyEvtVec,GameControl.Instance.livingFallingEvtVec,GameControl.Instance.livingShowBloodEvtVec,GameControl.Instance.addMapThingEvtVec,GameControl.Instance.livingActionMappingEvtVec,GameControl.Instance.updatePhysicObjectEvtVec,GameControl.Instance.playerBloodEvtVec];
         _evtFuncArray = [addliving,objectSetProperty,livingFalling,livingShowBlood,addMapThing,livingActionMapping,updatePhysicObject,playerBlood];
         super();
         Mouse.show();
      }
      
      private function loadResource() : void
      {
         var j:int = 0;
         if(!StartupResourceLoader.firstEnterHall)
         {
            for(j = 0; j < _gameInfo.neededMovies.length; )
            {
               _gameInfo.neededMovies[j].addEventListener("complete",__loaderComplete);
               _gameInfo.neededMovies[j].startLoad();
               j++;
            }
         }
      }
      
      private function __loaderComplete(event:LoaderEvent) : void
      {
         var j:int = 0;
         var k:int = 0;
         var flag:Boolean = false;
         event.target.removeEventListener("complete",__loaderComplete);
         if(_gameLivingArr && _gameLivingIdArr)
         {
            for(j = 0; j < _gameLivingArr.length; )
            {
               (_gameLivingArr[j] as GameLiving3D).replaceMovie();
               for(k = 0; k < _gameLivingIdArr.length; )
               {
                  if(_gameLivingArr[j].Id == _gameLivingIdArr[k])
                  {
                     flag = true;
                     break;
                  }
                  k++;
               }
               _playerThumbnailLController.updateHeadFigure(_gameLivingArr[j],flag);
               j++;
            }
         }
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         var i:int = 0;
         var j:int = 0;
         GameControl.Instance.gameView = this;
         _gameLivingArr = [];
         _gameLivingIdArr = [];
         _objectDic = new DictionaryData();
         _animationArray = [];
         GameLoadingManager.Instance.hide();
         super.enter(prev,data);
         loadResource();
         KeyboardManager.getInstance().isStopDispatching = false;
         KeyboardShortcutsManager.Instance.forbiddenSection(2,false);
         _gameInfo.resetResultCard();
         _gameInfo.livings.addEventListener("remove",__removePlayer);
         _gameInfo.addEventListener("windChanged",__windChanged);
         PlayerManager.Instance.Self.FightBag.addEventListener("update",__selfObtainItem);
         PlayerManager.Instance.Self.TempBag.addEventListener("update",__getTempItem);
         GameControl.Instance.addEventListener("addTerrace",addTerraceHander);
         GameControl.Instance.addEventListener("delTerrace",delTerraceHander);
         SocketManager.Instance.addEventListener("missionOver",__missionOver);
         SocketManager.Instance.addEventListener("gameOver",__gameOver);
         SocketManager.Instance.addEventListener("playerShoot",__shoot);
         SocketManager.Instance.addEventListener("playerStartMove",__startMove);
         SocketManager.Instance.addEventListener("playerVane",__changWind);
         SocketManager.Instance.addEventListener("playerHide",__playerHide);
         SocketManager.Instance.addEventListener("playerNoNole",__playerNoNole);
         SocketManager.Instance.addEventListener("playerProp",__playerUsingItem);
         SocketManager.Instance.addEventListener("playerDander",__dander);
         SocketManager.Instance.addEventListener("reduceDander",__reduceDander);
         SocketManager.Instance.addEventListener("playerAddAttack",__changeShootCount);
         SocketManager.Instance.addEventListener("suicide",__suicide);
         SocketManager.Instance.addEventListener("playerShootTag",__beginShoot);
         SocketManager.Instance.addEventListener("changeBall",__changeBall);
         SocketManager.Instance.addEventListener("playerFrost",__forstPlayer);
         SocketManager.Instance.addEventListener("playMovie",__playMovie);
         SocketManager.Instance.addEventListener("LivingChangeAngele",__livingTurnRotation);
         SocketManager.Instance.addEventListener("playSound",__playSound);
         SocketManager.Instance.addEventListener("livingMoveTo",__livingMoveto);
         SocketManager.Instance.addEventListener("livingJump",__livingJump);
         SocketManager.Instance.addEventListener("livingBeat",__livingBeat);
         SocketManager.Instance.addEventListener("livingSay",__livingSay);
         SocketManager.Instance.addEventListener("livingRangeAttacking",__livingRangeAttacking);
         SocketManager.Instance.addEventListener("playerDirection",__livingDirChanged);
         SocketManager.Instance.addEventListener("focusOnObject",__focusOnObject);
         SocketManager.Instance.addEventListener("changeState",__changeState);
         SocketManager.Instance.addEventListener("barrierInfo",__barrierInfoHandler);
         SocketManager.Instance.addEventListener("boxdisappear",__removePhysicObject);
         SocketManager.Instance.addEventListener("addTipLayer",__addTipLayer);
         SocketManager.Instance.addEventListener("forbidDrag",__forbidDragFocus);
         SocketManager.Instance.addEventListener("topLayer",__topLayer);
         SocketManager.Instance.addEventListener("controlBGM",__controlBGM);
         SocketManager.Instance.addEventListener("livingBoltmove",__onLivingBoltmove);
         SocketManager.Instance.addEventListener("changeTarget",__onChangePlayerTarget);
         SocketManager.Instance.addEventListener("fightAchievement",__fightAchievement);
         SocketManager.Instance.addEventListener("updateBuff",__updateBuff);
         SocketManager.Instance.addEventListener("petBuff",__updatePetBuff);
         SocketManager.Instance.addEventListener("gamesysmessage",__gameSysMessage);
         SocketManager.Instance.addEventListener("usePetSkill",__usePetSkill);
         SocketManager.Instance.addEventListener("PickBox",__pickBox);
         SocketManager.Instance.addEventListener("game_in_color_change",__livingSmallColorChange);
         SocketManager.Instance.addEventListener("game_trusteeship",__gameTrusteeship);
         SocketManager.Instance.addEventListener("gameFightStatus",__fightStatusChange);
         SocketManager.Instance.addEventListener("gameSkipNext",__skipNextHandler);
         SocketManager.Instance.addEventListener("gameClearDebuff",__clearDebuff);
         SocketManager.Instance.addEventListener("add_animation",__addAnimation);
         SocketManager.Instance.addEventListener("skill_lock",__skillLock);
         SocketManager.Instance.addEventListener("target_player",__showTargetPlayer);
         StatisticManager.Instance().startAction("game","yes");
         _tipItems = new Dictionary(true);
         CacheSysManager.lock("alertInFight");
         PlayerManager.Instance.Self.isUpGradeInGame = false;
         BackgoundView.Instance.hide();
         if(StartupResourceLoader.firstEnterHall)
         {
            _firstEnter = true;
            StartupResourceLoader.Instance.addThirdGameUI();
            StartupResourceLoader.Instance.startLoadRelatedInfo();
         }
         else
         {
            _firstEnter = false;
            BuffManager.startLoadBuffEffect();
         }
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(123) && _gameInfo.loaderMap.info.ID == 1120)
         {
            NoviceDataManager.instance.saveNoviceData(1070,PathManager.userName(),PathManager.solveRequestPath());
            SocketManager.Instance.out.syncWeakStep(123);
         }
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(130) && _gameInfo.loaderMap.info.ID == 1121)
         {
            NoviceDataManager.instance.saveNoviceData(1100,PathManager.userName(),PathManager.solveRequestPath());
         }
         _terraces = new Dictionary();
         if(GameControl.Instance.isAddTerrce)
         {
            addTerrce(GameControl.Instance.terrceX,GameControl.Instance.terrceY,GameControl.Instance.terrceID);
         }
         var roomType:int = RoomManager.Instance.current.type;
         if(guideTip() && roomType != 4 && roomType != 123 && StateManager.currentStateType != "fightLabGameView" && roomType != 11 && !isNewHand())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.MessageTip.AutoGuidFightBegin"));
         }
         GameControl.Instance.viewCompleteFlag = true;
         for(i = 0; i < _evtFuncArray.length; )
         {
            for(j = 0; j < _evtArray[i].length; )
            {
               _evtFuncArray[i](_evtArray[i][j]);
               j++;
            }
            _evtArray[i].length = 0;
            i++;
         }
      }
      
      private function addTerraceHander(e:GameEvent) : void
      {
         addTerrce(e.data[0],e.data[1],e.data[2]);
      }
      
      private function addTerrce($x:int, $y:int, $livingID:int) : void
      {
         if(_terraces[$livingID])
         {
            return;
         }
         var image:Image = StarlingMain.instance.createImage("camp.battle.terrace");
         image.x = $x - image.width / 2;
         image.y = $y;
         _map.addChild(image);
         _terraces[$livingID] = image;
      }
      
      private function delTerraceHander(e:GameEvent) : void
      {
         var image:Image = _terraces[e.data[0]];
         if(image)
         {
            StarlingObjectUtils.disposeObject(image);
            delete _terraces[e.data[0]];
         }
      }
      
      private function dioposeTerraces() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _terraces;
         for each(var terrace in _terraces)
         {
            StarlingObjectUtils.disposeObject(terrace);
            terrace = null;
         }
         _terraces = null;
      }
      
      private function retrunPlayer(id:int) : GamePlayer3D
      {
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var p in _players)
         {
            if(p.info.LivingID == id)
            {
               return p;
            }
         }
         return null;
      }
      
      private function petResLoad(currentPet:PetInfo) : void
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
      
      protected function __pickBox(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var tmpArray:Array = [];
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            tmpArray.push(pkg.readInt());
            i++;
         }
         _map.dropOutBox(tmpArray);
         hideAllOther();
      }
      
      private function guideTip() : Boolean
      {
         var player:* = null;
         if(RoomManager.Instance.current.type == 4 || 123)
         {
            return false;
         }
         var _allLivings:DictionaryData = GameControl.Instance.Current.livings;
         if(!_allLivings)
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _allLivings;
         for each(var liv in _allLivings)
         {
            player = liv as Player;
            if(player && (liv as Player).playerInfo.Grade <= 15)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isNewHand() : Boolean
      {
         var mapId:int = RoomManager.Instance.current.mapId;
         if(mapId == 112 || mapId == 113 || mapId == 114 || mapId == 115 || mapId == 116)
         {
            return true;
         }
         return false;
      }
      
      private function __gameSysMessage(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var msgType:int = pkg.readInt();
         var msg:String = pkg.readUTF();
         var para:int = pkg.readInt();
         if(!(int(msgType) - 1))
         {
            MessageTipManager.getInstance().show(String(para),2);
         }
      }
      
      private function __fightAchievement(event:CrazyTankSocketEvent) : void
      {
         var achievAnimate:* = null;
         var pkg:* = null;
         var living:* = null;
         var achiev:int = 0;
         var num:int = 0;
         var interval:int = 0;
         var now:int = 0;
         var animate:* = null;
         if(PathManager.getFightAchieveEnable())
         {
            if(_achievBar == null)
            {
               _achievBar = ComponentFactory.Instance.creatCustomObject("FightAchievBar");
               addChild(_achievBar);
            }
            pkg = event.pkg;
            living = GameControl.Instance.Current.findLiving(pkg.clientId);
            achiev = pkg.readInt();
            num = pkg.readInt();
            interval = pkg.readInt();
            now = getTimer();
            animate = _achievBar.getAnimate(achiev);
            if(animate == null)
            {
               _achievBar.addAnimate(ComponentFactory.Instance.creatCustomObject("AchieveAnimation",[achiev,num,interval,now]));
            }
            else if(FightAchievModel.getInstance().isNumAchiev(achiev))
            {
               animate.setNum(num);
            }
            else
            {
               _achievBar.rePlayAnimate(animate);
            }
         }
      }
      
      private function __windChanged(e:GameEvent) : void
      {
         _map.wind = e.data.wind;
         _map.windRate = GameControl.Instance.Current.windRate;
         if(_vane)
         {
            _vane.update(_map.wind,e.data.isSelfTurn,e.data.windNumArr);
         }
         if(_weatherView && e.data.windNumArr[5])
         {
            _weatherView.update(e.data.windNumArr[0],e.data.windNumArr[5]);
         }
      }
      
      override public function getType() : String
      {
         return "fighting3d";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
         if(StateManager.isExitRoom(next.getType()) && RoomManager.Instance.isReset(RoomManager.Instance.current.type))
         {
            GameControl.Instance.reset();
            RoomManager.Instance.reset();
         }
         else if(StateManager.isExitGame(next.getType()) && RoomManager.Instance.isReset(RoomManager.Instance.current.type))
         {
            GameControl.Instance.reset();
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         GameControl.Instance.viewCompleteFlag = false;
         SoundManager.instance.stopMusic();
         PageInterfaceManager.restorePageTitle();
         KeyboardShortcutsManager.Instance.forbiddenSection(2,true);
         if(PlayerManager.Instance.hasTempStyle)
         {
            PlayerManager.Instance.readAllTempStyleEvent();
         }
         if(_gameInfo != null)
         {
            _gameInfo.removeEventListener("windChanged",__windChanged);
            _gameInfo.livings.removeEventListener("remove",__removePlayer);
            _gameInfo.removeAllMonsters();
            _gameInfo.resetBossCardCnt();
         }
         SocketManager.Instance.removeEventListener("playerShoot",__shoot);
         SocketManager.Instance.removeEventListener("playerStartMove",__startMove);
         SocketManager.Instance.removeEventListener("playerVane",__changWind);
         SocketManager.Instance.removeEventListener("playerHide",__playerHide);
         SocketManager.Instance.removeEventListener("playerNoNole",__playerNoNole);
         SocketManager.Instance.removeEventListener("playerProp",__playerUsingItem);
         SocketManager.Instance.removeEventListener("playerDander",__dander);
         SocketManager.Instance.removeEventListener("reduceDander",__reduceDander);
         SocketManager.Instance.removeEventListener("playerAddAttack",__changeShootCount);
         SocketManager.Instance.removeEventListener("suicide",__suicide);
         SocketManager.Instance.removeEventListener("playerShootTag",__beginShoot);
         SocketManager.Instance.removeEventListener("changeBall",__changeBall);
         SocketManager.Instance.removeEventListener("playerFrost",__forstPlayer);
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         SocketManager.Instance.removeEventListener("gameOver",__gameOver);
         SocketManager.Instance.removeEventListener("playMovie",__playMovie);
         SocketManager.Instance.removeEventListener("LivingChangeAngele",__livingTurnRotation);
         SocketManager.Instance.removeEventListener("playSound",__playSound);
         SocketManager.Instance.removeEventListener("livingMoveTo",__livingMoveto);
         SocketManager.Instance.removeEventListener("livingJump",__livingJump);
         SocketManager.Instance.removeEventListener("livingBeat",__livingBeat);
         SocketManager.Instance.removeEventListener("livingSay",__livingSay);
         SocketManager.Instance.removeEventListener("livingRangeAttacking",__livingRangeAttacking);
         SocketManager.Instance.removeEventListener("playerDirection",__livingDirChanged);
         SocketManager.Instance.removeEventListener("focusOnObject",__focusOnObject);
         SocketManager.Instance.removeEventListener("changeState",__changeState);
         SocketManager.Instance.removeEventListener("barrierInfo",__barrierInfoHandler);
         SocketManager.Instance.removeEventListener("boxdisappear",__removePhysicObject);
         SocketManager.Instance.removeEventListener("addTipLayer",__addTipLayer);
         SocketManager.Instance.removeEventListener("forbidDrag",__forbidDragFocus);
         SocketManager.Instance.removeEventListener("topLayer",__topLayer);
         SocketManager.Instance.removeEventListener("controlBGM",__controlBGM);
         SocketManager.Instance.removeEventListener("livingBoltmove",__onLivingBoltmove);
         SocketManager.Instance.removeEventListener("changeTarget",__onChangePlayerTarget);
         SocketManager.Instance.removeEventListener("fightAchievement",__fightAchievement);
         SocketManager.Instance.removeEventListener("updateBuff",__updateBuff);
         SocketManager.Instance.removeEventListener("petBuff",__updatePetBuff);
         SocketManager.Instance.removeEventListener("gamesysmessage",__gameSysMessage);
         PlayerManager.Instance.Self.FightBag.removeEventListener("update",__selfObtainItem);
         PlayerManager.Instance.Self.TempBag.removeEventListener("update",__getTempItem);
         SocketManager.Instance.removeEventListener("usePetSkill",__usePetSkill);
         SocketManager.Instance.removeEventListener("PickBox",__pickBox);
         GameControl.Instance.removeEventListener("addTerrace",addTerraceHander);
         GameControl.Instance.removeEventListener("delTerrace",delTerraceHander);
         SocketManager.Instance.removeEventListener("game_in_color_change",__livingSmallColorChange);
         SocketManager.Instance.removeEventListener("game_trusteeship",__gameTrusteeship);
         SocketManager.Instance.removeEventListener("game_in_color_change",__revivePlayer);
         SocketManager.Instance.removeEventListener("gameFightStatus",__fightStatusChange);
         SocketManager.Instance.removeEventListener("gameSkipNext",__skipNextHandler);
         SocketManager.Instance.removeEventListener("gameClearDebuff",__clearDebuff);
         SocketManager.Instance.removeEventListener("add_animation",__addAnimation);
         SocketManager.Instance.removeEventListener("skill_lock",__skillLock);
         SocketManager.Instance.removeEventListener("target_player",__showTargetPlayer);
         StarlingObjectUtils.disposeAllChildren(_tipLayers);
         StarlingObjectUtils.disposeObject(_tipLayers);
         _tipLayers = null;
         _tipItems = null;
         if(_expView)
         {
            _expView.removeEventListener("expshowed",__expShowed);
         }
         if(_expGameBg)
         {
            StarlingObjectUtils.disposeObject(_expGameBg,true);
         }
         _expGameBg = null;
         BallManager.instance.clearAsset();
         BackgoundView.Instance.show();
         PlayerInfoViewControl._isBattle = false;
         PlayerInfoViewControl.isOpenFromBag = false;
         CampBattleManager.instance.isFighting = false;
         dioposeTerraces();
         _gameLivingArr = null;
         _gameLivingIdArr = null;
         _objectDic.clear();
         _objectDic = null;
         for(i = 0; i < _animationArray.length; )
         {
            _animationArray[i].dispose();
            _animationArray[i] = null;
            _animationArray.splice(i,1);
            i++;
         }
         GameControl.Instance.isAddTerrce = false;
         if(_logTimer)
         {
            _logTimer.removeEventListener("timer",logTimeHandler);
            _logTimer.stop();
         }
         _logTimer = null;
         super.dispose();
      }
      
      private function __showTargetPlayer(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            info = _gameInfo.findLiving(pkg.readInt());
            if(info is LocalPlayer)
            {
               PlayerManager.Instance.Self.targetId = pkg.readInt();
               setTargetIconShow(true);
               break;
            }
            pkg.readInt();
            i++;
         }
      }
      
      private function __skillLock(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var lockStyle:int = pkg.readInt();
         var lockStatus:Boolean = pkg.readBoolean();
         (_cs as LiveState).updateSkillLockStatus(lockStyle,lockStatus);
      }
      
      override public function addedToStage() : void
      {
         super.addedToStage();
      }
      
      override public function getBackType() : String
      {
         if(_gameInfo.roomType == 1)
         {
            return "challengeRoom";
         }
         if(_gameInfo.roomType == 0)
         {
            return "matchRoom";
         }
         if(_gameInfo.roomType == 5)
         {
            return "fightLib";
         }
         if(_gameInfo.roomType == 10)
         {
            if(StartupResourceLoader.firstEnterHall)
            {
               return "freshmanRoom2";
            }
            return "freshmanRoom1";
         }
         return "dungeonRoom";
      }
      
      override protected function __playerChange(event:CrazyTankSocketEvent) : void
      {
         event = event;
         PageInterfaceManager.restorePageTitle();
         if(_selfMarkBar)
         {
            _selfMarkBar.shutdown();
         }
         _map.currentFocusedLiving = null;
         var id:int = event.pkg.extend1;
         var sceneEffectLength:int = event.pkg.readInt();
         var sceneEffectArr:Array = [];
         for(var i:int = 0; i < sceneEffectLength; )
         {
            var sceneEffectObj:SceneEffectObj = new SceneEffectObj();
            sceneEffectObj.id = event.pkg.readInt();
            sceneEffectObj.turn = event.pkg.readInt();
            sceneEffectObj.x = event.pkg.readInt();
            sceneEffectObj.y = event.pkg.readInt();
            sceneEffectArr.push(sceneEffectObj);
            for(var j:int = sceneEffectObj.turn - 1; j > 0; )
            {
               var sceneEffectObj2:SceneEffectObj = new SceneEffectObj();
               ObjectUtils.copyProperties(sceneEffectObj2,sceneEffectObj);
               sceneEffectObj2.follow = true;
               sceneEffectObj2.turn = j;
               sceneEffectArr.push(sceneEffectObj2);
               j = Number(j) - 1;
            }
            i = Number(i) + 1;
         }
         if(_sceneEffectsBar && sceneEffectArr.length > 0)
         {
            _sceneEffectsBar.updateView(sceneEffectArr,function():void
            {
               var _loc3_:int = 0;
               var _loc2_:* = _gameInfo.livings;
               for each(var playerLiving in _gameInfo.livings)
               {
                  if(playerLiving is Player && playerLiving.playerInfo && playerLiving.isLiving)
                  {
                     playerLiving.dispatchEvent(new LivingEvent("checkCollide"));
                  }
               }
               changePlayerTurn(id,event);
            });
         }
         else
         {
            changePlayerTurn(id,event);
         }
         super.__playerChange(event);
      }
      
      private function changePlayerTurn(id:int, event:CrazyTankSocketEvent) : void
      {
         var gameLiving:* = null;
         var info:Living = _gameInfo.findLiving(id);
         _gameInfo.currentLiving = info;
         if(info is TurnedLiving)
         {
            _ignoreSmallEnemy = false;
            if(!info.isLiving)
            {
               setCurrentPlayer(null);
               return;
            }
            if(info.isBoss)
            {
               if(RoomManager.Instance.current.type == 21)
               {
                  updateDamageView();
               }
            }
            if(info.playerInfo == PlayerManager.Instance.Self)
            {
               PageInterfaceManager.changePageTitle();
               setTargetIconShow(true);
            }
            else
            {
               setTargetIconShow(false);
            }
            event.executed = false;
            _soundPlayFlag = true;
            if(info is LocalPlayer && _gameTrusteeshipView && _gameTrusteeshipView.trusteeshipState)
            {
               new ChangePlayerAction(_map,info as TurnedLiving,event,event.pkg,0,0).executeAtOnce();
            }
            else
            {
               _map.act(new ChangePlayerAction(_map,info as TurnedLiving,event,event.pkg));
            }
         }
         else
         {
            _map.act(new ChangeNpcAction(this,_map,info as Living,event,event.pkg,_ignoreSmallEnemy));
            if(!_ignoreSmallEnemy)
            {
               _ignoreSmallEnemy = true;
            }
         }
         var dic:DictionaryData = GameControl.Instance.Current.livings;
         var _loc9_:int = 0;
         var _loc8_:* = dic;
         for each(var liv in dic)
         {
            gameLiving = getGameLivingByID(liv.LivingID) as GameLiving3D;
            if(gameLiving)
            {
               gameLiving.fightPowerVisible = false;
            }
         }
         var ls:LiveState = _cs as LiveState;
         if(ls)
         {
            if(ls.rescuePropBar)
            {
               ls.rescuePropBar.setKingBlessEnable();
            }
            if(ls.insectProBar)
            {
               ls.insectProBar.setEnable(true);
               ls.rightPropBar.showPropBar();
            }
            if(BombKingManager.instance.Recording)
            {
               ls.arrow.modifyAngleData(info as Player);
            }
         }
         PrepareShootAction.hasDoSkillAnimation = false;
      }
      
      private function setTargetIconShow(flag:Boolean) : void
      {
         var dic:* = null;
         var gameLiving:* = null;
         if(_gameInfo.gameMode == 121)
         {
            dic = GameControl.Instance.Current.livings;
            gameLiving = null;
            var _loc6_:int = 0;
            var _loc5_:* = dic;
            for each(var liv in dic)
            {
               gameLiving = getGameLivingByID(liv.LivingID) as GameLiving3D;
               if(gameLiving != null)
               {
                  if(liv.LivingID == PlayerManager.Instance.Self.targetId)
                  {
                     if(flag)
                     {
                        gameLiving.addTartgetIcon();
                     }
                     else
                     {
                        gameLiving.deleteTargetIcon();
                     }
                  }
                  else
                  {
                     gameLiving.modifyPlayerColor();
                  }
               }
            }
         }
      }
      
      private function __playMovie(event:CrazyTankSocketEvent) : void
      {
         var type:* = null;
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(living)
         {
            type = event.pkg.readUTF();
            trace("playMovie:-->id:" + event.pkg.extend1 + ",type:" + type);
            living.playMovie(type);
            _map.bringToFront(living);
         }
      }
      
      private function __livingTurnRotation(event:CrazyTankSocketEvent) : void
      {
         var rota:int = 0;
         var roSpeed:Number = NaN;
         var type:* = null;
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(living)
         {
            rota = event.pkg.readInt() / 10;
            roSpeed = event.pkg.readInt() / 10;
            type = event.pkg.readUTF();
            living.turnRotation(rota,roSpeed,type);
            _map.bringToFront(living);
         }
      }
      
      public function addliving(event:CrazyTankSocketEvent) : void
      {
         var j:int = 0;
         var key:* = null;
         var value:* = null;
         var i:int = 0;
         var buff:* = null;
         var I:int = 0;
         var K:* = null;
         var Value:* = null;
         var living:* = null;
         var gameLiving:* = null;
         var bossID:int = 0;
         var ls:* = null;
         var k:int = 0;
         var pid:int = 0;
         var angle:int = 0;
         var childs:* = null;
         var pkg:PackageIn = event.pkg;
         var livingType:int = pkg.readByte();
         var ID:int = pkg.readInt();
         var Name:String = pkg.readUTF();
         var ActionMovie:String = pkg.readUTF();
         var specificAction:String = pkg.readUTF();
         var Pos:Point = new Point(pkg.readInt(),pkg.readInt());
         var currentHP:int = pkg.readInt();
         var MaxBoold:int = pkg.readInt();
         var team:int = pkg.readInt();
         var direction:int = pkg.readByte();
         var layer:int = pkg.readByte();
         var isBottom:Boolean = layer == 0?true:false;
         var isShowBlood:Boolean = pkg.readBoolean();
         var isShowSmallMapPoint:Boolean = pkg.readBoolean();
         var actionCount:int = pkg.readInt();
         var labelMapping:Dictionary = new Dictionary();
         for(j = 0; j < actionCount; )
         {
            key = pkg.readUTF();
            value = pkg.readUTF();
            labelMapping[key] = value;
            j++;
         }
         var buffCount:int = pkg.readInt();
         var buffs:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         for(i = 0; i < buffCount; )
         {
            buff = BuffManager.creatBuff(pkg.readInt());
            buffs.push(buff);
            i++;
         }
         var isFrost:Boolean = pkg.readBoolean();
         var isHide:Boolean = pkg.readBoolean();
         var isNoHole:Boolean = pkg.readBoolean();
         var isBubble:Boolean = pkg.readBoolean();
         var sealSatesCount:int = pkg.readInt();
         var sealSates:Dictionary = new Dictionary();
         for(I = 0; I < sealSatesCount; )
         {
            K = pkg.readUTF();
            Value = pkg.readUTF();
            sealSates[K] = Value;
            I++;
         }
         if(_map && _map.getPhysical(ID))
         {
            _map.getPhysical(ID).dispose();
         }
         if(livingType == 16)
         {
            BoneMovieFactory.instance.model.addBoneVoByStyle(ActionMovie.replace(/\./g,"_"),PathManager.getBoneLivingPath(),2,0,"none");
         }
         if(livingType != 4 && livingType != 5 && livingType != 6 && livingType != 12)
         {
            living = new SmallEnemy(ID,team,MaxBoold);
            living.typeLiving = livingType;
            living.actionMovieName = ActionMovie;
            living.direction = direction;
            living.pos = Pos;
            living.name = Name;
            living.isBottom = isBottom;
            living.isShowBlood = isShowBlood;
            living.isShowSmallMapPoint = isShowSmallMapPoint;
            _gameInfo.addGamePlayer(living);
            gameLiving = new GameSmallEnemy3D(living as SmallEnemy);
            _gameLivingArr.push(gameLiving);
            if(RoomManager.Instance.current.type == 21)
            {
               explorersLiving = _gameInfo.findLivingByName(LanguageMgr.GetTranslation("activity.dungeonView.explorers"));
            }
         }
         else
         {
            living = new SimpleBoss(ID,team,MaxBoold);
            living.typeLiving = livingType;
            living.actionMovieName = ActionMovie;
            living.direction = direction;
            living.pos = Pos;
            living.name = Name;
            living.isBottom = isBottom;
            living.isShowBlood = isShowBlood;
            living.isShowSmallMapPoint = isShowSmallMapPoint;
            _gameInfo.addGamePlayer(living);
            gameLiving = new GameSimpleBoss3D(living as SimpleBoss);
            _gameLivingArr.push(gameLiving);
            if(RoomManager.Instance.current.type == 21)
            {
               bossID = pkg.readInt();
               GameControl.Instance.bossName = Name;
               GameControl.Instance.currentNum = bossID - (bossID > 70003?70002:70000);
               addMessageBtn();
               if(!this.barrier)
               {
                  fadingComplete();
               }
               this.barrier.dispatchEvent(new CrazyTankSocketEvent("update_activitydungeon_info"));
            }
            if(RoomManager.Instance.current.type == 52)
            {
               ls = _cs as LiveState;
               if(ls && ls.insectProBar)
               {
                  ls.insectProBar.showBallTips();
               }
            }
         }
         k = 0;
         while(i < buffs.length)
         {
            living.addBuff(buffs[i]);
            i++;
         }
         var _loc45_:int = 0;
         var _loc44_:* = labelMapping;
         for(var Key in labelMapping)
         {
            gameLiving.setActionMapping(Key,labelMapping[Key]);
         }
         gameLiving.name = Name;
         if(layer == 7)
         {
            gameLiving.layer = layer;
         }
         if(currentHP != living.maxBlood)
         {
            living.initBlood(currentHP);
         }
         gameLiving.info.isFrozen = isFrost;
         gameLiving.info.isHidden = isHide;
         gameLiving.info.isNoNole = isNoHole;
         if(pkg.bytesAvailable)
         {
            pid = pkg.readInt();
            angle = pkg.readInt();
            gameLiving.angle = angle;
            trace("addLiving:-->id:" + gameLiving.Id + ",pid:" + pid);
            if(pid > -1)
            {
               if(_map.physicalChilds[pid])
               {
                  childs = _map.physicalChilds[pid];
               }
               else
               {
                  childs = [];
               }
               childs.push([gameLiving,labelMapping,specificAction,sealSates]);
               _map.physicalChilds[pid] = childs;
               return;
            }
            addGameLivingToMap([gameLiving,labelMapping,specificAction,sealSates]);
         }
         addGameLivingToMap([gameLiving,labelMapping,specificAction,sealSates]);
      }
      
      public function addGameLivingToMap(params:Array) : void
      {
         var gameLiving:GameLiving3D = params[0];
         var labelMapping:Dictionary = params[1];
         var specificAction:String = params[2];
         var sealSates:Dictionary = params[3];
         var living:Living = gameLiving.info;
         if(specificAction.length > 0)
         {
            gameLiving.doAction(specificAction);
         }
         else if(!labelMapping["stand"])
         {
            gameLiving.doAction("born");
         }
         else
         {
            gameLiving.doAction("stand");
         }
         var _loc9_:int = 0;
         var _loc8_:* = sealSates;
         for(var KEY in sealSates)
         {
            setProperty(gameLiving,KEY,sealSates[KEY]);
         }
         _playerThumbnailLController.addLiving(gameLiving.info);
         addChild(_playerThumbnailLController);
         if(living is SimpleBoss)
         {
            _map.setCenter(gameLiving.x,gameLiving.y - 150,false);
         }
         else
         {
            _map.setCenter(gameLiving.x,gameLiving.y - 150,true);
         }
         _map.addPhysical(gameLiving);
      }
      
      protected function __addAnimation(event:CrazyTankSocketEvent) : void
      {
         var nextView:* = null;
         var obj:* = null;
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readInt();
         var flag:Boolean = pkg.readBoolean();
         var id:int = pkg.readInt();
         var player:RoomPlayer = RoomManager.Instance.findRoomPlayer(id);
         var livingPlayer:Player = _gameInfo.findLivingByPlayerID(id,player.playerInfo.ZoneID);
         if(flag)
         {
            switch(int(type) - 1)
            {
               case 0:
                  nextView = new ActivityDungeonNextView(type,pkg.readDate().time);
                  PositionUtils.setPos(nextView,"game.view.activityDungeonNextView.viewPos");
                  livingPlayer.resetWithinTheMap();
                  if(player.isViewer || !livingPlayer.isLiving)
                  {
                     nextView.setBtnEnable();
                  }
                  hideView(false);
                  updateDamageView();
                  _animationArray.push(nextView);
                  deleteAnimation(2);
                  break;
               case 1:
                  if(livingPlayer.isLiving)
                  {
                     obj = new AnimationObject(2,"asset.game.lightning");
                     PositionUtils.setPos(obj,"game.view.activityDungeon.lightningPos");
                     _animationArray.push(obj);
                  }
            }
            i = 0;
            while(i < _animationArray.length)
            {
               addChild(_animationArray[i]);
               i++;
            }
         }
         else
         {
            deleteAnimation(type);
            hideView(true);
         }
      }
      
      public function deleteAnimation(type:int) : void
      {
         var i:int = 0;
         for(i = 0; i < _animationArray.length; )
         {
            if(type == _animationArray[i].Id)
            {
               removeChild(_animationArray[i]);
               _animationArray[i].dispose();
               _animationArray[i] = null;
               _animationArray.splice(i,1);
            }
            i++;
         }
      }
      
      public function hideView(flag:Boolean) : void
      {
         if(_selfMarkBar)
         {
            _selfMarkBar.visible = flag;
         }
         if(_cs)
         {
            _cs.visible = flag;
         }
         if(_selfBuffBar)
         {
            _selfBuffBar.visible = flag;
         }
         if(_kingblessIcon)
         {
            _kingblessIcon.visible = flag;
         }
         if(_playerThumbnailLController)
         {
            _playerThumbnailLController.visible = flag;
         }
         if(ChatManager.Instance.view)
         {
            ChatManager.Instance.view.visible = flag;
         }
         if(_leftPlayerView)
         {
            _leftPlayerView.visible = flag;
         }
         if(_vane)
         {
            _vane.visible = flag;
         }
         if(_barrier)
         {
            _barrier.visible = flag;
         }
      }
      
      private function __addTipLayer(evt:CrazyTankSocketEvent) : void
      {
         var bone:* = null;
         var obj:* = null;
         var id:int = evt.pkg.readInt();
         var type:int = evt.pkg.readInt();
         var px:int = evt.pkg.readInt();
         var py:int = evt.pkg.readInt();
         var model:String = evt.pkg.readUTF();
         var action:String = evt.pkg.readUTF();
         var pscale:int = evt.pkg.readInt();
         var protation:int = evt.pkg.readInt();
         if(type == 10)
         {
            bone = BoneMovieFactory.instance.creatBoneMovie(model);
            addTipSprite(bone);
            bone.play();
         }
         else
         {
            if(_tipItems[id])
            {
               obj = _tipItems[id] as SimpleObject3D;
            }
            else
            {
               obj = new SimpleObject3D(id,type,model,action);
               addTipSprite(obj);
            }
            obj.playAction(action);
            _tipItems[id] = obj;
         }
      }
      
      private function addTipSprite(obj:Sprite) : void
      {
         if(!_tipLayers)
         {
            _tipLayers = new DisplayObjectContainer();
            _tipLayers.touchable = false;
            StarlingMain.instance.currentScene.addChild(_tipLayers);
         }
         _tipLayers.addChild(obj);
      }
      
      private function hideAllOther() : void
      {
         ObjectUtils.disposeObject(_selfMarkBar);
         _selfMarkBar = null;
         ObjectUtils.disposeObject(_cs);
         _cs = null;
         ObjectUtils.disposeObject(_selfBuffBar);
         _selfBuffBar = null;
         ObjectUtils.disposeObject(_kingblessIcon);
         _kingblessIcon = null;
         _playerThumbnailLController.visible = false;
         ChatManager.Instance.view.visible = false;
         _leftPlayerView.visible = false;
         _vane.visible = false;
         _barrier.visible = false;
      }
      
      public function addMapThing(evt:CrazyTankSocketEvent) : void
      {
         var j:int = 0;
         var key:* = null;
         var value:* = null;
         var id:int = evt.pkg.readInt();
         var type:int = evt.pkg.readInt();
         var px:int = evt.pkg.readInt();
         var py:int = evt.pkg.readInt();
         var model:String = evt.pkg.readUTF();
         var action:String = evt.pkg.readUTF();
         var pscaleX:int = evt.pkg.readInt();
         var pscaleY:int = evt.pkg.readInt();
         var protation:int = evt.pkg.readInt();
         var layer:int = evt.pkg.readInt();
         var containerID:int = evt.pkg.readInt();
         var labelMappingCount:int = evt.pkg.readInt();
         var labelMapping:Dictionary = new Dictionary();
         for(j = 0; j < labelMappingCount; )
         {
            key = evt.pkg.readUTF();
            value = evt.pkg.readUTF();
            labelMapping[key] = value;
            j++;
         }
         model = model.replace(/\./g,"_");
         var p:String = PathManager.getBoneLivingPath();
         BoneMovieFactory.instance.model.addBoneVoByStyle(model,p,2,0,"none");
         var obj:SimpleObject3D = null;
         switch(int(type) - 1)
         {
            case 0:
               obj = new SimpleBox3D(id,model);
               break;
            case 1:
               obj = new SimpleObject3D(id,1,model,action);
               break;
            case 2:
         }
         obj.x = px;
         obj.y = py;
         obj.scaleX = pscaleX;
         obj.scaleY = pscaleY;
         obj.angle = protation;
         var _loc22_:int = 0;
         var _loc21_:* = labelMapping;
         for(var Key in labelMapping)
         {
            obj.setActionMapping(Key,labelMapping[Key]);
         }
         if(type == 1)
         {
            addBox(obj);
         }
         addEffect(obj,containerID,layer);
      }
      
      private function addBox(obj:SimpleObject3D) : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            if(!_boxArr)
            {
               _boxArr = [];
            }
            _boxArr.push(obj);
         }
         else
         {
            addEffect(obj);
         }
      }
      
      private function addEffect(obj:SimpleObject3D, containerID:int = 0, layer:int = 0) : void
      {
         var living:* = null;
         switch(int(containerID) - -1)
         {
            case 0:
               addStageCurtain(obj);
               break;
            case 1:
               _map.addPhysical(obj);
               _objectDic[obj.Id] = obj;
               if(layer > 0 && layer != 6)
               {
                  _map.phyBringToFront(obj);
               }
         }
      }
      
      public function updatePhysicObject(evt:CrazyTankSocketEvent) : void
      {
         var id:int = evt.pkg.readInt();
         var obj:SimpleObject3D = _map.getPhysical(id) as SimpleObject3D;
         if(!obj)
         {
            obj = _tipItems[id] as SimpleObject3D;
         }
         var action:String = evt.pkg.readUTF();
         if(obj)
         {
            obj.playAction(action);
         }
         var evtObj:PhyobjEvent = new PhyobjEvent(action);
         dispatchEvent(evtObj);
      }
      
      private function __applySkill(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var skill:int = pkg.readInt();
         var src:int = pkg.readInt();
         SkillManager.applySkillToLiving(skill,src,pkg);
      }
      
      private function __removeSkill(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var skill:int = pkg.readInt();
         var src:int = pkg.readInt();
         SkillManager.removeSkillFromLiving(skill,src,pkg);
      }
      
      private function __removePhysicObject(event:CrazyTankSocketEvent) : void
      {
         var simpleObj:* = null;
         var objID:int = event.pkg.readInt();
         var obj:PhysicalObj3D = getGameLivingByID(objID);
         if(obj is GameSimpleBoss3D)
         {
            LogManager.getInstance().sendLog(GameSimpleBoss3D(obj).simpleBoss.actionMovieName);
         }
         if(_objectDic[objID])
         {
            simpleObj = _objectDic[objID];
            delete _objectDic[objID];
         }
         if(obj && obj.parent)
         {
            _map.removePhysical(obj);
         }
      }
      
      private function __focusOnObject(event:CrazyTankSocketEvent) : void
      {
         var type:int = event.pkg.readInt();
         var list:Array = [];
         var obj:Object = {};
         obj.x = event.pkg.readInt();
         obj.y = event.pkg.readInt();
         list.push(obj);
         _map.act(new ViewEachObjectAction(_map,list,type));
      }
      
      private function __barrierInfoHandler(evt:CrazyTankSocketEvent) : void
      {
         barrierInfo = evt;
      }
      
      private function __livingMoveto(event:CrazyTankSocketEvent) : void
      {
         var from:* = null;
         var pt:* = null;
         var speed:int = 0;
         var actionType:* = null;
         var endAction:* = null;
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(living)
         {
            from = new Point(event.pkg.readInt(),event.pkg.readInt());
            pt = new Point(event.pkg.readInt(),event.pkg.readInt());
            speed = event.pkg.readInt();
            actionType = event.pkg.readUTF();
            endAction = event.pkg.readUTF();
            living.pos = from;
            living.moveTo(0,pt,0,true,actionType,speed,endAction);
            _map.bringToFront(living);
         }
      }
      
      public function livingFalling(event:CrazyTankSocketEvent) : void
      {
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         var pt:Point = new Point(event.pkg.readInt(),event.pkg.readInt());
         var speed:int = event.pkg.readInt();
         var actionType:String = event.pkg.readUTF();
         var fallType:int = event.pkg.readInt();
         if(living)
         {
            living.fallTo(pt,speed,actionType,fallType);
            if(pt.y - living.pos.y > 50)
            {
               _map.setCenter(pt.x,pt.y - 150,false);
            }
            _map.bringToFront(living);
         }
      }
      
      private function __livingJump(event:CrazyTankSocketEvent) : void
      {
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         var pt:Point = new Point(event.pkg.readInt(),event.pkg.readInt());
         var speed:int = event.pkg.readInt();
         var actionType:String = event.pkg.readUTF();
         var jumpType:int = event.pkg.readInt();
         living.jumpTo(pt,speed,actionType,jumpType);
         _map.bringToFront(living);
      }
      
      private function __livingBeat(event:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var target:* = null;
         var damage:int = 0;
         var targetBlood:int = 0;
         var dander:int = 0;
         var attackEffect:int = 0;
         var type:int = 0;
         var obj:* = null;
         var pkg:PackageIn = event.pkg;
         var attacker:Living = _gameInfo.findLiving(pkg.extend1);
         var action:String = pkg.readUTF();
         var deadEffect:String = pkg.readUTF();
         if(deadEffect == "0")
         {
            deadEffect = "";
         }
         var length:uint = pkg.readInt();
         var arg:Array = [];
         for(i = uint(0); i < length; )
         {
            target = _gameInfo.findLiving(pkg.readInt());
            damage = pkg.readInt();
            targetBlood = pkg.readInt();
            dander = pkg.readInt();
            attackEffect = pkg.readInt();
            type = pkg.readInt();
            obj = {};
            obj["action"] = action;
            obj["deadEffect"] = deadEffect;
            obj["target"] = target;
            obj["damage"] = damage;
            obj["targetBlood"] = targetBlood;
            obj["dander"] = dander;
            obj["attackEffect"] = attackEffect;
            obj["type"] = type;
            arg.push(obj);
            if(target && target.isPlayer() && target.isLiving)
            {
               (target as Player).dander = dander;
            }
            i++;
         }
         if(attacker)
         {
            attacker.beat(arg);
         }
      }
      
      private function __livingSay(event:CrazyTankSocketEvent) : void
      {
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(!living || !living.isLiving)
         {
            return;
         }
         var msg:String = event.pkg.readUTF();
         var type:int = event.pkg.readInt();
         _map.bringToFront(living);
         living.say(msg,type);
      }
      
      private function __livingRangeAttacking(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var livingID:int = 0;
         var damage:int = 0;
         var blood:int = 0;
         var dander:int = 0;
         var attackEffect:int = 0;
         var living:* = null;
         var count:int = e.pkg.readInt();
         for(i = 0; i < count; )
         {
            livingID = e.pkg.readInt();
            damage = e.pkg.readInt();
            blood = e.pkg.readInt();
            dander = e.pkg.readInt();
            attackEffect = e.pkg.readInt();
            living = _gameInfo.findLiving(livingID);
            if(living)
            {
               living.isHidden = false;
               living.isFrozen = false;
               living.updateBlood(blood,attackEffect);
               living.showAttackEffect(1);
               _map.bringToFront(living);
               if(living.isSelf)
               {
                  _map.setCenter(living.pos.x,living.pos.y,false);
               }
               if(living.isPlayer() && living.isLiving)
               {
                  (living as Player).dander = dander;
               }
            }
            i++;
         }
      }
      
      private function __livingDirChanged(event:CrazyTankSocketEvent) : void
      {
         var dir:int = 0;
         var living:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(living)
         {
            dir = event.pkg.readInt();
            living.direction = dir;
            _map.bringToFront(living);
         }
      }
      
      private function __removePlayer(event:DictionaryEvent) : void
      {
         _msg = RoomManager.Instance._removeRoomMsg;
         var info:Player = event.data as Player;
         var player:GamePlayer3D = _players[info];
         if(player && info)
         {
            if(_map.currentPlayer == info)
            {
               setCurrentPlayer(null);
            }
            if(info.isSelf)
            {
               if(RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1)
               {
                  StateManager.setState("roomlist");
               }
               else if(RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 123)
               {
                  StateManager.setState("dungeon");
               }
               else if(RoomManager.Instance.current.type == 40)
               {
                  ChristmasCoreManager.instance.reConnectChristmasFunc();
               }
               else if(RoomManager.Instance.current.type == 52)
               {
                  CatchInsectManager.instance.reConnectCatchInectFunc();
               }
            }
            _map.removePhysical(player);
            delete _players[info];
            player.dispose();
         }
      }
      
      private function __beginShoot(event:CrazyTankSocketEvent) : void
      {
         var gameplayer:* = null;
         if(_map.currentPlayer && _map.currentPlayer.isPlayer() && event.pkg.clientId != _map.currentPlayer.playerInfo.ID && !GameControl.Instance.Current.togetherShoot)
         {
            _map.executeAtOnce();
            _map.setCenter(_map.currentPlayer.pos.x,_map.currentPlayer.pos.y - 150,false);
            gameplayer = _players[_map.currentPlayer];
         }
         if(!GameControl.Instance.Current.togetherShoot || _map.currentPlayer && _map.currentPlayer.isPlayer() && event.pkg.clientId == _map.currentPlayer.playerInfo.ID)
         {
            setPropBarClickEnable(false,false);
            PrepareShootAction.hasDoSkillAnimation = false;
         }
      }
      
      protected function __shoot(event:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var b:* = null;
         var bid:int = 0;
         var damagePlus:Number = NaN;
         var damageMinus:Number = NaN;
         var bombDamageModifier:Number = NaN;
         var len:int = 0;
         var lastTime:int = 0;
         var bombAction:* = null;
         var j:int = 0;
         var actionType:int = 0;
         var actionParam1:int = 0;
         var actionParam2:int = 0;
         var actionParam3:int = 0;
         var actionParam4:int = 0;
         var parentBomb:* = null;
         var a:int = 0;
         var parentSimpleBomb:* = null;
         var k:int = 0;
         var targetId:int = 0;
         var target:* = null;
         var damage:int = 0;
         var blood:int = 0;
         var dander:int = 0;
         var obj:* = null;
         var targetPoint:* = null;
         var beatInfo:* = null;
         var petBomb:* = null;
         EnergyView.canPower = false;
         var pkg:PackageIn = event.pkg;
         var livingId:int = event.pkg.extend1;
         var info:Living = _gameInfo.findLiving(livingId);
         var windPower:Number = pkg.readInt() / 10;
         var windDic:Boolean = pkg.readBoolean();
         var windPowerNum0:int = pkg.readByte();
         var windPowerNum1:int = pkg.readByte();
         var windPowerNum2:int = pkg.readByte();
         var weatherLevel:int = pkg.readInt();
         GameControl.Instance.Current.windRate = pkg.readInt() / 100;
         var windNumArr:Array = [windDic,windPowerNum0,windPowerNum1,windPowerNum2,weatherLevel];
         var isSelf:Boolean = info == null?false:Boolean(info.isSelf);
         GameControl.Instance.Current.setWind(windPower,isSelf,windNumArr);
         var list:Array = [];
         var count:Number = pkg.readInt();
         for(i = uint(0); i < count; )
         {
            b = new Bomb();
            b.number = pkg.readInt();
            b.shootCount = pkg.readInt();
            b.IsHole = pkg.readBoolean();
            b.Id = pkg.readInt();
            b.pid = pkg.readInt();
            b.X = pkg.readInt();
            b.Y = pkg.readInt();
            b.VX = pkg.readInt();
            b.VY = pkg.readInt();
            if(i == 0)
            {
               setBombKingInfo(b.VX,b.VY);
            }
            bid = pkg.readInt();
            b.Template = BallManager.instance.findBall(bid);
            b.Actions = [];
            b.changedPartical = pkg.readUTF();
            damagePlus = pkg.readInt() / 1000;
            damageMinus = pkg.readInt() / 1000;
            bombDamageModifier = damagePlus * damageMinus;
            b.damageMod = bombDamageModifier;
            len = pkg.readInt();
            for(j = 0; j < len; )
            {
               lastTime = pkg.readInt();
               actionType = pkg.readInt();
               if(actionType == 27)
               {
                  actionParam1 = pkg.readInt();
                  actionParam2 = pkg.readInt();
               }
               else
               {
                  actionParam1 = pkg.readInt();
                  actionParam2 = pkg.readInt();
                  actionParam3 = pkg.readInt();
                  actionParam4 = pkg.readInt();
               }
               bombAction = new BombAction3D(lastTime,actionType,actionParam1,actionParam2,actionParam3,actionParam4);
               b.Actions.push(bombAction);
               if(info && RoomManager.Instance.current.type == 21 && info.isPlayer() && bombAction.type == 5)
               {
                  info.damageNum = info.damageNum + bombAction.param2;
               }
               j++;
            }
            list.push(b);
            i++;
         }
         if(list[0].pid > -1)
         {
            if(info.currentShootList)
            {
               parentBomb = null;
               for(a = 0; a < info.currentShootList.length; )
               {
                  if(info.currentShootList[a].Id == list[0].pid)
                  {
                     parentBomb = info.currentShootList[a];
                     break;
                  }
                  a++;
               }
            }
            if(parentBomb == null)
            {
               parentSimpleBomb = _map.getPhysical(list[0].pid) as SimpleBomb3D;
               if(parentSimpleBomb)
               {
                  parentBomb = parentSimpleBomb.info;
               }
            }
            if(parentBomb)
            {
               parentBomb.childs = parentBomb.childs.concat(list);
            }
         }
         else if(info)
         {
            info.shoot(list,event);
         }
         else if(livingId < 0)
         {
            map.act(new SceneEffectShootBombAction(livingId,map,list,event,24));
         }
         var petAttackCount:int = pkg.readInt();
         var targets:Array = [];
         for(k = 0; k < petAttackCount; )
         {
            targetId = pkg.readInt();
            target = _gameInfo.findLiving(targetId);
            damage = pkg.readInt();
            blood = pkg.readInt();
            dander = pkg.readInt();
            obj = {
               "target":target,
               "hp":blood,
               "damage":damage,
               "dander":dander
            };
            targets.push(obj);
            k++;
         }
         var act:int = pkg.readInt();
         var actionName:String = "attack" + act.toString();
         if(act != 0 && info)
         {
            targetPoint = null;
            if(list.length == 3)
            {
               targetPoint = Bomb(list[0]).target;
            }
            else if(list.length == 1)
            {
               targetPoint = Bomb(list[0]).target;
            }
            beatInfo = Player(info).currentPet.petBeatInfo;
            beatInfo["actionName"] = actionName;
            beatInfo["targetPoint"] = targetPoint;
            beatInfo["targets"] = targets;
            petBomb = Bomb(list[list.length == 3?0:0]);
            petBomb.Actions.push(new BombAction3D(0,20,event.pkg.extend1,0,0,0));
         }
      }
      
      private function setBombKingInfo(VX:int, VY:int) : void
      {
         var angle:Number = NaN;
         var direction:int = 0;
         var obj:* = null;
         if(BombKingManager.instance.Recording)
         {
            angle = Math.atan(VY / VX) * 180 / 3.14159265358979;
            direction = VX > 0?1:-1;
            obj = {};
            obj["angle"] = Math.abs(angle);
            obj["direction"] = direction;
            BombKingManager.instance.dispatchEvent(new BombKingEvent("recordingModifyAngle",obj));
         }
      }
      
      private function __suicide(event:CrazyTankSocketEvent) : void
      {
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info)
         {
            info.die();
         }
      }
      
      private function __changeBall(event:CrazyTankSocketEvent) : void
      {
         var player:* = null;
         var isSpecialSkill:Boolean = false;
         var currentBomb:int = 0;
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info && info is Player)
         {
            player = info as Player;
            isSpecialSkill = event.pkg.readBoolean();
            currentBomb = event.pkg.readInt();
            _map.act(new ChangeBallAction(player,isSpecialSkill,currentBomb));
         }
      }
      
      private function __playerUsingItem(event:CrazyTankSocketEvent) : void
      {
         var dis:* = null;
         var propAnimationName:* = null;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         var place:int = pkg.readInt();
         var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(pkg.readInt());
         if(props.indexOf(item.TemplateID) != -1)
         {
            EnergyView.canPower = true;
         }
         var from:Living = _gameInfo.findLiving(pkg.extend1);
         var to:Living = _gameInfo.findLiving(pkg.readInt());
         var autoMessage:Boolean = pkg.readBoolean();
         if(from && item)
         {
            if(from.isPlayer())
            {
               if(item.CategoryID == 10015)
               {
                  Player(from).skill == -1;
               }
               if(!(from as Player).isSelf)
               {
                  if(item.CategoryID == 17 || item.CategoryID == 31)
                  {
                     dis = (from as Player).currentDeputyWeaponInfo.getDeputyWeaponIcon3D();
                     dis.x = dis.x + 7;
                     (from as Player).useItemByIcon3D(dis);
                  }
                  else
                  {
                     (from as Player).useItem(item);
                     propAnimationName = EquipType.hasPropAnimation(item);
                     if(propAnimationName != null && to && to.LivingID != from.LivingID)
                     {
                        to.showEffect(propAnimationName);
                     }
                  }
               }
            }
            if(_map.currentPlayer && to.team == _map.currentPlayer.team && (!GameControl.Instance.Current.togetherShoot || (from as Player).isSelf))
            {
               _map.currentPlayer.addState(item.TemplateID);
            }
            if(!to.isLiving)
            {
               if(to.isPlayer())
               {
                  (to as Player).addState(item.TemplateID);
               }
            }
            if(RoomManager.Instance.current.type != 21)
            {
               if(!from.isLiving && to && from.team == to.team)
               {
                  GameMessageTipManager.getInstance().show(from.LivingID + "|" + item.TemplateID,1);
               }
               if(autoMessage)
               {
                  GameMessageTipManager.getInstance().show(String(to.LivingID),3);
               }
            }
         }
      }
      
      private function __updateBuff(evt:CrazyTankSocketEvent) : void
      {
         var buff:* = null;
         var pkg:PackageIn = evt.pkg;
         var livingid:int = pkg.extend1;
         var buffid:int = pkg.readInt();
         var enable:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
         var living:Living = _gameInfo.findLiving(livingid);
         if(living is LocalPlayer)
         {
            if(enable)
            {
               (living as LocalPlayer).usePassBall = true;
            }
            else
            {
               (living as LocalPlayer).usePassBall = false;
            }
         }
         if(living && buffid != -1)
         {
            if(enable)
            {
               buff = BuffManager.creatBuff(buffid);
               buff.Count = count;
               living.addBuff(buff);
            }
            else
            {
               living.removeBuff(buffid);
            }
         }
      }
      
      public function boxPhysicalPos(evt:CrazyTankSocketEvent) : void
      {
      }
      
      private function __updatePetBuff(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var livingid:int = pkg.extend1;
         var buffid:int = pkg.readInt();
         var buffName:String = pkg.readUTF();
         var description:String = pkg.readUTF();
         var buffPic:String = pkg.readUTF();
         var buffEffect:String = pkg.readUTF();
         var enable:Boolean = pkg.readBoolean();
         var living:Living = _gameInfo.findLiving(livingid);
         var buff:FightBuffInfo = new FightBuffInfo(buffid);
         buff.buffPic = buffPic;
         buff.buffEffect = buffEffect;
         buff.type = 5;
         buff.buffName = buffName;
         buff.description = description;
         if(living)
         {
            if(enable)
            {
               living.addPetBuff(buff);
            }
            else
            {
               living.removePetBuff(buff);
            }
         }
      }
      
      private function __startMove(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var info:Player = _gameInfo.findPlayer(event.pkg.extend1);
         var flag:Boolean = pkg.readBoolean();
         if(flag)
         {
            if(!info.playerInfo.isSelf || BombKingManager.instance.Recording)
            {
               playerMove(pkg,info);
            }
         }
         else
         {
            playerMove(pkg,info);
         }
      }
      
      private function playerMove(pkg:PackageIn, info:Player) : void
      {
         var pickBoxActs:* = null;
         var len:int = 0;
         var j:int = 0;
         var act:* = null;
         var type:int = pkg.readByte();
         var target:Point = new Point(pkg.readInt(),pkg.readInt());
         var dir:int = pkg.readByte();
         var isLiving:Boolean = pkg.readBoolean();
         if(type == 2)
         {
            pickBoxActs = [];
            len = pkg.readInt();
            for(j = 0; j < len; )
            {
               act = new PickBoxAction(pkg.readInt(),pkg.readInt());
               pickBoxActs.push(act);
               j++;
            }
            if(info)
            {
               info.playerMoveTo(type,target,dir,isLiving,pickBoxActs);
            }
         }
         else if(info)
         {
            info.playerMoveTo(type,target,dir,isLiving);
         }
      }
      
      private function __onLivingBoltmove(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info)
         {
            info.pos = new Point(pkg.readInt(),pkg.readInt());
         }
      }
      
      public function playerBlood(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         var blood:Number = pkg.readLong();
         var addValue:int = pkg.readInt();
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info)
         {
            trace("[playerBlood]actionMovieName:" + info.actionMovieName + ",ID:" + info.LivingID + ",type:" + type + ",value:" + blood + ",addVlaue:" + addValue);
            info.updateBlood(blood,type,addValue);
         }
      }
      
      private function __changWind(event:CrazyTankSocketEvent) : void
      {
         var _pkg:PackageIn = event.pkg;
         _map.wind = _pkg.readInt() / 10;
         var windDic:Boolean = _pkg.readBoolean();
         var windPowerNum0:int = _pkg.readByte();
         var windPowerNum1:int = _pkg.readByte();
         var windPowerNum2:int = _pkg.readByte();
         var weatherLevel:int = _pkg.readInt();
         var weatherRate:Number = _pkg.readInt() / 100;
         var windNumArr:Array = [windDic,windPowerNum0,windPowerNum1,windPowerNum2,weatherLevel];
         _vane.update(_map.wind,false,windNumArr);
      }
      
      private function __playerNoNole(evt:CrazyTankSocketEvent) : void
      {
         var info:Living = _gameInfo.findLiving(evt.pkg.extend1);
         if(info)
         {
            info.isNoNole = evt.pkg.readBoolean();
         }
      }
      
      private function __onChangePlayerTarget(evt:CrazyTankSocketEvent) : void
      {
         var id:int = evt.pkg.readInt();
         if(id == 0)
         {
            if(_playerThumbnailLController)
            {
               _playerThumbnailLController.currentBoss = null;
            }
            return;
         }
         var info:Living = _gameInfo.findLiving(id);
         _gameLivingIdArr.push(id);
         _playerThumbnailLController.currentBoss = info;
      }
      
      public function objectSetProperty(evt:CrazyTankSocketEvent) : void
      {
         var obj:GameLiving3D = getGameLivingByID(evt.pkg.extend1) as GameLiving3D;
         if(!obj)
         {
            return;
         }
         var property:String = evt.pkg.readUTF();
         var value:String = evt.pkg.readUTF();
         setProperty(obj,property,value);
      }
      
      private function __usePetSkill(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var livingID:int = pkg.extend1;
         var skillID:int = pkg.readInt();
         var isUse:Boolean = pkg.readBoolean();
         var info:Player = _gameInfo.findPlayer(livingID);
         var skillFrom:int = pkg.readInt();
         if(!info)
         {
            return;
         }
         if(skillFrom == 2)
         {
            info.useHorseSkill(skillID,isUse,pkg.readInt());
         }
         else
         {
            if(info && info.currentPet && isUse)
            {
               info.usePetSkill(skillID,isUse);
               if(PetSkillManager.getSkillByID(skillID).BallType == 2)
               {
                  info.isAttacking = false;
                  GameControl.Instance.Current.selfGamePlayer.beginShoot();
               }
            }
            if(!isUse)
            {
               GameControl.Instance.dispatchEvent(new LivingEvent("petSkillUsedFail"));
            }
         }
      }
      
      private function __petBeat(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var targetid:int = 0;
         var target:* = null;
         var dam:int = 0;
         var targetHp:int = 0;
         var dander:int = 0;
         var obj:* = null;
         var pkg:PackageIn = event.pkg;
         var playerid:int = pkg.extend1;
         var p:Player = _gameInfo.findPlayer(playerid);
         var targetLen:int = pkg.readInt();
         var targets:Array = [];
         for(i = 0; i < targetLen; )
         {
            targetid = pkg.readInt();
            target = _gameInfo.findLiving(targetid);
            dam = pkg.readInt();
            targetHp = pkg.readInt();
            dander = pkg.readInt();
            obj = {
               "target":target,
               "hp":targetHp,
               "damage":dam,
               "dander":dander
            };
            targets.push(obj);
            i++;
         }
         var act:int = pkg.readInt();
         var actionName:String = "attack" + act.toString();
         var pt:Point = new Point(pkg.readInt(),pkg.readInt());
         p.petBeat(actionName,pt,targets);
      }
      
      private function __playerHide(event:CrazyTankSocketEvent) : void
      {
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info)
         {
            info.isHidden = event.pkg.readBoolean();
         }
      }
      
      private function __gameOver(event:CrazyTankSocketEvent) : void
      {
         GameControl.Instance.currentNum = 0;
         gameOver();
         _map.act(new GameOverAction(_map,event,showExpView));
      }
      
      public function logTimeHandler(event:TimerEvent = null) : void
      {
         _map.traceCurrentAction();
      }
      
      private function __missionOver(event:CrazyTankSocketEvent) : void
      {
         gameOver();
         _missionAgain = new MissionAgainInfo();
         _missionAgain.value = _gameInfo.missionInfo.tryagain;
         var roomPlayers:DictionaryData = RoomManager.Instance.current.players;
         var _loc5_:int = 0;
         var _loc4_:* = roomPlayers;
         for(var key in roomPlayers)
         {
            if(RoomPlayer(roomPlayers[key]).isHost)
            {
               _missionAgain.host = RoomPlayer(roomPlayers[key]).playerInfo.NickName;
            }
         }
         _map.act(new MissionOverAction(_map,event,showExpView));
         if(GameManager.GAME_CAN_NOT_EXIT_SEND_LOG == 1 && _gameInfo.roomType == 21)
         {
            if(!_logTimer)
            {
               _logTimer = new Timer(15000,10);
               _logTimer.addEventListener("timer",logTimeHandler,false,0,true);
            }
            _logTimer.start();
         }
      }
      
      override protected function gameOver() : void
      {
         PageInterfaceManager.restorePageTitle();
         super.gameOver();
         KeyboardManager.getInstance().isStopDispatching = true;
      }
      
      private function showTryAgain() : void
      {
         var tryagain:TryAgain = new TryAgain(_missionAgain);
         tryagain.addEventListener("tryagain",__tryAgain);
         tryagain.addEventListener("giveup",__giveup);
         tryagain.addEventListener("timeOut",__tryAgainTimeOut);
         tryagain.show();
         addChild(tryagain);
      }
      
      private function __tryAgainTimeOut(event:GameEvent) : void
      {
         event.currentTarget.removeEventListener("tryagain",__tryAgain);
         event.currentTarget.removeEventListener("giveup",__giveup);
         event.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(event.currentTarget);
         if(_expView)
         {
            _expView.close();
         }
         if(_expGameBg)
         {
            StarlingObjectUtils.disposeObject(_expGameBg,true);
         }
         _expView = null;
         _expGameBg = null;
      }
      
      private function showExpView() : void
      {
         var bossState:int = 0;
         var time:int = 0;
         var urlVar:* = null;
         var url:* = null;
         var loader:* = null;
         if(ChatManager.Instance.input.parent)
         {
            ChatManager.Instance.switchVisible();
         }
         disposeUI();
         MenoryUtil.clearMenory();
         if(GameControl.Instance.Current.roomType == 14)
         {
            StateManager.setState("worldboss");
            return;
         }
         if(GameControl.Instance.Current.roomType == 17)
         {
            StateManager.setState("consortia",ConsortionModelManager.Instance.openBossFrame);
            return;
         }
         if(GameControl.Instance.Current.roomType == 19)
         {
            StateManager.setState("consortiaBattleScene");
            return;
         }
         if(GameControl.Instance.Current.roomType == 31)
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
            return;
         }
         if(GameControl.Instance.Current.roomType == 24 || GameControl.Instance.Current.roomType == 49)
         {
            StateManager.setState("main");
            return;
         }
         if(GameControl.Instance.Current.roomType == 27)
         {
            StateManager.setState("main");
            return;
         }
         if(GameControl.Instance.Current.roomType == 26)
         {
            StateManager.setState("main");
            return;
         }
         if(GameControl.Instance.Current.roomType == 21)
         {
            StateManager.setState("dungeon");
            return;
         }
         if(GameControl.Instance.Current.roomType == 40)
         {
            ChristmasCoreManager.instance.reConnectChristmasFunc();
            return;
         }
         if(GameControl.Instance.Current.roomType == 52)
         {
            CatchInsectManager.instance.reConnectCatchInectFunc();
            return;
         }
         if(GameControl.Instance.Current.roomType == 20)
         {
            SocketManager.Instance.out.returnToPve();
            return;
         }
         if(GameControl.Instance.Current.roomType == 48)
         {
            bossState = DemonChiYouManager.instance.model.bossState;
            if(bossState == 2 && PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               StateManager.setState("demon_chi_you");
            }
            else
            {
               StateManager.setState("main");
            }
            return;
         }
         if(GameControl.Instance.Current.roomType == 150)
         {
            StateManager.setState("consortia_domain");
            return;
         }
         if(GameControl.Instance.Current.roomType == 151)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               StateManager.setState("consortiaGuard");
            }
            else
            {
               StateManager.setState("main");
            }
            return;
         }
         if(!_firstEnter)
         {
            _expView = new ExpView();
            _expView.addEventListener("expshowed",__expShowed);
            addChild(_expView);
            StarlingObjectUtils.disposeObject(_expGameBg,true);
            _expGameBg = _map.drawMapView;
            StarlingMain.instance.currentScene.addChild(_expGameBg);
            _expView.show();
         }
         else
         {
            if(ApplicationDomain.currentDomain.hasDefinition("RegisterLuncher"))
            {
               if(getDefinitionByName("RegisterLuncher").newBieTime != -1)
               {
                  time = getTimer() - getDefinitionByName("RegisterLuncher").newBieTime;
                  urlVar = new URLVariables();
                  urlVar.id = PlayerManager.Instance.Self.ID;
                  urlVar.type = 3;
                  urlVar.time = time;
                  urlVar.grade = PlayerManager.Instance.Self.Grade;
                  urlVar.serverID = PlayerManager.Instance.Self.ZoneID;
                  url = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
                  url.method = "POST";
                  url.data = urlVar;
                  loader = new URLLoader();
                  loader.load(url);
               }
            }
            StateManager.setState("main");
         }
      }
      
      private function __expShowed(event:GameEvent) : void
      {
         _expView.removeEventListener("expshowed",__expShowed);
         var _loc5_:int = 0;
         var _loc4_:* = _gameInfo.livings.list;
         for each(var living in _gameInfo.livings.list)
         {
            if(living.isSelf)
            {
               if(Player(living).isWin && _missionAgain)
               {
                  _missionAgain.win = true;
               }
               if(Player(living).hasLevelAgain && _missionAgain)
               {
                  _missionAgain.hasLevelAgain = true;
               }
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _gameInfo.viewers.list;
         for each(var viewer in _gameInfo.viewers.list)
         {
            if(viewer.isSelf)
            {
               if(Player(viewer).isWin && _missionAgain)
               {
                  _missionAgain.win = true;
               }
               if(Player(viewer).hasLevelAgain && _missionAgain)
               {
                  _missionAgain.hasLevelAgain = true;
               }
            }
         }
         if((GameControl.isDungeonRoom(_gameInfo) || GameControl.isAcademyRoom(_gameInfo)) && _gameInfo.missionInfo.tryagain > 0)
         {
            if(RoomManager.Instance.current.selfRoomPlayer.isViewer && !_missionAgain.win)
            {
               showTryAgain();
               if(_expView)
               {
                  _expView.visible = false;
               }
               if(_expGameBg)
               {
                  _expGameBg.visible = false;
               }
            }
            else if(RoomManager.Instance.current.selfRoomPlayer.isViewer && _missionAgain.win)
            {
               if(_expView)
               {
                  _expView.close();
               }
               StarlingObjectUtils.disposeObject(_expGameBg,true);
               _expView = null;
               _expGameBg = null;
            }
            else if(!_gameInfo.selfGamePlayer.isWin)
            {
               showTryAgain();
               if(_expView)
               {
                  _expView.visible = false;
               }
               if(_expGameBg)
               {
                  _expGameBg.visible = false;
               }
            }
            else
            {
               _expView.showCard();
               _expView = null;
            }
         }
         else if(GameControl.isFightLib(_gameInfo) || RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _expView.close();
            _expView = null;
            StarlingObjectUtils.disposeObject(_expGameBg,true);
            _expGameBg = null;
         }
         else
         {
            _expView.showCard();
            _expView = null;
         }
      }
      
      private function __giveup(event:GameEvent) : void
      {
         event.currentTarget.removeEventListener("tryagain",__tryAgain);
         event.currentTarget.removeEventListener("giveup",__giveup);
         event.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(event.currentTarget);
         if(RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendMissionTryAgain(0,true);
         }
         _expView.close();
         StarlingObjectUtils.disposeObject(_expGameBg,true);
         _expView = null;
         _expGameBg = null;
      }
      
      private function __tryAgain(event:GameEvent) : void
      {
         event.currentTarget.removeEventListener("tryagain",__tryAgain);
         event.currentTarget.removeEventListener("giveup",__giveup);
         event.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(event.currentTarget);
         if(!RoomManager.Instance.current.selfRoomPlayer.isViewer || GameControl.Instance.TryAgain == 1)
         {
            GameControl.Instance.Current.hasNextMission = true;
         }
         if(RoomManager.Instance.current.type != 15)
         {
            _expView.close();
         }
         _expView = null;
         StarlingObjectUtils.disposeObject(_expGameBg,true);
         _expGameBg = null;
      }
      
      private function __dander(event:CrazyTankSocketEvent) : void
      {
         var d:int = 0;
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info && info is Player)
         {
            d = event.pkg.readInt();
            (info as Player).dander = d;
         }
      }
      
      private function __reduceDander(event:CrazyTankSocketEvent) : void
      {
         var d:int = 0;
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info && info is Player)
         {
            d = event.pkg.readInt();
            (info as Player).reduceDander(d);
         }
      }
      
      private function __changeState(evt:CrazyTankSocketEvent) : void
      {
         var info:Living = _gameInfo.findLiving(evt.pkg.extend1);
         if(info)
         {
            info.State = evt.pkg.readInt();
            _map.setCenter(info.pos.x,info.pos.y,true);
         }
      }
      
      private function __selfObtainItem(event:BagEvent) : void
      {
         var item:* = null;
         var propback:* = null;
         var prop:* = null;
         var propcite:* = null;
         var mc:* = null;
         if(_gameInfo.roomType == 21 || _gameInfo.roomType == 52)
         {
            return;
         }
         var _loc9_:int = 0;
         var _loc8_:* = event.changedSlots;
         for each(var info in event.changedSlots)
         {
            item = new PropInfo(info);
            item.Place = info.Place;
            if(PlayerManager.Instance.Self.FightBag.getItemAt(info.Place))
            {
               propback = new AutoDisappear(ComponentFactory.Instance.creatBitmap("asset.game.getPropBgAsset"),3);
               propback.x = _vane.x - propback.width / 2 + 48;
               propback.y = _selfMarkBar.y + _selfMarkBar.height + 70;
               LayerManager.Instance.addToLayer(propback,3,false);
               prop = new AutoDisappear(PropItemView.createView(item.Template.Pic,62,62),3);
               prop.x = _vane.x - prop.width / 2 + 47;
               prop.y = _selfMarkBar.y + _selfMarkBar.height + 70;
               LayerManager.Instance.addToLayer(prop,3,false);
               propcite = new AutoDisappear(ComponentFactory.Instance.creatBitmap("asset.game.getPropCiteAsset"),3);
               propcite.x = _vane.x - propcite.width / 2 + 45;
               propcite.y = _selfMarkBar.y + _selfMarkBar.height + 70;
               LayerManager.Instance.addToLayer(propcite,3,false);
               mc = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.zxcTip"),true,true);
               mc.movie.x = mc.movie.x + (mc.movie.width * info.Place - 24 * info.Place);
               LayerManager.Instance.addToLayer(mc.movie,4,false);
            }
         }
      }
      
      private function __getTempItem(evt:BagEvent) : void
      {
         var playSound:Boolean = GameControl.Instance.selfGetItemShowAndSound(evt.changedSlots);
         if(playSound && _soundPlayFlag)
         {
            _soundPlayFlag = false;
            SoundManager.instance.play("1001");
         }
      }
      
      private function __forstPlayer(event:CrazyTankSocketEvent) : void
      {
         var info:Living = _gameInfo.findLiving(event.pkg.extend1);
         if(info)
         {
            info.isFrozen = event.pkg.readBoolean();
         }
      }
      
      private function __changeShootCount(event:CrazyTankSocketEvent) : void
      {
         if(!GameControl.Instance.Current.togetherShoot || event.pkg.extend1 == _gameInfo.selfGamePlayer.LivingID)
         {
            _gameInfo.selfGamePlayer.shootCount = event.pkg.readByte();
         }
      }
      
      private function __playSound(event:CrazyTankSocketEvent) : void
      {
         var soundID:String = event.pkg.readUTF();
         SoundManager.instance.initSound(soundID);
         SoundManager.instance.play(soundID);
      }
      
      private function __controlBGM(evt:CrazyTankSocketEvent) : void
      {
         if(evt.pkg.readBoolean())
         {
            SoundManager.instance.resumeMusic();
         }
         else
         {
            SoundManager.instance.pauseMusic();
         }
      }
      
      private function __forbidDragFocus(evt:CrazyTankSocketEvent) : void
      {
         var _allowDrag:Boolean = evt.pkg.readBoolean();
         _map.smallMap.allowDrag = _allowDrag;
         var _loc3_:* = _allowDrag;
         _arrowUp.allowDrag = _loc3_;
         _loc3_ = _loc3_;
         _arrowRight.allowDrag = _loc3_;
         _loc3_ = _loc3_;
         _arrowDown.allowDrag = _loc3_;
         _arrowLeft.allowDrag = _loc3_;
      }
      
      override protected function defaultForbidDragFocus() : void
      {
         _map.smallMap.allowDrag = true;
         var _loc1_:* = true;
         _arrowUp.allowDrag = _loc1_;
         _loc1_ = _loc1_;
         _arrowRight.allowDrag = _loc1_;
         _loc1_ = _loc1_;
         _arrowDown.allowDrag = _loc1_;
         _arrowLeft.allowDrag = _loc1_;
      }
      
      private function __topLayer(evt:CrazyTankSocketEvent) : void
      {
         var living:Living = _gameInfo.findLiving(evt.pkg.readInt());
         if(living)
         {
            _map.bringToFront(living);
         }
      }
      
      private function __loadResource(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var needMovie:* = null;
         var count:int = event.pkg.readInt();
         for(i = 0; i < count; )
         {
            needMovie = new GameNeedMovieInfo();
            needMovie.type = event.pkg.readInt();
            needMovie.path = event.pkg.readUTF();
            needMovie.classPath = event.pkg.readUTF();
            needMovie.startLoad();
            i++;
         }
      }
      
      public function livingShowBlood(event:CrazyTankSocketEvent) : void
      {
         var id:int = event.pkg.readInt();
         var value:Boolean = event.pkg.readInt();
         if(_map)
         {
            if(_map.getPhysical(id))
            {
               (_map.getPhysical(id) as GameLiving3D).showBlood(value);
            }
         }
      }
      
      public function livingActionMapping(event:CrazyTankSocketEvent) : void
      {
         var id:int = event.pkg.readInt();
         var source:String = event.pkg.readUTF();
         var target:String = event.pkg.readUTF();
         if(_map.getPhysical(id))
         {
            _map.getPhysical(id).setActionMapping(source,target);
         }
      }
      
      private function __livingSmallColorChange(event:CrazyTankSocketEvent) : void
      {
         var id:int = event.pkg.readInt();
         var colorIndex:int = event.pkg.readByte();
         if(_map.getPhysical(id) && _map.getPhysical(id) is GameLiving3D)
         {
            (_map.getPhysical(id) as GameLiving3D).changeSmallViewColor(colorIndex);
         }
      }
      
      private function __revivePlayer(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var id:int = pkg.readInt();
         var blood:Number = pkg.readLong();
         var posX:int = pkg.readInt();
         var posY:int = pkg.readInt();
         var tmp:GamePlayer3D = retrunPlayer(id);
         if(tmp && !tmp.info.isLiving)
         {
            tmp.info.revive();
            tmp.pos = new Point(posX,posY);
            tmp.info.updateBlood(blood,0,blood);
            tmp.revive();
            tmp.info.dispatchEvent(new LivingEvent("livingRevive"));
            if(tmp is GameLocalPlayer3D)
            {
               _fightControlBar.setState(0);
               _selfBuffBar = ComponentFactory.Instance.creatCustomObject("SelfBuffBar",[this,_arrowDown]);
               if(GameControl.Instance.isShowSelfBuffBar)
               {
                  addChildAt(_selfBuffBar,this.numChildren - 1);
               }
               kingBlessIconInit();
            }
         }
      }
      
      public function revivePlayerChangePlayer(id:int) : void
      {
         var tmp:GamePlayer3D = retrunPlayer(id);
         if(tmp && !tmp.info.isLiving)
         {
            tmp.info.revive();
            tmp.revive();
            tmp.info.dispatchEvent(new LivingEvent("livingRevive"));
            if(tmp is GameLocalPlayer3D)
            {
               _fightControlBar.setState(0);
               _selfBuffBar = ComponentFactory.Instance.creatCustomObject("SelfBuffBar",[this,_arrowDown]);
               if(RoomManager.Instance.current.type != 18 && GameControl.Instance.Current.mapIndex != 140)
               {
                  addChildAt(_selfBuffBar,this.numChildren - 1);
               }
               kingBlessIconInit();
            }
         }
      }
      
      private function __gameTrusteeship(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var livingID:int = 0;
         var player:* = null;
         var len:int = event.pkg.readInt();
         if(len == 0)
         {
            return;
         }
         i = 0;
         while(i <= len - 1)
         {
            livingID = event.pkg.readInt();
            player = _gameInfo.findPlayer(livingID);
            player.playerInfo.isTrusteeship = event.pkg.readBoolean();
            i++;
         }
      }
      
      private function __fightStatusChange(event:CrazyTankSocketEvent) : void
      {
         var livingID:int = event.pkg.extend1;
         var player:Player = _gameInfo.findPlayer(livingID);
         if(player)
         {
            player.playerInfo.fightStatus = event.pkg.readInt();
         }
      }
      
      private function __skipNextHandler(event:CrazyTankSocketEvent) : void
      {
         if(_gameInfo.roomType == 21)
         {
            setTimeout(delayFocusSimpleBoss,250);
         }
      }
      
      private function __clearDebuff(event:CrazyTankSocketEvent) : void
      {
         var tmpLivingID:int = event.pkg.readInt();
         var tmpPlayer:GamePlayer3D = retrunPlayer(tmpLivingID);
         if(tmpPlayer)
         {
            tmpPlayer.clearDebuff();
         }
      }
      
      private function delayFocusSimpleBoss() : void
      {
         if(!_map)
         {
            return;
         }
         var tmps:GameSimpleBoss3D = _map.getOneSimpleBoss;
         if(tmps)
         {
            tmps.needFocus(0,0,{"priority":3});
         }
      }
      
      private function getGameLivingByID(id:int) : PhysicalObj3D
      {
         if(!_map)
         {
            return null;
         }
         return _map.getPhysical(id);
      }
      
      private function addStageCurtain(obj:SimpleObject3D) : void
      {
         obj = obj;
         playStageCurtainComplete = function(e:AnimationEvent):void
         {
            obj.movie.armature.removeEventListener("complete",playStageCurtainComplete);
            StarlingObjectUtils.disposeObject(obj);
         };
         obj.movie.armature.addEventListener("complete",playStageCurtainComplete);
         StarlingMain.instance.currentScene.addChild(obj);
      }
      
      private function addSceneEffects(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
      }
   }
}
