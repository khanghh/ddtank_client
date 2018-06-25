package game.view
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
    import com.pickgliss.ui.text.FilterFrameText;
    import com.pickgliss.utils.ClassUtils;
    import com.pickgliss.utils.ObjectUtils;

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
    import ddt.view.character.GameCharacter;
    import ddt.view.character.ICharacter;
    import ddt.view.character.ShowCharacter;
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
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;

    import game.GameDecorateManager;
    import game.actions.ViewEachPlayerAction;
    import game.objects.GameLiving;
    import game.objects.GameLocalPlayer;
    import game.objects.GamePlayer;
    import game.view.heroAuto.HeroAutoView;
    import game.view.map.MapView;

    import gameCommon.BloodNumberCreater;
    import gameCommon.BuffManager;
    import gameCommon.GameControl;
    import gameCommon.GameMessageTipManager;
    import gameCommon.model.GameInfo;
    import gameCommon.model.Living;
    import gameCommon.model.LocalPlayer;
    import gameCommon.model.Player;
    import gameCommon.model.SmallEnemy;
    import gameCommon.model.TurnedLiving;
    import gameCommon.view.AthleticsHelpView;
    import gameCommon.view.DamageView;
    import gameCommon.view.DreamLandDamageLogView;
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

    import kingBless.KingBlessManager;

    import org.aswing.KeyStroke;
    import org.aswing.KeyboardManager;

    import phy.math.EulerVector;

    import pvePowerBuff.PvePowerBuffManager;

    import rescue.data.RescueRoomInfo;

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

    public class GameViewBase extends BaseStateView
    {


        protected var _arrowLeft:SpringArrowView;

        protected var _arrowRight:SpringArrowView;

        protected var _arrowUp:SpringArrowView;

        protected var _arrowDown:SpringArrowView;

        protected var _selfUsedProp:PlayerStateContainer;

        protected var _leftPlayerView:LeftPlayerCartoonView;

        protected var _missionHelp:DungeonHelpView;

        protected var _fightControlBar:FightControlBar;

        protected var _cs:ControlState;

        protected var _vane:VaneView;

        protected var _playerThumbnailLController:PlayerThumbnailController;

        protected var _map:MapView;

        protected var _smallMapBorderBg:Bitmap;

        protected var _players:Dictionary;

        protected var _gameInfo:GameInfo;

        protected var _selfGamePlayer:GameLocalPlayer;

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

        protected var _damageView:DamageView;

        protected var _combatGainsView:DreamLandDamageLogView;

        private var _rescueRoomItemView:RescueRoomItemView;

        protected var _rescueScoreView:RescueScoreAlertView;

        protected var _sceneEffectsBar:SceneEffectsBar;

        private var _messageBtn:BaseButton;

        private var _pirateBall:ChatBallBoss;

        public var explorersLiving:Living;

        private var buffIcon:Image;

        private var buffTxt:FilterFrameText;

        protected var _weatherView:GameWeatherView;

        protected var _barrier:DungeonInfoView;

        private const GUIDEID:int = 10029;

        protected var _barrierVisible:Boolean = true;

        private var _self:LocalPlayer;

        private var _level:int;

        private var _gameLiving:GameLiving;

        private var _selfGameLiving:GamePlayer;

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

        public function GameViewBase()
        {
            _ef = new Point(0, 0);
            _collideRect = new Rectangle(-45, -30, 100, 80);
            super();
        }

        override public function prepare():void
        {
            super.prepare();
        }

        override public function fadingComplete():void
        {
            super.fadingComplete();
            if (_barrierVisible && !PolarRegionManager.Instance.ShowFlag)
            {
                drawMissionInfo();
            }
        }

        override public function enter(prev:BaseStateView, data:Object = null):void
        {
            var pstr:* = null;
            var getD:* = null;
            super.enter(prev, data);
            BloodNumberCreater.setup();
            _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
            SharedManager.Instance.propTransparent = false;
            _gameInfo = GameControl.Instance.Current;
            MainToolBar.Instance.hide();
            LayerManager.Instance.clearnStageDynamic();
            ChatBugleView.instance.hide();
            PlayerManager.Instance.Self.TempBag.clearnAll();
            GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = true;
            var _loc10_:int = 0;
            var _loc9_:* = _gameInfo.livings;
            for each(var player in _gameInfo.livings)
            {
                if (player is Player)
                {
                    Player(player).isUpGrade = false;
                    Player(player).LockState = false;
                }
            }
            _map = newMap();
            _map.gameView = this;
            _loc10_ = 0;
            _map.y = _loc10_;
            _map.x = _loc10_;
            addChild(_map);
            _map.smallMap.x = StageReferance.stageWidth - _map.smallMap.width - 1;
            var exitBool:Boolean = GameControl.EXIT_ROOM_TYPE_ARRAY.indexOf(_gameInfo.roomType) == -1 && GameControl.EXTI_GAME_MODE_ARRAY.indexOf(_gameInfo.gameMode) == -1;
            _map.smallMap.enableExit = !!BombKingManager.instance.Recording ? false : Boolean(exitBool);
            creatWeatherView();
            _smallMapBorderBg = addSmallMapBg();
            if (_smallMapBorderBg)
            {
                _smallMapBorderBg.visible = !GameControl.Instance.smallMapEnable();
            }
            _map.smallMap.visible = !GameControl.Instance.smallMapEnable();
            if (GameControl.Instance.smallMapAlpha())
            {
                _map.smallMap.alpha = 0.8;
            }
            addChild(_map.smallMap);
            _map.smallMap.hideSpliter();
            _selfMarkBar = new SelfMarkBar(GameControl.Instance.Current.selfGamePlayer, this);
            _selfMarkBar.x = 500;
            _selfMarkBar.y = 79;
            _fightControlBar = new FightControlBar(_gameInfo.selfGamePlayer, this);
            GameControl.Instance.Current.selfGamePlayer.addEventListener("die", __selfDie);
            _leftPlayerView = new LeftPlayerCartoonView();
            _vane = new VaneView();
            _vane.setUpCenter(446, 0);
            addChild(_vane);
            SoundManager.instance.playGameBackMusic(_map.info.BackMusic);
            if (RoomManager.Instance.current.type == 120)
            {
                _sceneEffectsBar = new SceneEffectsBar(_map);
                PositionUtils.setPos(_sceneEffectsBar, "asset.gameBattle.sceneEffectsBarPos");
                addChild(_sceneEffectsBar);
            }
            _arrowUp = new SpringArrowView("up", _map);
            _arrowDown = new SpringArrowView("down", _map);
            _arrowLeft = new SpringArrowView("right", _map);
            _arrowRight = new SpringArrowView("left", _map);
            addChild(_arrowUp);
            addChild(_arrowDown);
            addChild(_arrowLeft);
            addChild(_arrowRight);
            _selfBuffBar = ComponentFactory.Instance.creatCustomObject("SelfBuffBar", [this, _arrowDown]);
            if (!GameControl.Instance.Current.missionInfo || !(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI))
            {
                if (GameControl.Instance.isShowSelfBuffBar)
                {
                    addChildAt(_selfBuffBar, this.numChildren - 1);
                }
            }
            if (NoviceDataManager.instance.firstEnterGame && PlayerManager.Instance.Self.Grade < 11)
            {
                NoviceDataManager.instance.saveNoviceData(530, PathManager.userName(), PathManager.solveRequestPath());
            }
            _players = new Dictionary();
            SharedManager.Instance.addEventListener("change", __soundChange);
            __soundChange(null);
            var self:LocalPlayer = _gameInfo.selfGamePlayer;
            if (!BombKingManager.instance.Recording && !RoomManager.Instance.current.selfRoomPlayer.isViewer && self.isLiving)
            {
                _cs = _fightControlBar.setState(0);
                GameDecorateManager.Instance.createBitmapUI(_cs, "asset.gameDecorate.pow");
            }
            setupGameData();
            _playerThumbnailLController = new PlayerThumbnailController(_gameInfo);
            var thumbnailPos:Point = ComponentFactory.Instance.creatCustomObject("asset.game.ThumbnailLPos");
            _playerThumbnailLController.x = thumbnailPos.x;
            _playerThumbnailLController.y = thumbnailPos.y;
            addChildAt(_playerThumbnailLController, getChildIndex(_map.smallMap));
            if (RoomManager.Instance.current.type == 121)
            {
                _vane.x = 564;
            }
            ChatManager.Instance.state = 1;
            ChatManager.Instance.view.visible = true;
            addChild(ChatManager.Instance.view);
            if (WeakGuildManager.Instance.switchUserGuide)
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
            if (isShowTrusteeship())
            {
                _gameTrusteeshipView = ComponentFactory.Instance.creatCustomObject("game.view.gameTrusteeshipView");
                GameDecorateManager.Instance.createBitmapUI(_gameTrusteeshipView, "asset.gameDecorate.trusteeship");
            }
            initDiePlayer();
            if (RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 0)
            {
                buffIcon = ComponentFactory.Instance.creatComponentByStylename("game.buffTips.icon");
                addChild(buffIcon);
                pstr = "00:00";
                if (PvePowerBuffManager.instance.getBuffCount > 0 && PvePowerBuffManager.instance.getBuffDate != null)
                {
                    getD = new Date(PvePowerBuffManager.instance.getBuffDate.getTime() + 60000 * 30);
                    pstr = getD.getMonth() + 1 + " - " + getD.getDate() + " " + getD.getHours() + " : " + getD.getMinutes();
                }
                buffIcon.tipData = LanguageMgr.GetTranslation("ddt.game.signBuff.tips", PlayerManager.Instance.Self.experience_Rate, PlayerManager.Instance.Self.offer_Rate) + "\n" + LanguageMgr.GetTranslation("ddt.pvePowerBuff.buff.timelimit.text", pstr);
                buffTxt = ComponentFactory.Instance.creatComponentByStylename("game.buffTips.levelTxt");
                addChild(buffTxt);
                buffTxt.text = String(Math.ceil(PlayerManager.Instance.Self.experience_Rate));
            }
            if (RoomManager.Instance.current.type == 21)
            {
                _damageView = new DamageView();
                addChild(_damageView);
                PositionUtils.setPos(_damageView, "asset.game.damageViewPos");
            }
            else if (RoomManager.Instance.current.type == 49)
            {
                _heroAutoView = ComponentFactory.Instance.creatCustomObject("game.view.heroAuto.heroAutoView");
                _heroAutoView.autoState = true;
                addChild(_heroAutoView);
            }
            else if (RoomManager.Instance.current.type == 29)
            {
                _rescueRoomItemView = new RescueRoomItemView();
                addChild(_rescueRoomItemView);
                PositionUtils.setPos(_rescueRoomItemView, "rescue.roomInfo.viewPos");
                SocketManager.Instance.addEventListener("RescueItemInfo", __updateRescueItemInfo);
                SocketManager.Instance.addEventListener("addScore", __addRescueScore);
            }
            else if (RoomManager.Instance.current.type == 70)
            {
                _combatGainsView = new DreamLandDamageLogView();
                addChild(_combatGainsView);
                PositionUtils.setPos(_combatGainsView, "asset.game.damageViewPos");
            }
        }

        public function updateCombatGainsView(hurts:Array):void
        {
            if (_combatGainsView)
            {
                _combatGainsView.updateView(hurts);
            }
        }

        private function addSmallMapBg():Bitmap
        {
            var smallMapBorder:Bitmap = GameDecorateManager.Instance.createBitmapUI(this, "asset.gameDecorate.smallMapBorder");
            if (smallMapBorder)
            {
                smallMapBorder.x = _map.smallMap.x - 36;
                smallMapBorder.y = _map.smallMap.y + (_map.smallMap.height - smallMapBorder.height) + 7;
                if (GameDecorateManager.Instance.isGameBattle)
                {
                    smallMapBorder.x = smallMapBorder.x - 2;
                    smallMapBorder.y = smallMapBorder.y - 6;
                }
            }
            return smallMapBorder;
        }

        protected function creatWeatherView():void
        {
            if (GameControl.Instance.Current.isWeather)
            {
                setBarrierVisible(false);
                _weatherView = new GameWeatherView();
                addChild(_weatherView);
            }
        }

        protected function __addRescueScore(event:CrazyTankSocketEvent):void
        {
            var pkg:PackageIn = event.pkg;
            var npcX:int = pkg.readInt();
            var npcY:int = pkg.readInt();
            var value:int = pkg.readInt();
            if (!_rescueScoreView)
            {
                _rescueScoreView = new RescueScoreAlertView();
                _map.addChild(_rescueScoreView);
            }
            _rescueScoreView.x = npcX;
            _rescueScoreView.y = npcY - 50;
            _rescueScoreView.setData(value);
            _rescueScoreView.visible = true;
        }

        private function setScoreViewInvisible():void
        {
            _rescueScoreView.visible = false;
        }

        protected function __updateRescueItemInfo(event:CrazyTankSocketEvent):void
        {
            var pkg:PackageIn = event.pkg;
            var info:RescueRoomInfo = new RescueRoomInfo();
            info.sceneId = pkg.readInt();
            info.score = pkg.readInt();
            info.defaultArrow = pkg.readInt();
            info.arrow = pkg.readInt();
            info.bloodBag = pkg.readInt();
            info.kingBless = pkg.readInt();
            if (_rescueRoomItemView)
            {
                _rescueRoomItemView.update(info);
            }
            if (_barrier)
            {
                _barrier.setRescueArrow(info.defaultArrow + info.arrow);
            }
            var ls:LiveState = _cs as LiveState;
            if (ls)
            {
                ls.rescuePropBar.setKingBlessCount(info.kingBless);
            }
        }

        public function addMessageBtn():void
        {
            if (!_messageBtn)
            {
                _messageBtn = ComponentFactory.Instance.creatComponentByStylename("game.view.activityDungeonView.messageBtn");
                _messageBtn.addEventListener("click", __onMessageClick);
                _map.addChild(_messageBtn);
            }
        }

        protected function __onMessageClick(event:MouseEvent):void
        {
            _messageBtn.visible = false;
            if (explorersLiving)
            {
                explorersLiving.say(LanguageMgr.GetTranslation("activity.dungeonView.pirateSay" + GameControl.Instance.currentNum));
            }
        }

        private function initGameCountDownView():void
        {
            var totalTime:int = 0;
            var roomType:int = RoomManager.Instance.current.type;
            if (roomType == 19)
            {
                totalTime = 300 - int((TimeManager.Instance.Now().getTime() - GameControl.Instance.Current.startTime.getTime()) / 1000);
                _gameCountDownView = new GameCountDownView(totalTime);
                _gameCountDownView.x = _map.smallMap.x - _gameCountDownView.width - 1;
                _gameCountDownView.y = 2;
                addChild(_gameCountDownView);
            }
        }

        private function isShowTrusteeship():Boolean
        {
            var gameType:int = GameControl.Instance.Current.roomType;
            var gameMode:int = GameControl.Instance.Current.gameMode;
            if (gameType == 4 || gameType == 12 || gameType == 13 || gameType == 12 || gameType == 25 || gameType == 0 || gameType == 1 || gameType == 11 || gameType == 123 || gameType == 58)
            {
                if (gameMode == 56 || gameMode == 57)
                {
                    return false;
                }
                return true;
            }
            return false;
        }

        public function updateDamageView():void
        {
            if (_damageView)
            {
                _damageView.updateView();
            }
        }

        protected function kingBlessIconInit():void
        {
            var roomType:int = 0;
            if (KingBlessManager.instance.openType > 0)
            {
                roomType = RoomManager.Instance.current.type;
                if (roomType == 4 || roomType == 11 || roomType == 15 || roomType == 123)
                {
                    _kingblessIcon = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.addPropertyBuffIcon");
                    _kingblessIcon.tipData = KingBlessManager.instance.getOneBuffData(1);
                    _buffIconBox.addChild(_kingblessIcon);
                }
            }
        }

        private function trialBuffIconInit():void
        {
            var roomType:int = RoomManager.Instance.current.type;
            if (roomType == 120)
            {
                _trialBuffIcon = ComponentFactory.Instance.creatComponentByStylename("game.trial.addTrialBuffIcon");
                _trialBuffIcon.tipData = ServerConfigManager.instance.trialBuffTipPropertyValue;
                _buffIconBox.addChild(_trialBuffIcon);
            }
        }

        private function addRingSkillIcon():void
        {
            var roomType:int = RoomManager.Instance.current.type;
            if (roomType != 70)
            {
                if (_self.ringFlag && _self.loveBuffLevel > 0)
                {
                    _ringSkillIcon = ComponentFactory.Instance.creatComponentByStylename("game.ringSkill.BuffIcon");
                    setSkillTipData(_ringSkillIcon);
                    _buffIconBox.addChild(_ringSkillIcon);
                    _buffIconBox.arrange();
                }
            }
        }

        protected function updateGuardCoreIcon():void
        {
            var list:* = null;
            if (GameControl.Instance.Current.guardCoreEnable)
            {
                list = GameControl.Instance.Current.getGuardCoreBuffList();
                if (list.length > 0)
                {
                    if (_guardCoreIcon == null)
                    {
                        _guardCoreIcon = ComponentFactory.Instance.creatComponentByStylename("game.guardCore.tipsIcon");
                    }
                    _guardCoreIcon.tipData = list;
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

        private function setSkillTipData($target:Image):void
        {
            var level:* = null;
            var obj:* = null;
            var nextLevel:* = null;
            var skillLevel:int = BagAndInfoManager.Instance.getCurrentRingData().Level / 10;
            if (skillLevel > 0)
            {
                level = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0, skillLevel)[0];
                obj = {};
                obj["name"] = level.name + "Lv" + skillLevel;
                obj["content"] = level.descript.replace("{0}", level.value);
                if (skillLevel < RingSystemData.TotalLevel * 0.1)
                {
                    nextLevel = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0, skillLevel + 1)[0];
                    obj["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextLevel", nextLevel.name, skillLevel + 1, nextLevel.descript.replace("{0}", nextLevel.value));
                    obj["limitLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextUnLock", (skillLevel + 1) * 10);
                }
                else
                {
                    obj["nextLevel"] = "";
                    obj["limitLevel"] = "";
                }
                $target.tipData = obj;
                Helpers.colorful($target);
                $target.mouseEnabled = true;
            }
            else
            {
                Helpers.grey($target);
                $target.mouseEnabled = false;
            }
        }

        private function resetPlayerCharacters():void
        {
            var _loc3_:int = 0;
            var _loc2_:* = _players;
            for each(var p in _players)
            {
                if (p.info.character)
                {
                    p.info.character.resetShowBitmapBig();
                    p.info.character.showWing = true;
                    p.info.character.show();
                }
            }
        }

        protected function __wishClick(pEvent:Event):void
        {
            _selfUsedProp.info.addState(0);
        }

        protected function __selfDie(event:LivingEvent):void
        {
            var self:Living = event.currentTarget as Living;
            var team:DictionaryData = _gameInfo.findTeam(self.team);
            var _loc6_:int = 0;
            var _loc5_:* = team;
            for each(var living in team)
            {
                if (living.isLiving)
                {
                    _cs = _fightControlBar.setState(1);
                    return;
                }
            }
            if (_selfBuffBar)
            {
                _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL, __selfBuffBarUpdateCellHandler);
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

        protected function drawMissionInfo():void
        {
            if (_gameInfo.roomType >= 2 && _gameInfo.roomType != 5 && _gameInfo.roomType != 16 && _gameInfo.roomType != 18 && _gameInfo.roomType != 19 && _gameInfo.roomType != 24 && _gameInfo.roomType != 25 && _gameInfo.roomType != 27 && _gameInfo.roomType != 121 && _gameInfo.roomType != 120 && _gameInfo.roomType != 58 && _gameInfo.gameMode != 56 && _gameInfo.gameMode != 57 && _gameInfo.gameMode != 23)
            {
                _map.smallMap.titleBar.addEventListener("DungeonHelpChanged", __dungeonVisibleChanged);
                if (!_barrier)
                {
                    _barrier = new DungeonInfoView(_map.smallMap.titleBar.turnButton, this);
                    _barrier.addEventListener("DungeonHelpVisibleChanged", __dungeonHelpChanged);
                    _barrier.addEventListener("updateSmallMapView", __updateSmallMapView);
                }
                if (!_missionHelp)
                {
                    _missionHelp = new DungeonHelpView(_map.smallMap.titleBar.turnButton, _barrier, this);
                    addChild(_missionHelp);
                }
                _barrier.open();
            }
            else if (_gameInfo.gameMode == 56 || _gameInfo.gameMode == 57)
            {
                _map.smallMap.titleBar.addEventListener("DungeonHelpChanged", __dungeonVisibleChanged);
                _missionHelp = new AthleticsHelpView(_map.smallMap.titleBar.turnButton, null, this);
                addChild(_missionHelp);
            }
        }

        public function testHelpOpen():void
        {
            _missionHelp.open();
        }

        public function testHelpClose(to:Rectangle):void
        {
            _missionHelp.close(to);
        }

        protected function __updateSmallMapView(event:GameEvent):void
        {
            var mission:MissionInfo = GameControl.Instance.Current.missionInfo;
            if (mission.currentValue1 != -1 && mission.totalValue1 > 0)
            {
                _map.smallMap.setBarrier(mission.currentValue1, mission.totalValue1);
            }
        }

        protected function __dungeonHelpChanged(event:GameEvent):void
        {
            var bounds:* = null;
            if (_missionHelp)
            {
                if (event.data)
                {
                    if (_missionHelp.opened)
                    {
                        bounds = _barrier.getBounds(this);
                        var _loc3_:int = 1;
                        bounds.height = _loc3_;
                        bounds.width = _loc3_;
                        _missionHelp.close(bounds);
                    }
                    else
                    {
                        _missionHelp.open();
                    }
                }
                else if (_missionHelp.opened)
                {
                    bounds = _map.smallMap.titleBar.turnButton.getBounds(this);
                    _missionHelp.close(bounds);
                }
            }
        }

        protected function __dungeonVisibleChanged(evt:DungeonInfoEvent):void
        {
            if (_gameInfo.gameMode == 56 || _gameInfo.gameMode == 57)
            {
                if (_missionHelp)
                {
                    !!_missionHelp.parent ? _missionHelp.defaultClose() : _missionHelp.open();
                }
            }
            else if (_barrier && _barrierVisible)
            {
                if (_barrier.parent)
                {
                    _barrier.close();
                }
                else
                {
                    _barrier.open();
                }
            }
        }

        private function __onMissonHelpClick(event:MouseEvent):void
        {
            StageReferance.stage.focus = _map;
        }

        protected function initEvent():void
        {
            _playerThumbnailLController.addEventListener("wishSelect", __thumbnailControlHandle);
            GameControl.Instance.addEventListener("addringanamition", __onAddRingAnimation);
            GameControl.Instance.addEventListener("addguardcoreeffect", __onAddGuardCoreAnimation);
            _selfBuffBar.addEventListener(SelfBuffBar.UPDATECELL, __selfBuffBarUpdateCellHandler);
        }

        private function __selfBuffBarUpdateCellHandler(event:CEvent):void
        {
            updateBuffIconBoxPos();
        }

        private function addPlayerHander(e:DictionaryEvent):void
        {
            var movie:* = null;
            var character:* = null;
            var player:* = null;
            var info:* = e.data;
            if (info is Player && (info as Player).typeLiving != 18)
            {
                if (!info.movie)
                {
                    movie = CharactoryFactory.createCharacter(info.playerInfo, "game");
                    movie.show();
                    info.movie = GameCharacter(movie);
                }
                if (!info.character)
                {
                    character = CharactoryFactory.createCharacter(info.playerInfo, "show");
                    ShowCharacter(character).show();
                    info.character = ShowCharacter(character);
                }
                player = new GamePlayer(info, info.character, GameCharacter(movie));
                _map.addPhysical(player);
                _players[info] = player;
                _playerThumbnailLController.addNewLiving(info);
            }
        }

        protected function loadWeakGuild():void
        {
            _vane.visible = !!StateManager.RecordFlag ? true : Boolean(PlayerManager.Instance.Self.IsWeakGuildFinish(9));
            if (PlayerManager.Instance.Self.IsWeakGuildFinish(9) && !PlayerManager.Instance.Self.IsWeakGuildFinish(74))
            {
                setTimeout(propOpenShow, 2000, "asset.trainer.openVane");
                SocketManager.Instance.out.syncWeakStep(74);
            }
        }

        private function isWishGuideLoad():Boolean
        {
            return true;
        }

        private function propOpenShow(mcStr:String):void
        {
            var mc:MovieClipWrapper = new MovieClipWrapper(ClassUtils.CreatInstance(mcStr), true, true);
            LayerManager.Instance.addToLayer(mc.movie, 4, false);
        }

        protected function newMap():MapView
        {
            if (_map)
            {
                throw new Error(LanguageMgr.GetTranslation("tank.game.mapGenerated"));
            }
            return new MapView(_gameInfo, _gameInfo.loaderMap);
        }

        private function __soundChange(evt:Event):void
        {
            var mapSound:SoundTransform = new SoundTransform();
            if (SharedManager.Instance.allowSound)
            {
                mapSound.volume = SharedManager.Instance.soundVolumn / 100;
                this.soundTransform = mapSound;
            }
            else
            {
                mapSound.volume = 0;
                this.soundTransform = mapSound;
            }
        }

        public function restoreSmallMap():void
        {
            _map.smallMap.restore();
        }

        protected function disposeUI():void
        {
            GameDecorateManager.Instance.disposeBitmapUI();
            if (_missionHelp)
            {
                _missionHelp.removeEventListener("click", __onMissonHelpClick);
                ObjectUtils.disposeObject(_missionHelp);
                _missionHelp = null;
            }
            if (_arrowDown)
            {
                _arrowDown.dispose();
            }
            if (_arrowUp)
            {
                _arrowUp.dispose();
            }
            if (_arrowLeft)
            {
                _arrowLeft.dispose();
            }
            if (_arrowRight)
            {
                _arrowRight.dispose();
            }
            _arrowDown = null;
            _arrowLeft = null;
            _arrowRight = null;
            _arrowUp = null;
            ObjectUtils.disposeObject(_achievBar);
            _achievBar = null;
            if (_playerThumbnailLController)
            {
                _playerThumbnailLController.dispose();
            }
            _playerThumbnailLController = null;
            ObjectUtils.disposeObject(_selfUsedProp);
            _selfUsedProp = null;
            if (_leftPlayerView)
            {
                _leftPlayerView.dispose();
            }
            _leftPlayerView = null;
            if (_cs)
            {
                _cs.leaving();
            }
            _cs = null;
            ObjectUtils.disposeObject(_fightControlBar);
            _fightControlBar = null;
            ObjectUtils.disposeObject(_selfMarkBar);
            _selfMarkBar = null;
            if (_selfBuffBar)
            {
                _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL, __selfBuffBarUpdateCellHandler);
            }
            ObjectUtils.disposeObject(_selfBuffBar);
            _selfBuffBar = null;
            if (_vane)
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
            if (_damageView)
            {
                _damageView.dispose();
                _damageView = null;
            }
            ObjectUtils.disposeObject(_combatGainsView);
            _combatGainsView = null;
            ObjectUtils.disposeObject(_rescueRoomItemView);
            _rescueRoomItemView = null;
            ObjectUtils.disposeObject(_rescueScoreView);
            _rescueScoreView = null;
            ObjectUtils.disposeObject(_weatherView);
            _weatherView = null;
            if (_messageBtn)
            {
                _messageBtn.removeEventListener("click", __onMessageClick);
                _messageBtn.dispose();
                _messageBtn = null;
            }
            ObjectUtils.disposeObject(_sceneEffectsBar);
            _sceneEffectsBar = null;
            if (map)
            {
                map.clearSceneEffectLayer();
            }
            BallManager.clearSceneEffectMovie();
        }

        override public function leaving(next:BaseStateView):void
        {
            super.leaving(next);
            dispose();
            BloodNumberCreater.dispose();
        }

        override public function dispose():void
        {
            disposeUI();
            wishRemoveEvent();
            removeGameData();
            ObjectUtils.disposeObject(_bitmapMgr);
            _bitmapMgr = null;
            if (_map != null)
            {
                _map.smallMap.titleBar.removeEventListener("DungeonHelpChanged", __dungeonVisibleChanged);
                removeChild(_map);
                _map.dispose();
                _map = null;
            }
            PlayerInfoViewControl.clearView();
            LayerManager.Instance.clearnGameDynamic();
            SharedManager.Instance.removeEventListener("change", __soundChange);
            ObjectUtils.disposeObject(_missionHelp);
            _missionHelp = null;
            if (GameControl.Instance.Current != null)
            {
                GameControl.Instance.Current.selfGamePlayer.removeEventListener("die", __selfDie);
            }
            IMEManager.enable();
            while (numChildren > 0)
            {
                removeChildAt(0);
            }
            MenoryUtil.clearMenory();
            if (_barrier)
            {
                _barrier.removeEventListener("DungeonHelpVisibleChanged", __dungeonHelpChanged);
                _barrier.removeEventListener("updateSmallMapView", __updateSmallMapView);
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
            if (_heroAutoView)
            {
                ObjectUtils.disposeObject(_heroAutoView);
            }
            _heroAutoView = null;
            WorldBossManager.Instance.isLoadingState = false;
            SocketManager.Instance.removeEventListener("RescueItemInfo", __updateRescueItemInfo);
            SocketManager.Instance.removeEventListener("addScore", __addRescueScore);
            GameControl.Instance.removeEventListener("addringanamition", __onAddRingAnimation);
            GameControl.Instance.removeEventListener("addguardcoreeffect", __onAddGuardCoreAnimation);
            if (_selfBuffBar)
            {
                _selfBuffBar.removeEventListener(SelfBuffBar.UPDATECELL, __selfBuffBarUpdateCellHandler);
            }
        }

        protected function setupGameData():void
        {
            var view:* = null;
            var p:* = null;
            var rp:* = null;
            var movie:* = null;
            var character:* = null;
            var list:Array = [];
            var ringFlag:Boolean = false;
            var _loc13_:int = 0;
            var _loc12_:* = _gameInfo.livings;
            for each(var info in _gameInfo.livings)
            {
                if (info is Player)
                {
                    p = info as Player;
                    rp = RoomManager.Instance.current.findPlayerByID(p.playerInfo.ID);
                    if (!p.movie)
                    {
                        movie = CharactoryFactory.createCharacter(p.playerInfo, "game");
                        movie.show();
                        p.movie = GameCharacter(movie);
                    }
                    if (!p.character)
                    {
                        character = CharactoryFactory.createCharacter(p.playerInfo, "show");
                        ShowCharacter(character).show();
                        p.character = ShowCharacter(character);
                    }
                    if (p.isSelf)
                    {
                        view = new GameLocalPlayer(_gameInfo.selfGamePlayer, p.character as ShowCharacter, p.movie as GameCharacter, p.templeId);
                        _selfGamePlayer = view as GameLocalPlayer;
                    }
                    else
                    {
                        view = new GamePlayer(p, p.character as ShowCharacter, p.movie as GameCharacter, p.templeId);
                    }
                    if (p.movie)
                    {
                        p.movie.setDefaultAction(p.movie.standAction);
                        p.movie.doAction(p.movie.standAction);
                    }
                    var _loc11_:int = 0;
                    var _loc10_:* = p.outProperty;
                    for (var KEY in p.outProperty)
                    {
                        setProperty(view, KEY, p.outProperty[KEY]);
                    }
                    list.push(view);
                    _map.addPhysical(view);
                    _players[info] = view;
                    if (!ringFlag)
                    {
                        ringFlag = p.ringFlag;
                    }
                }
            }
            _map.wind = GameControl.Instance.Current.wind;
            _map.currentTurn = 1;
            _vane.initialize();
            _vane.update(_map.wind);
            if (RoomManager.Instance.current.type != 70)
            {
                _map.act(new ViewEachPlayerAction(_map, list, !!ringFlag ? 2000 : Number(1500)));
            }
        }

        protected function __onAddRingAnimation(event:GameEvent):void
        {
            var player:GamePlayer = event.data as GamePlayer;
            player.playRingSkill();
        }

        protected function __onAddGuardCoreAnimation(e:GameEvent):void
        {
            var player:GamePlayer = e.data as GamePlayer;
            player.playGuardCoreEffect();
        }

        protected function setProperty(obj:GameLiving, property:String, value:String):void
        {
            var LockType:int = 0;
            var lockState:Boolean = false;
            var info:* = null;
            var vo:StringObject = new StringObject(value);
            var _loc8_:* = property;
            if ("system" !== _loc8_)
            {
                if ("systemII" !== _loc8_)
                {
                    if ("propzxc" !== _loc8_)
                    {
                        if ("zxc" !== _loc8_)
                        {
                            if ("silencedSpecial" !== _loc8_)
                            {
                                if ("silenced" !== _loc8_)
                                {
                                    if ("nofly" !== _loc8_)
                                    {
                                        if ("silenceMany" !== _loc8_)
                                        {
                                            if ("hideBossThumbnail" !== _loc8_)
                                            {
                                                if ("energy" !== _loc8_)
                                                {
                                                    if ("energy2" !== _loc8_)
                                                    {
                                                        obj.setProperty(property, value);
                                                    }
                                                    else if (obj)
                                                    {
                                                        obj.info.energy = vo.getNumber();
                                                    }
                                                }
                                                else if (obj)
                                                {
                                                    obj.info.maxEnergy = vo.getNumber();
                                                    obj.info.energy = vo.getNumber();
                                                }
                                            }
                                            else if (obj)
                                            {
                                                _playerThumbnailLController.removeThumbnailContainer();
                                            }
                                        }
                                        else
                                        {
                                            LockType = 1;
                                            lockState = vo.getBoolean();
                                            info = obj.info;
                                            if (lockState)
                                            {
                                                info.addBuff(BuffManager.creatBuff(1000));
                                            }
                                            else
                                            {
                                                info.removeBuff(1000);
                                            }
                                            if (obj.info.isSelf)
                                            {
                                                GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = lockState;
                                                GameControl.Instance.Current.selfGamePlayer.lockFly = lockState;
                                                GameControl.Instance.Current.selfGamePlayer.lockRightProp = lockState;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        LockType = 4;
                                        lockState = vo.getBoolean();
                                        info = obj.info;
                                        info.LockType = LockType;
                                        if (obj.info.isSelf)
                                        {
                                            GameControl.Instance.Current.selfGamePlayer.lockFly = lockState;
                                        }
                                    }
                                }
                                else if (obj)
                                {
                                    LockType = 1;
                                    lockState = vo.getBoolean();
                                    info = obj.info;
                                    info.LockType = LockType;
                                    info.LockState = lockState;
                                    if (obj.info.isSelf)
                                    {
                                        GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !lockState;
                                        GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !lockState;
                                        GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = lockState;
                                    }
                                }
                            }
                            else if (obj)
                            {
                                LockType = 3;
                                lockState = vo.getBoolean();
                                info = obj.info;
                                info.LockType = LockType;
                                info.LockState = lockState;
                                if (obj.info.isSelf)
                                {
                                    if (RoomManager.Instance.current.type != 21)
                                    {
                                        GameControl.Instance.Current.selfGamePlayer.lockFly = lockState;
                                    }
                                    GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = lockState;
                                    GameControl.Instance.Current.selfGamePlayer.lockSpellKill = lockState;
                                    GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !lockState;
                                    GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !lockState;
                                }
                            }
                        }
                        else if (obj)
                        {
                            LockType = 0;
                            lockState = vo.getBoolean();
                            info = obj.info;
                            info.LockType = LockType;
                            if (obj.info.isSelf)
                            {
                                GameControl.Instance.Current.selfGamePlayer.customPropEnabled = lockState;
                            }
                        }
                    }
                    else if (obj)
                    {
                        LockType = 3;
                        lockState = vo.getBoolean();
                        info = obj.info;
                        info.LockType = LockType;
                        info.LockState = lockState;
                        if (obj.info.isSelf)
                        {
                            GameControl.Instance.Current.selfGamePlayer.customPropEnabled = lockState;
                        }
                    }
                }
                else if (obj)
                {
                    LockType = 0;
                    lockState = vo.getBoolean();
                    info = obj.info;
                    if (obj.info.isSelf)
                    {
                        GameControl.Instance.Current.selfGamePlayer.lockFly = lockState;
                        GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = lockState;
                        GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = !lockState;
                    }
                }
            }
            else if (obj)
            {
                LockType = 0;
                lockState = vo.getBoolean();
                info = obj.info;
                info.LockType = LockType;
                info.LockState = lockState;
                if (obj.info.isSelf)
                {
                    GameControl.Instance.Current.selfGamePlayer.lockDeputyWeapon = lockState;
                    GameControl.Instance.Current.selfGamePlayer.lockFly = lockState;
                    GameControl.Instance.Current.selfGamePlayer.lockSpellKill = lockState;
                    GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = !lockState;
                    GameControl.Instance.Current.selfGamePlayer.customPropEnabled = !lockState;
                    GameControl.Instance.Current.selfGamePlayer.petSkillEnabled = !lockState;
                }
            }
        }

        private function initDiePlayer():void
        {
            var _loc3_:int = 0;
            var _loc2_:* = _gameInfo.livings;
            for each(var info in _gameInfo.livings)
            {
                if (info.blood <= 0)
                {
                    info.reset();
                    info.die(true);
                    if (_gameTrusteeshipView)
                    {
                        _gameTrusteeshipView.visible = false;
                    }
                }
            }
        }

        private function removeGameData():void
        {
            var _loc3_:int = 0;
            var _loc2_:* = _players;
            for each(var view in _players)
            {
                view.dispose();
                delete _players[view.info];
            }
            _players = null;
            _selfGamePlayer = null;
            _gameInfo = null;
            _barrierVisible = true;
        }

        public function addLiving($living:Living):void
        {
        }

        private function updatePlayerState(info:Living):void
        {
            if (_selfUsedProp == null)
            {
                _selfUsedProp = new PlayerStateContainer(12);
                PositionUtils.setPos(_selfUsedProp, "asset.game.selfUsedProp");
                addChild(_selfUsedProp);
            }
            if (_selfUsedProp)
            {
                _selfUsedProp.disposeAllChildren();
            }
            var len:int = 0;
            if (_selfUsedProp)
            {
                if (_selfBuffBar && _selfBuffBar.visible)
                {
                    len = len + _selfBuffBar.right;
                }
                if (_buffIconBox && _buffIconBox.visible)
                {
                    len = len + _buffIconBox.width;
                }
                _selfUsedProp.x = len;
            }
            if (info is TurnedLiving)
            {
                _selfUsedProp.info = TurnedLiving(info);
            }
            if (GameControl.Instance.Current.selfGamePlayer.isAutoGuide && GameControl.Instance.Current.currentLiving.LivingID == GameControl.Instance.Current.selfGamePlayer.LivingID)
            {
                GameMessageTipManager.getInstance().show(String(GameControl.Instance.Current.selfGamePlayer.LivingID), 3);
            }
        }

        public function setCurrentPlayer(info:Living):void
        {
            if (info && info.isSelf && info.isLiving)
            {
                if (_buffIconBox)
                {
                    _buffIconBox.visible = true;
                }
                if (_selfBuffBar)
                {
                    _selfBuffBar.propertyWaterBuffBarVisible = true;
                }
                updateGuardCoreIcon();
            }
            else
            {
                if (_buffIconBox)
                {
                    _buffIconBox.visible = false;
                }
                if (_selfBuffBar)
                {
                    _selfBuffBar.propertyWaterBuffBarVisible = false;
                }
            }
            if (!BombKingManager.instance.Recording && !RoomManager.Instance.current.selfRoomPlayer.isViewer && info && _selfBuffBar)
            {
                _selfBuffBar.drawBuff(info);
            }
            updateBuffIconBoxPos();
            if (_leftPlayerView)
            {
                _leftPlayerView.info = info;
            }
            _map.bringToFront(info);
            if (_map.currentPlayer && !(info is TurnedLiving))
            {
                _map.currentPlayer.isAttacking = false;
                _map.currentPlayer = null;
            }
            else
            {
                _map.currentPlayer = info as TurnedLiving;
            }
            updatePlayerState(info);
            if (_leftPlayerView)
            {
                addChildAt(_leftPlayerView, this.numChildren - 3);
            }
            var self:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
            if (_map.currentPlayer)
            {
                if (self)
                {
                    self.soulPropEnabled = !self.isLiving && _map.currentPlayer.team == self.team;
                }
            }
            else if (self)
            {
                self.soulPropEnabled = false;
            }
        }

        private function updateBuffIconBoxPos():void
        {
            if (_buffIconBox && _buffIconBox.visible)
            {
                if (_selfBuffBar && _selfBuffBar.visible)
                {
                    _buffIconBox.x = _selfBuffBar.right + 30;
                }
                else
                {
                    PositionUtils.setPos(_buffIconBox, "game.kingbless.addPropertyBuffIconPos2");
                }
            }
        }

        public function updateControlBarState(info:Living):void
        {
            if (GameControl.Instance.Current == null)
            {
                return;
            }
            if (GameControl.Instance.Current.selfGamePlayer.LockState)
            {
                setPropBarClickEnable(false, true);
                return;
            }
            if (info is TurnedLiving && info.isLiving && GameControl.Instance.Current.selfGamePlayer.canUseProp(info as TurnedLiving))
            {
                setPropBarClickEnable(true, false);
            }
            else if (info)
            {
                if (!(!GameControl.Instance.Current.selfGamePlayer.isLiving && info.isSelf))
                {
                    if (!(!GameControl.Instance.Current.selfGamePlayer.isLiving && GameControl.Instance.Current.selfGamePlayer.team != info.team))
                    {
                        setPropBarClickEnable(true, false);
                    }
                }
            }
            else
            {
                setPropBarClickEnable(true, false);
            }
        }

        protected function setPropBarClickEnable(clickAble:Boolean, isGray:Boolean):void
        {
            GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = clickAble;
            if (RoomManager.Instance.current.type != 24)
            {
                GameControl.Instance.Current.selfGamePlayer.customPropEnabled = clickAble;
            }
        }

        protected function gameOver():void
        {
            _map.smallMap.enableExit = false;
            if (!NewHandGuideManager.Instance.isNewHandFB())
            {
                SoundManager.instance.stopMusic();
            }
            else
            {
                SoundManager.instance.setMusicVolumeByRatio(0.5);
            }
            setPropBarClickEnable(false, false);
            _leftPlayerView.gameOver();
            _leftPlayerView.visible = false;
            if (_selfMarkBar)
            {
                _selfMarkBar.shutdown();
            }
            if (NoviceDataManager.instance.firstEnterGame)
            {
                NoviceDataManager.instance.firstEnterGame = false;
                NoviceDataManager.instance.saveNoviceData(540, PathManager.userName(), PathManager.solveRequestPath());
            }
        }

        protected function set barrierInfo(evt:CrazyTankSocketEvent):void
        {
            if (_barrier)
            {
                _barrier.barrierInfoHandler(evt);
            }
        }

        protected function set arrowHammerEnable(b:Boolean):void
        {
        }

        public function blockHammer():void
        {
        }

        public function allowHammer():void
        {
        }

        protected function defaultForbidDragFocus():void
        {
        }

        protected function setBarrierVisible(v:Boolean):void
        {
            _barrierVisible = v;
        }

        protected function setVaneVisible(v:Boolean):void
        {
            _vane.visible = v;
        }

        protected function setPlayerThumbVisible(v:Boolean):void
        {
            _playerThumbnailLController.visible = v;
        }

        protected function setEnergyVisible(v:Boolean):void
        {
            var ls:LiveState = _cs as LiveState;
            if (ls)
            {
                ls.setEnergyVisible(v);
            }
        }

        public function setRecordRotation():void
        {
        }

        public function get map():*
        {
            return _map;
        }

        protected function set mapWind(value:Number):void
        {
            _mapWind = value;
            if (_useAble)
            {
                showShoot();
            }
        }

        public function get currentLivID():int
        {
            return _currentLivID;
        }

        public function set currentLivID(value:int):void
        {
            _currentLivID = value;
            showFightPower();
            drawRouteLine(_currentLivID);
            if (_map)
            {
                _map.smallMap.drawRouteLine(_currentLivID);
            }
        }

        private function showFightPower():void
        {
            var targetLiving:* = null;
            if (_currentLivID != -1 && _allLivings[_currentLivID])
            {
                targetLiving = _allLivings[_currentLivID] as Living;
                _selfGameLiving.setFightPower(targetLiving.fightPower);
                _self.fightPower = targetLiving.fightPower;
            }
        }

        private function wishInit():void
        {
            _self = GameControl.Instance.Current.selfGamePlayer;
            _selfGameLiving = _map.getPhysical(_self.LivingID) as GamePlayer;
            _allLivings = GameControl.Instance.Current.livings;
            _drawRoute = new Sprite();
            _map.addChild(_drawRoute);
            currentLivID = -1;
            _gameInfo.livings.addEventListener("add", addPlayerHander);
            _self.addEventListener("gunangleChanged", __changeAngle);
            _self.addEventListener("posChanged", __changeAngle);
            _self.addEventListener("dirChanged", __changeAngle);
            SocketManager.Instance.addEventListener("wishofdd", __wishofdd);
            SocketManager.Instance.addEventListener("playerChange", __playerChange);
            RoomManager.Instance.addEventListener("PlayerRoomExit", __playerExit);
            KeyboardManager.getInstance().addEventListener("keyDown", __KeyDown);
            SocketManager.Instance.addEventListener("RescueKingBless", __useRescueKingBless);
        }

        private function wishRemoveEvent():void
        {
            if (_self != null)
            {
                _self.removeEventListener("gunangleChanged", __changeAngle);
                _self.removeEventListener("posChanged", __changeAngle);
                _self.removeEventListener("dirChanged", __changeAngle);
            }
            if (_gameInfo != null)
            {
                _gameInfo.livings.removeEventListener("add", addPlayerHander);
            }
            SocketManager.Instance.removeEventListener("wishofdd", __wishofdd);
            SocketManager.Instance.removeEventListener("playerChange", __playerChange);
            RoomManager.Instance.removeEventListener("PlayerRoomExit", __playerExit);
            KeyboardManager.getInstance().removeEventListener("keyDown", __KeyDown);
            SocketManager.Instance.removeEventListener("RescueKingBless", __useRescueKingBless);
        }

        private function __useRescueKingBless(event:CrazyTankSocketEvent):void
        {
            var pwind:Number = NaN;
            var weatherLevel:int = 0;
            var weatherRate:Number = NaN;
            var pkg:PackageIn = event.pkg;
            var isShoot:Boolean = pkg.readBoolean();
            if (isShoot)
            {
                pwind = pkg.readInt();
                weatherLevel = pkg.readInt();
                weatherRate = pkg.readInt() / 100;
                _mapWind = pwind * weatherRate / 10 * _windFactor;
                _useAble = true;
                showShoot();
            }
        }

        protected function __KeyDown(event:KeyboardEvent):void
        {
            var i:int = 0;
            var tmpArr:Array = [];
            if (event.keyCode == KeyStroke.VK_V.getCode())
            {
                var _loc6_:int = 0;
                var _loc5_:* = _allLivings;
                for each(var liv in _allLivings)
                {
                    if (!(liv.isHidden || liv.team == GameControl.Instance.Current.selfGamePlayer.team || !liv.isLiving || liv.LivingID == _self.LivingID))
                    {
                        tmpArr.push(liv);
                    }
                }
                for (i = 0; i <= tmpArr.length - 1;)
                {
                    if ((tmpArr[i] as Living).LivingID == currentLivID)
                    {
                        if (i >= tmpArr.length - 1)
                        {
                            i = 0;
                        }
                        else
                        {
                            i++;
                        }
                        break;
                    }
                    i++;
                }
                if (i <= tmpArr.length - 1)
                {
                    currentLivID = tmpArr[i].LivingID;
                }
            }
        }

        protected function showShoot():void
        {
            var enemyPos:* = null;
            var player:* = null;
            var power:Number = NaN;
            var xS_Lef_E:Boolean = false;
            var yS_Up_E:Boolean = false;
            var shootpos:Point = _selfGameLiving.body.localToGlobal(new Point(30, -20));
            shootpos = _map.globalToLocal(shootpos);
            _shootAngle = _self.calcBombAngle();
            _arf = _map.airResistance;
            _gf = _map.gravity * _mass * _gravityFactor;
            _ga = _gf / _mass;
            _wa = _mapWind / _mass;
            var _loc9_:int = 0;
            var _loc8_:* = _allLivings;
            for each(var liv in _allLivings)
            {
                liv.route = null;
                if (!(liv.isHidden || liv.team == GameControl.Instance.Current.selfGamePlayer.team || !liv.isLiving || liv.LivingID == _self.LivingID))
                {
                    enemyPos = liv.pos;
                    if (_self.isLiving && _self.isAttacking)
                    {
                        liv.route = null;
                        xS_Lef_E = true;
                        yS_Up_E = true;
                        if (shootpos.x > enemyPos.x)
                        {
                            xS_Lef_E = false;
                        }
                        if (shootpos.y > enemyPos.y)
                        {
                            yS_Up_E = false;
                        }
                        if (judgeMaxPower(shootpos, enemyPos, _shootAngle, xS_Lef_E, yS_Up_E))
                        {
                            power = getPower(0, 2000, shootpos, enemyPos, _shootAngle, xS_Lef_E, yS_Up_E);
                        }
                        else
                        {
                            power = 2100;
                        }
                        _stateFlag = 0;
                        if (power > 2000)
                        {
                            if (liv.state)
                            {
                                _stateFlag = 1;
                            }
                            else
                            {
                                _stateFlag = 2;
                            }
                            liv.state = false;
                        }
                        else
                        {
                            if (liv.state)
                            {
                                _stateFlag = 3;
                            }
                            else
                            {
                                _stateFlag = 4;
                            }
                            liv.state = true;
                        }
                        _gameLiving = _map.getPhysical(liv.LivingID) as GameLiving;
                        if (_stateFlag == 1 || _stateFlag == 2)
                        {
                            liv.route = null;
                        }
                        else
                        {
                            liv.route = getRouteData(power, _shootAngle, shootpos, enemyPos);
                        }
                        liv.fightPower = Number((power * 100 / 2000).toFixed(1));
                    }
                }
            }
            if (currentLivID == -1 || !_allLivings[currentLivID].route)
            {
                currentLivID = calculateRecent();
            }
            else
            {
                currentLivID = currentLivID;
            }
        }

        protected function judgeMaxPower(shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean):Boolean
        {
            var Ex:* = null;
            var Ey:* = null;
            var vx:int = 0;
            var vy:int = 0;
            vx = 2000 * Math.cos(shootAngle / 180 * 3.14159265358979);
            Ex = new EulerVector(shootPos.x, vx, _wa);
            vy = 2000 * Math.sin(shootAngle / 180 * 3.14159265358979);
            Ey = new EulerVector(shootPos.y, vy, _ga);
            var timeTemp:Boolean = false;
            while (true)
            {
                if (xS_Lef_E)
                {
                    if (Ex.x0 > _map.bound.width)
                    {
                        return true;
                    }
                    if (Ex.x0 < _map.bound.x || Ey.x0 > _map.bound.height)
                    {
                        return false;
                    }
                }
                else
                {
                    if (Ex.x0 < _map.bound.x)
                    {
                        break;
                    }
                    if (Ex.x0 > _map.bound.width || Ey.x0 > _map.bound.height)
                    {
                        return false;
                    }
                }
                if (ifHit(Ex.x0, Ey.x0, enemyPos))
                {
                    return true;
                }
                Ex.ComputeOneEulerStep(_mass, _arf, _mapWind, _dt);
                Ey.ComputeOneEulerStep(_mass, _arf, _gf, _dt);
                if (xS_Lef_E && yS_Up_E)
                {
                    if (Ey.x0 > enemyPos.y)
                    {
                        if (Ex.x0 < enemyPos.x)
                        {
                            return false;
                        }
                        return true;
                    }
                }
                else if (xS_Lef_E && !yS_Up_E)
                {
                    if (!timeTemp)
                    {
                        if (Ex.x0 > enemyPos.x)
                        {
                            return false;
                        }
                        if (Ey.x0 < enemyPos.y)
                        {
                            timeTemp = true;
                        }
                    }
                    else if (timeTemp)
                    {
                        if (Ey.x0 > enemyPos.y)
                        {
                            if (Ex.x0 < enemyPos.x)
                            {
                                return false;
                            }
                            return true;
                        }
                    }
                }
                else if (!xS_Lef_E && !yS_Up_E)
                {
                    if (!timeTemp)
                    {
                        if (Ex.x0 < enemyPos.x)
                        {
                            return false;
                        }
                        if (Ey.x0 < enemyPos.y)
                        {
                            timeTemp = true;
                        }
                    }
                    else if (timeTemp)
                    {
                        if (Ey.x0 > enemyPos.y)
                        {
                            if (Ex.x0 < enemyPos.x)
                            {
                                return true;
                            }
                            return false;
                        }
                    }
                }
                else if (!xS_Lef_E && yS_Up_E)
                {
                    if (Ey.x0 > enemyPos.y)
                    {
                        if (Ex.x0 < enemyPos.x)
                        {
                            return true;
                        }
                        return false;
                    }
                }
            }
            return true;
        }

        protected function getPower(min:Number, max:Number, shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean):Number
        {
            var Ex:* = null;
            var Ey:* = null;
            var vx:int = 0;
            var vy:int = 0;
            var power:int = (min + max) / 2;
            if (power <= min || power >= max)
            {
                return power;
            }
            vx = power * Math.cos(shootAngle / 180 * 3.14159265358979);
            Ex = new EulerVector(shootPos.x, vx, _wa);
            vy = power * Math.sin(shootAngle / 180 * 3.14159265358979);
            Ey = new EulerVector(shootPos.y, vy, _ga);
            var timeTemp:Boolean = false;
            while (true)
            {
                if (xS_Lef_E)
                {
                    if (Ex.x0 > _map.bound.width)
                    {
                        power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        break;
                    }
                    if (Ey.x0 > _map.bound.height)
                    {
                        power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        break;
                    }
                    if (Ex.x0 < _map.bound.x)
                    {
                        power = 2100;
                        return 2100;
                    }
                }
                else
                {
                    if (Ex.x0 < _map.bound.x)
                    {
                        power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        break;
                    }
                    if (Ey.x0 > _map.bound.height)
                    {
                        power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        break;
                    }
                    if (Ex.x0 > _map.bound.width)
                    {
                        power = 2100;
                        return 2100;
                    }
                }
                if (ifHit(Ex.x0, Ey.x0, enemyPos))
                {
                    return power;
                }
                Ex.ComputeOneEulerStep(_mass, _arf, _mapWind, _dt);
                Ey.ComputeOneEulerStep(_mass, _arf, _gf, _dt);
                if (xS_Lef_E && yS_Up_E)
                {
                    if (Ey.x0 > enemyPos.y)
                    {
                        if (Ex.x0 < enemyPos.x)
                        {
                            power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        }
                        else
                        {
                            power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        }
                        break;
                    }
                }
                else if (xS_Lef_E && !yS_Up_E)
                {
                    if (!timeTemp)
                    {
                        if (Ex.x0 > enemyPos.x)
                        {
                            power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            break;
                        }
                        if (Ey.x0 < enemyPos.y)
                        {
                            timeTemp = true;
                        }
                    }
                    else if (timeTemp)
                    {
                        if (Ey.x0 > enemyPos.y)
                        {
                            if (Ex.x0 < enemyPos.x)
                            {
                                power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            }
                            else
                            {
                                power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            }
                            break;
                        }
                    }
                }
                else if (!xS_Lef_E && !yS_Up_E)
                {
                    if (!timeTemp)
                    {
                        if (Ex.x0 < enemyPos.x)
                        {
                            power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            break;
                        }
                        if (Ey.x0 < enemyPos.y)
                        {
                            timeTemp = true;
                        }
                    }
                    else if (timeTemp)
                    {
                        if (Ey.x0 > enemyPos.y)
                        {
                            if (Ex.x0 > enemyPos.x)
                            {
                                power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            }
                            else
                            {
                                power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                            }
                            break;
                        }
                    }
                }
                else if (!xS_Lef_E && yS_Up_E)
                {
                    if (Ey.x0 > enemyPos.y)
                    {
                        if (Ex.x0 > enemyPos.x)
                        {
                            power = getPower(power, max, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        }
                        else
                        {
                            power = getPower(min, power, shootPos, enemyPos, shootAngle, xS_Lef_E, yS_Up_E);
                        }
                        break;
                    }
                }
            }
            return power;
        }

        protected function ifHit(bulletX:Number, bulletY:Number, enemyPos:Point):Boolean
        {
            if (bulletX > enemyPos.x - 15 && bulletX < enemyPos.x + 20 && bulletY > enemyPos.y - 20 && bulletY < enemyPos.y + 30)
            {
                return true;
            }
            return false;
        }

        private function isOutOfMap(ex:EulerVector, ey:EulerVector):Boolean
        {
            if (ex.x0 < _map.bound.x || ex.x0 > _map.bound.width || ey.x0 > _map.bound.height)
            {
                return true;
            }
            return false;
        }

        private function drawRouteLine(id:int):void
        {
            var i:int = 0;
            _drawRoute.graphics.clear();
            var _loc8_:int = 0;
            var _loc7_:* = _allLivings;
            for each(var liv in _allLivings)
            {
                liv.currentSelectId = id;
            }
            if (id < 0)
            {
                return;
            }
            var living:Living = _allLivings[id];
            if (!living)
            {
                return;
            }
            var data:Vector.<Point> = living.route;
            if (!data || data.length == 0)
            {
                return;
            }
            _collideRect.x = living.pos.x - 50;
            _collideRect.y = living.pos.y - 50;
            _drawRoute.graphics.lineStyle(2, 16711680, 0.5);
            var length:int = data.length;
            for (i = 0; i < length - 1;)
            {
                drawDashed(_drawRoute.graphics, data[i], data[i + 1], 8, 5);
                i++;
            }
        }

        private function getRouteData(power:Number, shootAngle:Number, shootPos:Point, enemyPos:Point):Vector.<Point>
        {
            var Ex:* = null;
            var Ey:* = null;
            var vx:int = 0;
            var vy:int = 0;
            if (power > 2000)
            {
                return null;
            }
            vx = power * Math.cos(shootAngle / 180 * 3.14159265358979);
            Ex = new EulerVector(shootPos.x, vx, _wa);
            vy = power * Math.sin(shootAngle / 180 * 3.14159265358979);
            Ey = new EulerVector(shootPos.y, vy, _ga);
            var ary:Vector.<Point> = new Vector.<Point>();
            ary.push(new Point(shootPos.x, shootPos.y));
            while (!isOutOfMap(Ex, Ey))
            {
                if (ifHit(Ex.x0, Ey.x0, enemyPos))
                {
                    return ary;
                }
                Ex.ComputeOneEulerStep(_mass, _arf, _mapWind, _dt);
                Ey.ComputeOneEulerStep(_mass, _arf, _gf, _dt);
                ary.push(new Point(Ex.x0, Ey.x0));
            }
            return ary;
        }

        public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number):void
        {
            var y:Number = NaN;
            var x:Number = NaN;
            if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0)
            {
                return;
            }
            var Ox:Number = beginPoint.x;
            var Oy:Number = beginPoint.y;
            var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
            var totalLen:Number = Point.distance(beginPoint, endPoint);
            trace("big map :" + totalLen);
            var currLen:* = 0;
            while (currLen <= totalLen)
            {
                if (_collideRect.contains(x, y))
                {
                    return;
                }
                x = Ox + Math.cos(radian) * currLen;
                y = Oy + Math.sin(radian) * currLen;
                graphics.moveTo(x, y);
                currLen = Number(currLen + width);
                if (currLen > totalLen)
                {
                    currLen = totalLen;
                }
                x = Ox + Math.cos(radian) * currLen;
                y = Oy + Math.sin(radian) * currLen;
                graphics.lineTo(x, y);
                currLen = Number(currLen + grap);
            }
        }

        private function drawArrow(graphics:Graphics, start:Point, end:Point, angle:Number, length:int):void
        {
            var y:Number = NaN;
            var x:Number = NaN;
            if (!start || !end || !angle || length <= 0)
            {
                return;
            }
            var radian:Number = Math.atan2(end.y - start.y, end.x - start.x);
            angle = angle * 3.14159265358979 / 180;
            graphics.moveTo(end.x, end.y);
            x = end.x + Math.cos(radian + angle) * length;
            y = end.y + Math.sin(radian + angle) * length;
            graphics.lineTo(x, y);
            graphics.moveTo(end.x, end.y);
            x = end.x + Math.cos(radian - angle) * length;
            y = end.y + Math.sin(radian - angle) * length;
            graphics.lineTo(x, y);
        }

        protected function __playerChange(event:CrazyTankSocketEvent):void
        {
            _drawRoute.graphics.clear();
            _useAble = false;
            currentLivID = -1;
            var _loc4_:int = 0;
            var _loc3_:* = _allLivings;
            for each(var liv in _allLivings)
            {
                liv.state = false;
            }
        }

        private function __playerExit(e:Event):void
        {
            if (_useAble)
            {
                currentLivID = calculateRecent();
            }
        }

        protected function __changeAngle(event:LivingEvent):void
        {
            if (_useAble)
            {
                showShoot();
            }
        }

        protected function __wishofdd(event:CrazyTankSocketEvent):void
        {
            var pwind:Number = NaN;
            var weatherLevel:int = 0;
            var weatherRate:Number = NaN;
            var pwind2:Number = NaN;
            var shoot:Boolean = event.pkg.readBoolean();
            if (shoot)
            {
                pwind = event.pkg.readInt();
                weatherLevel = event.pkg.readInt();
                weatherRate = event.pkg.readInt() / 100;
                _mapWind = pwind * weatherRate / 10 * _windFactor;
                _useAble = true;
                showShoot();
            }
            else
            {
                pwind2 = event.pkg.readInt();
                _useAble = false;
            }
        }

        private function __thumbnailControlHandle(e:GameEvent):void
        {
            currentLivID = e.data as int;
        }

        private function calculateRecent():int
        {
            var livRoute:* = undefined;
            var length:int = 0;
            var distance:int = 0;
            var min:* = 2147483647;
            var ret:int = -1;
            var _loc8_:int = 0;
            var _loc7_:* = _allLivings;
            for each(var liv in _allLivings)
            {
                if (liv.route)
                {
                    if (RoomManager.Instance.current.type == 29 || !(liv is SmallEnemy))
                    {
                        livRoute = liv.route;
                        length = livRoute.length;
                        if (length >= 2)
                        {
                            distance = getDistance(livRoute[0], livRoute[length - 1]);
                            if (distance < min)
                            {
                                min = distance;
                                ret = liv.LivingID;
                            }
                        }
                    }
                }
            }
            return ret;
        }

        private function getDistance(start:Point, end:Point):int
        {
            return (end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y);
        }

        public function get barrier():DungeonInfoView
        {
            return _barrier;
        }

        public function get messageBtn():BaseButton
        {
            return _messageBtn;
        }
    }
}
