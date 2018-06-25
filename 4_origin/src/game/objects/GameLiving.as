package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PropItemView;
   import ddt.view.chat.chatBall.ChatBallBase;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import game.actions.LivingDeadEffectAction;
   import game.actions.LivingFallingAction;
   import game.actions.LivingJumpAction;
   import game.actions.LivingMoveAction;
   import game.actions.LivingTurnAction;
   import game.actions.PlayerFallingAction;
   import game.actions.PlayerWalkAction;
   import game.animations.ShockMapAnimation;
   import game.view.AutoPropEffect;
   import game.view.EffectIconContainer;
   import game.view.IDisplayPack;
   import game.view.buff.FightBuffBar;
   import game.view.buff.SkillBuffBar;
   import game.view.effects.ShootPercentView;
   import game.view.effects.ShowEffect;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.event.LivingCommandEvent;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import gameCommon.view.smallMap.SmallLiving;
   import gameCommon.view.smallMap.SmallPlayer;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovie;
   import road.game.resource.ActionMovieEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.data.StringObject;
   import road7th.utils.AutoDisappear;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import tank.events.ActionEvent;
   
   public class GameLiving extends PhysicalObj
   {
      
      protected static var SHOCK_EVENT:String = "shockEvent";
      
      protected static var SHOCK_EVENT2:String = "shockEvent2";
      
      protected static var SHIELD:String = "shield";
      
      protected static var BOMB_EVENT:String = "bombEvent";
      
      public static var SHOOT_PREPARED:String = "shootPrepared";
      
      protected static var RENEW:String = "renew";
      
      protected static var NEED_FOCUS:String = "focus";
      
      protected static var PLAY_EFFECT:String = "playeffect";
      
      protected static var PLAYER_EFFECT:String = "effect";
      
      protected static var ATTACK_COMPLETE_FOCUS:String = "attackCompleteFocus";
      
      public static const stepY:int = 7;
      
      public static const npcStepX:int = 1;
      
      public static const npcStepY:int = 3;
       
      
      protected var _info:Living;
      
      protected var _actionMovie:ActionMovie;
      
      protected var _chatballview:ChatBallBase;
      
      protected var _smallView:SmallLiving;
      
      protected var speedMult:int = 1;
      
      protected var _nickName:FilterFrameText;
      
      protected var _targetBlood:int;
      
      protected var targetAttackEffect:int;
      
      protected var _originalHeight:Number;
      
      protected var _originalWidth:Number;
      
      public var bodyWidth:Number;
      
      public var bodyHeight:Number;
      
      public var isExist:Boolean = true;
      
      protected var _turns:int;
      
      private var _offsetX:Number = 0;
      
      private var _offsetY:Number = 0;
      
      private var _speedX:Number = 3;
      
      private var _speedY:Number = 7;
      
      protected var _bloodStripBg:Bitmap;
      
      protected var _HPStrip:ScaleFrameImage;
      
      protected var _bloodWidth:int;
      
      protected var _buffBar:FightBuffBar;
      
      private var _fightPower:FilterFrameText;
      
      private var _buffEffect:DictionaryData;
      
      protected var _attestBtn:ScaleFrameImage;
      
      private var _targetIcon:MovieClip;
      
      protected var _skillBuffBar:SkillBuffBar;
      
      private var _effectIconContainer:EffectIconContainer;
      
      protected var counter:int = 1;
      
      protected var ap:Number = 0;
      
      protected var effectForzen:Sprite;
      
      protected var lock:MovieClip;
      
      private var solidIceEffect:Sprite;
      
      private var _noRemoveEffect:Array;
      
      protected var _isDie:Boolean = false;
      
      protected var _effRect:Rectangle;
      
      private var _attackEffectPlayer:PhysicalObj;
      
      private var _attackEffectPlaying:Boolean = false;
      
      protected var _attackEffectPos:Point;
      
      protected var _moviePool:Object;
      
      private var _hiddenByServer:Boolean;
      
      protected var _propArray:Array;
      
      private var _onSmallMap:Boolean = true;
      
      public function GameLiving(info:Living)
      {
         _buffEffect = new DictionaryData();
         _noRemoveEffect = [20090];
         _attackEffectPos = new Point(0,5);
         _moviePool = {};
         _info = info;
         initView();
         initListener();
         initInfoChange();
         super(info.LivingID);
      }
      
      public static function getAttackEffectAssetByID(id:int) : MovieClip
      {
         var mc:MovieClip = ClassUtils.CreatInstance("asset.game.AttackEffect" + id.toString()) as MovieClip;
         return mc;
      }
      
      public function get stepX() : int
      {
         return _speedX * speedMult;
      }
      
      public function get stepY() : int
      {
         return _speedY * speedMult;
      }
      
      override public function get x() : Number
      {
         return super.x + _offsetX;
      }
      
      override public function get y() : Number
      {
         return super.y + _offsetY;
      }
      
      public function get EffectIcon() : EffectIconContainer
      {
         if(_effectIconContainer == null)
         {
         }
         return _effectIconContainer;
      }
      
      override public function get layer() : int
      {
         if(_layer == -1)
         {
            if(info.isBottom)
            {
               return 6;
            }
            return 1;
         }
         return _layer;
      }
      
      public function get info() : Living
      {
         return _info;
      }
      
      public function get map() : MapView
      {
         return _map as MapView;
      }
      
      private function __fightPowerChanged(event:LivingEvent) : void
      {
         if(_info.fightPower > 0 && _info.fightPower <= 100)
         {
            fightPowerVisible = true;
            _fightPower.text = LanguageMgr.GetTranslation("ddt.games.powerText",_info.fightPower);
         }
         else
         {
            _fightPower.text = "";
         }
      }
      
      public function addTartgetIcon() : void
      {
         if(_targetIcon == null)
         {
            _targetIcon = ComponentFactory.Instance.creat("asset.game.survival.target");
            PositionUtils.setPos(_targetIcon,"game.view.targetPos");
            addChild(_targetIcon);
         }
         else
         {
            _targetIcon.visible = true;
         }
         modifyPlayerColor();
      }
      
      public function deleteTargetIcon() : void
      {
         if(_targetIcon)
         {
            _targetIcon.visible = false;
         }
      }
      
      public function setFightPower(fightPower:int) : void
      {
         if(fightPower > 0 && fightPower <= 100)
         {
            fightPowerVisible = true;
            _fightPower.text = LanguageMgr.GetTranslation("ddt.games.powerText",fightPower);
         }
         else
         {
            _fightPower.text = "";
         }
      }
      
      public function set fightPowerVisible(value:Boolean) : void
      {
         _fightPower.visible = value;
      }
      
      protected function initView() : void
      {
         _propArray = [];
         _bloodStripBg = ComponentFactory.Instance.creatBitmap("asset.game.smallHPStripBgAsset");
         _HPStrip = ComponentFactory.Instance.creatComponentByStylename("asset.game.HPStrip");
         var _loc1_:* = -_bloodStripBg.width / 2 + 2;
         _bloodStripBg.x = _loc1_;
         _HPStrip.x = _HPStrip.x + _loc1_;
         _loc1_ = 20;
         _bloodStripBg.y = _loc1_;
         _HPStrip.y = _HPStrip.y + _loc1_;
         _bloodWidth = _HPStrip.width;
         addChild(_bloodStripBg);
         addChild(_HPStrip);
         _HPStrip.setFrame(info.team);
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("GameLiving.fightPower");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("GameLiving.nickName");
         if(info.playerInfo != null)
         {
            _nickName.text = info.playerInfo.NickName;
         }
         else
         {
            _nickName.text = info.name;
         }
         _nickName.setFrame(info.team);
         _nickName.x = -_nickName.width / 2 + 2;
         _nickName.y = _bloodStripBg.y + _bloodStripBg.height / 2 + 4;
         _buffBar = new FightBuffBar();
         _buffBar.y = -98;
         addChild(_buffBar);
         _buffBar.update(_info.turnBuffs);
         _buffBar.x = -(_buffBar.width / 2);
         _skillBuffBar = new SkillBuffBar();
         _skillBuffBar.y = -80;
         addChild(_skillBuffBar);
         addChild(_nickName);
         _fightPower.x = _nickName.x - 27;
         _fightPower.y = _nickName.y - 130;
         addChild(_fightPower);
         initSmallMapObject();
         mouseEnabled = false;
         mouseChildren = false;
         _loc1_ = _info.isShowBlood;
         _nickName.visible = _loc1_;
         _loc1_ = _loc1_;
         _HPStrip.visible = _loc1_;
         _bloodStripBg.visible = _loc1_;
         updateBloodStrip();
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(info.playerInfo && info.playerInfo.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.buttonMode = true;
            addChild(_attestBtn);
            _attestBtn.x = _nickName.x + _nickName.width;
            _attestBtn.y = _nickName.y;
         }
      }
      
      protected function initInfoChange() : void
      {
         if(_info.isFrozen)
         {
            effectForzen = ClassUtils.CreatInstance("asset.gameFrostEffectAsset") as MovieClip;
            effectForzen.y = 24;
            addChild(effectForzen);
         }
         if(_info.isHidden)
         {
            if(_info.team != GameControl.Instance.Current.selfGamePlayer.team)
            {
               visible = false;
               if(_smallView)
               {
                  _smallView.visible = false;
                  _smallView.alpha = 0;
               }
               alpha = 0;
            }
            else
            {
               alpha = 0.5;
               if(_smallView)
               {
                  _smallView.alpha = 0.5;
               }
            }
         }
         if(_info.markMeHide)
         {
            _info.markMeHide = true;
         }
         if(_info.markMeHideDest)
         {
            _info.markMeHideDest = true;
         }
      }
      
      protected function initSmallMapObject() : void
      {
         var smallPlayer:* = null;
         if(_info.isShowSmallMapPoint)
         {
            if(_info.isPlayer())
            {
               smallPlayer = new SmallPlayer();
               _smallView = smallPlayer;
            }
            else
            {
               _smallView = new SmallLiving();
            }
            _smallView.info = _info;
         }
      }
      
      protected function initEffectIcon() : void
      {
      }
      
      protected function initFreezonRect() : void
      {
         _effRect = new Rectangle(0,24,200,200);
      }
      
      public function addChildrenByPack(pack:IDisplayPack) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = pack.content;
         for each(var someDO in pack.content)
         {
            addChild(someDO);
         }
      }
      
      protected function initListener() : void
      {
         _info.addEventListener("beat",__beat);
         _info.addEventListener("beginNewTurn",__beginNewTurn);
         _info.addEventListener("bloodChanged",__bloodChanged);
         _info.addEventListener("die",__die);
         _info.addEventListener("dirChanged",__dirChanged);
         _info.addEventListener("fall",__fall);
         _info.addEventListener("forzenChanged",__forzenChanged);
         _info.addEventListener("hiddenChanged",__hiddenChanged);
         _info.addEventListener("mark_me_hide_dest",__markMeHideDest);
         _info.addEventListener("solidiceStateChanged",_solidIceStateChanged);
         _info.addEventListener("targetStealthStateChanged",_targetStealthStateChanged);
         _info.addEventListener("enableSpellKill",_enableSpellSkill);
         _info.addEventListener("addSkillBuffBar",_addSkillBuffBar_Handler);
         _info.addEventListener("playmovie",__playMovie);
         _info.addEventListener("turnrotation",__turnRotation);
         _info.addEventListener("jump",__jump);
         _info.addEventListener("moveTo",__moveTo);
         _info.addEventListener("maxHpChanged",__maxHpChanged);
         _info.addEventListener("lockState",__lockStateChanged);
         _info.addEventListener("posChanged",__posChanged);
         _info.addEventListener("shoot",__shoot);
         _info.addEventListener("transmit",__transmit);
         _info.addEventListener("say",__say);
         _info.addEventListener("startMoving",__startMoving);
         _info.addEventListener("changeState",__changeState);
         _info.addEventListener("showAttackEffect",__showAttackEffect);
         _info.addEventListener("playDeadEffect",__playDeadEffect);
         _info.addEventListener("bombed",__bombed);
         _info.addEventListener("playskillMovie",__playSkillMovie);
         _info.addEventListener("buffChanged",__buffChanged);
         _info.addEventListener("playContinuousEffect",__playContinuousEffect);
         _info.addEventListener("removeContinuousEffect",__removeContinuousEffect);
         _info.addEventListener("livingCommand",__onLivingCommand);
         if(_chatballview)
         {
            _chatballview.addEventListener("complete",onChatBallComplete);
         }
         if(_actionMovie)
         {
            _actionMovie.addEventListener("renew",__renew);
            _actionMovie.addEventListener(SHOCK_EVENT2,__shockMap2);
            _actionMovie.addEventListener(SHOCK_EVENT,__shockMap);
            _actionMovie.addEventListener(NEED_FOCUS,__needFocus);
            _actionMovie.addEventListener(SHIELD,__showDefence);
            _actionMovie.addEventListener(ATTACK_COMPLETE_FOCUS,__attackCompleteFocus);
            _actionMovie.addEventListener(BOMB_EVENT,__startBlank);
            _actionMovie.addEventListener(PLAY_EFFECT,__playEffect);
            _actionMovie.addEventListener(PLAYER_EFFECT,__playerEffect);
         }
      }
      
      protected function __markMeHideDest(event:LivingEvent) : void
      {
         if(_info.markMeHideDest)
         {
            alpha = 0.5;
            visible = true;
            if(_smallView)
            {
               _smallView.visible = true;
               _smallView.alpha = 0.5;
            }
         }
         else
         {
            __hiddenChanged(null);
         }
      }
      
      public function replaceMovie() : void
      {
         var labelMap:* = null;
         var currentAction:* = null;
         var movieClass:* = null;
         if(_actionMovie && _actionMovie.shouldReplace && info && ModuleLoader.hasDefinition(info.actionMovieName))
         {
            labelMap = _actionMovie.labelMapping;
            currentAction = _actionMovie.currentAction;
            removeChild(_actionMovie);
            _actionMovie = null;
            movieClass = ModuleLoader.getDefinition(info.actionMovieName) as Class;
            _actionMovie = new movieClass();
            _info.actionMovieBitmap = new Bitmap(getBodyBitmapData("show2"));
            _info.thumbnail = getBodyBitmapData("show");
            _actionMovie.scaleX = -_info.direction;
            _actionMovie.mouseEnabled = false;
            _actionMovie.mouseChildren = false;
            _actionMovie.scrollRect = null;
            _actionMovie.shouldReplace = false;
            _actionMovie.labelMapping = labelMap;
            _actionMovie.doAction(currentAction);
            addChild(_actionMovie);
         }
      }
      
      protected function __addToState(event:Event) : void
      {
         initInfoChange();
      }
      
      protected function __removeContinuousEffect(event:LivingEvent) : void
      {
         removeBuffEffect(int(event.paras[0]));
      }
      
      protected function __playContinuousEffect(event:LivingEvent) : void
      {
         showBuffEffect(event.paras[0],int(event.paras[1]));
      }
      
      protected function __buffChanged(event:LivingEvent) : void
      {
         if((event.paras[0] == 0 || event.paras[0] == 6) && _info && _info.isLiving)
         {
            if(_buffBar)
            {
               _buffBar.update(_info.turnBuffs);
               if(_info.turnBuffs.length > 0)
               {
                  _buffBar.x = 5 - _buffBar.width / 2;
                  _buffBar.y = bodyHeight * -1 - 23;
                  addChild(_buffBar);
               }
               else if(_buffBar.parent)
               {
                  _buffBar.parent.removeChild(_buffBar);
               }
            }
         }
         if(!_info.isLiving)
         {
            GameControl.Instance.gameView.deleteAnimation(2);
         }
      }
      
      protected function __removeSkillMovie(event:LivingEvent) : void
      {
      }
      
      protected function __applySkill(event:LivingEvent) : void
      {
      }
      
      protected function __playSkillMovie(event:LivingEvent) : void
      {
         showEffect(event.paras[0]);
      }
      
      protected function __skillMovieComplete(event:Event) : void
      {
         var movie:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         movie.removeEventListener("complete",__skillMovieComplete);
      }
      
      protected function __bombed(event:LivingEvent) : void
      {
      }
      
      protected function removeListener() : void
      {
         if(_info)
         {
            _info.removeEventListener("beat",__beat);
            _info.removeEventListener("beginNewTurn",__beginNewTurn);
            _info.removeEventListener("bloodChanged",__bloodChanged);
            _info.removeEventListener("enableSpellKill",_enableSpellSkill);
            _info.removeEventListener("die",__die);
            _info.removeEventListener("dirChanged",__dirChanged);
            _info.removeEventListener("fall",__fall);
            _info.removeEventListener("forzenChanged",__forzenChanged);
            _info.removeEventListener("hiddenChanged",__hiddenChanged);
            _info.removeEventListener("mark_me_hide_dest",__markMeHideDest);
            _info.removeEventListener("solidiceStateChanged",_solidIceStateChanged);
            _info.removeEventListener("targetStealthStateChanged",_targetStealthStateChanged);
            _info.removeEventListener("addSkillBuffBar",_addSkillBuffBar_Handler);
            _info.removeEventListener("playmovie",__playMovie);
            _info.removeEventListener("turnrotation",__turnRotation);
            _info.removeEventListener("playskillMovie",__playSkillMovie);
            _info.removeEventListener("removeSkillMovie",__removeSkillMovie);
            _info.removeEventListener("jump",__jump);
            _info.removeEventListener("moveTo",__moveTo);
            _info.removeEventListener("lockState",__lockStateChanged);
            _info.removeEventListener("posChanged",__posChanged);
            _info.removeEventListener("shoot",__shoot);
            _info.removeEventListener("transmit",__transmit);
            _info.removeEventListener("say",__say);
            _info.removeEventListener("startMoving",__startMoving);
            _info.removeEventListener("changeState",__changeState);
            _info.removeEventListener("showAttackEffect",__showAttackEffect);
            _info.removeEventListener("playDeadEffect",__playDeadEffect);
            _info.removeEventListener("bombed",__bombed);
            _info.removeEventListener("applySkill",__applySkill);
            _info.removeEventListener("buffChanged",__buffChanged);
            _info.removeEventListener("maxHpChanged",__maxHpChanged);
            _info.removeEventListener("playContinuousEffect",__playContinuousEffect);
            _info.removeEventListener("removeContinuousEffect",__removeContinuousEffect);
            _info.removeEventListener("livingCommand",__onLivingCommand);
         }
         if(_chatballview)
         {
            _chatballview.removeEventListener("complete",onChatBallComplete);
         }
         if(_actionMovie)
         {
            _actionMovie.removeEventListener("renew",__renew);
            _actionMovie.removeEventListener(SHOCK_EVENT2,__shockMap2);
            _actionMovie.removeEventListener(SHOCK_EVENT,__shockMap);
            _actionMovie.removeEventListener(NEED_FOCUS,__needFocus);
            _actionMovie.removeEventListener(SHIELD,__showDefence);
            _actionMovie.removeEventListener(BOMB_EVENT,__startBlank);
            _actionMovie.removeEventListener(PLAY_EFFECT,__playEffect);
            _actionMovie.removeEventListener(PLAYER_EFFECT,__playerEffect);
         }
      }
      
      protected function __shockMap(evt:ActionEvent) : void
      {
         if(map)
         {
            map.animateSet.addAnimation(new ShockMapAnimation(this,evt.param as int,20));
         }
      }
      
      protected function __shockMap2(evt:Event) : void
      {
         if(map)
         {
            map.animateSet.addAnimation(new ShockMapAnimation(this,30,20));
         }
      }
      
      protected function __renew(evt:Event) : void
      {
         this._info.showAttackEffect(2);
      }
      
      protected function __startBlank(evt:Event) : void
      {
         addEventListener("enterFrame",drawBlank);
      }
      
      protected function drawBlank(evt:Event) : void
      {
         if(counter <= 15)
         {
            graphics.clear();
            ap = 0.00444444444444444 * (counter * counter);
            graphics.beginFill(16777215,ap);
            graphics.drawRect(-3000,-1800,7000,4200);
         }
         else if(counter <= 23)
         {
            graphics.clear();
            ap = 1;
            graphics.beginFill(16777215,ap);
            graphics.drawRect(-3000,-1800,7000,4200);
         }
         else if(counter <= 75)
         {
            graphics.clear();
            ap = ap - 0.02;
            graphics.beginFill(16777215,ap);
            graphics.drawRect(-3000,-1800,7000,4200);
         }
         else
         {
            graphics.clear();
            removeEventListener("enterFrame",drawBlank);
         }
         counter = Number(counter) + 1;
      }
      
      protected function __showDefence(evt:Event) : void
      {
         var show:ShowEffect = new ShowEffect(ShowEffect.GUARD);
         show.x = x + offset();
         show.y = y - 50 + offset(25);
         _map.addChild(show);
      }
      
      protected function __addEffectHandler(e:DictionaryEvent) : void
      {
         var baseeffect:BaseMirariEffectIcon = e.data as BaseMirariEffectIcon;
         EffectIcon.handleEffect(baseeffect.mirariType,baseeffect.getEffectIcon());
      }
      
      protected function __removeEffectHandler(e:DictionaryEvent) : void
      {
         var baseeffect:BaseMirariEffectIcon = e.data as BaseMirariEffectIcon;
         EffectIcon.removeEffect(baseeffect.mirariType);
      }
      
      protected function __clearEffectHandler(e:DictionaryEvent) : void
      {
         EffectIcon.clearEffectIcon();
      }
      
      protected function __sizeChangeHandler(e:Event) : void
      {
         EffectIcon.x = 5 - EffectIcon.width / 2;
         EffectIcon.y = bodyHeight * -1 - EffectIcon.height;
      }
      
      protected function __changeState(evt:LivingEvent) : void
      {
      }
      
      protected function initMovie() : void
      {
         var movieClass:* = null;
         if(!info)
         {
            return;
         }
         if(ModuleLoader.hasDefinition(info.actionMovieName))
         {
            movieClass = ModuleLoader.getDefinition(info.actionMovieName) as Class;
            _actionMovie = new movieClass();
            _info.actionMovieBitmap = new Bitmap(getBodyBitmapData("show2"));
            _info.thumbnail = getBodyBitmapData("show");
            _actionMovie.mouseEnabled = false;
            _actionMovie.mouseChildren = false;
            _actionMovie.scrollRect = null;
            addChild(_actionMovie);
            _actionMovie.gotoAndStop(1);
            _actionMovie.scaleX = -_info.direction;
            _actionMovie.shouldReplace = false;
         }
         else if(ModuleLoader.hasDefinition("game.living.defaultSmallEnemyLiving"))
         {
            if(info.typeLiving != 4 && info.typeLiving != 5 && info.typeLiving != 6 && info.typeLiving != 12)
            {
               movieClass = ModuleLoader.getDefinition("game.living.defaultSmallEnemyLiving") as Class;
            }
            else
            {
               movieClass = ModuleLoader.getDefinition("game.living.defaultSimpleBossLiving") as Class;
            }
            _actionMovie = new movieClass();
            _info.actionMovieBitmap = new Bitmap(getBodyBitmapData("show2"));
            _info.thumbnail = getBodyBitmapData("show");
            _actionMovie.mouseEnabled = false;
            _actionMovie.mouseChildren = false;
            _actionMovie.scrollRect = null;
            addChild(_actionMovie);
            _actionMovie.gotoAndStop(1);
            _actionMovie.scaleX = 1;
            _actionMovie.shouldReplace = true;
         }
         initChatball();
      }
      
      protected function initChatball() : void
      {
         _chatballview = new ChatBallPlayer();
         _originalHeight = _actionMovie.height;
         _originalWidth = _actionMovie.width;
         addChild(_chatballview);
      }
      
      protected function __startMoving(event:LivingEvent) : void
      {
         if(_map == null)
         {
            return;
         }
         var pos:Point = _map.findYLineNotEmptyPointDown(x,y,_map.height);
         if(pos == null)
         {
            pos = new Point(x,_map.height + 1);
         }
         _info.fallTo(pos,20);
      }
      
      protected function __say(event:LivingEvent) : void
      {
         if(_info.isHidden)
         {
            return;
         }
         _chatballview.x = 0;
         _chatballview.y = 0;
         addChild(_chatballview);
         var data:String = event.paras[0] as String;
         var type:int = 0;
         if(event.paras[1])
         {
            type = event.paras[1];
         }
         _chatballview.setText(data,type);
         fitChatBallPos();
      }
      
      protected function fitChatBallPos() : void
      {
         _chatballview.x = popPos.x;
         _chatballview.y = popPos.y;
         if(popDir)
         {
            _chatballview.directionY = popDir.y - _chatballview.y;
            _chatballview.directionX = popDir.x - _chatballview.x;
         }
      }
      
      protected function get popPos() : Point
      {
         if(movie["popupPos"])
         {
            return new Point(movie["popupPos"].x,movie["popupPos"].y);
         }
         return new Point(-(_originalWidth * 0.4) * movie.scaleX,-(_originalHeight * 0.8) * movie.scaleY);
      }
      
      protected function get popDir() : Point
      {
         if(movie["popupDir"])
         {
            return new Point(movie["popupDir"].x,movie["popupDir"].y);
         }
         return popPos;
      }
      
      override public function collidedByObject(obj:PhysicalObj) : void
      {
      }
      
      protected function __beat(event:LivingEvent) : void
      {
         if(_isLiving)
         {
            targetAttackEffect = event.paras[0][0].attackEffect;
            _actionMovie.doAction(event.paras[0][0].action,updateTargetsBlood,event.paras);
         }
      }
      
      protected function updateTargetsBlood(arg:Array) : void
      {
         var i:int = 0;
         var living:* = null;
         if(arg == null)
         {
            return;
         }
         var deadEffectLivings:Array = [];
         var selfFocus:Boolean = false;
         for(i = 0; i < arg.length; )
         {
            trace("arg_target:" + arg[i].target + ",targetID:" + arg[i].target.LivingID + ",targetState:" + arg[i].target.isLiving);
            if(arg[i] && arg[i].target && arg[i].target.isLiving)
            {
               living = arg[i].target;
               living.isHidden = false;
               if(arg[i].deadEffect != "")
               {
                  deadEffectLivings.push(arg[i]);
               }
               else
               {
                  trace("arg_targetID:" + living.LivingID + ",blood:" + arg[i].targetBlood);
                  living.showAttackEffect(arg[i].attackEffect);
                  living.updateBlood(arg[i].targetBlood,arg[i].type,arg[i].damage);
               }
               if(!selfFocus)
               {
                  map.setCenter(living.pos.x,living.pos.y - 150,true);
               }
               if(living.isSelf)
               {
                  selfFocus = true;
               }
            }
            i++;
         }
         if(deadEffectLivings.length > 0)
         {
            map.act(new LivingDeadEffectAction(deadEffectLivings));
         }
      }
      
      protected function __beginNewTurn(event:LivingEvent) : void
      {
      }
      
      protected function __playMovie(event:LivingEvent) : void
      {
         if(_actionMovie)
         {
            _actionMovie.doAction(event.paras[0],event.paras[1],event.paras[2]);
         }
      }
      
      protected function __turnRotation(event:LivingEvent) : void
      {
         act(new LivingTurnAction(this,event.paras[0],event.paras[1],event.paras[2]));
      }
      
      protected function __bloodChanged(event:LivingEvent) : void
      {
         var movie:* = null;
         var index:int = 0;
         var showBlood:int = 0;
         if(!isExist || !_map)
         {
            return;
         }
         var diff:Number = event.value - event.old;
         var type:int = event.paras[0];
         var _loc7_:* = type;
         if(0 !== _loc7_)
         {
            if(90 !== _loc7_)
            {
               if(5 !== _loc7_)
               {
                  if(3 !== _loc7_)
                  {
                     if(11 !== _loc7_)
                     {
                        showBlood = event.paras[1];
                        if(showBlood < 0)
                        {
                           diff = showBlood;
                        }
                        if(diff != 0)
                        {
                           movie = new ShootPercentView(Math.abs(diff),event.paras[0],false);
                           movie.x = x + offset();
                           movie.y = y - 50 + offset(25);
                           _loc7_ = 0.8 + Math.random() * 0.4;
                           movie.scaleY = _loc7_;
                           movie.scaleX = _loc7_;
                           _map.addToPhyLayer(movie);
                           if(GameControl.Instance.Current.roomType != 120)
                           {
                              if(_info.isHidden)
                              {
                                 if(_info.team == GameControl.Instance.Current.selfGamePlayer.team)
                                 {
                                    movie.alpha == 0.5;
                                 }
                                 else
                                 {
                                    visible = false;
                                    movie.alpha = 0;
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        showBlood = event.paras[1];
                        if(showBlood < 0)
                        {
                           diff = showBlood;
                        }
                        if(diff != 0)
                        {
                           movie = new ShootPercentView(Math.abs(diff),event.paras[0],false);
                           movie.x = x - 70;
                           movie.y = y - 80;
                           _loc7_ = 0.8 + Math.random() * 0.4;
                           movie.scaleY = _loc7_;
                           movie.scaleX = _loc7_;
                           _map.addToPhyLayer(movie);
                        }
                     }
                  }
                  else
                  {
                     showBlood = event.paras[1];
                     diff = showBlood;
                     if(diff != 0)
                     {
                        movie = new ShootPercentView(Math.abs(diff),1,false);
                        movie.x = x + offset();
                        movie.y = y - 50 + offset(25);
                        _loc7_ = 0.8 + Math.random() * 0.4;
                        movie.scaleY = _loc7_;
                        movie.scaleX = _loc7_;
                        _map.addToPhyLayer(movie);
                     }
                  }
               }
            }
            else
            {
               movie = new ShootPercentView(0,2);
               movie.x = x + offset();
               movie.y = y - 50 + offset(25);
               _loc7_ = 0.8 + Math.random() * 0.4;
               movie.scaleY = _loc7_;
               movie.scaleX = _loc7_;
               _map.addToPhyLayer(movie);
            }
         }
         else
         {
            diff = event.paras[1];
            if(diff != 0 && _info.blood != 0)
            {
               movie = new ShootPercentView(Math.abs(diff),1,true);
               movie.x = x + offset();
               movie.y = y - 50 + offset(25);
               _loc7_ = 0.8 + Math.random() * 0.4;
               movie.scaleY = _loc7_;
               movie.scaleX = _loc7_;
               _map.addToPhyLayer(movie);
               if(_info.isHidden)
               {
                  if(_info.team == GameControl.Instance.Current.selfGamePlayer.team)
                  {
                     movie.alpha == 0.5;
                  }
                  else
                  {
                     visible = false;
                     movie.alpha = 0;
                  }
               }
            }
         }
         updateBloodStrip();
      }
      
      protected function __maxHpChanged(event:LivingEvent) : void
      {
         updateBloodStrip();
      }
      
      protected function updateBloodStrip() : void
      {
         if(info.blood < 0)
         {
            _HPStrip.width = 0;
         }
         else
         {
            _HPStrip.width = Math.floor(_bloodWidth / info.maxBlood * info.blood);
         }
      }
      
      private function offset(off:int = 30) : int
      {
         var i:int = Math.random() * 10;
         if(i % 2 == 0)
         {
            return -(int(Math.random() * off));
         }
         return int(Math.random() * off);
      }
      
      protected function __die(event:LivingEvent) : void
      {
         if(_isLiving)
         {
            _isLiving = false;
            die();
         }
      }
      
      override public function die() : void
      {
         info.isFrozen = false;
         info.isNoNole = false;
         info.markMeHide = false;
         info.markMeHideDest = false;
         info.isHidden = false;
         info.showSolidIce = false;
         if(_bloodStripBg && _bloodStripBg.parent)
         {
            _bloodStripBg.parent.removeChild(_bloodStripBg);
         }
         if(_HPStrip && _HPStrip.parent)
         {
            _HPStrip.parent.removeChild(_HPStrip);
         }
         if(_buffBar)
         {
            _buffBar.dispose();
            _buffBar = null;
         }
         if(_skillBuffBar)
         {
            _skillBuffBar.dispose();
            _skillBuffBar = null;
         }
         if(_targetIcon)
         {
            ObjectUtils.disposeObject(_targetIcon);
            _targetIcon = null;
         }
         removeAllPetBuffEffects();
      }
      
      public function revive() : void
      {
         _info.revive();
         _isLiving = true;
         if(_bloodStripBg)
         {
            addChild(_bloodStripBg);
         }
         if(_HPStrip)
         {
            addChild(_HPStrip);
         }
         _buffBar = new FightBuffBar();
         _buffBar.y = -98;
         _buffBar.update(_info.turnBuffs);
         _buffBar.x = -(_buffBar.width / 2);
      }
      
      protected function __dirChanged(event:LivingEvent) : void
      {
         if((_info is SmallEnemy || _info is SimpleBoss) && _actionMovie && _actionMovie.shouldReplace)
         {
            movie.scaleX = 1;
            return;
         }
         if(_info.direction > 0)
         {
            movie.scaleX = -1;
         }
         else
         {
            movie.scaleX = 1;
         }
      }
      
      protected function __forzenChanged(event:LivingEvent) : void
      {
         if(_info.isFrozen)
         {
            effectForzen = ClassUtils.CreatInstance("asset.gameFrostEffectAsset") as MovieClip;
            effectForzen.y = 24;
            addChild(effectForzen);
         }
         else if(effectForzen)
         {
            trace("...");
            removeChild(effectForzen);
            effectForzen = null;
         }
      }
      
      protected function __lockStateChanged(evt:LivingEvent) : void
      {
         if(_info.LockState)
         {
            lock = ClassUtils.CreatInstance("asset.gameII.LockAsset") as MovieClip;
            lock.x = 10;
            lock.y = 5;
            addChild(lock);
            if(evt.paras[0] == 2)
            {
               lock.y = lock.y + 50;
               var _loc2_:* = 0.8;
               lock.scaleY = _loc2_;
               lock.scaleX = _loc2_;
               lock.stop();
               lock.alpha = 0.7;
            }
         }
         else if(lock)
         {
            removeChild(lock);
            lock = null;
         }
      }
      
      protected function _solidIceStateChanged(event:LivingEvent) : void
      {
         if(_info.showSolidIce)
         {
            solidIceEffect = ClassUtils.CreatInstance("asset.gameTrailFrostEffectAsset") as MovieClip;
            solidIceEffect.y = 24;
            addChild(solidIceEffect);
         }
         else if(solidIceEffect)
         {
            removeChild(solidIceEffect);
            solidIceEffect = null;
         }
      }
      
      protected function _targetStealthStateChanged(event:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = map.gameInfo.livings;
         for each(var player in map.gameInfo.livings)
         {
            if(player.isPlayer() && player.team != _info.team && !player.isSelf)
            {
               if(_info.isRemoveStealth)
               {
                  if(player.isHidden)
                  {
                     player.removeStealth = true;
                  }
               }
               else if(player.removeStealth)
               {
                  player.removeStealth = false;
               }
            }
         }
      }
      
      protected function _enableSpellSkill(evt:LivingEvent) : void
      {
         GameControl.Instance.Current.selfGamePlayer.lockSpellKill = _info.noUseCritical;
      }
      
      protected function _addSkillBuffBar_Handler(evt:LivingEvent) : void
      {
         var isAdd:Boolean = false;
         var iconId:int = 0;
         var paras:Array = evt.paras;
         if(_skillBuffBar && paras.length >= 2)
         {
            isAdd = paras[1];
            iconId = paras[0];
            !!isAdd?_skillBuffBar.addIcon(iconId):_skillBuffBar.removeIcon(iconId);
            _skillBuffBar.x = -(_skillBuffBar.width / 2);
         }
      }
      
      protected function __hiddenChanged(event:LivingEvent) : void
      {
         if(_info.isHidden)
         {
            if(_info.team != GameControl.Instance.Current.selfGamePlayer.team)
            {
               visible = false;
               if(_smallView)
               {
                  _smallView.visible = false;
                  _smallView.alpha = 0;
               }
               alpha = 0;
            }
            else
            {
               alpha = 0.5;
               if(_smallView)
               {
                  _smallView.alpha = 0.5;
               }
            }
         }
         else
         {
            alpha = 1;
            visible = true;
            if(_smallView)
            {
               _smallView.visible = true;
               _smallView.alpha = 1;
            }
            if(parent)
            {
               parent.addChild(this);
            }
         }
      }
      
      protected function __posChanged(event:LivingEvent) : void
      {
         var angle:Number = NaN;
         pos = _info.pos;
         if(_isLiving)
         {
            angle = calcObjectAngle(16);
            _info.playerAngle = angle;
         }
         if(map)
         {
            map.smallMap.updatePos(smallView,pos);
            map.updateObjectPos(this,pos);
         }
      }
      
      protected function __jump(event:LivingEvent) : void
      {
         doAction(event.paras[2]);
         act(new LivingJumpAction(this,event.paras[0],event.paras[1],event.paras[3]));
      }
      
      protected function __moveTo(event:LivingEvent) : void
      {
         var offset:* = null;
         var action:String = event.paras[4];
         doAction(action);
         var speed:int = event.paras[5];
         if(speed == 0)
         {
            speed = 7;
         }
         var pt:Point = event.paras[1] as Point;
         var dir:int = event.paras[2];
         var endAction:String = event.paras[6];
         if(x == pt.x && y == pt.y)
         {
            return;
         }
         var path:Array = [];
         var tx:int = x;
         var ty:int = y;
         var thisPos:Point = new Point(x,y);
         var direction:int = pt.x > tx?1:-1;
         var p:Point = new Point(x,y);
         if(action.substr(0,3) == "fly")
         {
            offset = new Point(pt.x - p.x,pt.y - p.y);
            while(offset.length > speed)
            {
               offset.normalize(speed);
               p = new Point(p.x + offset.x,p.y + offset.y);
               offset = new Point(pt.x - p.x,pt.y - p.y);
               if(p)
               {
                  path.push(p);
                  continue;
               }
               path.push(pt);
               break;
            }
         }
         else
         {
            while((pt.x - tx) * direction > 0)
            {
               p = _map.findNextWalkPoint(tx,ty,direction,speed * 1,speed * 3);
               if(p)
               {
                  path.push(p);
                  tx = p.x;
                  ty = p.y;
                  continue;
               }
               break;
            }
         }
         if(path.length > 0)
         {
            _info.act(new LivingMoveAction(this,path,dir,endAction));
         }
         else if(endAction != "")
         {
            doAction(endAction);
         }
         else
         {
            _info.doDefaultAction();
         }
      }
      
      public function canMoveDirection(dir:Number) : Boolean
      {
         return !map.IsOutMap(x + (15 + Player.MOVE_SPEED) * dir,y);
      }
      
      public function canStand(x:int, y:int) : Boolean
      {
         return !map.IsEmpty(x - 1,y) || !map.IsEmpty(x + 1,y);
      }
      
      public function getNextWalkPoint(dir:int) : Point
      {
         if(canMoveDirection(dir))
         {
            return _map.findNextWalkPoint(x,y,dir,stepX,stepY);
         }
         return null;
      }
      
      private function __needFocus(evt:ActionMovieEvent) : void
      {
         if(evt.data)
         {
            needFocus(evt.data.x,evt.data.y,evt.data);
         }
      }
      
      protected function __playEffect(evt:ActionMovieEvent) : void
      {
      }
      
      protected function __playerEffect(evt:ActionMovieEvent) : void
      {
      }
      
      public function needFocus(offsetX:int = 0, offsetY:int = 0, data:Object = null, player:GameLiving = null) : void
      {
         if(map)
         {
            map.livingSetCenter(x + offsetX,y + offsetY - 150,true,2,data,player);
         }
      }
      
      private function __attackCompleteFocus(event:ActionMovieEvent) : void
      {
         map.setSelfCenter(true,2,event.data);
      }
      
      protected function __shoot(event:LivingEvent) : void
      {
      }
      
      protected function __transmit(event:LivingEvent) : void
      {
         info.pos = event.paras[0];
      }
      
      protected function __fall(event:LivingEvent) : void
      {
         _info.act(new LivingFallingAction(this,event.paras[0],event.paras[1],event.paras[3]));
      }
      
      public function get actionMovie() : ActionMovie
      {
         return _actionMovie;
      }
      
      public function get movie() : Sprite
      {
         return _actionMovie;
      }
      
      public function doAction(actionType:*) : void
      {
         if(_actionMovie != null)
         {
            _actionMovie.doAction(actionType);
         }
      }
      
      public function showEffect(classLink:String) : void
      {
         var mc:* = null;
         if(classLink && ModuleLoader.hasDefinition(classLink))
         {
            mc = new AutoDisappear(ClassUtils.CreatInstance(classLink));
            addChild(mc);
         }
      }
      
      public function showBuffEffect(classLink:String, buffId:int) : void
      {
         var mc:* = null;
         var effMC:* = null;
         if(classLink && ModuleLoader.hasDefinition(classLink))
         {
            if(!_buffEffect)
            {
               return;
            }
            if(_buffEffect && _buffEffect.hasKey(buffId))
            {
               removeBuffEffect(buffId);
            }
            mc = ClassUtils.CreatInstance(classLink) as DisplayObject;
            if(_noRemoveEffect.indexOf(buffId) != -1)
            {
               effMC = new MovieClipWrapper(mc as MovieClip,true,true);
               addChild(effMC.movie);
            }
            else
            {
               addChild(mc);
               _buffEffect.add(buffId,mc);
            }
         }
      }
      
      public function removeBuffEffect(buffId:int) : void
      {
         var mc:* = null;
         if(_buffEffect && _buffEffect.hasKey(buffId))
         {
            mc = _buffEffect[buffId] as DisplayObject;
            if(mc && mc.parent)
            {
               removeChild(mc);
            }
            _buffEffect.remove(buffId);
         }
      }
      
      public function act(action:BaseAction) : void
      {
         _info.act(action);
      }
      
      public function traceCurrentAction() : void
      {
         _info.traceCurrentAction();
      }
      
      override public function update(dt:Number) : void
      {
         if(_isDie)
         {
            return;
         }
         super.update(dt);
         _info.update();
      }
      
      protected function getBodyBmpData(action:String = "") : BitmapData
      {
         return getBodyBitmapData(action);
      }
      
      private function getBodyBitmapData(action:String = "") : BitmapData
      {
         var oldWidth:Number = _actionMovie.width;
         var container:Sprite = new Sprite();
         bodyWidth = _actionMovie.width;
         bodyHeight = _actionMovie.height;
         _actionMovie.gotoAndStop(action);
         var hasChangedSize:Boolean = false;
         if(120 < _actionMovie.width)
         {
            _actionMovie.width = 120;
            _actionMovie.scaleY = _actionMovie.scaleX;
            hasChangedSize = true;
         }
         container.addChild(_actionMovie);
         var clipRect:Rectangle = _actionMovie.getBounds(_actionMovie);
         _actionMovie.x = -clipRect.x * _actionMovie.scaleX;
         _actionMovie.y = -clipRect.y * _actionMovie.scaleX;
         var bitmapdata:BitmapData = new BitmapData(container.width,container.height,true,0);
         bitmapdata.draw(container);
         if(hasChangedSize)
         {
            _actionMovie.width = oldWidth;
            var _loc7_:int = 1;
            _actionMovie.scaleX = _loc7_;
            _actionMovie.scaleY = _loc7_;
         }
         _actionMovie.doAction("stand");
         _loc7_ = 0;
         _actionMovie.y = _loc7_;
         _actionMovie.x = _loc7_;
         container.removeChild(_actionMovie);
         return bitmapdata;
      }
      
      protected function deleteSmallView() : void
      {
         if(_bloodStripBg)
         {
            if(_bloodStripBg.parent)
            {
               _bloodStripBg.parent.removeChild(_bloodStripBg);
            }
            _bloodStripBg.bitmapData.dispose();
            _bloodStripBg = null;
         }
         if(_HPStrip)
         {
            if(_HPStrip.parent)
            {
               _HPStrip.parent.removeChild(_HPStrip);
            }
            _HPStrip.dispose();
            _HPStrip = null;
         }
         if(_nickName)
         {
            if(_nickName.parent)
            {
               _nickName.parent.removeChild(_nickName);
            }
         }
         if(_smallView)
         {
            _smallView.dispose();
            _smallView.visible = false;
         }
         _smallView = null;
      }
      
      private function removeAllPetBuffEffects() : void
      {
         if(_buffEffect)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _buffEffect.list;
            for each(var buf in _buffEffect.list)
            {
               ObjectUtils.disposeObject(buf);
            }
            _buffEffect = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeListener();
         _info = null;
         deleteSmallView();
         removeAllPetBuffEffects();
         if(_buffBar)
         {
            ObjectUtils.disposeObject(_buffBar);
            _buffBar = null;
         }
         if(_skillBuffBar)
         {
            ObjectUtils.disposeObject(_skillBuffBar);
            _skillBuffBar = null;
         }
         if(_targetIcon)
         {
            ObjectUtils.disposeObject(_targetIcon);
            _targetIcon = null;
         }
         if(_fightPower)
         {
            ObjectUtils.disposeObject(_fightPower);
         }
         _fightPower = null;
         if(_nickName)
         {
            _nickName.dispose();
         }
         _nickName = null;
         if(_chatballview)
         {
            _chatballview.dispose();
            if(_chatballview.parent)
            {
               _chatballview.parent.removeChild(_chatballview);
            }
         }
         if(_actionMovie)
         {
            _actionMovie.dispose();
            _actionMovie = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_map)
         {
            _map.removePhysical(this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         cleanMovies();
         isExist = false;
         if(_propArray)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _propArray;
            for each(var o in _propArray)
            {
               ObjectUtils.disposeObject(o);
            }
         }
         _propArray = null;
      }
      
      public function get EffectRect() : Rectangle
      {
         return _effRect;
      }
      
      override public function get smallView() : SmallObject
      {
         return _smallView;
      }
      
      protected function __showAttackEffect(event:LivingEvent) : void
      {
         if(_attackEffectPlaying)
         {
            return;
         }
         if(_info == null)
         {
            return;
         }
         _attackEffectPlaying = true;
         var effectID:int = event.paras[0];
         var effect:MovieClip = creatAttackEffectAssetByID(effectID);
         effect.scaleX = -1 * _info.direction;
         var warpper:MovieClipWrapper = new MovieClipWrapper(effect,true,true);
         warpper.addEventListener("complete",__playComplete);
         warpper.gotoAndPlay(1);
         _attackEffectPlayer = new PhysicalObj(-1);
         _attackEffectPlayer.addChild(warpper.movie);
         var pos:Point = _map.globalToLocal(movie.localToGlobal(_attackEffectPos));
         _attackEffectPlayer.x = pos.x;
         _attackEffectPlayer.y = pos.y;
         _map.addPhysical(_attackEffectPlayer);
      }
      
      protected function __playDeadEffect(event:LivingEvent) : void
      {
         var backFun:Function = event.paras[2] as Function;
         if(backFun != null)
         {
            backFun(event.paras[3]);
         }
      }
      
      private function __playComplete(event:Event) : void
      {
         if(event.currentTarget)
         {
            event.currentTarget.removeEventListener("complete",__playComplete);
         }
         if(_map)
         {
            _map.removePhysical(_attackEffectPlayer);
         }
         if(_attackEffectPlayer && _attackEffectPlayer.parent)
         {
            _attackEffectPlayer.parent.removeChild(_attackEffectPlayer);
         }
         _attackEffectPlaying = false;
         _attackEffectPlayer = null;
      }
      
      protected function hasMovie(name:String) : Boolean
      {
         return _moviePool.hasOwnProperty(name);
      }
      
      protected function creatAttackEffectAssetByID(id:int) : MovieClip
      {
         var mc:* = null;
         var name:String = "asset.game.AttackEffect" + id;
         if(hasMovie(name))
         {
            return _moviePool[name] as MovieClip;
         }
         mc = ClassUtils.CreatInstance("asset.game.AttackEffect" + id.toString()) as MovieClip;
         _moviePool[name] = mc;
         return mc;
      }
      
      private function cleanMovies() : void
      {
         var movie:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _moviePool;
         for(var key in _moviePool)
         {
            movie = _moviePool[key];
            movie.stop();
            ObjectUtils.disposeObject(movie);
            delete _moviePool[key];
         }
      }
      
      public function showBlood(value:Boolean) : void
      {
         var _loc2_:* = value;
         _HPStrip.visible = _loc2_;
         _bloodStripBg.visible = _loc2_;
         _nickName.visible = value;
      }
      
      override public function setActionMapping(source:String, target:String) : void
      {
         _actionMovie.setActionMapping(source,target);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(hiddenByServer)
         {
            return;
         }
         .super.visible = value;
         if(_onSmallMap == false)
         {
            return;
         }
         if(_smallView)
         {
            _smallView.visible = value;
         }
      }
      
      private function get hiddenByServer() : Boolean
      {
         return _hiddenByServer;
      }
      
      private function set hiddenByServer(value:Boolean) : void
      {
         if(value)
         {
            .super.visible = false;
         }
         else
         {
            .super.visible = true;
         }
         _hiddenByServer = value;
      }
      
      protected function __onLivingCommand(evt:LivingCommandEvent) : void
      {
         var _loc2_:* = evt.commandType;
         if("focusSelf" !== _loc2_)
         {
            if("focus" === _loc2_)
            {
               needFocus(evt.object.x,evt.object.y);
               return;
            }
         }
         else
         {
            map.setCenter(GameControl.Instance.Current.selfGamePlayer.pos.x,GameControl.Instance.Current.selfGamePlayer.pos.x,false);
         }
      }
      
      protected function onChatBallComplete(evt:Event) : void
      {
         if(_chatballview && _chatballview.parent)
         {
            _chatballview.parent.removeChild(_chatballview);
         }
         if(GameControl.Instance.gameView.messageBtn)
         {
            GameControl.Instance.gameView.messageBtn.visible = true;
         }
      }
      
      protected function doUseItemAnimation(skip:Boolean = false) : void
      {
         var using:MovieClipWrapper = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset")),true,true);
         using.addFrameScriptAt(12,headPropEffect);
         SoundManager.instance.play("039");
         using.movie.x = 0;
         using.movie.y = -10;
         if(!skip)
         {
            addChild(using.movie);
         }
      }
      
      protected function headPropEffect() : void
      {
         var movie:* = null;
         var head:* = null;
         var pic:* = null;
         if(_propArray && _propArray.length > 0)
         {
            if(_propArray[0] is String)
            {
               pic = _propArray.shift();
               if(pic == "-1")
               {
                  movie = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.specialKillAsset");
               }
               else
               {
                  movie = PropItemView.createView(pic,60,60);
               }
               head = new AutoPropEffect(movie);
               head.x = -5;
               head.y = -140;
            }
            else
            {
               movie = _propArray.shift() as DisplayObject;
               head = new AutoPropEffect(movie);
               head.x = 5;
               head.y = -140;
            }
            addChild(head);
         }
      }
      
      override public function startMoving() : void
      {
         super.startMoving();
         if(_info)
         {
            _info.isMoving = true;
         }
      }
      
      override public function stopMoving() : void
      {
         super.stopMoving();
         if(_info)
         {
            _info.isMoving = false;
         }
      }
      
      public function setProperty(property:String, value:String) : void
      {
         var vo:StringObject = new StringObject(value);
         var _loc4_:* = property;
         if("visible" !== _loc4_)
         {
            if("offsetX" !== _loc4_)
            {
               if("offsetY" !== _loc4_)
               {
                  if("speedX" !== _loc4_)
                  {
                     if("speedY" !== _loc4_)
                     {
                        if("onSmallMap" !== _loc4_)
                        {
                           if("speedMult" !== _loc4_)
                           {
                              info.setProperty(property,value);
                           }
                           else
                           {
                              speedMult = vo.getInt();
                           }
                        }
                        else
                        {
                           if(smallView)
                           {
                              smallView.visible = vo.getBoolean();
                           }
                           _onSmallMap = vo.getBoolean();
                           if(_onSmallMap && _smallView)
                           {
                              _smallView.info = _info;
                           }
                        }
                     }
                     else
                     {
                        speedMult = vo.getInt() / _speedY;
                     }
                  }
                  else
                  {
                     speedMult = vo.getInt() / _speedX;
                  }
                  return;
               }
               _offsetY = vo.getInt();
               map.smallMap.updatePos(_smallView,new Point(x,y));
               map.updateObjectPos(this,new Point(x,y));
               return;
            }
            _offsetX = vo.getInt();
            map.smallMap.updatePos(_smallView,new Point(x,y));
            map.updateObjectPos(this,new Point(x,y));
            return;
         }
         hiddenByServer = !vo.getBoolean();
      }
      
      public function modifyPlayerColor() : void
      {
         if(RoomManager.Instance.current.type == 121)
         {
            if(_info.isSelf)
            {
               changeSmallViewColor(2);
            }
            else if(PlayerManager.Instance.Self.targetId == _info.LivingID)
            {
               changeSmallViewColor(3);
            }
            else
            {
               changeSmallViewColor(4);
            }
         }
      }
      
      public function playerMoveTo(params:Array) : void
      {
         var type:int = params[0];
         switch(int(type))
         {
            case 0:
               act(new PlayerWalkAction(this,params[1],params[2],getAction("walk"),params[5]));
               break;
            case 1:
               act(new PlayerFallingAction(this,params[1],params[3],false,params[5]));
               break;
            default:
               act(new PlayerFallingAction(this,params[1],params[3],false,params[5]));
               break;
            case 3:
               act(new PlayerFallingAction(this,params[1],params[3],true,params[5]));
               break;
            case 4:
               act(new PlayerWalkAction(this,params[1],params[2],getAction("stand"),params[5]));
         }
      }
      
      public function getAction(type:String) : *
      {
         return type;
      }
      
      public function changeSmallViewColor(index:int) : void
      {
         if(_smallView)
         {
            _smallView.alpha = 1;
            _smallView.setColor(index);
         }
      }
   }
}
