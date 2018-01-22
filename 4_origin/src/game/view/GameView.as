package game.view
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import christmas.ChristmasCoreManager;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
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
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
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
   import game.actions.ChangeBallAction;
   import game.actions.ChangeNpcAction;
   import game.actions.ChangePlayerAction;
   import game.actions.GameOverAction;
   import game.actions.MissionOverAction;
   import game.actions.PickBoxAction;
   import game.actions.PrepareShootAction;
   import game.actions.SceneEffectShootBombAction;
   import game.actions.ViewEachObjectAction;
   import game.objects.BombAction;
   import game.objects.GameLiving;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import game.objects.GameSimpleBoss;
   import game.objects.GameSmallEnemy;
   import game.objects.SimpleBomb;
   import game.objects.SimpleBox;
   import game.objects.SimpleObject;
   import game.objects.TransmissionGate;
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
   import gameCommon.model.SpecialLiving;
   import gameCommon.model.TurnedLiving;
   import gameCommon.objects.ActivityDungeonNextView;
   import gameCommon.objects.AnimationObject;
   import gameCommon.view.AchieveAnimation;
   import gameCommon.view.EnergyView;
   import gameCommon.view.control.LiveState;
   import gameCommon.view.experience.ExpView;
   import hall.GameLoadingManager;
   import magicStone.stoneExploreView.StoneExploreNextView;
   import org.aswing.KeyboardManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import phy.object.PhysicalObj;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.AutoDisappear;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import sevenDouble.SevenDoubleManager;
   
   public class GameView extends GameViewBase implements IGameView
   {
       
      
      private const ZXC_OFFSET:int = 24;
      
      protected var _msg:String = "";
      
      protected var _tipItems:Dictionary;
      
      protected var _tipLayers:Sprite;
      
      protected var _result:ExpView;
      
      private var _gameLivingArr:Array;
      
      private var _gameLivingIdArr:Array;
      
      private var _objectDic:Dictionary;
      
      private var _evtArray:Array;
      
      private var _evtFuncArray:Array;
      
      private var _animationArray:Array;
      
      private var _campBattleTerrace:Bitmap;
      
      private var _terraces:Dictionary;
      
      private var _firstEnter:Boolean = false;
      
      private var numCh:Number;
      
      private var _gameDice:GameDice;
      
      private var _soundPlayFlag:Boolean;
      
      private var _ignoreSmallEnemy:Boolean;
      
      private var _boxArr:Array;
      
      private var finished:int = 0;
      
      private var total:int = 0;
      
      private var props:Array;
      
      private var _logTimer:Timer;
      
      private var _missionAgain:MissionAgainInfo;
      
      protected var _expView:ExpView;
      
      private var _isPVPover:Boolean;
      
      public function GameView()
      {
         props = [10467,10468,10469];
         _evtArray = [GameControl.Instance.addLivingEvtVec,GameControl.Instance.setPropertyEvtVec,GameControl.Instance.livingFallingEvtVec,GameControl.Instance.livingShowBloodEvtVec,GameControl.Instance.addMapThingEvtVec,GameControl.Instance.livingActionMappingEvtVec,GameControl.Instance.updatePhysicObjectEvtVec,GameControl.Instance.playerBloodEvtVec];
         _evtFuncArray = [addliving,objectSetProperty,livingFalling,livingShowBlood,addMapThing,livingActionMapping,updatePhysicObject,playerBlood];
         super();
         Mouse.show();
      }
      
      private function loadResource() : void
      {
         var _loc1_:int = 0;
         if(!StartupResourceLoader.firstEnterHall)
         {
            _loc1_ = 0;
            while(_loc1_ < _gameInfo.neededMovies.length)
            {
               if(_gameInfo.neededMovies[_loc1_].type == 2)
               {
                  _gameInfo.neededMovies[_loc1_].addEventListener("complete",__loaderComplete);
                  _gameInfo.neededMovies[_loc1_].startLoad();
               }
               _loc1_++;
            }
         }
      }
      
      private function __loaderComplete(param1:LoaderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         param1.target.removeEventListener("complete",__loaderComplete);
         var _loc7_:int = 0;
         var _loc6_:* = _objectDic;
         for each(var _loc3_ in _objectDic)
         {
            if(_loc3_.shouldReCreate)
            {
               _loc3_.createMovieAfterLoadComplete();
            }
         }
         if(_gameLivingArr && _gameLivingIdArr)
         {
            _loc4_ = 0;
            while(_loc4_ < _gameLivingArr.length)
            {
               (_gameLivingArr[_loc4_] as GameLiving).replaceMovie();
               _loc5_ = 0;
               while(_loc5_ < _gameLivingIdArr.length)
               {
                  if(_gameLivingArr[_loc4_].Id == _gameLivingIdArr[_loc5_])
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc5_++;
               }
               _playerThumbnailLController.updateHeadFigure(_gameLivingArr[_loc4_],_loc2_);
               _loc4_++;
            }
         }
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         GameControl.Instance.gameView = this;
         _gameLivingArr = [];
         _gameLivingIdArr = [];
         _objectDic = new Dictionary();
         _animationArray = [];
         GameLoadingManager.Instance.hide();
         super.enter(param1,param2);
         loadResource();
         KeyboardManager.getInstance().isStopDispatching = false;
         KeyboardShortcutsManager.Instance.forbiddenSection(2,false);
         _gameInfo.resetResultCard();
         _gameInfo.livings.addEventListener("remove",__removePlayer);
         _gameInfo.addEventListener("windChanged",__windChanged);
         GameControl.Instance.addEventListener("complete",__loaderComplete);
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
         SocketManager.Instance.addEventListener("dropGoods",__onDropItemComplete);
         SocketManager.Instance.addEventListener("addPlayerShow",__addPlayerSadowHandler);
         SocketManager.Instance.addEventListener("gameFightStatus",__fightStatusChange);
         SocketManager.Instance.addEventListener("gameSkipNext",__skipNextHandler);
         SocketManager.Instance.addEventListener("gameClearDebuff",__clearDebuff);
         SocketManager.Instance.addEventListener("add_animation",__addAnimation);
         SocketManager.Instance.addEventListener("stick_doAction",__onStickDoAction);
         SocketManager.Instance.addEventListener("skill_lock",__skillLock);
         SocketManager.Instance.addEventListener("target_player",__showTargetPlayer);
         SocketManager.Instance.addEventListener("mark_me_hide_info",__markMeHideInfo);
         SocketManager.Instance.addEventListener("updateFlagCount",__onUpdateFlagCount);
         SocketManager.Instance.addEventListener("flagBattleState",__onFlagBattleState);
         SocketManager.Instance.addEventListener("openGameDice",__openGameDice);
         SocketManager.Instance.addEventListener("gameRollDice",__gameRollDice);
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
         var _loc18_:int = RoomManager.Instance.current.type;
         if(guideTip() && _loc18_ != 4 && StateManager.currentStateType != "fightLabGameView" && _loc18_ != 11 && !isNewHand())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.MessageTip.AutoGuidFightBegin"));
         }
         GameControl.Instance.viewCompleteFlag = true;
         var _loc15_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.addLivingEvtVec;
         _loc8_ = 0;
         while(_loc8_ < _loc15_.length)
         {
            addliving(_loc15_[_loc8_]);
            _loc8_++;
         }
         var _loc11_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.setPropertyEvtVec;
         _loc9_ = 0;
         while(_loc9_ < _loc11_.length)
         {
            objectSetProperty(_loc11_[_loc9_]);
            _loc9_++;
         }
         var _loc14_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.livingFallingEvtVec;
         _loc10_ = 0;
         while(_loc10_ < _loc14_.length)
         {
            livingFalling(_loc14_[_loc10_]);
            _loc10_++;
         }
         var _loc16_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.livingShowBloodEvtVec;
         _loc12_ = 0;
         while(_loc12_ < _loc16_.length)
         {
            livingShowBlood(_loc16_[_loc12_]);
            _loc12_++;
         }
         var _loc17_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.addMapThingEvtVec;
         _loc4_ = 0;
         while(_loc4_ < _loc17_.length)
         {
            addMapThing(_loc17_[_loc4_]);
            _loc4_++;
         }
         var _loc19_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.livingActionMappingEvtVec;
         _loc5_ = 0;
         while(_loc5_ < _loc19_.length)
         {
            livingActionMapping(_loc19_[_loc5_]);
            _loc5_++;
         }
         var _loc13_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.updatePhysicObjectEvtVec;
         _loc6_ = 0;
         while(_loc6_ < _loc13_.length)
         {
            updatePhysicObject(_loc13_[_loc6_]);
            _loc6_++;
         }
         var _loc3_:Vector.<CrazyTankSocketEvent> = GameControl.Instance.playerBloodEvtVec;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            playerBlood(_loc3_[_loc7_]);
            _loc7_++;
         }
         GameControl.Instance.ClearAllCrazyTankSocketEvent();
      }
      
      private function addTerraceHander(param1:GameEvent) : void
      {
         addTerrce(param1.data[0],param1.data[1],param1.data[2]);
      }
      
      private function addTerrce(param1:int, param2:int, param3:int) : void
      {
         if(_terraces[param3])
         {
            return;
         }
         var _loc4_:Bitmap = ComponentFactory.Instance.creat("camp.battle.terrace");
         _loc4_.x = param1 - _loc4_.width / 2;
         _loc4_.y = param2;
         _map.addChild(_loc4_);
         _terraces[param3] = _loc4_;
      }
      
      private function delTerraceHander(param1:GameEvent) : void
      {
         var _loc2_:Bitmap = _terraces[param1.data[0]];
         if(_loc2_)
         {
            _loc2_.bitmapData.dispose();
            _loc2_ = null;
            delete _terraces[param1.data[0]];
         }
      }
      
      private function dioposeTerraces() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _terraces;
         for each(var _loc1_ in _terraces)
         {
            if(_loc1_)
            {
               _loc1_.bitmapData.dispose();
            }
            _loc1_ = null;
         }
         _terraces = null;
      }
      
      private function retrunPlayer(param1:int) : GamePlayer
      {
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var _loc2_ in _players)
         {
            if(_loc2_.info.LivingID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function petResLoad(param1:PetInfo) : void
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
      
      protected function __pickBox(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         var _loc5_:Array = [];
         var _loc3_:int = _loc2_.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_.push(_loc2_.readInt());
            _loc4_++;
         }
         _map.dropOutBox(_loc5_);
         hideAllOther();
      }
      
      private function guideTip() : Boolean
      {
         var _loc1_:* = null;
         if(RoomManager.Instance.current.type == 4)
         {
            return false;
         }
         var _loc2_:DictionaryData = GameControl.Instance.Current.livings;
         if(!_loc2_)
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc1_ = _loc3_ as Player;
            if(_loc1_ && (_loc3_ as Player).playerInfo.Grade <= 15)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isNewHand() : Boolean
      {
         var _loc1_:int = RoomManager.Instance.current.mapId;
         if(_loc1_ == 112 || _loc1_ == 113 || _loc1_ == 114 || _loc1_ == 115 || _loc1_ == 116)
         {
            return true;
         }
         return false;
      }
      
      private function __gameSysMessage(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:String = _loc2_.readUTF();
         var _loc5_:int = _loc2_.readInt();
         if(!(int(_loc3_) - 1))
         {
            MessageTipManager.getInstance().show(String(_loc5_),2);
         }
      }
      
      private function __fightAchievement(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         if(PathManager.getFightAchieveEnable())
         {
            if(_achievBar == null)
            {
               _achievBar = ComponentFactory.Instance.creatCustomObject("FightAchievBar");
               addChild(_achievBar);
            }
            _loc7_ = param1.pkg;
            _loc8_ = GameControl.Instance.Current.findLiving(_loc7_.clientId);
            _loc9_ = _loc7_.readInt();
            _loc2_ = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _loc6_ = getTimer();
            _loc3_ = _achievBar.getAnimate(_loc9_);
            if(_loc3_ == null)
            {
               _achievBar.addAnimate(ComponentFactory.Instance.creatCustomObject("AchieveAnimation",[_loc9_,_loc2_,_loc5_,_loc6_]));
            }
            else if(FightAchievModel.getInstance().isNumAchiev(_loc9_))
            {
               _loc3_.setNum(_loc2_);
            }
            else
            {
               _achievBar.rePlayAnimate(_loc3_);
            }
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         numCh = 0;
         _loc3_ = 0;
         while(_loc3_ < stage.numChildren)
         {
            _loc2_ = StageReferance.stage.getChildAt(_loc3_);
            _loc2_.visible = true;
            numCh = Number(numCh) + 1;
            if(_loc2_ is DisplayObjectContainer)
            {
               show(DisplayObjectContainer(_loc2_));
            }
            _loc3_++;
         }
      }
      
      private function show(param1:DisplayObjectContainer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            _loc2_.visible = true;
            numCh = Number(numCh) + 1;
            if(_loc2_ is DisplayObjectContainer)
            {
               show(DisplayObjectContainer(_loc2_));
            }
            _loc3_++;
         }
      }
      
      private function __windChanged(param1:GameEvent) : void
      {
         _map.wind = param1.data.wind;
         _map.windRate = GameControl.Instance.Current.windRate;
         if(_vane)
         {
            _vane.update(_map.wind,param1.data.isSelfTurn,param1.data.windNumArr);
         }
         if(_weatherView && param1.data.windNumArr[5])
         {
            _weatherView.update(param1.data.windNumArr[0],param1.data.windNumArr[5]);
         }
      }
      
      override public function getType() : String
      {
         return "fighting";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         super.leaving(param1);
         if(StateManager.isExitRoom(param1.getType()) && RoomManager.Instance.isReset(RoomManager.Instance.current.type))
         {
            GameControl.Instance.reset();
            RoomManager.Instance.reset();
         }
         else if(StateManager.isExitGame(param1.getType()) && RoomManager.Instance.isReset(RoomManager.Instance.current.type))
         {
            GameControl.Instance.reset();
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         GameControl.Instance.viewCompleteFlag = false;
         StageReferance.stage.removeEventListener("click",onClick);
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
         SocketManager.Instance.removeEventListener("dropGoods",__onDropItemComplete);
         SocketManager.Instance.removeEventListener("game_in_color_change",__revivePlayer);
         SocketManager.Instance.removeEventListener("addPlayerShow",__addPlayerSadowHandler);
         SocketManager.Instance.removeEventListener("gameFightStatus",__fightStatusChange);
         SocketManager.Instance.removeEventListener("gameSkipNext",__skipNextHandler);
         SocketManager.Instance.removeEventListener("gameClearDebuff",__clearDebuff);
         SocketManager.Instance.removeEventListener("add_animation",__addAnimation);
         SocketManager.Instance.removeEventListener("stick_doAction",__onStickDoAction);
         SocketManager.Instance.removeEventListener("skill_lock",__skillLock);
         SocketManager.Instance.removeEventListener("target_player",__showTargetPlayer);
         SocketManager.Instance.removeEventListener("mark_me_hide_info",__markMeHideInfo);
         SocketManager.Instance.removeEventListener("updateFlagCount",__onUpdateFlagCount);
         SocketManager.Instance.removeEventListener("flagBattleState",__onFlagBattleState);
         SocketManager.Instance.removeEventListener("openGameDice",__openGameDice);
         SocketManager.Instance.removeEventListener("gameRollDice",__gameRollDice);
         var _loc5_:int = 0;
         var _loc4_:* = _tipItems;
         for each(var _loc1_ in _tipItems)
         {
            delete _tipLayers[_loc1_.Id];
            _loc1_.dispose();
            _loc1_ = null;
         }
         _tipItems = null;
         if(_tipLayers)
         {
            if(_tipLayers.parent)
            {
               _tipLayers.parent.removeChild(_tipLayers);
            }
         }
         _tipLayers = null;
         if(_expView)
         {
            _expView.removeEventListener("expshowed",__expShowed);
         }
         if(_gameDice)
         {
            _gameDice.dispose();
            _gameDice = null;
         }
         BallManager.instance.clearAsset();
         BackgoundView.Instance.show();
         PlayerInfoViewControl._isBattle = false;
         PlayerInfoViewControl.isOpenFromBag = false;
         CampBattleManager.instance.isFighting = false;
         dioposeTerraces();
         _gameLivingArr = null;
         _gameLivingIdArr = null;
         var _loc7_:int = 0;
         var _loc6_:* = _objectDic;
         for each(var _loc3_ in _objectDic)
         {
            delete _objectDic[_loc3_.Id];
            _loc3_.dispose();
            _loc3_ = null;
         }
         _objectDic = null;
         if(_animationArray.length > 1)
         {
            _loc2_ = 0;
            while(_loc2_ < _animationArray.length)
            {
               _animationArray[_loc2_].dispose();
               _animationArray[_loc2_] = null;
               _loc2_++;
            }
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
      
      private function __markMeHideInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.extend1;
         var _loc5_:int = _loc4_.readInt();
         var _loc6_:Boolean = _loc4_.readBoolean();
         if(GameControl.Instance.Current.selfGamePlayer.LivingID == _loc3_)
         {
            _loc2_ = getGameLivingByID(_loc5_) as GameLiving;
            _loc2_.info.markMeHideDest = _loc6_;
         }
      }
      
      private function __showTargetPlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = _gameInfo.findLiving(_loc3_.readInt());
            if(_loc4_ is LocalPlayer)
            {
               PlayerManager.Instance.Self.targetId = _loc3_.readInt();
               setTargetIconShow(true);
               break;
            }
            _loc3_.readInt();
            _loc5_++;
         }
      }
      
      protected function __addPlayerSadowHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:int = _loc4_.readByte();
         var _loc12_:int = _loc4_.readInt();
         var _loc9_:Point = new Point(_loc4_.readInt(),_loc4_.readInt());
         var _loc5_:int = _loc4_.readInt();
         var _loc11_:int = _loc4_.readInt();
         var _loc6_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readByte();
         var _loc13_:Boolean = _loc4_.readBoolean();
         var _loc2_:Boolean = _loc4_.readBoolean();
         var _loc10_:int = _loc4_.readInt();
         var _loc8_:GamePlayer = _map.getPhysical(_loc10_) as GamePlayer;
         var _loc14_:GamePlayer = _loc8_.clone(_loc12_);
         _loc14_.player.typeLiving = _loc7_;
         _loc14_.player.pos = _loc9_;
         _gameInfo.addGamePlayer(_loc14_.player);
         _map.addPhysical(_loc14_);
      }
      
      private function __onUpdateFlagCount(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         var _loc5_:GameLiving = getGameLivingByID(_loc2_) as GameLiving;
         if(!_loc5_)
         {
            return;
         }
         var _loc3_:Player = _loc5_.info as Player;
         _loc3_.flagNum = _loc4_;
         _loc3_.dispatchEvent(new LivingEvent("updateFlagNum"));
      }
      
      private function __openGameDice(param1:CrazyTankSocketEvent) : void
      {
         if(_gameDice == null)
         {
            _gameDice = new GameDice();
         }
         var _loc2_:Boolean = param1.pkg.readBoolean();
         _gameDice.leaderId = param1.pkg.readInt();
         if(_loc2_)
         {
            addChild(_gameDice);
         }
         else
         {
            _gameDice.dispose();
            _gameDice = null;
         }
      }
      
      private function __gameRollDice(param1:CrazyTankSocketEvent) : void
      {
         if(_gameDice)
         {
            _gameDice.diceNum = param1.pkg.readInt();
            _gameDice.roll();
         }
      }
      
      private function __onFlagBattleState(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc5_:GamePlayer = getGameLivingByID(_loc2_) as GamePlayer;
         if(!_loc5_)
         {
            return;
         }
         var _loc3_:Player = _loc5_.info as Player;
         _loc3_.isFeignDeath = _loc4_;
         _loc5_.visible = !_loc4_;
         _loc3_.dispatchEvent(new LivingEvent("updateFeignDeathState"));
         if(param1.cmd == 155 && !_loc4_)
         {
            if(param1.cmd == 155 && !_loc4_)
            {
               _loc5_.playFlagBattleReviveAction();
            }
         }
      }
      
      private function __skillLock(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc4_:int = _loc2_.readInt();
         var _loc3_:Boolean = _loc2_.readBoolean();
         (_cs as LiveState).updateSkillLockStatus(_loc4_,_loc3_);
      }
      
      private function __onStickDoAction(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Array = [];
         while(_loc3_.bytesAvailable > 0)
         {
            _loc2_.push(_loc3_.readInt());
         }
         var _loc4_:SpecialLiving = _gameInfo.findLiving(2) as SpecialLiving;
         if(_loc4_)
         {
            _loc4_.playSpecialMovie("",null,_loc2_);
         }
      }
      
      override public function addedToStage() : void
      {
         super.addedToStage();
         stage.focus = _map;
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
      
      override protected function __playerChange(param1:CrazyTankSocketEvent) : void
      {
         event = param1;
         PageInterfaceManager.restorePageTitle();
         if(_selfMarkBar)
         {
            _selfMarkBar.shutdown();
         }
         _map.currentFocusedLiving = null;
         var id:int = event.pkg.extend1;
         var sceneEffectLength:int = event.pkg.readInt();
         var sceneEffectArr:Array = [];
         var i:int = 0;
         while(i < sceneEffectLength)
         {
            var sceneEffectObj:SceneEffectObj = new SceneEffectObj();
            sceneEffectObj.id = event.pkg.readInt();
            sceneEffectObj.turn = event.pkg.readInt();
            sceneEffectObj.x = event.pkg.readInt();
            sceneEffectObj.y = event.pkg.readInt();
            sceneEffectArr.push(sceneEffectObj);
            var j:int = sceneEffectObj.turn - 1;
            while(j > 0)
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
         if(RoomManager.Instance.current.type == 49)
         {
            var wind:int = event.pkg.readInt();
            if(_heroAutoView)
            {
               _heroAutoView.updateWind(wind);
            }
         }
         if(_sceneEffectsBar && sceneEffectArr.length > 0)
         {
            _sceneEffectsBar.updateView(sceneEffectArr,function():void
            {
               changePlayerTurn(id,event);
               var _loc3_:int = 0;
               var _loc2_:* = _gameInfo.livings;
               for each(var _loc1_ in _gameInfo.livings)
               {
                  if(_loc1_ is Player && _loc1_.playerInfo && _loc1_.isLiving)
                  {
                     _loc1_.dispatchEvent(new LivingEvent("checkCollide"));
                  }
               }
            });
         }
         else
         {
            changePlayerTurn(id,event);
         }
      }
      
      private function changePlayerTurn(param1:int, param2:CrazyTankSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc7_:Living = _gameInfo.findLiving(param1);
         _gameInfo.currentLiving = _loc7_;
         if(_loc7_ is TurnedLiving)
         {
            _ignoreSmallEnemy = false;
            if(!_loc7_.isLiving)
            {
               setCurrentPlayer(null);
               return;
            }
            if(_loc7_.isBoss)
            {
               if(RoomManager.Instance.current.type == 21)
               {
                  updateDamageView();
               }
            }
            if(_loc7_.playerInfo == PlayerManager.Instance.Self)
            {
               PageInterfaceManager.changePageTitle();
            }
            param2.executed = false;
            _soundPlayFlag = true;
            if(_loc7_ is LocalPlayer && _gameTrusteeshipView && _gameTrusteeshipView.trusteeshipState)
            {
               new ChangePlayerAction(_map,_loc7_ as TurnedLiving,param2,param2.pkg,0,0).executeAtOnce();
            }
            else
            {
               _map.act(new ChangePlayerAction(_map,_loc7_ as TurnedLiving,param2,param2.pkg));
            }
         }
         else
         {
            _map.act(new ChangeNpcAction(this,_map,_loc7_ as Living,param2,param2.pkg,_ignoreSmallEnemy));
            if(!_ignoreSmallEnemy)
            {
               _ignoreSmallEnemy = true;
            }
         }
         var _loc5_:DictionaryData = GameControl.Instance.Current.livings;
         var _loc9_:int = 0;
         var _loc8_:* = _loc5_;
         for each(var _loc6_ in _loc5_)
         {
            _loc3_ = getGameLivingByID(_loc6_.LivingID) as GameLiving;
            if(_loc3_)
            {
               _loc3_.fightPowerVisible = false;
            }
         }
         var _loc4_:LiveState = _cs as LiveState;
         if(_loc4_)
         {
            if(_loc4_.rescuePropBar)
            {
               _loc4_.rescuePropBar.setKingBlessEnable();
            }
            if(_loc4_.insectProBar)
            {
               _loc4_.insectProBar.setEnable(true);
               _loc4_.rightPropBar.showPropBar();
            }
            if(BombKingManager.instance.Recording)
            {
               _loc4_.arrow.modifyAngleData(_loc7_ as Player);
            }
         }
         PrepareShootAction.hasDoSkillAnimation = false;
      }
      
      private function setTargetIconShow(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_gameInfo.gameMode == 121)
         {
            _loc3_ = GameControl.Instance.Current.livings;
            _loc2_ = null;
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _loc2_ = getGameLivingByID(_loc4_.LivingID) as GameLiving;
               if(_loc2_ != null)
               {
                  if(_loc4_.LivingID == PlayerManager.Instance.Self.targetId)
                  {
                     if(param1)
                     {
                        _loc2_.addTartgetIcon();
                     }
                     else
                     {
                        _loc2_.deleteTargetIcon();
                     }
                  }
                  else
                  {
                     _loc2_.modifyPlayerColor();
                  }
               }
            }
         }
      }
      
      private function __playMovie(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc3_)
         {
            _loc2_ = param1.pkg.readUTF();
            _loc3_.playMovie(_loc2_);
            _map.bringToFront(_loc3_);
         }
      }
      
      private function __livingTurnRotation(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:* = null;
         var _loc4_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc4_)
         {
            _loc2_ = param1.pkg.readInt() / 10;
            _loc5_ = param1.pkg.readInt() / 10;
            _loc3_ = param1.pkg.readUTF();
            _loc4_.turnRotation(_loc2_,_loc5_,_loc3_);
            _map.bringToFront(_loc4_);
         }
      }
      
      public function addliving(param1:CrazyTankSocketEvent) : void
      {
         var _loc31_:int = 0;
         var _loc18_:* = null;
         var _loc13_:* = null;
         var _loc34_:int = 0;
         var _loc39_:* = null;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc20_:* = null;
         var _loc29_:* = null;
         var _loc37_:* = null;
         var _loc27_:int = 0;
         var _loc3_:* = null;
         var _loc32_:int = 0;
         var _loc25_:int = 0;
         var _loc21_:* = null;
         var _loc40_:* = null;
         var _loc23_:PackageIn = param1.pkg;
         var _loc7_:int = _loc23_.readByte();
         var _loc12_:int = _loc23_.readInt();
         var _loc35_:String = _loc23_.readUTF();
         var _loc38_:String = _loc23_.readUTF();
         var _loc5_:String = _loc23_.readUTF();
         var _loc36_:Point = new Point(_loc23_.readInt(),_loc23_.readInt());
         var _loc41_:int = _loc23_.readInt();
         var _loc33_:int = _loc23_.readInt();
         var _loc28_:int = _loc23_.readInt();
         var _loc4_:int = _loc23_.readByte();
         var _loc22_:int = _loc23_.readByte();
         var _loc30_:Boolean = _loc22_ == 0?true:false;
         var _loc19_:Boolean = _loc23_.readBoolean();
         var _loc11_:Boolean = _loc23_.readBoolean();
         var _loc14_:int = _loc23_.readInt();
         var _loc17_:Dictionary = new Dictionary();
         _loc31_ = 0;
         while(_loc31_ < _loc14_)
         {
            _loc18_ = _loc23_.readUTF();
            _loc13_ = _loc23_.readUTF();
            _loc17_[_loc18_] = _loc13_;
            _loc31_++;
         }
         var _loc24_:int = _loc23_.readInt();
         var _loc10_:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         _loc34_ = 0;
         while(_loc34_ < _loc24_)
         {
            _loc39_ = BuffManager.creatBuff(_loc23_.readInt());
            _loc10_.push(_loc39_);
            _loc34_++;
         }
         var _loc15_:Boolean = _loc23_.readBoolean();
         var _loc43_:Boolean = _loc23_.readBoolean();
         var _loc9_:Boolean = _loc23_.readBoolean();
         var _loc42_:Boolean = _loc23_.readBoolean();
         var _loc26_:int = _loc23_.readInt();
         var _loc16_:Dictionary = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _loc26_)
         {
            _loc8_ = _loc23_.readUTF();
            _loc20_ = _loc23_.readUTF();
            _loc16_[_loc8_] = _loc20_;
            _loc6_++;
         }
         if(_map && _map.getPhysical(_loc12_))
         {
            _map.getPhysical(_loc12_).dispose();
         }
         if(_loc7_ != 4 && _loc7_ != 5 && _loc7_ != 6 && _loc7_ != 12)
         {
            _loc29_ = new SmallEnemy(_loc12_,_loc28_,_loc33_);
            _loc29_.typeLiving = _loc7_;
            _loc29_.actionMovieName = _loc38_;
            _loc29_.direction = _loc4_;
            _loc29_.pos = _loc36_;
            _loc29_.name = _loc35_;
            _loc29_.isBottom = _loc30_;
            _loc29_.isShowBlood = _loc19_;
            _loc29_.isShowSmallMapPoint = _loc11_;
            _gameInfo.addGamePlayer(_loc29_);
            _loc37_ = new GameSmallEnemy(_loc29_ as SmallEnemy);
            _gameLivingArr.push(_loc37_);
            if(RoomManager.Instance.current.type == 21)
            {
               explorersLiving = _gameInfo.findLivingByName(LanguageMgr.GetTranslation("activity.dungeonView.explorers"));
            }
         }
         else
         {
            _loc29_ = new SimpleBoss(_loc12_,_loc28_,_loc33_);
            _loc29_.typeLiving = _loc7_;
            _loc29_.actionMovieName = _loc38_;
            _loc29_.direction = _loc4_;
            _loc29_.pos = _loc36_;
            _loc29_.name = _loc35_;
            _loc29_.isBottom = _loc30_;
            _loc29_.isShowBlood = _loc19_;
            _loc29_.isShowSmallMapPoint = _loc11_;
            _gameInfo.addGamePlayer(_loc29_);
            _loc37_ = new GameSimpleBoss(_loc29_ as SimpleBoss);
            _gameLivingArr.push(_loc37_);
            if(RoomManager.Instance.current.type == 21)
            {
               _loc27_ = _loc23_.readInt();
               GameControl.Instance.bossName = _loc35_;
               GameControl.Instance.currentNum = _loc27_ - (_loc27_ > 70003?70002:70000);
               addMessageBtn();
               if(!this.barrier)
               {
                  fadingComplete();
               }
               this.barrier.dispatchEvent(new CrazyTankSocketEvent("update_activitydungeon_info"));
            }
            if(RoomManager.Instance.current.type == 52)
            {
               _loc3_ = _cs as LiveState;
               if(_loc3_ && _loc3_.insectProBar)
               {
                  _loc3_.insectProBar.showBallTips();
               }
            }
         }
         _loc32_ = 0;
         while(_loc34_ < _loc10_.length)
         {
            _loc29_.addBuff(_loc10_[_loc34_]);
            _loc34_++;
         }
         var _loc45_:int = 0;
         var _loc44_:* = _loc17_;
         for(var _loc2_ in _loc17_)
         {
            _loc37_.setActionMapping(_loc2_,_loc17_[_loc2_]);
         }
         _loc37_.name = _loc35_;
         if(_loc22_ == 7)
         {
            _loc37_.layer = _loc22_;
         }
         if(_loc41_ != _loc29_.maxBlood)
         {
            _loc29_.initBlood(_loc41_);
         }
         _loc37_.info.isFrozen = _loc15_;
         _loc37_.info.isHidden = _loc43_;
         _loc37_.info.isNoNole = _loc9_;
         if(_loc23_.bytesAvailable)
         {
            _loc25_ = _loc23_.readInt();
            if(_loc25_ > -1)
            {
               _loc21_ = _map.getPhysical(_loc25_) as SimpleBomb;
               _loc40_ = null;
               if(_loc21_)
               {
                  _loc40_ = _loc21_.info;
               }
               if(_loc40_)
               {
                  _loc40_.childs.push([_loc37_,_loc17_,_loc5_,_loc16_]);
                  return;
               }
            }
            else
            {
               addGameLivingToMap([_loc37_,_loc17_,_loc5_,_loc16_]);
            }
         }
         addGameLivingToMap([_loc37_,_loc17_,_loc5_,_loc16_]);
      }
      
      public function addGameLivingToMap(param1:Array) : void
      {
         var _loc2_:GameLiving = param1[0];
         var _loc7_:Dictionary = param1[1];
         var _loc3_:String = param1[2];
         var _loc6_:Dictionary = param1[3];
         var _loc5_:Living = _loc2_.info;
         if(_loc3_.length > 0)
         {
            _loc2_.doAction(_loc3_);
         }
         else if(!_loc7_["stand"])
         {
            _loc2_.doAction("born");
         }
         else
         {
            _loc2_.doAction("stand");
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_;
         for(var _loc4_ in _loc6_)
         {
            setProperty(_loc2_,_loc4_,_loc6_[_loc4_]);
         }
         _playerThumbnailLController.addLiving(_loc2_.info);
         addChild(_playerThumbnailLController);
         if(_loc5_ is SimpleBoss)
         {
            _map.setCenter(_loc2_.x,_loc2_.y - 150,false);
         }
         else
         {
            _map.setCenter(_loc2_.x,_loc2_.y - 150,true);
         }
         _map.addPhysical(_loc2_);
      }
      
      protected function __addAnimation(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc2_:Boolean = false;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc13_:* = null;
         var _loc9_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc8_:int = _loc6_.readInt();
         var _loc12_:Boolean = _loc6_.readBoolean();
         var _loc10_:int = _loc6_.readInt();
         var _loc11_:Number = _loc6_.readDate().time;
         if(RoomManager.Instance.current.type == 56)
         {
            _loc7_ = _loc6_.readUTF();
            _loc5_ = _loc7_ == ""?[]:_loc7_.split("|");
            _loc2_ = _loc6_.readBoolean();
         }
         var _loc4_:RoomPlayer = RoomManager.Instance.findRoomPlayer(_loc10_);
         var _loc3_:Player = _gameInfo.findLivingByPlayerID(_loc10_,_loc4_.playerInfo.ZoneID);
         if(_loc12_)
         {
            switch(int(_loc8_) - 1)
            {
               case 0:
                  _loc14_ = new ActivityDungeonNextView(_loc8_,_loc11_);
                  PositionUtils.setPos(_loc14_,"game.view.activityDungeonNextView.viewPos");
                  _loc3_.resetWithinTheMap();
                  if(_loc4_.isViewer || !_loc3_.isLiving)
                  {
                     _loc14_.setBtnEnable();
                  }
                  hideView(false);
                  updateDamageView();
                  _animationArray.push(_loc14_);
                  deleteAnimation(2);
                  break;
               case 1:
                  if(_loc3_.isLiving)
                  {
                     _loc15_ = new AnimationObject(2,"asset.game.lightning");
                     PositionUtils.setPos(_loc15_,"game.view.activityDungeon.lightningPos");
                     _animationArray.push(_loc15_);
                  }
                  break;
               case 2:
                  _loc13_ = new StoneExploreNextView(_loc8_,_loc2_);
                  if(_loc5_ != null && _loc5_.length > 0)
                  {
                     _loc13_.setData(_loc5_);
                  }
                  else
                  {
                     _loc13_.setQuitPos();
                  }
                  PositionUtils.setPos(_loc13_,"game.view.StoneExploreNextView.nextExploreViewPos");
                  if(_loc4_.isViewer || !_loc3_.isLiving)
                  {
                     _loc13_.setBtnEnable();
                  }
                  hideView(false);
                  _animationArray.push(_loc13_);
                  deleteAnimation(2);
            }
            _loc9_ = 0;
            while(_loc9_ < _animationArray.length)
            {
               addChild(_animationArray[_loc9_]);
               _loc9_++;
            }
         }
         else
         {
            deleteAnimation(_loc8_);
            hideView(true);
            StageReferance.stage.focus = _map;
         }
      }
      
      public function deleteAnimation(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _animationArray.length)
         {
            if(param1 == _animationArray[_loc2_].Id)
            {
               removeChild(_animationArray[_loc2_]);
               _animationArray[_loc2_].dispose();
               _animationArray[_loc2_] = null;
               _animationArray.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function hideView(param1:Boolean) : void
      {
         if(_selfMarkBar)
         {
            _selfMarkBar.visible = param1;
         }
         if(_cs)
         {
            _cs.visible = param1;
         }
         if(_selfBuffBar)
         {
            _selfBuffBar.visible = param1;
         }
         if(_kingblessIcon)
         {
            _kingblessIcon.visible = param1;
         }
         if(_playerThumbnailLController)
         {
            _playerThumbnailLController.visible = param1;
         }
         if(ChatManager.Instance.view)
         {
            ChatManager.Instance.view.visible = param1;
         }
         if(_leftPlayerView)
         {
            _leftPlayerView.visible = param1;
         }
         if(_vane)
         {
            _vane.visible = param1;
         }
         if(_barrier)
         {
            _barrier.visible = param1;
         }
      }
      
      private function __addTipLayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc12_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc13_:* = null;
         var _loc7_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc8_:int = param1.pkg.readInt();
         var _loc9_:int = param1.pkg.readInt();
         var _loc2_:String = param1.pkg.readUTF();
         var _loc11_:String = param1.pkg.readUTF();
         var _loc3_:int = param1.pkg.readInt();
         var _loc10_:int = param1.pkg.readInt();
         if(_loc6_ == 10)
         {
            if(ModuleLoader.hasDefinition(_loc2_))
            {
               _loc4_ = ModuleLoader.getDefinition(_loc2_) as Class;
               _loc12_ = new _loc4_() as MovieClip;
               _loc5_ = new MovieClipWrapper(_loc12_,false,true);
               addTipSprite(_loc5_.movie);
               _loc5_.gotoAndPlay(1);
            }
         }
         else
         {
            if(_tipItems[_loc7_])
            {
               _loc13_ = _tipItems[_loc7_] as SimpleObject;
            }
            else
            {
               _loc13_ = new SimpleObject(_loc7_,_loc6_,_loc2_,_loc11_);
               addTipSprite(_loc13_);
            }
            _loc13_.playAction(_loc11_);
            _tipItems[_loc7_] = _loc13_;
         }
      }
      
      private function addTipSprite(param1:Sprite) : void
      {
         if(!_tipLayers)
         {
            _tipLayers = new Sprite();
            var _loc2_:Boolean = false;
            _tipLayers.mouseEnabled = _loc2_;
            _tipLayers.mouseChildren = _loc2_;
            addChild(_tipLayers);
         }
         _tipLayers.addChild(param1);
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
      
      public function addMapThing(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc19_:* = null;
         var _loc14_:* = null;
         var _loc9_:int = param1.pkg.readInt();
         var _loc7_:int = param1.pkg.readInt();
         var _loc10_:int = param1.pkg.readInt();
         var _loc11_:int = param1.pkg.readInt();
         var _loc3_:String = param1.pkg.readUTF();
         var _loc15_:String = param1.pkg.readUTF();
         var _loc18_:int = param1.pkg.readInt();
         var _loc17_:int = param1.pkg.readInt();
         var _loc12_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc21_:int = param1.pkg.readInt();
         var _loc13_:int = param1.pkg.readInt();
         var _loc8_:int = param1.pkg.readInt();
         var _loc20_:Dictionary = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc19_ = param1.pkg.readUTF();
            _loc14_ = param1.pkg.readUTF();
            _loc20_[_loc19_] = _loc14_;
            _loc6_++;
         }
         var _loc2_:Boolean = param1.pkg.readInt() > 0?true:false;
         var _loc16_:SimpleObject = null;
         switch(int(_loc7_) - 1)
         {
            case 0:
               _loc16_ = new SimpleBox(_loc9_,_loc3_);
               break;
            case 1:
               _loc16_ = new SimpleObject(_loc9_,1,_loc3_,_loc15_);
               break;
            case 2:
               _loc16_ = new TransmissionGate(_loc9_,_loc7_,"asset.game.transmitted",_loc15_);
               hideAllOther();
         }
         _loc16_.IsCollide = _loc2_;
         _loc16_.x = _loc10_;
         _loc16_.y = _loc11_;
         if(_loc2_)
         {
            _loc16_.setCollideRect(-55,-10,55,10);
         }
         _loc16_.scaleX = _loc18_;
         _loc16_.scaleY = _loc17_;
         _loc16_.rotation = _loc12_;
         var _loc23_:int = 0;
         var _loc22_:* = _loc20_;
         for(var _loc4_ in _loc20_)
         {
            _loc16_.setActionMapping(_loc4_,_loc20_[_loc4_]);
         }
         if(_loc7_ == 1)
         {
            addBox(_loc16_);
         }
         addEffect(_loc16_,_loc21_,_loc5_);
      }
      
      private function addBox(param1:SimpleObject) : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            if(!_boxArr)
            {
               _boxArr = [];
            }
            _boxArr.push(param1);
         }
         else
         {
            addEffect(param1);
         }
      }
      
      private function addEffect(param1:SimpleObject, param2:int = 0, param3:int = 0) : void
      {
         switch(int(param2) - -1)
         {
            case 0:
               addStageCurtain(param1);
               break;
            case 1:
               _map.addPhysical(param1);
               _objectDic[param1.Id] = param1;
               if(param3 > 0 && param3 != 6)
               {
                  _map.phyBringToFront(param1);
               }
         }
      }
      
      public function updatePhysicObject(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc5_:SimpleObject = _map.getPhysical(_loc2_) as SimpleObject;
         if(!_loc5_)
         {
            _loc5_ = _tipItems[_loc2_] as SimpleObject;
         }
         var _loc4_:String = param1.pkg.readUTF();
         if(_loc5_)
         {
            _loc5_.playAction(_loc4_);
         }
         var _loc3_:PhyobjEvent = new PhyobjEvent(_loc4_);
         dispatchEvent(_loc3_);
      }
      
      private function __applySkill(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = _loc3_.readInt();
         SkillManager.applySkillToLiving(_loc2_,_loc4_,_loc3_);
      }
      
      private function __removeSkill(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = _loc3_.readInt();
         SkillManager.removeSkillFromLiving(_loc2_,_loc4_,_loc3_);
      }
      
      private function __removePhysicObject(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = param1.pkg.readInt();
         var _loc2_:PhysicalObj = getGameLivingByID(_loc4_);
         if(_loc2_ is GameSimpleBoss)
         {
            LogManager.getInstance().sendLog(GameSimpleBoss(_loc2_).simpleBoss.actionMovieName);
         }
         var _loc3_:Boolean = true;
         if(_loc2_ && _loc2_.parent)
         {
            _map.removePhysical(_loc2_);
         }
         if(_loc2_ && _loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         if(_loc3_ && _loc2_)
         {
            if(!(_loc2_ is GameLiving) || GameLiving(_loc2_).isExist)
            {
               _loc2_.dispose();
            }
         }
         if(_objectDic[_loc4_])
         {
            _loc5_ = _objectDic[_loc4_];
            delete _objectDic[_loc4_];
            _loc5_.dispose();
            _loc5_ = null;
         }
      }
      
      private function __focusOnObject(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = param1.pkg.readInt();
         var _loc3_:Array = [];
         var _loc2_:Object = {};
         _loc2_.x = param1.pkg.readInt();
         _loc2_.y = param1.pkg.readInt();
         _loc3_.push(_loc2_);
         _map.act(new ViewEachObjectAction(_map,_loc3_,_loc4_));
      }
      
      private function __barrierInfoHandler(param1:CrazyTankSocketEvent) : void
      {
         barrierInfo = param1;
      }
      
      private function __livingMoveto(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc7_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc7_)
         {
            _loc6_ = new Point(param1.pkg.readInt(),param1.pkg.readInt());
            _loc4_ = new Point(param1.pkg.readInt(),param1.pkg.readInt());
            _loc3_ = param1.pkg.readInt();
            _loc5_ = param1.pkg.readUTF();
            _loc2_ = param1.pkg.readUTF();
            _loc7_.pos = _loc6_;
            _loc7_.moveTo(0,_loc4_,0,true,_loc5_,_loc3_,_loc2_);
            _map.bringToFront(_loc7_);
         }
      }
      
      public function livingFalling(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         var _loc3_:Point = new Point(param1.pkg.readInt(),param1.pkg.readInt());
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:String = param1.pkg.readUTF();
         var _loc6_:int = param1.pkg.readInt();
         if(_loc5_)
         {
            _loc5_.fallTo(_loc3_,_loc2_,_loc4_,_loc6_);
            if(_loc3_.y - _loc5_.pos.y > 50)
            {
               _map.setCenter(_loc3_.x,_loc3_.y - 150,false);
            }
            _map.bringToFront(_loc5_);
         }
      }
      
      private function __livingJump(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         var _loc4_:Point = new Point(param1.pkg.readInt(),param1.pkg.readInt());
         var _loc3_:int = param1.pkg.readInt();
         var _loc5_:String = param1.pkg.readUTF();
         var _loc2_:int = param1.pkg.readInt();
         _loc6_.jumpTo(_loc4_,_loc3_,_loc5_,_loc2_);
         _map.bringToFront(_loc6_);
      }
      
      private function __livingBeat(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:* = 0;
         var _loc13_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc15_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc14_:Living = _gameInfo.findLiving(_loc7_.extend1);
         var _loc11_:String = _loc7_.readUTF();
         var _loc2_:String = _loc7_.readUTF();
         if(_loc2_ == "0")
         {
            _loc2_ = "";
         }
         var _loc12_:uint = _loc7_.readInt();
         var _loc10_:Array = [];
         _loc9_ = uint(0);
         while(_loc9_ < _loc12_)
         {
            _loc13_ = _gameInfo.findLiving(_loc7_.readInt());
            _loc6_ = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _loc4_ = _loc7_.readInt();
            _loc3_ = _loc7_.readInt();
            _loc8_ = _loc7_.readInt();
            _loc15_ = {};
            _loc15_["action"] = _loc11_;
            _loc15_["deadEffect"] = _loc2_;
            _loc15_["target"] = _loc13_;
            _loc15_["damage"] = _loc6_;
            _loc15_["targetBlood"] = _loc5_;
            _loc15_["dander"] = _loc4_;
            _loc15_["attackEffect"] = _loc3_;
            _loc15_["type"] = _loc8_;
            _loc10_.push(_loc15_);
            if(_loc13_ && _loc13_.isPlayer() && _loc13_.isLiving)
            {
               (_loc13_ as Player).dander = _loc4_;
            }
            _loc9_++;
         }
         if(_loc14_)
         {
            _loc14_.beat(_loc10_);
         }
      }
      
      private function __livingSay(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(!_loc3_ || !_loc3_.isLiving)
         {
            return;
         }
         var _loc4_:String = param1.pkg.readUTF();
         var _loc2_:int = param1.pkg.readInt();
         _map.bringToFront(_loc3_);
         _loc3_.say(_loc4_,_loc2_);
      }
      
      private function __livingRangeAttacking(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc8_ = param1.pkg.readInt();
            _loc5_ = param1.pkg.readInt();
            _loc6_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc7_ = _gameInfo.findLiving(_loc8_);
            if(_loc7_)
            {
               _loc7_.isHidden = false;
               _loc7_.isFrozen = false;
               _loc7_.updateBlood(_loc6_,_loc2_);
               _loc7_.showAttackEffect(1);
               _map.bringToFront(_loc7_);
               if(_loc7_.isSelf)
               {
                  _map.setCenter(_loc7_.pos.x,_loc7_.pos.y,false);
               }
               if(_loc7_.isPlayer() && _loc7_.isLiving)
               {
                  (_loc7_ as Player).dander = _loc4_;
               }
            }
            _loc9_++;
         }
      }
      
      private function __livingDirChanged(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc3_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc3_.direction = _loc2_;
            _map.bringToFront(_loc3_);
         }
      }
      
      private function __removePlayer(param1:DictionaryEvent) : void
      {
         _msg = RoomManager.Instance._removeRoomMsg;
         var _loc3_:Player = param1.data as Player;
         var _loc2_:GamePlayer = _players[_loc3_];
         if(_loc2_ && _loc3_)
         {
            if(_map.currentPlayer == _loc3_)
            {
               setCurrentPlayer(null);
            }
            if(_loc3_.isSelf)
            {
               if(RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1)
               {
                  StateManager.setState("roomlist");
               }
               else if(RoomManager.Instance.current.type == 4)
               {
                  StateManager.setState("dungeon");
               }
               else if(RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 42)
               {
                  StateManager.setState("matchRoom");
               }
               else if(RoomManager.Instance.current.type == 40)
               {
                  ChristmasCoreManager.instance.reConnectChristmasFunc();
               }
               else if(RoomManager.Instance.current.type == 52)
               {
                  CatchInsectManager.instance.reConnectCatchInectFunc();
               }
               else if(RoomManager.Instance.current.type == 56)
               {
                  StateManager.setState("main");
               }
            }
            _map.removePhysical(_loc2_);
            _loc2_.dispose();
            delete _players[_loc3_];
         }
      }
      
      private function __beginShoot(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         if(_map.currentPlayer && _map.currentPlayer.isPlayer() && param1.pkg.clientId != _map.currentPlayer.playerInfo.ID && !GameControl.Instance.Current.togetherShoot && _gameInfo.roomType != 56)
         {
            _map.executeAtOnce();
            _map.setCenter(_map.currentPlayer.pos.x,_map.currentPlayer.pos.y - 150,false);
            _loc2_ = _players[_map.currentPlayer];
         }
         if(_gameInfo.roomType != 56 && !_gameInfo.togetherShoot || _map.currentPlayer && _map.currentPlayer.isPlayer() && param1.pkg.clientId == _map.currentPlayer.playerInfo.ID)
         {
            setPropBarClickEnable(false,false);
            PrepareShootAction.hasDoSkillAnimation = false;
         }
      }
      
      protected function __shoot(param1:CrazyTankSocketEvent) : void
      {
         var _loc39_:* = 0;
         var _loc22_:* = null;
         var _loc18_:int = 0;
         var _loc31_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc35_:int = 0;
         var _loc29_:int = 0;
         var _loc40_:* = null;
         var _loc37_:int = 0;
         var _loc36_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc45_:* = null;
         var _loc27_:int = 0;
         var _loc26_:* = null;
         var _loc38_:int = 0;
         var _loc32_:int = 0;
         var _loc41_:* = null;
         var _loc28_:int = 0;
         var _loc34_:int = 0;
         var _loc23_:int = 0;
         var _loc7_:int = 0;
         var _loc42_:* = null;
         var _loc43_:* = null;
         var _loc17_:* = null;
         var _loc20_:* = null;
         EnergyView.canPower = false;
         var _loc30_:PackageIn = param1.pkg;
         var _loc47_:int = param1.pkg.extend1;
         var _loc9_:Living = _gameInfo.findLiving(_loc47_);
         var _loc15_:Number = _loc30_.readInt() / 10;
         var _loc8_:Boolean = _loc30_.readBoolean();
         var _loc3_:int = _loc30_.readByte();
         var _loc6_:int = _loc30_.readByte();
         var _loc4_:int = _loc30_.readByte();
         var _loc24_:int = _loc30_.readInt();
         GameControl.Instance.Current.windRate = _loc30_.readInt() / 100;
         var _loc46_:Array = [_loc8_,_loc3_,_loc6_,_loc4_,_loc24_];
         var _loc16_:Boolean = _loc9_ == null?false:Boolean(_loc9_.isSelf);
         GameControl.Instance.Current.setWind(_loc15_,_loc16_,_loc46_);
         var _loc33_:Array = [];
         var _loc2_:Number = _loc30_.readInt();
         _loc39_ = uint(0);
         while(_loc39_ < _loc2_)
         {
            _loc22_ = new Bomb();
            _loc22_.number = _loc30_.readInt();
            _loc22_.shootCount = _loc30_.readInt();
            _loc22_.IsHole = _loc30_.readBoolean();
            _loc22_.Id = _loc30_.readInt();
            _loc22_.pid = _loc30_.readInt();
            _loc22_.X = _loc30_.readInt();
            _loc22_.Y = _loc30_.readInt();
            _loc22_.VX = _loc30_.readInt();
            _loc22_.VY = _loc30_.readInt();
            if(_loc39_ == 0)
            {
               setBombKingInfo(_loc22_.VX,_loc22_.VY);
            }
            _loc18_ = _loc30_.readInt();
            _loc22_.Template = BallManager.instance.findBall(_loc18_);
            _loc22_.Actions = [];
            _loc22_.changedPartical = _loc30_.readUTF();
            _loc31_ = _loc30_.readInt() / 1000;
            _loc25_ = _loc30_.readInt() / 1000;
            _loc21_ = _loc31_ * _loc25_;
            _loc22_.damageMod = _loc21_;
            _loc35_ = _loc30_.readInt();
            _loc37_ = 0;
            while(_loc37_ < _loc35_)
            {
               _loc29_ = _loc30_.readInt();
               _loc36_ = _loc30_.readInt();
               if(_loc36_ == 27)
               {
                  _loc14_ = _loc30_.readInt();
                  _loc13_ = _loc30_.readInt();
               }
               else
               {
                  _loc14_ = _loc30_.readInt();
                  _loc13_ = _loc30_.readInt();
                  _loc11_ = _loc30_.readInt();
                  _loc10_ = _loc30_.readInt();
               }
               _loc40_ = new BombAction(_loc29_,_loc36_,_loc14_,_loc13_,_loc11_,_loc10_);
               _loc22_.Actions.push(_loc40_);
               if(_loc9_ && RoomManager.Instance.current.type == 21 && _loc9_.isPlayer() && _loc40_.type == 5)
               {
                  _loc9_.damageNum = _loc9_.damageNum + _loc40_.param2;
               }
               _loc37_++;
            }
            _loc33_.push(_loc22_);
            _loc39_++;
         }
         if(_loc33_[0].pid > -1)
         {
            if(_loc9_.currentShootList)
            {
               _loc45_ = null;
               _loc27_ = 0;
               while(_loc27_ < _loc9_.currentShootList.length)
               {
                  if(_loc9_.currentShootList[_loc27_].Id == _loc33_[0].pid)
                  {
                     _loc45_ = _loc9_.currentShootList[_loc27_];
                     break;
                  }
                  _loc27_++;
               }
            }
            if(_loc45_ == null)
            {
               _loc26_ = _map.getPhysical(_loc33_[0].pid) as SimpleBomb;
               if(_loc26_)
               {
                  _loc45_ = _loc26_.info;
               }
            }
            if(_loc45_)
            {
               _loc45_.childs = _loc45_.childs.concat(_loc33_);
            }
         }
         else if(_loc9_)
         {
            _loc9_.shoot(_loc33_,param1);
         }
         else if(_loc47_ < 0)
         {
            map.act(new SceneEffectShootBombAction(_loc47_,map,_loc33_,param1,24));
         }
         var _loc12_:int = _loc30_.readInt();
         var _loc19_:Array = [];
         _loc38_ = 0;
         while(_loc38_ < _loc12_)
         {
            _loc32_ = _loc30_.readInt();
            _loc41_ = _gameInfo.findLiving(_loc32_);
            _loc28_ = _loc30_.readInt();
            _loc34_ = _loc30_.readInt();
            _loc23_ = _loc30_.readInt();
            _loc7_ = 3;
            _loc42_ = {
               "target":_loc41_,
               "hp":_loc34_,
               "damage":_loc28_,
               "dander":_loc23_,
               "type":_loc7_
            };
            _loc19_.push(_loc42_);
            _loc38_++;
         }
         var _loc44_:int = _loc30_.readInt();
         var _loc5_:String = "attack" + _loc44_.toString();
         if(_loc44_ != 0 && _loc9_)
         {
            _loc43_ = null;
            if(_loc33_.length == 3)
            {
               _loc43_ = Bomb(_loc33_[0]).target;
            }
            else if(_loc33_.length == 1)
            {
               _loc43_ = Bomb(_loc33_[0]).target;
            }
            if(Player(_loc9_).currentPet)
            {
               _loc17_ = Player(_loc9_).currentPet.petBeatInfo;
               _loc17_["actionName"] = _loc5_;
               _loc17_["targetPoint"] = _loc43_;
               _loc17_["targets"] = _loc19_;
            }
            _loc20_ = Bomb(_loc33_[_loc33_.length == 3?0:0]);
            _loc20_.Actions.push(new BombAction(0,20,param1.pkg.extend1,0,0,0));
         }
      }
      
      private function setBombKingInfo(param1:int, param2:int) : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(BombKingManager.instance.Recording)
         {
            _loc5_ = Math.atan(param2 / param1) * 180 / 3.14159265358979;
            _loc3_ = param1 > 0?1:-1;
            _loc4_ = {};
            _loc4_["angle"] = Math.abs(_loc5_);
            _loc4_["direction"] = _loc3_;
            BombKingManager.instance.dispatchEvent(new BombKingEvent("recordingModifyAngle",_loc4_));
         }
      }
      
      private function __suicide(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc2_)
         {
            _loc2_.die();
         }
      }
      
      private function __changeBall(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc5_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc5_ && _loc5_ is Player)
         {
            _loc4_ = _loc5_ as Player;
            _loc3_ = param1.pkg.readBoolean();
            _loc2_ = param1.pkg.readInt();
            _map.act(new ChangeBallAction(_loc4_,_loc3_,_loc2_));
         }
      }
      
      private function __playerUsingItem(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc10_:int = _loc6_.readByte();
         var _loc9_:int = _loc6_.readInt();
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc6_.readInt());
         if(props.indexOf(_loc5_.TemplateID) != -1)
         {
            EnergyView.canPower = true;
         }
         var _loc8_:Living = _gameInfo.findLiving(_loc6_.extend1);
         var _loc2_:Living = _gameInfo.findLiving(_loc6_.readInt());
         var _loc3_:Boolean = _loc6_.readBoolean();
         if(_loc8_ && _loc5_)
         {
            if(_loc8_.isPlayer())
            {
               if(_loc5_.CategoryID == 10015)
               {
                  Player(_loc8_).skill == -1;
               }
               if(!(_loc8_ as Player).isSelf)
               {
                  if(_loc5_.CategoryID == 17 || _loc5_.CategoryID == 31)
                  {
                     _loc4_ = (_loc8_ as Player).currentDeputyWeaponInfo.getDeputyWeaponIcon();
                     _loc4_.x = _loc4_.x + 7;
                     (_loc8_ as Player).useItemByIcon(_loc4_);
                  }
                  else
                  {
                     (_loc8_ as Player).useItem(_loc5_);
                     _loc7_ = EquipType.hasPropAnimation(_loc5_);
                     if(_loc7_ != null && _loc2_ && _loc2_.LivingID != _loc8_.LivingID)
                     {
                        _loc2_.showEffect(_loc7_);
                     }
                  }
               }
            }
            if(_map.currentPlayer && _loc2_.team == _map.currentPlayer.team && (!GameControl.Instance.Current.togetherShoot && RoomManager.Instance.current.type != 56 || (_loc8_ as Player).isSelf))
            {
               _map.currentPlayer.addState(_loc5_.TemplateID);
            }
            if(!_loc2_.isLiving)
            {
               if(_loc2_.isPlayer())
               {
                  (_loc2_ as Player).addState(_loc5_.TemplateID);
               }
            }
            if(RoomManager.Instance.current.type != 21 && RoomManager.Instance.current.type != 56)
            {
               if(!_loc8_.isLiving && _loc2_ && _loc8_.team == _loc2_.team)
               {
                  GameMessageTipManager.getInstance().show(_loc8_.LivingID + "|" + _loc5_.TemplateID,1);
               }
               if(_loc3_)
               {
                  GameMessageTipManager.getInstance().show(String(_loc2_.LivingID),3);
               }
            }
         }
      }
      
      private function __updateBuff(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc4_:int = _loc6_.extend1;
         var _loc2_:int = _loc6_.readInt();
         var _loc5_:Boolean = _loc6_.readBoolean();
         var _loc3_:int = _loc6_.readInt();
         var _loc8_:Living = _gameInfo.findLiving(_loc4_);
         if(_loc8_ is LocalPlayer)
         {
            if(_loc5_)
            {
               (_loc8_ as LocalPlayer).usePassBall = true;
            }
            else
            {
               (_loc8_ as LocalPlayer).usePassBall = false;
            }
         }
         if(_loc8_ && _loc2_ != -1)
         {
            if(_loc5_)
            {
               _loc7_ = BuffManager.creatBuff(_loc2_);
               _loc7_.Count = _loc3_;
               _loc8_.addBuff(_loc7_);
            }
            else
            {
               _loc8_.removeBuff(_loc2_);
            }
         }
      }
      
      private function __updatePetBuff(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:PackageIn = param1.pkg;
         var _loc3_:int = _loc9_.extend1;
         var _loc2_:int = _loc9_.readInt();
         var _loc6_:String = _loc9_.readUTF();
         var _loc4_:String = _loc9_.readUTF();
         var _loc5_:String = _loc9_.readUTF();
         var _loc8_:String = _loc9_.readUTF();
         var _loc7_:Boolean = _loc9_.readBoolean();
         var _loc11_:Living = _gameInfo.findLiving(_loc3_);
         var _loc10_:FightBuffInfo = new FightBuffInfo(_loc2_);
         _loc10_.buffPic = _loc5_;
         _loc10_.buffEffect = _loc8_;
         _loc10_.type = 5;
         _loc10_.buffName = _loc6_;
         _loc10_.description = _loc4_;
         if(_loc11_)
         {
            if(_loc7_)
            {
               _loc11_.addPetBuff(_loc10_);
            }
            else
            {
               _loc11_.removePetBuff(_loc10_);
            }
         }
      }
      
      private function __startMove(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Player = _gameInfo.findPlayer(param1.pkg.extend1);
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc4_)
         {
            if(_loc2_)
            {
               if(!_loc4_.playerInfo.isSelf || BombKingManager.instance.Recording)
               {
                  playerMove(_loc3_,_loc4_);
               }
            }
            else
            {
               playerMove(_loc3_,_loc4_);
            }
         }
      }
      
      private function playerMove(param1:PackageIn, param2:Player) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc10_:int = param1.readByte();
         var _loc5_:Point = new Point(param1.readInt(),param1.readInt());
         var _loc4_:int = param1.readByte();
         var _loc7_:Boolean = param1.readBoolean();
         if(_loc10_ == 2)
         {
            _loc3_ = [];
            _loc6_ = param1.readInt();
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               _loc8_ = new PickBoxAction(param1.readInt(),param1.readInt());
               _loc3_.push(_loc8_);
               _loc9_++;
            }
            if(param2)
            {
               param2.playerMoveTo(_loc10_,_loc5_,_loc4_,_loc7_,_loc3_);
            }
         }
         else if(param2)
         {
            param2.playerMoveTo(_loc10_,_loc5_,_loc4_,_loc7_);
         }
      }
      
      private function __onLivingBoltmove(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc3_)
         {
            _loc3_.pos = new Point(_loc2_.readInt(),_loc2_.readInt());
         }
      }
      
      public function playerBlood(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc5_:int = _loc3_.readByte();
         var _loc4_:Number = _loc3_.readLong();
         var _loc2_:int = _loc3_.readInt();
         var _loc6_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc6_)
         {
            _loc6_.updateBlood(_loc4_,_loc5_,_loc2_);
         }
      }
      
      private function __changWind(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.pkg;
         _map.wind = _loc7_.readInt() / 10;
         var _loc8_:Boolean = _loc7_.readBoolean();
         var _loc3_:int = _loc7_.readByte();
         var _loc6_:int = _loc7_.readByte();
         var _loc5_:int = _loc7_.readByte();
         var _loc2_:int = _loc7_.readInt();
         var _loc4_:Number = _loc7_.readInt() / 100;
         var _loc9_:Array = [_loc8_,_loc3_,_loc6_,_loc5_,_loc2_];
         _vane.update(_map.wind,false,_loc9_);
      }
      
      private function __playerNoNole(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc2_)
         {
            _loc2_.isNoNole = param1.pkg.readBoolean();
         }
      }
      
      private function __onChangePlayerTarget(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == 0)
         {
            if(_playerThumbnailLController)
            {
               _playerThumbnailLController.currentBoss = null;
            }
            return;
         }
         var _loc3_:Living = _gameInfo.findLiving(_loc2_);
         _gameLivingIdArr.push(_loc2_);
         _playerThumbnailLController.currentBoss = _loc3_;
      }
      
      public function objectSetProperty(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:GameLiving = getGameLivingByID(param1.pkg.extend1) as GameLiving;
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:String = param1.pkg.readUTF();
         var _loc2_:String = param1.pkg.readUTF();
         setProperty(_loc4_,_loc3_,_loc2_);
      }
      
      private function __usePetSkill(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc6_:int = _loc3_.extend1;
         var _loc5_:int = _loc3_.readInt();
         var _loc2_:Boolean = _loc3_.readBoolean();
         var _loc7_:Player = _gameInfo.findPlayer(_loc6_);
         var _loc4_:int = _loc3_.readInt();
         if(!_loc7_)
         {
            return;
         }
         if(_loc4_ == 2)
         {
            _loc7_.useHorseSkill(_loc5_,_loc2_,_loc3_.readInt());
         }
         else
         {
            if(_loc7_ && _loc7_.currentPet && _loc2_)
            {
               _loc7_.usePetSkill(_loc5_,_loc2_);
               if(PetSkillManager.getSkillByID(_loc5_).BallType == 2)
               {
                  _loc7_.isAttacking = false;
                  GameControl.Instance.Current.selfGamePlayer.beginShoot();
               }
            }
            if(!_loc2_)
            {
               GameControl.Instance.dispatchEvent(new LivingEvent("petSkillUsedFail"));
            }
         }
      }
      
      private function __petBeat(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc13_:* = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc14_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.extend1;
         var _loc10_:Player = _gameInfo.findPlayer(_loc5_);
         var _loc9_:int = _loc4_.readInt();
         var _loc16_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc6_ = _loc4_.readInt();
            _loc13_ = _gameInfo.findLiving(_loc6_);
            _loc11_ = _loc4_.readInt();
            _loc8_ = _loc4_.readInt();
            _loc2_ = _loc4_.readInt();
            _loc14_ = {
               "target":_loc13_,
               "hp":_loc8_,
               "damage":_loc11_,
               "dander":_loc2_
            };
            _loc16_.push(_loc14_);
            _loc7_++;
         }
         var _loc15_:int = _loc4_.readInt();
         var _loc3_:String = "attack" + _loc15_.toString();
         var _loc12_:Point = new Point(_loc4_.readInt(),_loc4_.readInt());
         _loc10_.petBeat(_loc3_,_loc12_,_loc16_);
      }
      
      private function __playerHide(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc2_)
         {
            _loc2_.isHidden = param1.pkg.readBoolean();
         }
      }
      
      private function __gameOver(param1:CrazyTankSocketEvent) : void
      {
         GameControl.Instance.currentNum = 0;
         gameOver();
         _map.act(new GameOverAction(_map,param1,showExpView));
      }
      
      public function logTimeHandler(param1:TimerEvent = null) : void
      {
         _map.traceCurrentAction();
      }
      
      private function __missionOver(param1:CrazyTankSocketEvent) : void
      {
         gameOver();
         _missionAgain = new MissionAgainInfo();
         _missionAgain.value = _gameInfo.missionInfo.tryagain;
         var _loc2_:DictionaryData = RoomManager.Instance.current.players;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            if(RoomPlayer(_loc2_[_loc3_]).isHost)
            {
               _missionAgain.host = RoomPlayer(_loc2_[_loc3_]).playerInfo.NickName;
            }
         }
         _map.act(new MissionOverAction(_map,param1,showExpView));
         if(GameManager.GAME_CAN_NOT_EXIT_SEND_LOG == 1 && (_gameInfo.roomType == 21 || _gameInfo.roomType == 56))
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
         var _loc1_:TryAgain = new TryAgain(_missionAgain);
         _loc1_.addEventListener("tryagain",__tryAgain);
         _loc1_.addEventListener("giveup",__giveup);
         _loc1_.addEventListener("timeOut",__tryAgainTimeOut);
         _loc1_.show();
         addChild(_loc1_);
      }
      
      private function __tryAgainTimeOut(param1:GameEvent) : void
      {
         param1.currentTarget.removeEventListener("tryagain",__tryAgain);
         param1.currentTarget.removeEventListener("giveup",__giveup);
         param1.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(_expView)
         {
            _expView.close();
         }
         _expView = null;
      }
      
      private function showExpView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
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
         if(RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 42)
         {
            StateManager.setState("matchRoom");
            return;
         }
         if(GameControl.Instance.Current.roomType == 19)
         {
            StateManager.setState("consortiaBattleScene");
            return;
         }
         if(GameControl.Instance.Current.roomType == 56)
         {
            StateManager.setState("main");
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
         if(GameControl.Instance.Current.roomType == 150)
         {
            StateManager.setState("consortia_domain");
            return;
         }
         if(GameControl.Instance.Current.roomType == 151)
         {
            StateManager.setState("consortiaGuard");
            return;
         }
         if(GameControl.Instance.Current.roomType == 155)
         {
            StateManager.setState("main");
            return;
         }
         if(!_firstEnter)
         {
            _expView = new ExpView(_map.mapBitmap);
            _expView.addEventListener("expshowed",__expShowed);
            addChild(_expView);
            _expView.show();
         }
         else
         {
            if(ApplicationDomain.currentDomain.hasDefinition("RegisterLuncher"))
            {
               if(getDefinitionByName("RegisterLuncher").newBieTime != -1)
               {
                  _loc2_ = getTimer() - getDefinitionByName("RegisterLuncher").newBieTime;
                  _loc1_ = new URLVariables();
                  _loc1_.id = PlayerManager.Instance.Self.ID;
                  _loc1_.type = 3;
                  _loc1_.time = _loc2_;
                  _loc1_.grade = PlayerManager.Instance.Self.Grade;
                  _loc1_.serverID = PlayerManager.Instance.Self.ZoneID;
                  _loc4_ = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
                  _loc4_.method = "POST";
                  _loc4_.data = _loc1_;
                  _loc3_ = new URLLoader();
                  _loc3_.load(_loc4_);
               }
            }
            StateManager.setState("main");
         }
      }
      
      private function __expShowed(param1:GameEvent) : void
      {
         _expView.removeEventListener("expshowed",__expShowed);
         var _loc5_:int = 0;
         var _loc4_:* = _gameInfo.livings.list;
         for each(var _loc2_ in _gameInfo.livings.list)
         {
            if(_loc2_.isSelf)
            {
               if(Player(_loc2_).isWin && _missionAgain)
               {
                  _missionAgain.win = true;
               }
               if(Player(_loc2_).hasLevelAgain && _missionAgain)
               {
                  _missionAgain.hasLevelAgain = true;
               }
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _gameInfo.viewers.list;
         for each(var _loc3_ in _gameInfo.viewers.list)
         {
            if(_loc3_.isSelf)
            {
               if(Player(_loc3_).isWin && _missionAgain)
               {
                  _missionAgain.win = true;
               }
               if(Player(_loc3_).hasLevelAgain && _missionAgain)
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
            }
            else if(RoomManager.Instance.current.selfRoomPlayer.isViewer && _missionAgain.win)
            {
               if(_expView)
               {
                  _expView.close();
               }
               _expView = null;
            }
            else if(!_gameInfo.selfGamePlayer.isWin)
            {
               showTryAgain();
               if(_expView)
               {
                  _expView.visible = false;
               }
            }
            else
            {
               _expView.showCard();
               _expView = null;
            }
         }
         else if(GameControl.isFightLib(_gameInfo))
         {
            _expView.close();
            _expView = null;
         }
         else if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _expView.close();
            _expView = null;
         }
         else
         {
            _expView.showCard();
            _expView = null;
         }
      }
      
      private function __giveup(param1:GameEvent) : void
      {
         param1.currentTarget.removeEventListener("tryagain",__tryAgain);
         param1.currentTarget.removeEventListener("giveup",__giveup);
         param1.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendMissionTryAgain(0,true);
         }
         _expView.close();
         _expView = null;
      }
      
      private function __tryAgain(param1:GameEvent) : void
      {
         param1.currentTarget.removeEventListener("tryagain",__tryAgain);
         param1.currentTarget.removeEventListener("giveup",__giveup);
         param1.currentTarget.removeEventListener("timeOut",__tryAgainTimeOut);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(!RoomManager.Instance.current.selfRoomPlayer.isViewer || GameControl.Instance.TryAgain == 1)
         {
            GameControl.Instance.Current.hasNextMission = true;
         }
         if(RoomManager.Instance.current.type != 15)
         {
            _expView.close();
         }
         _expView = null;
      }
      
      private function __dander(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc3_ && _loc3_ is Player)
         {
            _loc2_ = param1.pkg.readInt();
            (_loc3_ as Player).dander = _loc2_;
         }
      }
      
      private function __reduceDander(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc3_ && _loc3_ is Player)
         {
            _loc2_ = param1.pkg.readInt();
            (_loc3_ as Player).reduceDander(_loc2_);
         }
      }
      
      private function __changeState(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc2_)
         {
            _loc2_.State = param1.pkg.readInt();
            _map.setCenter(_loc2_.pos.x,_loc2_.pos.y,true);
         }
      }
      
      private function __selfObtainItem(param1:BagEvent) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_gameInfo.roomType == 21 || _gameInfo.roomType == 52 || _gameInfo.roomType == 56)
         {
            return;
         }
         var _loc9_:int = 0;
         var _loc8_:* = param1.changedSlots;
         for each(var _loc7_ in param1.changedSlots)
         {
            _loc4_ = new PropInfo(_loc7_);
            _loc4_.Place = _loc7_.Place;
            if(PlayerManager.Instance.Self.FightBag.getItemAt(_loc7_.Place))
            {
               if(_gameInfo.gameMode != 41 && _gameInfo.gameMode != 42)
               {
                  _loc6_ = new AutoDisappear(ComponentFactory.Instance.creatBitmap("asset.game.getPropBgAsset"),3);
                  _loc6_.x = _vane.x - _loc6_.width / 2 + 48;
                  _loc6_.y = _selfMarkBar.y + _selfMarkBar.height + 70;
                  LayerManager.Instance.addToLayer(_loc6_,3,false);
                  _loc5_ = new AutoDisappear(PropItemView.createView(_loc4_.Template.Pic,62,62),3);
                  _loc5_.x = _vane.x - _loc5_.width / 2 + 47;
                  _loc5_.y = _selfMarkBar.y + _selfMarkBar.height + 70;
                  LayerManager.Instance.addToLayer(_loc5_,3,false);
                  _loc3_ = new AutoDisappear(ComponentFactory.Instance.creatBitmap("asset.game.getPropCiteAsset"),3);
                  _loc3_.x = _vane.x - _loc3_.width / 2 + 45;
                  _loc3_.y = _selfMarkBar.y + _selfMarkBar.height + 70;
                  LayerManager.Instance.addToLayer(_loc3_,3,false);
               }
               _loc2_ = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.zxcTip"),true,true);
               _loc2_.movie.x = _loc2_.movie.x + (_loc2_.movie.width * _loc7_.Place - 24 * _loc7_.Place);
               LayerManager.Instance.addToLayer(_loc2_.movie,4,false);
            }
         }
      }
      
      private function __getTempItem(param1:BagEvent) : void
      {
         var _loc2_:Boolean = GameControl.Instance.selfGetItemShowAndSound(param1.changedSlots);
         if(_loc2_ && _soundPlayFlag)
         {
            _soundPlayFlag = false;
            SoundManager.instance.play("1001");
         }
      }
      
      private function __forstPlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.extend1);
         if(_loc2_)
         {
            _loc2_.isFrozen = param1.pkg.readBoolean();
         }
      }
      
      private function __changeShootCount(param1:CrazyTankSocketEvent) : void
      {
         if(_gameInfo.roomType != 56 || !GameControl.Instance.Current.togetherShoot || param1.pkg.extend1 == _gameInfo.selfGamePlayer.LivingID)
         {
            _gameInfo.selfGamePlayer.shootCount = param1.pkg.readByte();
         }
      }
      
      private function __playSound(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:String = param1.pkg.readUTF();
         SoundManager.instance.initSound(_loc2_);
         SoundManager.instance.play(_loc2_);
      }
      
      private function __controlBGM(param1:CrazyTankSocketEvent) : void
      {
         if(param1.pkg.readBoolean())
         {
            SoundManager.instance.resumeMusic();
         }
         else
         {
            SoundManager.instance.pauseMusic();
         }
      }
      
      private function __forbidDragFocus(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         _map.smallMap.allowDrag = _loc2_;
         var _loc3_:* = _loc2_;
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
      
      private function __topLayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:Living = _gameInfo.findLiving(param1.pkg.readInt());
         if(_loc2_)
         {
            _map.bringToFront(_loc2_);
         }
      }
      
      private function __loadResource(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new GameNeedMovieInfo();
            _loc3_.type = param1.pkg.readInt();
            _loc3_.path = param1.pkg.readUTF();
            _loc3_.classPath = param1.pkg.readUTF();
            _loc3_.startLoad();
            _loc4_++;
         }
      }
      
      public function livingShowBlood(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readInt();
         if(_map)
         {
            if(_map.getPhysical(_loc2_))
            {
               (_map.getPhysical(_loc2_) as GameLiving).showBlood(_loc3_);
            }
         }
      }
      
      public function livingActionMapping(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:String = param1.pkg.readUTF();
         var _loc4_:String = param1.pkg.readUTF();
         if(_map.getPhysical(_loc2_))
         {
            _map.getPhysical(_loc2_).setActionMapping(_loc3_,_loc4_);
         }
      }
      
      private function __livingSmallColorChange(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readByte();
         if(_map.getPhysical(_loc2_) && _map.getPhysical(_loc2_) is GameLiving)
         {
            (_map.getPhysical(_loc2_) as GameLiving).changeSmallViewColor(_loc3_);
         }
      }
      
      private function __revivePlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.pkg;
         var _loc2_:int = _loc6_.readInt();
         var _loc7_:Number = _loc6_.readLong();
         var _loc4_:int = _loc6_.readInt();
         var _loc3_:int = _loc6_.readInt();
         var _loc5_:GamePlayer = retrunPlayer(_loc2_);
         if(_loc5_ && !_loc5_.info.isLiving)
         {
            _loc5_.info.revive();
            _loc5_.pos = new Point(_loc4_,_loc3_);
            _loc5_.info.updateBlood(_loc7_,0,_loc7_);
            _loc5_.revive();
            _loc5_.info.dispatchEvent(new LivingEvent("livingRevive"));
            if(_loc5_ is GameLocalPlayer)
            {
               _fightControlBar.setState(0);
               _selfBuffBar = ComponentFactory.Instance.creatCustomObject("SelfBuffBar",[this,_arrowDown]);
               if(!(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI) && GameControl.Instance.isShowSelfBuffBar)
               {
                  addChildAt(_selfBuffBar,this.numChildren - 1);
               }
               kingBlessIconInit();
            }
         }
      }
      
      public function revivePlayerChangePlayer(param1:int) : void
      {
         var _loc2_:GamePlayer = retrunPlayer(param1);
         if(_loc2_ && !_loc2_.info.isLiving)
         {
            _loc2_.info.revive();
            _loc2_.revive();
            _loc2_.info.dispatchEvent(new LivingEvent("livingRevive"));
            if(_loc2_ is GameLocalPlayer)
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
      
      private function __gameTrusteeship(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.pkg.readInt();
         if(_loc3_ == 0)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ <= _loc3_ - 1)
         {
            _loc4_ = param1.pkg.readInt();
            _loc2_ = _gameInfo.findPlayer(_loc4_);
            _loc2_.playerInfo.isTrusteeship = param1.pkg.readBoolean();
            _loc5_++;
         }
      }
      
      private function __fightStatusChange(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = param1.pkg.extend1;
         var _loc2_:Player = _gameInfo.findPlayer(_loc3_);
         if(_loc2_)
         {
            _loc2_.playerInfo.fightStatus = param1.pkg.readInt();
         }
      }
      
      private function __skipNextHandler(param1:CrazyTankSocketEvent) : void
      {
         if(_gameInfo.roomType == 21 || _gameInfo.roomType == 56)
         {
            setTimeout(delayFocusSimpleBoss,250);
         }
      }
      
      private function __clearDebuff(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:GamePlayer = retrunPlayer(_loc3_);
         if(_loc2_)
         {
            _loc2_.clearDebuff();
         }
      }
      
      private function delayFocusSimpleBoss() : void
      {
         if(!_map)
         {
            return;
         }
         var _loc1_:GameSimpleBoss = _map.getOneSimpleBoss;
         if(_loc1_)
         {
            _loc1_.needFocus(0,0,{"priority":3});
         }
      }
      
      private function getGameLivingByID(param1:int) : PhysicalObj
      {
         if(!_map)
         {
            return null;
         }
         return _map.getPhysical(param1);
      }
      
      private function addStageCurtain(param1:SimpleObject) : void
      {
         obj = param1;
         obj.movie.addEventListener("playEnd",function():void
         {
            obj.movie.stop();
            if(obj.parent)
            {
               obj.parent.removeChild(obj);
            }
            obj.dispose();
            obj = null;
         });
         addChild(obj);
      }
      
      private function __onDropItemComplete(param1:CrazyTankSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc13_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc15_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         if(_loc7_.bytesAvailable < 1)
         {
            return;
         }
         var _loc9_:int = _loc7_.readInt();
         var _loc8_:int = _loc7_.readInt();
         var _loc16_:int = _loc7_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc16_)
         {
            _loc14_ = _loc7_.readInt();
            _loc12_ = 0;
            while(_loc12_ < _loc14_)
            {
               _loc11_ = _loc7_.readInt();
               _loc2_ = _loc7_.readInt();
               _loc11_ = EquipType.filterEquiqItemId(_loc11_);
               _loc13_ = ItemManager.Instance.getTemplateById(_loc11_);
               _loc6_ = new BaseCell(new Sprite(),_loc13_,false,false);
               _loc6_.setContentSize(40,40);
               _loc5_ = _loc6_;
               _loc4_ = new Point(_loc9_,_loc8_);
               if(_selfGamePlayer)
               {
                  _loc3_ = new Point(_selfGamePlayer.x,_selfGamePlayer.y - 30);
               }
               GameControl.Instance.setDropData(_loc11_,_loc2_);
               _loc15_ = new DropGoods(this.map,_loc5_,_loc4_,_loc3_,_loc2_);
               GameControl.Instance.dropGoodslist.push(_loc15_);
               _loc12_++;
            }
            _loc10_++;
         }
      }
   }
}
