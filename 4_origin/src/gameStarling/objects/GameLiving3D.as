package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import bones.game.ActionMovieBone;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.chatBall.ChatBallBase;
   import dragonBones.events.AnimationEvent;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.BloodNumberCreater;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.event.LivingCommandEvent;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.view.smallMap.SmallLiving;
   import gameCommon.view.smallMap.SmallPlayer;
   import gameStarling.actions.LivingDeadEffectAction;
   import gameStarling.actions.LivingFallingAction;
   import gameStarling.actions.LivingJumpAction;
   import gameStarling.actions.LivingMoveAction;
   import gameStarling.actions.LivingTurnAction;
   import gameStarling.actions.PlayerFallingAction;
   import gameStarling.actions.PlayerWalkAction;
   import gameStarling.animations.ShockMapAnimation;
   import gameStarling.chat.ChatBallPlayer3D;
   import gameStarling.view.AutoPropEffect3D;
   import gameStarling.view.EffectIconContainer3D;
   import gameStarling.view.buff.FightBuffBar3D;
   import gameStarling.view.buff.SkillBuffBar3D;
   import gameStarling.view.effects.ShootPercentView3D;
   import gameStarling.view.effects.ShowEffect3D;
   import gameStarling.view.map.MapView3D;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovieEvent;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.AutoDisappearStarling;
   import road7th.utils.BoneMovieWrapper;
   import room.RoomManager;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   import starlingui.core.text.TextLabel;
   
   public class GameLiving3D extends PhysicalObj3D
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
      
      protected var _actionMovie:Sprite;
      
      protected var _chatballview:ChatBallBase;
      
      protected var _smallView:SmallLiving;
      
      protected var speedMult:int = 1;
      
      protected var _nickName:TextLabel;
      
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
      
      protected var _bloodStripBg:Image;
      
      protected var _HPStrip:Image;
      
      protected var _bloodWidth:int;
      
      protected var _buffBar:FightBuffBar3D;
      
      protected var _skillBuffBar:SkillBuffBar3D;
      
      private var _fightPower:TextLabel;
      
      private var _buffEffect:DictionaryData;
      
      protected var _girlAttest:Image;
      
      private var _targetIcon:BoneMovieStarling;
      
      private var _bodyLoader:DisplayLoader;
      
      protected var counter:int = 1;
      
      protected var ap:Number = 0;
      
      private var _effectIconContainer:EffectIconContainer3D;
      
      protected var effectForzen:BoneMovieStarling;
      
      private var solidIceEffect:BoneMovieStarling;
      
      private var _noRemoveEffect:Array;
      
      protected var _isDie:Boolean = false;
      
      protected var _effRect:Rectangle;
      
      private var _attackEffectPlayer:PhysicalObj3D;
      
      private var _attackEffectPlaying:Boolean = false;
      
      protected var _attackEffectPos:Point;
      
      protected var _moviePool:Object;
      
      private var _hiddenByServer:Boolean;
      
      protected var _propArray:Array;
      
      private var _onSmallMap:Boolean = true;
      
      private var _actionList:Array;
      
      public function GameLiving3D(info:Living)
      {
         _buffEffect = new DictionaryData();
         _noRemoveEffect = [20090];
         _attackEffectPos = new Point(0,5);
         _moviePool = {};
         super(info.LivingID);
         _info = info;
         initView();
         initListener();
         initInfoChange();
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
      
      public function get map() : MapView3D
      {
         return _map as MapView3D;
      }
      
      public function addTartgetIcon() : void
      {
         if(_targetIcon == null)
         {
            _targetIcon = BoneMovieFactory.instance.creatBoneMovie("bonesGameSurvivalTarget");
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
         if(_fightPower == null && value)
         {
            _fightPower = new TextLabel("GameLiving.fightPower");
            _fightPower.x = _nickName.x - 27;
            _fightPower.y = _nickName.y - 130;
            addChild(_fightPower);
         }
         if(_fightPower)
         {
            _fightPower.visible = value;
         }
      }
      
      protected function initView() : void
      {
         touchable = false;
         _propArray = [];
         _bloodStripBg = StarlingMain.instance.createImage("game_smallHPStripBgAsset");
         _bloodStripBg.x = _bloodStripBg.x - 20;
         _bloodStripBg.y = 20;
         _HPStrip = BloodNumberCreater.createHPStrip(info.team);
         _HPStrip.x = _HPStrip.x + (_bloodStripBg.x + 1);
         _HPStrip.y = _HPStrip.y + (_bloodStripBg.y + 1);
         _bloodWidth = _HPStrip.width;
         addChild(_bloodStripBg);
         addChild(_HPStrip);
         _nickName = new TextLabel("GameLiving.nickName");
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
         _nickName.y = _bloodStripBg.y + _bloodStripBg.height / 2 + 7;
         _buffBar = new FightBuffBar3D();
         _buffBar.y = -98;
         addChild(_buffBar);
         _buffBar.update(_info.turnBuffs);
         _buffBar.x = -(_buffBar.width / 2);
         _skillBuffBar = new SkillBuffBar3D();
         _skillBuffBar.y = -80;
         addChild(_skillBuffBar);
         addChild(_nickName);
         initSmallMapObject();
         var _loc1_:* = _info.isShowBlood;
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
            _girlAttest = StarlingMain.instance.createImage("image_player_girlAttest");
            addChild(_girlAttest);
            _girlAttest.x = _nickName.x + _nickName.width;
            _girlAttest.y = _nickName.y;
         }
      }
      
      protected function initInfoChange() : void
      {
         __forzenChanged(null);
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
         _info.addEventListener("applySkill",__applySkill);
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
            actionMovie.boneMovie.addFrameScript("mark",movieActionEvent);
            actionMovie.boneMovie.addFrameScript("effect",movieEffectEvent);
            actionMovie.boneMovie.addFrameScript("skill",movieSkillEvent);
         }
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
            _info.removeEventListener("solidiceStateChanged",_solidIceStateChanged);
            _info.removeEventListener("targetStealthStateChanged",_targetStealthStateChanged);
            _info.removeEventListener("addSkillBuffBar",_addSkillBuffBar_Handler);
            _info.removeEventListener("playmovie",__playMovie);
            _info.removeEventListener("turnrotation",__turnRotation);
            _info.removeEventListener("playskillMovie",__playSkillMovie);
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
            actionMovie.boneMovie.removeFrameScriptAll();
         }
         if(_bodyLoader)
         {
            _bodyLoader.removeEventListener("complete",__onBodyLoaderComplete);
         }
      }
      
      protected function movieActionEvent(e:BoneMovieWrapper, args:Array = null) : void
      {
         var label:String = args[0];
         var _loc4_:* = label;
         if(RENEW !== _loc4_)
         {
            if(SHOCK_EVENT !== _loc4_)
            {
               if(SHOCK_EVENT2 !== _loc4_)
               {
                  if(NEED_FOCUS !== _loc4_)
                  {
                     if(SHIELD !== _loc4_)
                     {
                        if(ATTACK_COMPLETE_FOCUS !== _loc4_)
                        {
                           if(BOMB_EVENT !== _loc4_)
                           {
                              trace("gameLiving3D living:( " + e.movie.styleName + " ) 动作:( " + label + " ) 未处理");
                           }
                           else
                           {
                              startBlank();
                           }
                        }
                        else
                        {
                           attackCompleteFocus(args[1]);
                        }
                     }
                     else
                     {
                        showDefence();
                     }
                  }
                  else if(args.length >= 3)
                  {
                     needFocus(args[1],args[2],args[3]);
                  }
               }
               else
               {
                  shockMap2();
               }
            }
            else
            {
               shockMap(args[1]);
            }
         }
         else
         {
            renew();
         }
      }
      
      protected function movieEffectEvent(e:BoneMovieWrapper, args:Array = null) : void
      {
      }
      
      protected function movieSkillEvent(e:BoneMovieWrapper, args:Array = null) : void
      {
      }
      
      protected function renew() : void
      {
         this._info.showAttackEffect(2);
      }
      
      protected function shockMap(radius:int) : void
      {
         if(map)
         {
            map.animateSet.addAnimation(new ShockMapAnimation(this,radius,20));
         }
      }
      
      protected function shockMap2() : void
      {
         if(map)
         {
            map.animateSet.addAnimation(new ShockMapAnimation(this,30,20));
         }
      }
      
      protected function showDefence() : void
      {
         var show:ShowEffect3D = new ShowEffect3D(ShowEffect3D.GUARD);
         show.x = x + offset();
         show.y = y - 50 + offset(25);
         _map.addChild(show);
      }
      
      private function attackCompleteFocus(obj:Object) : void
      {
         map.setSelfCenter(true,2,obj);
      }
      
      protected function startBlank() : void
      {
         addEventListener("enterFrame",drawBlank);
      }
      
      protected function __addToState(event:starling.events.Event) : void
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
      
      protected function __applySkill(event:LivingEvent) : void
      {
      }
      
      protected function __playSkillMovie(event:LivingEvent) : void
      {
         showEffect(event.paras[0]);
      }
      
      protected function __bombed(event:LivingEvent) : void
      {
      }
      
      protected function drawBlank(evt:starling.events.Event) : void
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
      
      public function get EffectIcon() : EffectIconContainer3D
      {
         if(_effectIconContainer == null)
         {
         }
         return _effectIconContainer;
      }
      
      protected function __sizeChangeHandler(e:starling.events.Event) : void
      {
         EffectIcon.x = 5 - EffectIcon.width / 2;
         EffectIcon.y = bodyHeight * -1 - EffectIcon.height;
      }
      
      protected function __changeState(evt:LivingEvent) : void
      {
      }
      
      protected function initMovie() : void
      {
         if(!info)
         {
            return;
         }
         var movieName:String = info.actionBonesMovieName;
         var bone:ActionMovieBone = new ActionMovieBone(movieName);
         bone.boneMovie.movie.stop();
         addChild(bone);
         _info.actionMovieBitmap = null;
         _actionMovie = bone;
         initChatball();
         loadBodyBitmap();
      }
      
      private function loadBodyBitmap() : void
      {
         _bodyLoader = LoadResourceManager.Instance.createLoader(PathManager.getBoneLivingBodyPath(info.actionBonesMovieName),0);
         _bodyLoader.addEventListener("complete",__onBodyLoaderComplete);
         LoadResourceManager.Instance.startLoad(_bodyLoader);
      }
      
      private function __onBodyLoaderComplete(e:LoaderEvent) : void
      {
         _bodyLoader.removeEventListener("complete",__onBodyLoaderComplete);
         if(e.loader.isSuccess)
         {
            _info.actionMovieBitmap = _bodyLoader.content as Bitmap;
         }
      }
      
      public function replaceMovie() : void
      {
         initChatball();
      }
      
      protected function initChatball() : void
      {
         if(_chatballview == null)
         {
            _chatballview = new ChatBallPlayer3D();
         }
         (_chatballview as ChatBallPlayer3D).player = this;
         _originalHeight = _actionMovie.height;
         _originalWidth = _actionMovie.width;
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
         (_chatballview as ChatBallPlayer3D).setPos(popPos.x,popPos.y);
         _chatballview.directionX = movie.scaleX;
      }
      
      protected function get popPos() : Point
      {
         var movie:* = null;
         var x:int = 0;
         var y:int = 0;
         if(actionMovie)
         {
            movie = actionMovie.boneMovie.movie as BoneMovieStarling;
            if(movie != null && movie.armature != null)
            {
               x = movie.getValueByAttribute("popupPosX");
               y = movie.getValueByAttribute("popupPosY");
               return new Point(x,y);
            }
            return new Point(18,-40);
         }
         return new Point(-(_originalWidth * 0.4) * movie.scaleX,-(_originalHeight * 0.8) * movie.scaleY);
      }
      
      protected function get popDir() : Point
      {
         var movie:* = null;
         var dic:int = 0;
         if(actionMovie)
         {
            movie = actionMovie.boneMovie.movie as BoneMovieStarling;
            if(movie != null && movie.armature != null)
            {
               dic = movie.getValueByAttribute("popupDir") as int;
               return new Point(dic * movie.scaleX,movie.scaleY);
            }
         }
         return new Point(-(_originalWidth * 0.4) * movie.scaleX,-(_originalHeight * 0.8) * movie.scaleY);
      }
      
      protected function __beat(event:LivingEvent) : void
      {
         var action:* = null;
         if(_isLiving)
         {
            targetAttackEffect = event.paras[0][0].attackEffect;
            action = event.paras[0][0].action;
            if(action != "")
            {
               actionMovie.doAction(action,updateTargetsBlood,event.paras[0]);
            }
            else
            {
               updateTargetsBlood(event.paras[0]);
            }
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
         doAction(event.paras[0],event.paras[1],event.paras[2]);
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
                           movie = new ShootPercentView3D(Math.abs(diff),event.paras[0],false);
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
                           movie = new ShootPercentView3D(Math.abs(diff),event.paras[0],false);
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
                        movie = new ShootPercentView3D(Math.abs(diff),1,false);
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
               movie = new ShootPercentView3D(0,2);
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
               movie = new ShootPercentView3D(Math.abs(diff),1,true);
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
         var w:Number = NaN;
         if(info.blood < 0)
         {
            _HPStrip.width = 0;
         }
         else
         {
            w = Math.floor(_bloodWidth / info.maxBlood * info.blood);
            _HPStrip.width = w > _bloodWidth?_bloodWidth:w;
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
         super.die();
         info.isFrozen = false;
         info.isNoNole = false;
         info.isHidden = false;
         info.showSolidIce = false;
         _bloodStripBg.visible = false;
         _bloodStripBg.visible = false;
         _buffBar.visible = false;
         _skillBuffBar.visible = false;
         StarlingObjectUtils.disposeObject(_targetIcon);
         _targetIcon = null;
         removeAllPetBuffEffects();
         _actionList = null;
      }
      
      public function revive() : void
      {
         _info.revive();
         startMoving();
         _isLiving = true;
         _bloodStripBg.visible = true;
         _bloodStripBg.visible = true;
         _buffBar.visible = true;
         _skillBuffBar.visible = true;
         if(_targetIcon)
         {
            _targetIcon.visible = true;
         }
         _buffBar.clearBuff();
      }
      
      protected function __dirChanged(event:LivingEvent) : void
      {
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
            StarlingObjectUtils.disposeObject(effectForzen);
            effectForzen = null;
            if(effectForzen == null)
            {
               effectForzen = BoneMovieFactory.instance.creatBoneMovie("bonesGameTrailFrostEffectAsset");
            }
            effectForzen.y = 24;
            addChild(effectForzen);
         }
         else
         {
            StarlingObjectUtils.disposeObject(effectForzen);
            effectForzen = null;
         }
      }
      
      protected function __lockStateChanged(evt:LivingEvent) : void
      {
      }
      
      protected function _solidIceStateChanged(event:LivingEvent) : void
      {
         if(_info.showSolidIce)
         {
            if(solidIceEffect == null)
            {
               solidIceEffect = BoneMovieFactory.instance.creatBoneMovie("bonesGameTrailFrostEffectAsset");
            }
            solidIceEffect.y = 24;
            addChild(solidIceEffect);
         }
         else
         {
            StarlingObjectUtils.disposeObject(solidIceEffect);
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
      
      public function showIcon(iconId:int, isAdd:Boolean = true) : void
      {
         !!isAdd?_skillBuffBar.addIcon(iconId):_skillBuffBar.removeIcon(iconId);
         _skillBuffBar.x = -(_skillBuffBar.width / 2);
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
         var ballPos:Point = popPos;
         (_chatballview as ChatBallPlayer3D).setPos(ballPos.x,ballPos.y);
         if(_isLiving)
         {
            angle = calcObjectAngle(16);
            _info.playerAngle = angle;
         }
         if(map)
         {
            map.smallMap.updatePos(smallView,pos);
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
      
      protected function __playerEffect(evt:ActionMovieEvent) : void
      {
      }
      
      public function needFocus(offsetX:int = 0, offsetY:int = 0, data:Object = null) : void
      {
         if(map)
         {
            map.livingSetCenter(x + offsetX,y + offsetY - 150,true,2,data);
         }
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
      
      public function get actionMovie() : ActionMovieBone
      {
         return _actionMovie as ActionMovieBone;
      }
      
      public function get movie() : Sprite
      {
         return _actionMovie;
      }
      
      public function doAction(actionType:*, callback:Function = null, args:Array = null) : void
      {
         actionType = actionType;
         callback = callback;
         args = args;
         if(actionMovie != null)
         {
            actionMovie.visible = true;
            var isLoop:Boolean = false;
            if(actionType == "walk" || actionType == "stand")
            {
               isLoop = true;
            }
            else if(actionType != "die")
            {
               var actionCallBack:Function = function():void
               {
                  doActionCallBack(callback,args);
               };
            }
            actionMovie.doAction(actionType,actionCallBack,args);
         }
      }
      
      private function doActionCallBack(callback:Function = null, args:Array = null) : void
      {
         if(callback != null)
         {
            callback.apply(this,args);
         }
         else
         {
            info.doDefaultAction();
         }
      }
      
      public function showEffect(classLink:String) : void
      {
         var display:* = null;
         var mc:* = null;
         if(classLink)
         {
            if(BoneMovieFactory.instance.hasBoneMovie(classLink))
            {
               display = BoneMovieFactory.instance.creatBoneMovie(classLink);
            }
            else
            {
               display = StarlingMain.instance.createImage(classLink);
            }
            mc = new AutoDisappearStarling(display);
            addChild(mc);
         }
      }
      
      public function showBuffEffect(classLink:String, buffId:int) : void
      {
         var display:* = null;
         var className:String = classLink.replace("asset.game.AttackEffect2","bonesGameAttackEffect2");
         if(className && BoneMovieFactory.instance.model.getBonesStyle(className))
         {
            if(!_buffEffect)
            {
               return;
            }
            if(_buffEffect && _buffEffect.hasKey(buffId))
            {
               removeBuffEffect(buffId);
            }
            if(BoneMovieFactory.instance.hasBoneMovie(className))
            {
               display = BoneMovieFactory.instance.creatBoneMovie(className);
               if(_noRemoveEffect.indexOf(buffId) != -1)
               {
                  _buffEffect.add(buffId,display);
               }
            }
            else
            {
               display = StarlingMain.instance.createImage(className);
               _buffEffect.add(buffId,display);
            }
            addChild(display);
         }
      }
      
      public function removeBuffEffect(buffId:int) : void
      {
         var mc:* = null;
         if(_buffEffect && _buffEffect.hasKey(buffId))
         {
            mc = _buffEffect[buffId] as DisplayObject;
            StarlingObjectUtils.disposeObject(mc);
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
      
      protected function deleteSmallView() : void
      {
         StarlingObjectUtils.disposeObject(_bloodStripBg);
         _bloodStripBg = null;
         StarlingObjectUtils.disposeObject(_HPStrip);
         _HPStrip = null;
         StarlingObjectUtils.disposeObject(_nickName);
         _nickName = null;
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
            _buffEffect.clear();
         }
      }
      
      override public function dispose() : void
      {
         removeListener();
         _info = null;
         deleteSmallView();
         removeAllPetBuffEffects();
         _buffEffect = null;
         StarlingObjectUtils.disposeObject(_buffBar);
         _buffBar = null;
         StarlingObjectUtils.disposeObject(_skillBuffBar);
         _skillBuffBar = null;
         StarlingObjectUtils.disposeObject(_targetIcon);
         _targetIcon = null;
         StarlingObjectUtils.disposeObject(_fightPower);
         _fightPower = null;
         StarlingObjectUtils.disposeObject(_nickName);
         _nickName = null;
         if(_chatballview)
         {
            _chatballview.dispose();
         }
         if(_actionMovie)
         {
            _actionMovie.dispose();
            _actionMovie = null;
         }
         StarlingObjectUtils.disposeObject(solidIceEffect);
         solidIceEffect = null;
         StarlingObjectUtils.disposeObject(_girlAttest);
         _girlAttest = null;
         cleanMovies();
         isExist = false;
         if(_propArray)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _propArray;
            for each(var o in _propArray)
            {
               if(o is Image)
               {
                  StarlingObjectUtils.disposeObject(o);
               }
            }
         }
         _propArray = null;
         _bodyLoader = null;
         super.dispose();
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
         var effect:BoneMovieStarling = creatAttackEffectAssetByID(effectID);
         effect.scaleX = -1 * _info.direction;
         StarlingObjectUtils.disposeObject(_attackEffectPlayer);
         _attackEffectPlayer = new PhysicalObj3D(-1);
         _attackEffectPlayer.addChild(effect);
         var pos:Point = _map.globalToLocal(movie.localToGlobal(_attackEffectPos));
         _attackEffectPlayer.x = pos.x;
         _attackEffectPlayer.y = pos.y;
         _map.addPhysical(_attackEffectPlayer);
         effect.armature.addEventListener("complete",__playComplete);
         effect.play();
      }
      
      protected function __playDeadEffect(event:LivingEvent) : void
      {
         var backFun:Function = event.paras[2] as Function;
         if(backFun != null)
         {
            backFun(event.paras[3]);
         }
      }
      
      private function __playComplete(event:AnimationEvent) : void
      {
         event.currentTarget.removeEventListener("complete",__playComplete);
         if(_map)
         {
            _map.removePhysical(_attackEffectPlayer);
         }
         var movie:BoneMovieStarling = _attackEffectPlayer.getChildAt(0) as BoneMovieStarling;
         delete _moviePool[movie.styleName];
         StarlingObjectUtils.disposeObject(movie);
         StarlingObjectUtils.disposeObject(_attackEffectPlayer);
         _attackEffectPlaying = false;
         _attackEffectPlayer = null;
      }
      
      protected function creatAttackEffectAssetByID(id:int) : BoneMovieStarling
      {
         var name:String = "bonesGameAttackEffect" + id;
         var movie:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie(name);
         _moviePool[name] = movie;
         return movie;
      }
      
      private function cleanMovies() : void
      {
         var movie:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _moviePool;
         for(var key in _moviePool)
         {
            movie = _moviePool[key];
            StarlingObjectUtils.disposeObject(movie);
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
         actionMovie.setActionMapping(source,target);
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
      
      protected function onChatBallComplete(evt:flash.events.Event) : void
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
         var using:* = null;
         SoundManager.instance.play("039");
         if(!skip)
         {
            using = new BoneMovieWrapper("bonesGameGhostPcikPropAsset",false,true);
            using.addFrameScript("effect",headPropEffect);
            using.asDisplay.x = 0;
            using.asDisplay.y = -10;
            addChild(using.asDisplay);
            using.playAction();
         }
         else
         {
            headPropEffect();
         }
      }
      
      protected function headPropEffect(bone:BoneMovieWrapper = null, arge:Array = null) : void
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
                  movie = StarlingMain.instance.createImage("game_specialKillAsset");
               }
               else
               {
                  if(pic == "wish")
                  {
                     movie = StarlingMain.instance.createImage("game_wishBtn");
                  }
                  else
                  {
                     movie = StarlingMain.instance.createImage("game_prop_" + pic);
                  }
                  var _loc6_:int = 60;
                  movie.height = _loc6_;
                  movie.width = _loc6_;
               }
               head = new AutoPropEffect3D(movie);
               head.x = -5;
               head.y = -140;
            }
            else
            {
               movie = _propArray.shift() as CellContent3D;
               head = new AutoPropEffect3D(movie);
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
               return;
            }
            _offsetX = vo.getInt();
            map.smallMap.updatePos(_smallView,new Point(x,y));
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
      
      public function startAction(actionList:Array) : void
      {
         _actionList = actionList;
         executeAction();
      }
      
      private function executeAction() : void
      {
         if(_actionList && _actionList.length > 0 && _map)
         {
            var tempAction:BombAction3D = _actionList.shift();
            var param1:int = tempAction.param1;
            var param2:int = tempAction.param2;
            var param3:int = tempAction.param3;
            var param4:int = tempAction.param4;
            var mapView:MapView3D = _map as MapView3D;
            var gameInfo:GameInfo = mapView.gameInfo;
            if(tempAction.type == 25)
            {
               var moveInfo1:PhysicalObj3D = mapView.getPhysical(param1);
               if(moveInfo1 is GameLiving3D)
               {
                  (moveInfo1 as GameLiving3D).setProperty("speedMult","8");
               }
               var moveInfo2:Living = gameInfo.findLiving(param1);
               if(moveInfo1 && moveInfo2)
               {
                  if(param2 > moveInfo2.pos.x)
                  {
                     moveInfo2.direction = 1;
                  }
                  else if(param2 < moveInfo2.pos.x)
                  {
                     moveInfo2.direction = -1;
                  }
                  var backFun:Function = function():void
                  {
                     (moveInfo1 as GameLiving3D).setProperty("speedMult","1");
                     executeAction();
                  };
                  var params1:Array = [4,new Point(param2,param3),moveInfo2.direction,true,null,backFun];
                  (moveInfo1 as GameLiving3D).playerMoveTo(params1);
               }
            }
            else if(tempAction.type == 26)
            {
               var fallingInfo1:Living = gameInfo.findLiving(param1);
               var fallingInfo2:PhysicalObj3D = mapView.getPhysical(param1);
               if(fallingInfo1 || fallingInfo2 is GamePlayer3D)
               {
                  var params2:Array = [1,new Point(param2,param3),fallingInfo1.direction,true,null,executeAction];
                  (fallingInfo2 as GameLiving3D).playerMoveTo(params2);
               }
            }
            else if(tempAction.type == 29)
            {
               var fallingDie1:Living = gameInfo.findLiving(param1);
               var fallingDie2:PhysicalObj3D = mapView.getPhysical(param1);
               if(fallingDie2 is GameLiving3D)
               {
                  var params3:Array = [1,new Point(param2,param3),fallingDie1.direction,false,executeAction];
                  (fallingDie2 as GameLiving3D).playerMoveTo(params3);
               }
            }
            else if(tempAction.type == 5)
            {
               var player:Living = gameInfo.findLiving(param1);
               if(player)
               {
                  player.updateBlood(param4,param3,0 - param2);
                  player.isHidden = false;
               }
               executeAction();
            }
         }
         else
         {
            _actionList = null;
         }
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
