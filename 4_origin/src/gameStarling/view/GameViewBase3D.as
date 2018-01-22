package gameStarling.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.BombKingManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.data.map.MissionInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.DungeonInfoEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.BallManager;
   import ddt.manager.BitmapManager;
   import ddt.manager.ChatManager;
   import ddt.manager.IMEManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PolarRegionManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.states.BaseStateView;
   import ddt.utils.Helpers;
   import ddt.utils.MenoryUtil;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ShowCharacter;
   import ddt.view.characterStarling.GameCharacter3D;
   import ddt.view.chat.ChatBugleView;
   import ddt.view.chat.chatBall.ChatBallBoss;
   import ddt.view.rescue.RescueRoomItemView;
   import ddt.view.rescue.RescueScoreAlertView;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import game.GameDecorateManager;
   import game.view.heroAuto.HeroAutoView;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.GameMessageTipManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.DamageView;
   import gameCommon.view.DungeonHelpView;
   import gameCommon.view.DungeonInfoView;
   import gameCommon.view.FightAchievBar;
   import gameCommon.view.GameCountDownView;
   import gameCommon.view.GameTrusteeshipView;
   import gameCommon.view.LeftPlayerCartoonView;
   import gameCommon.view.SelfMarkBar;
   import gameCommon.view.VaneView;
   import gameCommon.view.buff.SelfBuffBar;
   import gameCommon.view.control.ControlState;
   import gameCommon.view.control.FightControlBar;
   import gameCommon.view.control.LiveState;
   import gameCommon.view.playerThumbnail.PlayerThumbnailController;
   import gameCommon.view.propContainer.PlayerStateContainer;
   import gameStarling.actions.ViewEachPlayerAction;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.view.map.MapView3D;
   import kingBless.KingBlessManager;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import particleSystem.ParticleRender;
   import phy.math.EulerVector;
   import rescue.data.RescueRoomInfo;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.data.StringObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   import worldboss.WorldBossManager;
   
   public class GameViewBase3D extends BaseStateView
   {
       
      
      protected var _arrowLeft:SpringArrowView3D;
      
      protected var _arrowRight:SpringArrowView3D;
      
      protected var _arrowUp:SpringArrowView3D;
      
      protected var _arrowDown:SpringArrowView3D;
      
      protected var _selfUsedProp:PlayerStateContainer;
      
      protected var _leftPlayerView:LeftPlayerCartoonView;
      
      protected var _missionHelp:DungeonHelpView;
      
      protected var _fightControlBar:FightControlBar;
      
      protected var _cs:ControlState;
      
      protected var _vane:VaneView;
      
      protected var _playerThumbnailLController:PlayerThumbnailController;
      
      protected var _map:MapView3D;
      
      protected var _mapSprite:Sprite;
      
      protected var _smallMapBorderBg:Bitmap;
      
      protected var _players:DictionaryData;
      
      protected var _gameInfo:GameInfo;
      
      protected var _selfGamePlayer:GameLocalPlayer3D;
      
      protected var _selfBuffBar:SelfBuffBar;
      
      protected var _selfMarkBar:SelfMarkBar;
      
      protected var _achievBar:FightAchievBar;
      
      protected var _bitmapMgr:BitmapManager;
      
      private var _buffIconBox:HBox;
      
      protected var _kingblessIcon:Image;
      
      protected var _trialBuffIcon:Image;
      
      protected var _ringSkillIcon:Image;
      
      protected var _guardCoreIcon:Image;
      
      protected var _gameTrusteeshipView:GameTrusteeshipView;
      
      protected var _heroAutoView:HeroAutoView;
      
      protected var _gameCountDownView:GameCountDownView;
      
      private var _damageView:DamageView;
      
      private var _rescueRoomItemView:RescueRoomItemView;
      
      protected var _rescueScoreView:RescueScoreAlertView;
      
      protected var _sceneEffectsBar:SceneEffectsBar3D;
      
      private var _messageBtn:BaseButton;
      
      private var _pirateBall:ChatBallBoss;
      
      public var explorersLiving:Living;
      
      protected var _weatherView:GameWeatherView;
      
      protected var _barrier:DungeonInfoView;
      
      private const GUIDEID:int = 10029;
      
      protected var _barrierVisible:Boolean = true;
      
      private var _self:LocalPlayer;
      
      private var _level:int;
      
      private var _gameLiving:GameLiving3D;
      
      private var _selfGameLiving:GamePlayer3D;
      
      private var _allLivings:DictionaryData;
      
      private var _mass:Number = 10;
      
      private var _gravityFactor:Number = 70;
      
      protected var _windFactor:Number = 240;
      
      private var _powerRef:Number = 1;
      
      private var _reangle:Number = 0;
      
      private var _dt:Number = 0.04;
      
      private var _arf:Number;
      
      private var _gf:Number;
      
      private var _ga:Number;
      
      private var _mapWind:Number = 0;
      
      private var _wa:Number;
      
      private var _ef:Point;
      
      private var _shootAngle:Number;
      
      private var _state:Boolean = false;
      
      private var _useAble:Boolean = false;
      
      private var _stateFlag:int;
      
      private var _currentLivID:int;
      
      private var _collideRect:Rectangle;
      
      private var _drawRoute:Sprite;
      
      public function GameViewBase3D()
      {
         _ef = new Point(0,0);
         _collideRect = new Rectangle(-45,-30,100,80);
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function fadingComplete() : void
      {
         super.fadingComplete();
         if(_barrierVisible && !PolarRegionManager.Instance.ShowFlag)
         {
            drawMissionInfo();
         }
      }
      
      public function get selfGamePlayer() : GameLocalPlayer3D
      {
         return _selfGamePlayer;
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         ParticleRender.Instance.turnOn();
         super.enter(param1,param2);
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
         SharedManager.Instance.propTransparent = false;
         _gameInfo = GameControl.Instance.Current;
         MainToolBar.Instance.hide();
         LayerManager.Instance.clearnStageDynamic();
         ChatBugleView.instance.hide();
         PlayerManager.Instance.Self.TempBag.clearnAll();
         GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = true;
         var _loc8_:int = 0;
         var _loc7_:* = _gameInfo.livings;
         for each(var _loc4_ in _gameInfo.livings)
         {
            if(_loc4_ is Player)
            {
               Player(_loc4_).isUpGrade = false;
               Player(_loc4_).LockState = false;
            }
         }
         _map = newMap();
         _mapSprite = new Sprite();
         _mapSprite.graphics.beginFill(0,0);
         _mapSprite.graphics.drawRect(0,0,_map.width,_map.height);
         _mapSprite.graphics.endFill();
         addChild(_mapSprite);
         _map.gameView = this;
         _loc8_ = 0;
         _map.y = _loc8_;
         _map.x = _loc8_;
         StarlingMain.instance.currentScene.addChild(_map);
         _map.smallMap.x = StageReferance.stageWidth - _map.smallMap.width - 1;
         var _loc6_:Boolean = GameControl.EXIT_ROOM_TYPE_ARRAY.indexOf(_gameInfo.roomType) == -1 && GameControl.EXTI_GAME_MODE_ARRAY.indexOf(_gameInfo.gameMode) == -1;
         _map.smallMap.enableExit = !!BombKingManager.instance.Recording?false:Boolean(_loc6_);
         creatWeatherView();
         _smallMapBorderBg = addSmallMapBg();
         if(_smallMapBorderBg)
         {
            _smallMapBorderBg.visible = !GameControl.Instance.smallMapEnable();
         }
         _map.smallMap.visible = !GameControl.Instance.smallMapEnable();
         if(GameControl.Instance.smallMapAlpha())
         {
            _map.smallMap.alpha = 0.8;
         }
         addChild(_map.smallMap);
         _map.smallMap.hideSpliter();
         _selfMarkBar = new SelfMarkBar(GameControl.Instance.Current.selfGamePlayer,this);
         _selfMarkBar.x = 500;
         _selfMarkBar.y = 79;
         _fightControlBar = new FightControlBar(_gameInfo.selfGamePlayer,this);
         GameControl.Instance.Current.selfGamePlayer.addEventListener("die",__selfDie);
         _leftPlayerView = new LeftPlayerCartoonView();
         _vane = new VaneView();
         _vane.setUpCenter(446,0);
         addChild(_vane);
         SoundManager.instance.playGameBackMusic(_map.info.BackMusic);
         if(RoomManager.Instance.current.type == 120 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.gameMode == 120)
         {
            _sceneEffectsBar = new SceneEffectsBar3D(_map);
            PositionUtils.setPos(_sceneEffectsBar,"asset.gameBattle.sceneEffectsBarPos");
            addChild(_sceneEffectsBar);
         }
         _arrowUp = new SpringArrowView3D("up",_map);
         _arrowDown = new SpringArrowView3D("down",_map);
         _arrowLeft = new SpringArrowView3D("right",_map);
         _arrowRight = new SpringArrowView3D("left",_map);
         addChild(_arrowUp);
         addChild(_arrowDown);
         addChild(_arrowLeft);
         addChild(_arrowRight);
         _selfBuffBar = ComponentFactory.Instance.creatCustomObject("SelfBuffBar",[this,_arrowDown]);
         if(!GameControl.Instance.Current.missionInfo || !(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI))
         {
            if(GameControl.Instance.isShowSelfBuffBar)
            {
               addChildAt(_selfBuffBar,this.numChildren - 1);
            }
         }
         if(NoviceDataManager.instance.firstEnterGame && PlayerManager.Instance.Self.Grade < 11)
         {
            NoviceDataManager.instance.saveNoviceData(530,PathManager.userName(),PathManager.solveRequestPath());
         }
         _players = new DictionaryData();
         SharedManager.Instance.addEventListener("change",__soundChange);
         __soundChange(null);
         var _loc5_:LocalPlayer = _gameInfo.selfGamePlayer;
         if(!BombKingManager.instance.Recording && !RoomManager.Instance.current.selfRoomPlayer.isViewer && _loc5_.isLiving)
         {
            _cs = _fightControlBar.setState(0);
         }
         setupGameData();
         _playerThumbnailLController = new PlayerThumbnailController(_gameInfo);
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.ThumbnailLPos");
         _playerThumbnailLController.x = _loc3_.x;
         _playerThumbnailLController.y = _loc3_.y;
         addChildAt(_playerThumbnailLController,getChildIndex(_map.smallMap));
         if(RoomManager.Instance.current.type == 121)
         {
            _vane.x = 564;
         }
         ChatManager.Instance.state = 1;
         ChatManager.Instance.view.visible = true;
         addChild(ChatManager.Instance.view);
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            loadWeakGuild();
         }
         defaultForbidDragFocus();
         initEvent();
         wishInit();
         _buffIconBox = ComponentFactory.Instance.creat("game.buff.iconHbox");
         _buffIconBox.visible = false;
         addChild(_buffIconBox);
         kingBlessIconInit();
         trialBuffIconInit();
         addRingSkillIcon();
         initGameCountDownView();
         resetPlayerCharacters();
         if(isShowTrusteeship())
         {
            _gameTrusteeshipView = ComponentFactory.Instance.creatCustomObject("game.view.gameTrusteeshipView");
            GameDecorateManager.Instance.createBitmapUI(_gameTrusteeshipView,"asset.gameDecorate.trusteeship");
         }
         initDiePlayer();
         if(RoomManager.Instance.current.type == 21)
         {
            _damageView = new DamageView();
            addChild(_damageView);
            PositionUtils.setPos(_damageView,"asset.game.damageViewPos");
         }
         else if(RoomManager.Instance.current.type == 49)
         {
            _heroAutoView = ComponentFactory.Instance.creatCustomObject("game.view.heroAuto.heroAutoView");
            _heroAutoView.autoState = true;
            addChild(_heroAutoView);
         }
         else if(RoomManager.Instance.current.type == 29)
         {
            _rescueRoomItemView = new RescueRoomItemView();
            addChild(_rescueRoomItemView);
            PositionUtils.setPos(_rescueRoomItemView,"rescue.roomInfo.viewPos");
            SocketManager.Instance.addEventListener("RescueItemInfo",__updateRescueItemInfo);
            SocketManager.Instance.addEventListener("addScore",__addRescueScore);
         }
      }
      
      private function addSmallMapBg() : Bitmap
      {
         var _loc1_:Bitmap = GameDecorateManager.Instance.createBitmapUI(this,"asset.gameDecorate.smallMapBorder");
         if(_loc1_)
         {
            _loc1_.x = _map.smallMap.x - 36;
            _loc1_.y = _map.smallMap.y + (_map.smallMap.height - _loc1_.height) + 7;
            if(GameDecorateManager.Instance.isGameBattle)
            {
               _loc1_.x = _loc1_.x - 2;
               _loc1_.y = _loc1_.y - 6;
            }
         }
         return _loc1_;
      }
      
      protected function creatWeatherView() : void
      {
         if(GameControl.Instance.Current.isWeather)
         {
            setBarrierVisible(false);
            _weatherView = new GameWeatherView();
            addChild(_weatherView);
         }
      }
      
      protected function __addRescueScore(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         if(!_rescueScoreView)
         {
            trace("救援行动有问题！！！GameViewBase3D eroor");
         }
         _rescueScoreView.x = _loc2_;
         _rescueScoreView.y = _loc5_ - 50;
         _rescueScoreView.setData(_loc3_);
         _rescueScoreView.visible = true;
      }
      
      private function setScoreViewInvisible() : void
      {
         _rescueScoreView.visible = false;
      }
      
      protected function __updateRescueItemInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:RescueRoomInfo = new RescueRoomInfo();
         _loc4_.sceneId = _loc3_.readInt();
         _loc4_.score = _loc3_.readInt();
         _loc4_.defaultArrow = _loc3_.readInt();
         _loc4_.arrow = _loc3_.readInt();
         _loc4_.bloodBag = _loc3_.readInt();
         _loc4_.kingBless = _loc3_.readInt();
         if(_rescueRoomItemView)
         {
            _rescueRoomItemView.update(_loc4_);
         }
         if(_barrier)
         {
            _barrier.setRescueArrow(_loc4_.defaultArrow + _loc4_.arrow);
         }
         var _loc2_:LiveState = _cs as LiveState;
         if(_loc2_)
         {
            _loc2_.rescuePropBar.setKingBlessCount(_loc4_.kingBless);
         }
      }
      
      public function addMessageBtn() : void
      {
         if(!_messageBtn)
         {
            _messageBtn = ComponentFactory.Instance.creatComponentByStylename("game.view.activityDungeonView.messageBtn");
            _messageBtn.addEventListener("click",__onMessageClick);
            _mapSprite.addChild(_messageBtn);
         }
      }
      
      protected function __onMessageClick(param1:MouseEvent) : void
      {
         _messageBtn.visible = false;
         if(explorersLiving)
         {
            explorersLiving.say(LanguageMgr.GetTranslation("activity.dungeonView.pirateSay" + GameControl.Instance.currentNum));
         }
      }
      
      private function initGameCountDownView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = RoomManager.Instance.current.type;
         if(_loc1_ == 19)
         {
            _loc2_ = 300 - int((TimeManager.Instance.Now().getTime() - GameControl.Instance.Current.startTime.getTime()) / 1000);
            _gameCountDownView = new GameCountDownView(_loc2_);
            _gameCountDownView.x = _map.smallMap.x - _gameCountDownView.width - 1;
            _gameCountDownView.y = 2;
            addChild(_gameCountDownView);
         }
      }
      
      private function isShowTrusteeship() : Boolean
      {
         if(RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 13 || RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 25 || RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.gameMode != 120 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123)
         {
            return true;
         }
         return false;
      }
      
      public function updateDamageView() : void
      {
         if(_damageView)
         {
            _damageView.updateView();
         }
      }
      
      protected function kingBlessIconInit() : void
      {
         var _loc1_:int = 0;
         if(KingBlessManager.instance.openType > 0)
         {
            _loc1_ = RoomManager.Instance.current.type;
            if(_loc1_ == 4 || _loc1_ == 11 || _loc1_ == 15 || _loc1_ == 123)
            {
               _kingblessIcon = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.addPropertyBuffIcon");
               _kingblessIcon.tipData = KingBlessManager.instance.getOneBuffData(1);
               _buffIconBox.addChild(_kingblessIcon);
            }
         }
      }
      
      private function trialBuffIconInit() : void
      {
         var _loc1_:int = RoomManager.Instance.current.type;
         if(_loc1_ == 120 || _loc1_ == 1 && RoomManager.Instance.current.gameMode == 120)
         {
            _trialBuffIcon = ComponentFactory.Instance.creatComponentByStylename("game.trial.addTrialBuffIcon");
            _trialBuffIcon.tipData = ServerConfigManager.instance.trialBuffTipPropertyValue;
            _buffIconBox.addChild(_trialBuffIcon);
         }
         else if(_loc1_ == 123)
         {
            _trialBuffIcon = ComponentFactory.Instance.creatComponentByStylename("game.trial.addTrialBuffIcon");
            _trialBuffIcon.tipData = ServerConfigManager.instance.trialfubenBuffTipPropertyValue;
            _buffIconBox.addChild(_trialBuffIcon);
         }
      }
      
      private function addRingSkillIcon() : void
      {
         if(_self.ringFlag && _self.loveBuffLevel > 0)
         {
            _ringSkillIcon = ComponentFactory.Instance.creatComponentByStylename("game.ringSkill.BuffIcon");
            setSkillTipData(_ringSkillIcon);
            _buffIconBox.addChild(_ringSkillIcon);
            _buffIconBox.arrange();
         }
      }
      
      protected function updateGuardCoreIcon() : void
      {
         var _loc1_:* = null;
         if(GameControl.Instance.Current.guardCoreEnable)
         {
            _loc1_ = GameControl.Instance.Current.getGuardCoreBuffList();
            if(_loc1_.length > 0)
            {
               if(_guardCoreIcon == null)
               {
                  _guardCoreIcon = ComponentFactory.Instance.creatComponentByStylename("game.guardCore.tipsIcon");
               }
               _guardCoreIcon.tipData = _loc1_;
               _buffIconBox.addChild(_guardCoreIcon);
               _buffIconBox.arrange();
            }
            else
            {
               ObjectUtils.disposeObject(_guardCoreIcon);
               _guardCoreIcon = null;
            }
         }
      }
      
      private function setSkillTipData(param1:Image) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = BagAndInfoManager.Instance.getCurrentRingData().Level / 10;
         if(_loc2_ > 0)
         {
            _loc3_ = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,_loc2_)[0];
            _loc5_ = {};
            _loc5_["name"] = _loc3_.name + "Lv" + _loc2_;
            _loc5_["content"] = _loc3_.descript.replace("{0}",_loc3_.value);
            if(_loc2_ < RingSystemData.TotalLevel * 0.1)
            {
               _loc4_ = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,_loc2_ + 1)[0];
               _loc5_["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextLevel",_loc4_.name,_loc2_ + 1,_loc4_.descript.replace("{0}",_loc4_.value));
               _loc5_["limitLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextUnLock",(_loc2_ + 1) * 10);
            }
            else
            {
               _loc5_["nextLevel"] = "";
               _loc5_["limitLevel"] = "";
            }
            param1.tipData = _loc5_;
            Helpers.colorful(param1);
            param1.mouseEnabled = true;
         }
         else
         {
            Helpers.grey(param1);
            param1.mouseEnabled = false;
         }
      }
      
      private function resetPlayerCharacters() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var _loc1_ in _players)
         {
            if(_loc1_.info.character)
            {
               _loc1_.info.character.resetShowBitmapBig();
               _loc1_.info.character.showWing = true;
               _loc1_.info.character.show();
            }
         }
      }
      
      protected function __wishClick(param1:Event) : void
      {
         _selfUsedProp.info.addState(0);
      }
      
      protected function __selfDie(param1:LivingEvent) : void
      {
         var _loc2_:Living = param1.currentTarget as Living;
         var _loc3_:DictionaryData = _gameInfo.findTeam(_loc2_.team);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.isLiving)
            {
               _fightControlBar.setState(1);
               return;
            }
         }
         if(_selfBuffBar)
         {
            _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL,__selfBuffBarUpdateCellHandler);
         }
         ObjectUtils.disposeObject(_selfBuffBar);
         _selfBuffBar = null;
         ObjectUtils.disposeObject(_kingblessIcon);
         _kingblessIcon = null;
         ObjectUtils.disposeObject(_trialBuffIcon);
         _trialBuffIcon = null;
         ObjectUtils.disposeObject(_ringSkillIcon);
         _ringSkillIcon = null;
         ObjectUtils.disposeObject(_buffIconBox);
         _buffIconBox = null;
      }
      
      protected function drawMissionInfo() : void
      {
         if(_gameInfo.roomType >= 2 && _gameInfo.roomType != 5 && _gameInfo.roomType != 16 && _gameInfo.roomType != 18 && _gameInfo.roomType != 19 && _gameInfo.roomType != 24 && _gameInfo.roomType != 25 && _gameInfo.roomType != 27 && _gameInfo.roomType != 121 && _gameInfo.roomType != 120 && _gameInfo.gameMode != 23)
         {
            _map.smallMap.titleBar.addEventListener("DungeonHelpChanged",__dungeonVisibleChanged);
            if(!_barrier)
            {
               _barrier = new DungeonInfoView(_map.smallMap.titleBar.turnButton,this);
               _barrier.addEventListener("DungeonHelpVisibleChanged",__dungeonHelpChanged);
               _barrier.addEventListener("updateSmallMapView",__updateSmallMapView);
            }
            if(!_missionHelp)
            {
               _missionHelp = new DungeonHelpView(_map.smallMap.titleBar.turnButton,_barrier,this);
               addChild(_missionHelp);
            }
            _barrier.open();
         }
      }
      
      protected function __updateSmallMapView(param1:GameEvent) : void
      {
         var _loc2_:MissionInfo = GameControl.Instance.Current.missionInfo;
         if(_loc2_.currentValue1 != -1 && _loc2_.totalValue1 > 0)
         {
            _map.smallMap.setBarrier(_loc2_.currentValue1,_loc2_.totalValue1);
         }
      }
      
      protected function __dungeonHelpChanged(param1:GameEvent) : void
      {
         var _loc2_:* = null;
         if(_missionHelp)
         {
            if(param1.data)
            {
               if(_missionHelp.opened)
               {
                  _loc2_ = _barrier.getBounds(this);
                  var _loc3_:int = 1;
                  _loc2_.height = _loc3_;
                  _loc2_.width = _loc3_;
                  _missionHelp.close(_loc2_);
               }
               else
               {
                  _missionHelp.open();
               }
            }
            else if(_missionHelp.opened)
            {
               _loc2_ = _map.smallMap.titleBar.turnButton.getBounds(this);
               _missionHelp.close(_loc2_);
            }
         }
      }
      
      protected function __dungeonVisibleChanged(param1:DungeonInfoEvent) : void
      {
         if(_barrier && _barrierVisible)
         {
            if(_barrier.parent)
            {
               _barrier.close();
            }
            else
            {
               _barrier.open();
            }
         }
      }
      
      protected function initEvent() : void
      {
         _playerThumbnailLController.addEventListener("wishSelect",__thumbnailControlHandle);
         GameControl.Instance.addEventListener("addringanamition",__onAddRingAnimation);
         GameControl.Instance.addEventListener("addguardcoreeffect",__onAddGuardCoreAnimation);
         _selfBuffBar.addEventListener(SelfBuffBar.UPDATECELL,__selfBuffBarUpdateCellHandler);
         addEventListener("click",__mouseClick);
      }
      
      private function __selfBuffBarUpdateCellHandler(param1:CEvent) : void
      {
         updateBuffIconBoxPos();
      }
      
      private function addPlayerHander(param1:DictionaryEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = param1.data;
         if(_loc5_ is Player)
         {
            if(!_loc5_.movie)
            {
               _loc3_ = CharactoryFactory.createCharacter(_loc5_.playerInfo,"game3d");
               _loc3_.show();
               _loc5_.movie = GameCharacter3D(_loc3_);
            }
            if(!_loc5_.character)
            {
               _loc4_ = CharactoryFactory.createCharacter(_loc5_.playerInfo,"show");
               ShowCharacter(_loc4_).show();
               _loc5_.character = ShowCharacter(_loc4_);
            }
            _loc2_ = new GamePlayer3D(_loc5_,_loc5_.character,GameCharacter3D(_loc3_));
            _map.addPhysical(_loc2_);
            _players[_loc5_] = _loc2_;
            _playerThumbnailLController.addNewLiving(_loc5_);
         }
      }
      
      protected function loadWeakGuild() : void
      {
         _vane.visible = !!StateManager.RecordFlag?true:Boolean(PlayerManager.Instance.Self.IsWeakGuildFinish(9));
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(9) && !PlayerManager.Instance.Self.IsWeakGuildFinish(74))
         {
            setTimeout(propOpenShow,2000,"asset.trainer.openVane");
            SocketManager.Instance.out.syncWeakStep(74);
         }
      }
      
      private function isWishGuideLoad() : Boolean
      {
         return true;
      }
      
      private function propOpenShow(param1:String) : void
      {
         var _loc2_:MovieClipWrapper = new MovieClipWrapper(ClassUtils.CreatInstance(param1),true,true);
         LayerManager.Instance.addToLayer(_loc2_.movie,4,false);
      }
      
      protected function newMap() : MapView3D
      {
         if(_map)
         {
            throw new Error(LanguageMgr.GetTranslation("tank.game.mapGenerated"));
         }
         return new MapView3D(_gameInfo,_gameInfo.loaderMap);
      }
      
      private function __soundChange(param1:Event) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         if(SharedManager.Instance.allowSound)
         {
            _loc2_.volume = SharedManager.Instance.soundVolumn / 100;
            this.soundTransform = _loc2_;
            GameDecorateManager.Instance.createBitmapUI(_cs,"asset.gameDecorate.pow");
         }
         else
         {
            _loc2_.volume = 0;
            this.soundTransform = _loc2_;
         }
      }
      
      public function restoreSmallMap() : void
      {
         _map.smallMap.restore();
      }
      
      protected function disposeUI() : void
      {
         GameDecorateManager.Instance.disposeBitmapUI();
         if(_missionHelp)
         {
            ObjectUtils.disposeObject(_missionHelp);
            _missionHelp = null;
         }
         if(_arrowDown)
         {
            _arrowDown.dispose();
         }
         if(_arrowUp)
         {
            _arrowUp.dispose();
         }
         if(_arrowLeft)
         {
            _arrowLeft.dispose();
         }
         if(_arrowRight)
         {
            _arrowRight.dispose();
         }
         _arrowDown = null;
         _arrowLeft = null;
         _arrowRight = null;
         _arrowUp = null;
         ObjectUtils.disposeObject(_achievBar);
         _achievBar = null;
         if(_playerThumbnailLController)
         {
            _playerThumbnailLController.dispose();
         }
         _playerThumbnailLController = null;
         ObjectUtils.disposeObject(_selfUsedProp);
         _selfUsedProp = null;
         if(_leftPlayerView)
         {
            _leftPlayerView.dispose();
         }
         _leftPlayerView = null;
         if(_cs)
         {
            _cs.leaving();
         }
         _cs = null;
         ObjectUtils.disposeObject(_fightControlBar);
         _fightControlBar = null;
         ObjectUtils.disposeObject(_selfMarkBar);
         _selfMarkBar = null;
         if(_selfBuffBar)
         {
            _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL,__selfBuffBarUpdateCellHandler);
         }
         ObjectUtils.disposeObject(_selfBuffBar);
         _selfBuffBar = null;
         if(_vane)
         {
            _vane.dispose();
            _vane = null;
         }
         ObjectUtils.disposeObject(_kingblessIcon);
         _kingblessIcon = null;
         ObjectUtils.disposeObject(_trialBuffIcon);
         _trialBuffIcon = null;
         ObjectUtils.disposeObject(_ringSkillIcon);
         _ringSkillIcon = null;
         ObjectUtils.disposeObject(_guardCoreIcon);
         _guardCoreIcon = null;
         ObjectUtils.disposeObject(_buffIconBox);
         _buffIconBox = null;
         ObjectUtils.disposeObject(_gameCountDownView);
         _gameCountDownView = null;
         if(_damageView)
         {
            _damageView.dispose();
            _damageView = null;
         }
         ObjectUtils.disposeObject(_rescueRoomItemView);
         _rescueRoomItemView = null;
         ObjectUtils.disposeObject(_rescueScoreView);
         _rescueScoreView = null;
         ObjectUtils.disposeObject(_weatherView);
         _weatherView = null;
         if(_messageBtn)
         {
            _messageBtn.removeEventListener("click",__onMessageClick);
            ObjectUtils.disposeObject(_messageBtn);
            _messageBtn = null;
         }
         ObjectUtils.disposeObject(_sceneEffectsBar);
         _sceneEffectsBar = null;
         if(map)
         {
            map.clearSceneEffectLayer();
         }
         BallManager.clearSceneEffectMovieBone();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         dispose();
         ParticleRender.Instance.turnOff();
      }
      
      override public function dispose() : void
      {
         disposeUI();
         removeEvent();
         removeGameData();
         ObjectUtils.disposeObject(_bitmapMgr);
         _bitmapMgr = null;
         if(_map != null)
         {
            _map.smallMap.titleBar.removeEventListener("DungeonHelpChanged",__dungeonVisibleChanged);
            StarlingObjectUtils.disposeObject(_map);
            _map = null;
         }
         PlayerInfoViewControl.clearView();
         LayerManager.Instance.clearnGameDynamic();
         SharedManager.Instance.removeEventListener("change",__soundChange);
         ObjectUtils.disposeObject(_missionHelp);
         _missionHelp = null;
         if(GameControl.Instance.Current != null)
         {
            GameControl.Instance.Current.selfGamePlayer.removeEventListener("die",__selfDie);
         }
         IMEManager.enable();
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         MenoryUtil.clearMenory();
         if(_barrier)
         {
            _barrier.removeEventListener("DungeonHelpVisibleChanged",__dungeonHelpChanged);
            _barrier.removeEventListener("updateSmallMapView",__updateSmallMapView);
            ObjectUtils.disposeObject(_barrier);
            _barrier = null;
         }
         ObjectUtils.disposeObject(_drawRoute);
         _drawRoute = null;
         _self = null;
         _selfGameLiving = null;
         _allLivings = null;
         _gameLiving = null;
         ObjectUtils.disposeObject(_gameTrusteeshipView);
         _gameTrusteeshipView = null;
         if(_heroAutoView)
         {
            ObjectUtils.disposeObject(_heroAutoView);
         }
         _heroAutoView = null;
         ObjectUtils.disposeAllChildren(_mapSprite);
         if(_mapSprite.parent)
         {
            _mapSprite.parent.removeChild(_mapSprite);
         }
         _mapSprite = null;
         WorldBossManager.Instance.isLoadingState = false;
         SocketManager.Instance.removeEventListener("RescueItemInfo",__updateRescueItemInfo);
         SocketManager.Instance.removeEventListener("addScore",__addRescueScore);
         GameControl.Instance.removeEventListener("addringanamition",__onAddRingAnimation);
         GameControl.Instance.removeEventListener("addguardcoreeffect",__onAddGuardCoreAnimation);
         if(_selfBuffBar)
         {
            _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL,__selfBuffBarUpdateCellHandler);
         }
      }
      
      protected function setupGameData() : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:Array = [];
         var _loc7_:Boolean = false;
         var _loc13_:int = 0;
         var _loc12_:* = _gameInfo.livings;
         for each(var _loc9_ in _gameInfo.livings)
         {
            if(_loc9_ is Player)
            {
               _loc2_ = _loc9_ as Player;
               _loc1_ = RoomManager.Instance.current.findPlayerByID(_loc2_.playerInfo.ID);
               if(!_loc2_.movie)
               {
                  _loc3_ = CharactoryFactory.createCharacter(_loc2_.playerInfo,"game3d");
                  _loc3_.show();
                  _loc2_.movie = GameCharacter3D(_loc3_);
               }
               if(!_loc2_.character)
               {
                  _loc8_ = CharactoryFactory.createCharacter(_loc2_.playerInfo,"show");
                  ShowCharacter(_loc8_).show();
                  _loc2_.character = ShowCharacter(_loc8_);
               }
               if(_loc2_.isSelf)
               {
                  _loc6_ = new GameLocalPlayer3D(_gameInfo.selfGamePlayer,_loc2_.character as ShowCharacter,_loc2_.movie as GameCharacter3D,_loc2_.templeId);
                  _selfGamePlayer = _loc6_ as GameLocalPlayer3D;
               }
               else
               {
                  _loc6_ = new GamePlayer3D(_loc2_,_loc2_.character as ShowCharacter,_loc2_.movie as GameCharacter3D,_loc2_.templeId);
               }
               if(_loc2_.movie)
               {
                  _loc2_.movie.setDefaultAction(_loc2_.movie.standAction);
                  _loc2_.movie.doAction(_loc2_.movie.standAction);
               }
               var _loc11_:int = 0;
               var _loc10_:* = _loc2_.outProperty;
               for(var _loc5_ in _loc2_.outProperty)
               {
                  setProperty(_loc6_,_loc5_,_loc2_.outProperty[_loc5_]);
               }
               _loc4_.push(_loc6_);
               _map.addPhysical(_loc6_);
               _players[_loc9_] = _loc6_;
               if(!_loc7_)
               {
                  _loc7_ = _loc2_.ringFlag;
               }
            }
         }
         _map.wind = GameControl.Instance.Current.wind;
         _map.currentTurn = 1;
         _vane.initialize();
         _vane.update(_map.wind);
         _map.act(new ViewEachPlayerAction(_map,_loc4_,!!_loc7_?2000:Number(1500)));
      }
      
      protected function __onAddRingAnimation(param1:GameEvent) : void
      {
         var _loc2_:GamePlayer3D = param1.data as GamePlayer3D;
         _loc2_.playRingSkill();
      }
      
      protected function __onAddGuardCoreAnimation(param1:GameEvent) : void
      {
         var _loc2_:GamePlayer3D = param1.data as GamePlayer3D;
         _loc2_.playGuardCoreEffect();
      }
      
      protected function setProperty(param1:GameLiving3D, param2:String, param3:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:* = null;
         var _loc7_:StringObject = new StringObject(param3);
         var _loc8_:* = param2;
         if("system" !== _loc8_)
         {
            if("systemII" !== _loc8_)
            {
               if("propzxc" !== _loc8_)
               {
                  if("zxc" !== _loc8_)
                  {
                     if("silencedSpecial" !== _loc8_)
                     {
                        if("silenced" !== _loc8_)
                        {
                           if("nofly" !== _loc8_)
                           {
                              if("silenceMany" !== _loc8_)
                              {
                                 if("hideBossThumbnail" !== _loc8_)
                                 {
                                    if("energy" !== _loc8_)
                                    {
                                       if("energy2" !== _loc8_)
                                       {
                                          param1.setProperty(param2,param3);
                                       }
                                       else if(param1)
                                       {
                                          param1.info.energy = _loc7_.getNumber();
                                       }
                                    }
                                    else if(param1)
                                    {
                                       param1.info.maxEnergy = _loc7_.getNumber();
                                       param1.info.energy = _loc7_.getNumber();
                                    }
                                 }
                                 else if(param1)
                                 {
                                    _playerThumbnailLController.removeThumbnailContainer();
                                 }
                              }
                              else
                              {
                                 _loc4_ = 1;
                                 _loc5_ = _loc7_.getBoolean();
                                 _loc6_ = param1.info;
                                 if(_loc5_)
                                 {
                                    _loc6_.addBuff(BuffManager.creatBuff(1000));
                                 }
                                 else
                                 {
                                    _loc6_.removeBuff(1000);
                                 }
                                 if(param1.info.isSelf)
                                 {
                                    GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = _loc5_;
                                    GameControl.Instance.Current.selfGamePlayer.lockFly = _loc5_;
                                    GameControl.Instance.Current.selfGamePlayer.lockRightProp = _loc5_;
                                 }
                              }
                           }
                           else
                           {
                              _loc4_ = 4;
                              _loc5_ = _loc7_.getBoolean();
                              _loc6_ = param1.info;
                              _loc6_.LockType = _loc4_;
                              if(param1.info.isSelf)
                              {
                                 GameControl.Instance.Current.selfGamePlayer.lockFly = _loc5_;
                              }
                           }
                        }
                        else if(param1)
                        {
                           _loc4_ = 1;
                           _loc5_ = _loc7_.getBoolean();
                           _loc6_ = param1.info;
                           _loc6_.LockType = _loc4_;
                           _loc6_.LockState = _loc5_;
                           if(param1.info.isSelf)
                           {
                              GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !_loc5_;
                              GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !_loc5_;
                              GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = _loc5_;
                           }
                        }
                     }
                     else if(param1)
                     {
                        _loc4_ = 3;
                        _loc5_ = _loc7_.getBoolean();
                        _loc6_ = param1.info;
                        _loc6_.LockType = _loc4_;
                        _loc6_.LockState = _loc5_;
                        if(param1.info.isSelf)
                        {
                           if(RoomManager.Instance.current.type != 21)
                           {
                              GameControl.Instance.Current.selfGamePlayer.lockFly = _loc5_;
                           }
                           GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = _loc5_;
                           GameControl.Instance.Current.selfGamePlayer.lockSpellKill = _loc5_;
                           GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !_loc5_;
                           GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !_loc5_;
                        }
                     }
                  }
                  else if(param1)
                  {
                     _loc4_ = 0;
                     _loc5_ = _loc7_.getBoolean();
                     _loc6_ = param1.info;
                     _loc6_.LockType = _loc4_;
                     if(param1.info.isSelf)
                     {
                        GameControl.Instance.Current.selfGamePlayer.customPropEnabled = _loc5_;
                     }
                  }
               }
               else if(param1)
               {
                  _loc4_ = 3;
                  _loc5_ = _loc7_.getBoolean();
                  _loc6_ = param1.info;
                  _loc6_.LockType = _loc4_;
                  _loc6_.LockState = _loc5_;
                  if(param1.info.isSelf)
                  {
                     GameControl.Instance.Current.selfGamePlayer.customPropEnabled = _loc5_;
                  }
               }
            }
            else if(param1)
            {
               _loc4_ = 0;
               _loc5_ = _loc7_.getBoolean();
               _loc6_ = param1.info;
               if(param1.info.isSelf)
               {
                  GameControl.Instance.Current.selfGamePlayer.lockFly = _loc5_;
                  GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = _loc5_;
                  GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = !_loc5_;
               }
            }
         }
         else if(param1)
         {
            _loc4_ = 0;
            _loc5_ = _loc7_.getBoolean();
            _loc6_ = param1.info;
            _loc6_.LockType = _loc4_;
            _loc6_.LockState = _loc5_;
            if(param1.info.isSelf)
            {
               GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = _loc5_;
               GameControl.Instance.Current.selfGamePlayer.lockFly = _loc5_;
               GameControl.Instance.Current.selfGamePlayer.lockSpellKill = _loc5_;
               GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !_loc5_;
               GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !_loc5_;
               GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = !_loc5_;
            }
         }
      }
      
      private function initDiePlayer() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _gameInfo.livings;
         for each(var _loc1_ in _gameInfo.livings)
         {
            if(_loc1_.blood <= 0)
            {
               _loc1_.reset();
               _loc1_.die(true);
               if(_gameTrusteeshipView)
               {
                  _gameTrusteeshipView.visible = false;
               }
            }
         }
      }
      
      private function removeGameData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var _loc1_ in _players)
         {
            StarlingObjectUtils.removeChildAllChildren(_loc1_,false);
            StarlingObjectUtils.disposeObject(_loc1_);
         }
         _players.clear();
         _players = null;
         _selfGamePlayer = null;
         _gameInfo = null;
         _barrierVisible = true;
      }
      
      public function addLiving(param1:Living) : void
      {
      }
      
      private function updatePlayerState(param1:Living) : void
      {
         if(_selfUsedProp == null)
         {
            _selfUsedProp = new PlayerStateContainer(12);
            PositionUtils.setPos(_selfUsedProp,"asset.game.selfUsedProp");
            addChild(_selfUsedProp);
         }
         if(_selfUsedProp)
         {
            _selfUsedProp.disposeAllChildren();
         }
         var _loc2_:int = 0;
         if(_selfUsedProp)
         {
            if(_selfBuffBar && _selfBuffBar.visible)
            {
               _loc2_ = _loc2_ + _selfBuffBar.right;
            }
            if(_buffIconBox && _buffIconBox.visible)
            {
               _loc2_ = _loc2_ + _buffIconBox.width;
            }
            _selfUsedProp.x = _loc2_;
         }
         if(param1 is TurnedLiving)
         {
            _selfUsedProp.info = TurnedLiving(param1);
         }
         if(GameControl.Instance.Current.selfGamePlayer.isAutoGuide && GameControl.Instance.Current.currentLiving.LivingID == GameControl.Instance.Current.selfGamePlayer.LivingID)
         {
            GameMessageTipManager.getInstance().show(String(GameControl.Instance.Current.selfGamePlayer.LivingID),3);
         }
      }
      
      public function setCurrentPlayer(param1:Living) : void
      {
         if(param1 && param1.isSelf && param1.isLiving)
         {
            if(_buffIconBox)
            {
               _buffIconBox.visible = true;
            }
            if(_selfBuffBar)
            {
               _selfBuffBar.propertyWaterBuffBarVisible = true;
            }
            updateGuardCoreIcon();
         }
         else
         {
            if(_buffIconBox)
            {
               _buffIconBox.visible = false;
            }
            if(_selfBuffBar)
            {
               _selfBuffBar.propertyWaterBuffBarVisible = false;
            }
         }
         if(_selfBuffBar)
         {
            if(_self.isLiving)
            {
               if(!BombKingManager.instance.Recording && !RoomManager.Instance.current.selfRoomPlayer.isViewer && param1 && _selfBuffBar)
               {
                  _selfBuffBar.drawBuff(param1);
               }
               addChildAt(_selfBuffBar,this.numChildren - 1);
            }
            else if(_selfBuffBar.parent)
            {
               _selfBuffBar.parent.removeChild(_selfBuffBar);
            }
         }
         updateBuffIconBoxPos();
         if(_leftPlayerView)
         {
            _leftPlayerView.info = param1;
         }
         _map.bringToFront(param1);
         if(_map.currentPlayer && !(param1 is TurnedLiving))
         {
            _map.currentPlayer.isAttacking = false;
            _map.currentPlayer = null;
         }
         else
         {
            _map.currentPlayer = param1 as TurnedLiving;
         }
         updatePlayerState(param1);
         if(_leftPlayerView)
         {
            addChildAt(_leftPlayerView,this.numChildren - 3);
         }
         var _loc2_:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
         if(_map.currentPlayer)
         {
            if(_loc2_)
            {
               _loc2_.soulPropEnabled = !_loc2_.isLiving && _map.currentPlayer.team == _loc2_.team;
            }
         }
         else if(_loc2_)
         {
            _loc2_.soulPropEnabled = false;
         }
      }
      
      private function updateBuffIconBoxPos() : void
      {
         if(_buffIconBox && _buffIconBox.visible)
         {
            if(_selfBuffBar && _selfBuffBar.visible)
            {
               _buffIconBox.x = _selfBuffBar.right + 30;
            }
            else
            {
               PositionUtils.setPos(_buffIconBox,"game.kingbless.addPropertyBuffIconPos2");
            }
         }
      }
      
      public function updateControlBarState(param1:Living) : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(GameControl.Instance.Current.selfGamePlayer.LockState)
         {
            setPropBarClickEnable(false,true);
            return;
         }
         if(param1 is TurnedLiving && param1.isLiving && GameControl.Instance.Current.selfGamePlayer.canUseProp(param1 as TurnedLiving))
         {
            setPropBarClickEnable(true,false);
         }
         else if(param1)
         {
            if(!(!GameControl.Instance.Current.selfGamePlayer.isLiving && param1.isSelf))
            {
               if(!(!GameControl.Instance.Current.selfGamePlayer.isLiving && GameControl.Instance.Current.selfGamePlayer.team != param1.team))
               {
                  setPropBarClickEnable(true,false);
               }
            }
         }
         else
         {
            setPropBarClickEnable(true,false);
         }
      }
      
      protected function setPropBarClickEnable(param1:Boolean, param2:Boolean) : void
      {
         GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = param1;
         if(RoomManager.Instance.current.type != 24)
         {
            GameControl.Instance.Current.selfGamePlayer.customPropEnabled = param1;
         }
      }
      
      protected function gameOver() : void
      {
         _map.smallMap.enableExit = false;
         if(!NewHandGuideManager.Instance.isNewHandFB())
         {
            SoundManager.instance.stopMusic();
         }
         else
         {
            SoundManager.instance.setMusicVolumeByRatio(0.5);
         }
         setPropBarClickEnable(false,false);
         _leftPlayerView.gameOver();
         _leftPlayerView.visible = false;
         if(_selfMarkBar)
         {
            _selfMarkBar.shutdown();
         }
         if(NoviceDataManager.instance.firstEnterGame)
         {
            NoviceDataManager.instance.firstEnterGame = false;
            NoviceDataManager.instance.saveNoviceData(540,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      protected function set barrierInfo(param1:CrazyTankSocketEvent) : void
      {
         if(_barrier)
         {
            _barrier.barrierInfoHandler(param1);
         }
      }
      
      protected function set arrowHammerEnable(param1:Boolean) : void
      {
      }
      
      public function blockHammer() : void
      {
      }
      
      public function allowHammer() : void
      {
      }
      
      protected function defaultForbidDragFocus() : void
      {
      }
      
      protected function setBarrierVisible(param1:Boolean) : void
      {
         _barrierVisible = param1;
      }
      
      protected function setVaneVisible(param1:Boolean) : void
      {
         _vane.visible = param1;
      }
      
      protected function setPlayerThumbVisible(param1:Boolean) : void
      {
         _playerThumbnailLController.visible = param1;
      }
      
      protected function setEnergyVisible(param1:Boolean) : void
      {
         var _loc2_:LiveState = _cs as LiveState;
         if(_loc2_)
         {
            _loc2_.setEnergyVisible(param1);
         }
      }
      
      public function setRecordRotation() : void
      {
      }
      
      public function get map() : *
      {
         return _map;
      }
      
      public function get mapSprite() : Sprite
      {
         return _mapSprite;
      }
      
      protected function set mapWind(param1:Number) : void
      {
         _mapWind = param1;
         if(_useAble)
         {
            showShoot();
         }
      }
      
      public function get currentLivID() : int
      {
         return _currentLivID;
      }
      
      public function set currentLivID(param1:int) : void
      {
         _currentLivID = param1;
         showFightPower();
         drawRouteLine(_currentLivID);
         if(_map)
         {
            _map.smallMap.drawRouteLine(_currentLivID);
         }
      }
      
      private function showFightPower() : void
      {
         var _loc1_:* = null;
         if(_currentLivID != -1 && _allLivings[_currentLivID])
         {
            _loc1_ = _allLivings[_currentLivID] as Living;
            _selfGameLiving.setFightPower(_loc1_.fightPower);
            _self.fightPower = _loc1_.fightPower;
         }
      }
      
      private function wishInit() : void
      {
         _self = GameControl.Instance.Current.selfGamePlayer;
         _selfGameLiving = _map.getPhysical(_self.LivingID) as GamePlayer3D;
         _allLivings = GameControl.Instance.Current.livings;
         _drawRoute = new Sprite();
         _mapSprite.addChild(_drawRoute);
         currentLivID = -1;
         _gameInfo.livings.addEventListener("add",addPlayerHander);
         _self.addEventListener("gunangleChanged",__changeAngle);
         _self.addEventListener("posChanged",__changeAngle);
         _self.addEventListener("dirChanged",__changeAngle);
         SocketManager.Instance.addEventListener("wishofdd",__wishofdd);
         SocketManager.Instance.addEventListener("playerChange",__playerChange);
         RoomManager.Instance.addEventListener("PlayerRoomExit",__playerExit);
         KeyboardManager.getInstance().addEventListener("keyDown",__KeyDown);
         SocketManager.Instance.addEventListener("RescueKingBless",__useRescueKingBless);
      }
      
      public function updaet() : void
      {
         if(!IMManager.Instance.privateChatFocus)
         {
            if(ChatManager.Instance.input.parent == null)
            {
               if(IME.enabled)
               {
                  IMEManager.disable();
               }
               if(stage && stage.focus == null)
               {
                  stage.focus = this;
               }
            }
            if(StageReferance.stage.focus is TextField && TextField(StageReferance.stage.focus).type == "input")
            {
               if(!IME.enabled)
               {
                  IMEManager.enable();
               }
            }
            else if(IME.enabled)
            {
               IMEManager.disable();
            }
         }
         else if(!IME.enabled)
         {
            IMEManager.enable();
         }
      }
      
      private function __mouseClick(param1:MouseEvent) : void
      {
         stage.focus = this;
         if(ChatManager.Instance.input.parent && !NewHandGuideManager.Instance.isNewHandFB())
         {
            SoundManager.instance.play("008");
            ChatManager.Instance.switchVisible();
         }
      }
      
      private function removeEvent() : void
      {
         if(_self != null)
         {
            _self.removeEventListener("gunangleChanged",__changeAngle);
            _self.removeEventListener("posChanged",__changeAngle);
            _self.removeEventListener("dirChanged",__changeAngle);
         }
         if(_gameInfo != null)
         {
            _gameInfo.livings.removeEventListener("add",addPlayerHander);
         }
         SocketManager.Instance.removeEventListener("wishofdd",__wishofdd);
         SocketManager.Instance.removeEventListener("playerChange",__playerChange);
         RoomManager.Instance.removeEventListener("PlayerRoomExit",__playerExit);
         KeyboardManager.getInstance().removeEventListener("keyDown",__KeyDown);
         SocketManager.Instance.removeEventListener("RescueKingBless",__useRescueKingBless);
         removeEventListener("click",__mouseClick);
      }
      
      private function __useRescueKingBless(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc5_.readBoolean();
         if(_loc2_)
         {
            _loc6_ = _loc5_.readInt();
            _loc3_ = _loc5_.readInt();
            _loc4_ = _loc5_.readInt() / 100;
            _mapWind = _loc6_ * _loc4_ / 10 * _windFactor;
            _useAble = true;
            showShoot();
         }
      }
      
      protected function __KeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1.keyCode == KeyStroke.VK_V.getCode())
         {
            var _loc6_:int = 0;
            var _loc5_:* = _allLivings;
            for each(var _loc3_ in _allLivings)
            {
               if(!(_loc3_.isHidden || _loc3_.team == GameControl.Instance.Current.selfGamePlayer.team || !_loc3_.isLiving || _loc3_.LivingID == _self.LivingID))
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_ = 0;
            while(_loc4_ <= _loc2_.length - 1)
            {
               if((_loc2_[_loc4_] as Living).LivingID == currentLivID)
               {
                  if(_loc4_ >= _loc2_.length - 1)
                  {
                     _loc4_ = 0;
                  }
                  else
                  {
                     _loc4_++;
                  }
                  break;
               }
               _loc4_++;
            }
            if(_loc4_ <= _loc2_.length - 1)
            {
               currentLivID = _loc2_[_loc4_].LivingID;
            }
         }
      }
      
      protected function showShoot() : void
      {
         var _loc7_:* = null;
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc3_:Point = _selfGameLiving.body.localToGlobal(new Point(30,-20));
         _loc3_ = _map.globalToLocal(_loc3_);
         _shootAngle = _self.calcBombAngle();
         _arf = _map.airResistance;
         _gf = _map.gravity * _mass * _gravityFactor;
         _ga = _gf / _mass;
         _wa = _mapWind / _mass;
         var _loc9_:int = 0;
         var _loc8_:* = _allLivings;
         for each(var _loc6_ in _allLivings)
         {
            _loc6_.route = null;
            if(!(_loc6_.isHidden || _loc6_.team == GameControl.Instance.Current.selfGamePlayer.team || !_loc6_.isLiving || _loc6_.LivingID == _self.LivingID))
            {
               _loc7_ = _loc6_.pos;
               if(_self.isLiving && _self.isAttacking)
               {
                  _loc6_.route = null;
                  _loc4_ = true;
                  _loc5_ = true;
                  if(_loc3_.x > _loc7_.x)
                  {
                     _loc4_ = false;
                  }
                  if(_loc3_.y > _loc7_.y)
                  {
                     _loc5_ = false;
                  }
                  if(judgeMaxPower(_loc3_,_loc7_,_shootAngle,_loc4_,_loc5_))
                  {
                     _loc2_ = getPower(0,2000,_loc3_,_loc7_,_shootAngle,_loc4_,_loc5_);
                  }
                  else
                  {
                     _loc2_ = 2100;
                  }
                  _stateFlag = 0;
                  if(_loc2_ > 2000)
                  {
                     if(_loc6_.state)
                     {
                        _stateFlag = 1;
                     }
                     else
                     {
                        _stateFlag = 2;
                     }
                     _loc6_.state = false;
                  }
                  else
                  {
                     if(_loc6_.state)
                     {
                        _stateFlag = 3;
                     }
                     else
                     {
                        _stateFlag = 4;
                     }
                     _loc6_.state = true;
                  }
                  _gameLiving = _map.getPhysical(_loc6_.LivingID) as GameLiving3D;
                  if(_stateFlag == 1 || _stateFlag == 2)
                  {
                     _loc6_.route = null;
                  }
                  else
                  {
                     _loc6_.route = getRouteData(_loc2_,_shootAngle,_loc3_,_loc7_);
                  }
                  _loc6_.fightPower = Number((_loc2_ * 100 / 2000).toFixed(1));
               }
            }
         }
         if(currentLivID == -1 || !_allLivings[currentLivID].route)
         {
            currentLivID = calculateRecent();
         }
         else
         {
            currentLivID = currentLivID;
         }
      }
      
      protected function judgeMaxPower(param1:Point, param2:Point, param3:Number, param4:Boolean, param5:Boolean) : Boolean
      {
         var _loc10_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         _loc7_ = 2000 * Math.cos(param3 / 180 * 3.14159265358979);
         _loc10_ = new EulerVector(param1.x,_loc7_,_wa);
         _loc6_ = 2000 * Math.sin(param3 / 180 * 3.14159265358979);
         _loc8_ = new EulerVector(param1.y,_loc6_,_ga);
         var _loc9_:Boolean = false;
         while(true)
         {
            if(param4)
            {
               if(_loc10_.x0 > _map.bound.width)
               {
                  return true;
               }
               if(_loc10_.x0 < _map.bound.x || _loc8_.x0 > _map.bound.height)
               {
                  return false;
               }
            }
            else
            {
               if(_loc10_.x0 < _map.bound.x)
               {
                  break;
               }
               if(_loc10_.x0 > _map.bound.width || _loc8_.x0 > _map.bound.height)
               {
                  return false;
               }
            }
            if(ifHit(_loc10_.x0,_loc8_.x0,param2))
            {
               return true;
            }
            _loc10_.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
            _loc8_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(param4 && param5)
            {
               if(_loc8_.x0 > param2.y)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return false;
                  }
                  return true;
               }
            }
            else if(param4 && !param5)
            {
               if(!_loc9_)
               {
                  if(_loc10_.x0 > param2.x)
                  {
                     return false;
                  }
                  if(_loc8_.x0 < param2.y)
                  {
                     _loc9_ = true;
                  }
               }
               else if(_loc9_)
               {
                  if(_loc8_.x0 > param2.y)
                  {
                     if(_loc10_.x0 < param2.x)
                     {
                        return false;
                     }
                     return true;
                  }
               }
            }
            else if(!param4 && !param5)
            {
               if(!_loc9_)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return false;
                  }
                  if(_loc8_.x0 < param2.y)
                  {
                     _loc9_ = true;
                  }
               }
               else if(_loc9_)
               {
                  if(_loc8_.x0 > param2.y)
                  {
                     if(_loc10_.x0 < param2.x)
                     {
                        return true;
                     }
                     return false;
                  }
               }
            }
            else if(!param4 && param5)
            {
               if(_loc8_.x0 > param2.y)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return true;
                  }
                  return false;
               }
            }
         }
         return true;
      }
      
      protected function getPower(param1:Number, param2:Number, param3:Point, param4:Point, param5:Number, param6:Boolean, param7:Boolean) : Number
      {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = (param1 + param2) / 2;
         if(_loc12_ <= param1 || _loc12_ >= param2)
         {
            return _loc12_;
         }
         _loc11_ = _loc12_ * Math.cos(param5 / 180 * 3.14159265358979);
         _loc9_ = new EulerVector(param3.x,_loc11_,_wa);
         _loc10_ = _loc12_ * Math.sin(param5 / 180 * 3.14159265358979);
         _loc8_ = new EulerVector(param3.y,_loc10_,_ga);
         var _loc13_:Boolean = false;
         while(true)
         {
            if(param6)
            {
               if(_loc9_.x0 > _map.bound.width)
               {
                  _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc8_.x0 > _map.bound.height)
               {
                  _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc9_.x0 < _map.bound.x)
               {
                  _loc12_ = 2100;
                  return 2100;
               }
            }
            else
            {
               if(_loc9_.x0 < _map.bound.x)
               {
                  _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc8_.x0 > _map.bound.height)
               {
                  _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc9_.x0 > _map.bound.width)
               {
                  _loc12_ = 2100;
                  return 2100;
               }
            }
            if(ifHit(_loc9_.x0,_loc8_.x0,param4))
            {
               return _loc12_;
            }
            _loc9_.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
            _loc8_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(param6 && param7)
            {
               if(_loc8_.x0 > param4.y)
               {
                  if(_loc9_.x0 < param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  }
                  else
                  {
                     _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  }
                  break;
               }
            }
            else if(param6 && !param7)
            {
               if(!_loc13_)
               {
                  if(_loc9_.x0 > param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     break;
                  }
                  if(_loc8_.x0 < param4.y)
                  {
                     _loc13_ = true;
                  }
               }
               else if(_loc13_)
               {
                  if(_loc8_.x0 > param4.y)
                  {
                     if(_loc9_.x0 < param4.x)
                     {
                        _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     }
                     else
                     {
                        _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                     }
                     break;
                  }
               }
            }
            else if(!param6 && !param7)
            {
               if(!_loc13_)
               {
                  if(_loc9_.x0 < param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     break;
                  }
                  if(_loc8_.x0 < param4.y)
                  {
                     _loc13_ = true;
                  }
               }
               else if(_loc13_)
               {
                  if(_loc8_.x0 > param4.y)
                  {
                     if(_loc9_.x0 > param4.x)
                     {
                        _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     }
                     else
                     {
                        _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                     }
                     break;
                  }
               }
            }
            else if(!param6 && param7)
            {
               if(_loc8_.x0 > param4.y)
               {
                  if(_loc9_.x0 > param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  }
                  else
                  {
                     _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  }
                  break;
               }
            }
         }
         return _loc12_;
      }
      
      protected function ifHit(param1:Number, param2:Number, param3:Point) : Boolean
      {
         if(param1 > param3.x - 15 && param1 < param3.x + 20 && param2 > param3.y - 20 && param2 < param3.y + 30)
         {
            return true;
         }
         return false;
      }
      
      private function isOutOfMap(param1:EulerVector, param2:EulerVector) : Boolean
      {
         if(param1.x0 < _map.bound.x || param1.x0 > _map.bound.width || param2.x0 > _map.bound.height)
         {
            return true;
         }
         return false;
      }
      
      private function drawRouteLine(param1:int) : void
      {
         var _loc6_:int = 0;
         _drawRoute.graphics.clear();
         var _loc8_:int = 0;
         var _loc7_:* = _allLivings;
         for each(var _loc5_ in _allLivings)
         {
            _loc5_.currentSelectId = param1;
         }
         if(param1 < 0)
         {
            return;
         }
         var _loc4_:Living = _allLivings[param1];
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:Vector.<Point> = _loc4_.route;
         if(!_loc3_ || _loc3_.length == 0)
         {
            return;
         }
         _collideRect.x = _loc4_.pos.x - 50;
         _collideRect.y = _loc4_.pos.y - 50;
         _drawRoute.graphics.lineStyle(2,16711680,0.5);
         var _loc2_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_ - 1)
         {
            drawDashed(_drawRoute.graphics,_loc3_[_loc6_],_loc3_[_loc6_ + 1],8,5);
            _loc6_++;
         }
      }
      
      private function getRouteData(param1:Number, param2:Number, param3:Point, param4:Point) : Vector.<Point>
      {
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param1 > 2000)
         {
            return null;
         }
         _loc6_ = param1 * Math.cos(param2 / 180 * 3.14159265358979);
         _loc9_ = new EulerVector(param3.x,_loc6_,_wa);
         _loc5_ = param1 * Math.sin(param2 / 180 * 3.14159265358979);
         _loc7_ = new EulerVector(param3.y,_loc5_,_ga);
         var _loc8_:Vector.<Point> = new Vector.<Point>();
         _loc8_.push(new Point(param3.x,param3.y));
         while(!isOutOfMap(_loc9_,_loc7_))
         {
            if(ifHit(_loc9_.x0,_loc7_.x0,param4))
            {
               return _loc8_;
            }
            _loc9_.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
            _loc7_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            _loc8_.push(new Point(_loc9_.x0,_loc7_.x0));
         }
         return _loc8_;
      }
      
      public function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void
      {
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!param1 || !param2 || !param3 || param4 <= 0 || param5 <= 0)
         {
            return;
         }
         var _loc8_:Number = param2.x;
         var _loc10_:Number = param2.y;
         var _loc12_:Number = Math.atan2(param3.y - _loc10_,param3.x - _loc8_);
         var _loc7_:Number = Point.distance(param2,param3);
         trace("big map :" + _loc7_);
         var _loc6_:* = 0;
         while(_loc6_ <= _loc7_)
         {
            if(_collideRect.contains(_loc11_,_loc9_))
            {
               return;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.moveTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param4);
            if(_loc6_ > _loc7_)
            {
               _loc6_ = _loc7_;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.lineTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param5);
         }
      }
      
      private function drawArrow(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:int) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(!param2 || !param3 || !param4 || param5 <= 0)
         {
            return;
         }
         var _loc8_:Number = Math.atan2(param3.y - param2.y,param3.x - param2.x);
         param4 = param4 * 3.14159265358979 / 180;
         param1.moveTo(param3.x,param3.y);
         _loc7_ = param3.x + Math.cos(_loc8_ + param4) * param5;
         _loc6_ = param3.y + Math.sin(_loc8_ + param4) * param5;
         param1.lineTo(_loc7_,_loc6_);
         param1.moveTo(param3.x,param3.y);
         _loc7_ = param3.x + Math.cos(_loc8_ - param4) * param5;
         _loc6_ = param3.y + Math.sin(_loc8_ - param4) * param5;
         param1.lineTo(_loc7_,_loc6_);
      }
      
      protected function __playerChange(param1:CrazyTankSocketEvent) : void
      {
         _drawRoute.graphics.clear();
         _useAble = false;
         currentLivID = -1;
         var _loc4_:int = 0;
         var _loc3_:* = _allLivings;
         for each(var _loc2_ in _allLivings)
         {
            _loc2_.state = false;
         }
      }
      
      private function __playerExit(param1:Event) : void
      {
         if(_useAble)
         {
            currentLivID = calculateRecent();
         }
      }
      
      protected function __changeAngle(param1:LivingEvent) : void
      {
         if(_useAble)
         {
            showShoot();
         }
      }
      
      protected function __wishofdd(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:Number = NaN;
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            _loc6_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt() / 100;
            _mapWind = _loc6_ * _loc4_ / 10 * _windFactor;
            _useAble = true;
            showShoot();
         }
         else
         {
            _loc5_ = param1.pkg.readInt();
            _useAble = false;
         }
      }
      
      private function __thumbnailControlHandle(param1:GameEvent) : void
      {
         currentLivID = param1.data as int;
      }
      
      private function calculateRecent() : int
      {
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = 2147483647;
         var _loc1_:int = -1;
         var _loc8_:int = 0;
         var _loc7_:* = _allLivings;
         for each(var _loc6_ in _allLivings)
         {
            if(_loc6_.route)
            {
               if(RoomManager.Instance.current.type == 29 || !(_loc6_ is SmallEnemy))
               {
                  _loc3_ = _loc6_.route;
                  _loc5_ = _loc3_.length;
                  if(_loc5_ >= 2)
                  {
                     _loc4_ = getDistance(_loc3_[0],_loc3_[_loc5_ - 1]);
                     if(_loc4_ < _loc2_)
                     {
                        _loc2_ = _loc4_;
                        _loc1_ = _loc6_.LivingID;
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getDistance(param1:Point, param2:Point) : int
      {
         return (param2.x - param1.x) * (param2.x - param1.x) + (param2.y - param1.y) * (param2.y - param1.y);
      }
      
      public function get barrier() : DungeonInfoView
      {
         return _barrier;
      }
      
      public function get messageBtn() : BaseButton
      {
         return _messageBtn;
      }
   }
}
