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
      
      public function GameLiving3D(param1:Living)
      {
         _buffEffect = new DictionaryData();
         _noRemoveEffect = [20090];
         _attackEffectPos = new Point(0,5);
         _moviePool = {};
         super(param1.LivingID);
         _info = param1;
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
      
      public function setFightPower(param1:int) : void
      {
         if(param1 > 0 && param1 <= 100)
         {
            fightPowerVisible = true;
            _fightPower.text = LanguageMgr.GetTranslation("ddt.games.powerText",param1);
         }
         else
         {
            _fightPower.text = "";
         }
      }
      
      public function set fightPowerVisible(param1:Boolean) : void
      {
         if(_fightPower == null && param1)
         {
            _fightPower = new TextLabel("GameLiving.fightPower");
            _fightPower.x = _nickName.x - 27;
            _fightPower.y = _nickName.y - 130;
            addChild(_fightPower);
         }
         if(_fightPower)
         {
            _fightPower.visible = param1;
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
         var _loc1_:* = null;
         if(_info.isShowSmallMapPoint)
         {
            if(_info.isPlayer())
            {
               _loc1_ = new SmallPlayer();
               _smallView = _loc1_;
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
      
      protected function movieActionEvent(param1:BoneMovieWrapper, param2:Array = null) : void
      {
         var _loc3_:String = param2[0];
         var _loc4_:* = _loc3_;
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
                              trace("gameLiving3D living:( " + param1.movie.styleName + " ) 动作:( " + _loc3_ + " ) 未处理");
                           }
                           else
                           {
                              startBlank();
                           }
                        }
                        else
                        {
                           attackCompleteFocus(param2[1]);
                        }
                     }
                     else
                     {
                        showDefence();
                     }
                  }
                  else if(param2.length >= 3)
                  {
                     needFocus(param2[1],param2[2],param2[3]);
                  }
               }
               else
               {
                  shockMap2();
               }
            }
            else
            {
               shockMap(param2[1]);
            }
         }
         else
         {
            renew();
         }
      }
      
      protected function movieEffectEvent(param1:BoneMovieWrapper, param2:Array = null) : void
      {
      }
      
      protected function movieSkillEvent(param1:BoneMovieWrapper, param2:Array = null) : void
      {
      }
      
      protected function renew() : void
      {
         this._info.showAttackEffect(2);
      }
      
      protected function shockMap(param1:int) : void
      {
         if(map)
         {
            map.animateSet.addAnimation(new ShockMapAnimation(this,param1,20));
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
         var _loc1_:ShowEffect3D = new ShowEffect3D(ShowEffect3D.GUARD);
         _loc1_.x = x + offset();
         _loc1_.y = y - 50 + offset(25);
         _map.addChild(_loc1_);
      }
      
      private function attackCompleteFocus(param1:Object) : void
      {
         map.setSelfCenter(true,2,param1);
      }
      
      protected function startBlank() : void
      {
         addEventListener("enterFrame",drawBlank);
      }
      
      protected function __addToState(param1:starling.events.Event) : void
      {
         initInfoChange();
      }
      
      protected function __removeContinuousEffect(param1:LivingEvent) : void
      {
         removeBuffEffect(int(param1.paras[0]));
      }
      
      protected function __playContinuousEffect(param1:LivingEvent) : void
      {
         showBuffEffect(param1.paras[0],int(param1.paras[1]));
      }
      
      protected function __buffChanged(param1:LivingEvent) : void
      {
         if((param1.paras[0] == 0 || param1.paras[0] == 6) && _info && _info.isLiving)
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
      
      protected function __applySkill(param1:LivingEvent) : void
      {
      }
      
      protected function __playSkillMovie(param1:LivingEvent) : void
      {
         showEffect(param1.paras[0]);
      }
      
      protected function __bombed(param1:LivingEvent) : void
      {
      }
      
      protected function drawBlank(param1:starling.events.Event) : void
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
      
      protected function __sizeChangeHandler(param1:starling.events.Event) : void
      {
         EffectIcon.x = 5 - EffectIcon.width / 2;
         EffectIcon.y = bodyHeight * -1 - EffectIcon.height;
      }
      
      protected function __changeState(param1:LivingEvent) : void
      {
      }
      
      protected function initMovie() : void
      {
         if(!info)
         {
            return;
         }
         var _loc1_:String = info.actionBonesMovieName;
         var _loc2_:ActionMovieBone = new ActionMovieBone(_loc1_);
         _loc2_.boneMovie.movie.stop();
         addChild(_loc2_);
         _info.actionMovieBitmap = null;
         _actionMovie = _loc2_;
         initChatball();
         loadBodyBitmap();
      }
      
      private function loadBodyBitmap() : void
      {
         _bodyLoader = LoadResourceManager.Instance.createLoader(PathManager.getBoneLivingBodyPath(info.actionBonesMovieName),0);
         _bodyLoader.addEventListener("complete",__onBodyLoaderComplete);
         LoadResourceManager.Instance.startLoad(_bodyLoader);
      }
      
      private function __onBodyLoaderComplete(param1:LoaderEvent) : void
      {
         _bodyLoader.removeEventListener("complete",__onBodyLoaderComplete);
         if(param1.loader.isSuccess)
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
      
      protected function __startMoving(param1:LivingEvent) : void
      {
         if(_map == null)
         {
            return;
         }
         var _loc2_:Point = _map.findYLineNotEmptyPointDown(x,y,_map.height);
         if(_loc2_ == null)
         {
            _loc2_ = new Point(x,_map.height + 1);
         }
         _info.fallTo(_loc2_,20);
      }
      
      protected function __say(param1:LivingEvent) : void
      {
         if(_info.isHidden)
         {
            return;
         }
         var _loc2_:String = param1.paras[0] as String;
         var _loc3_:int = 0;
         if(param1.paras[1])
         {
            _loc3_ = param1.paras[1];
         }
         _chatballview.setText(_loc2_,_loc3_);
         fitChatBallPos();
      }
      
      protected function fitChatBallPos() : void
      {
         (_chatballview as ChatBallPlayer3D).setPos(popPos.x,popPos.y);
         _chatballview.directionX = movie.scaleX;
      }
      
      protected function get popPos() : Point
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(actionMovie)
         {
            _loc1_ = actionMovie.boneMovie.movie as BoneMovieStarling;
            if(_loc1_ != null && _loc1_.armature != null)
            {
               _loc3_ = _loc1_.getValueByAttribute("popupPosX");
               _loc2_ = _loc1_.getValueByAttribute("popupPosY");
               return new Point(_loc3_,_loc2_);
            }
            return new Point(18,-40);
         }
         return new Point(-(_originalWidth * 0.4) * _loc1_.scaleX,-(_originalHeight * 0.8) * _loc1_.scaleY);
      }
      
      protected function get popDir() : Point
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(actionMovie)
         {
            _loc2_ = actionMovie.boneMovie.movie as BoneMovieStarling;
            if(_loc2_ != null && _loc2_.armature != null)
            {
               _loc1_ = _loc2_.getValueByAttribute("popupDir") as int;
               return new Point(_loc1_ * _loc2_.scaleX,_loc2_.scaleY);
            }
         }
         return new Point(-(_originalWidth * 0.4) * _loc2_.scaleX,-(_originalHeight * 0.8) * _loc2_.scaleY);
      }
      
      protected function __beat(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         if(_isLiving)
         {
            targetAttackEffect = param1.paras[0][0].attackEffect;
            _loc2_ = param1.paras[0][0].action;
            if(_loc2_ != "")
            {
               actionMovie.doAction(_loc2_,updateTargetsBlood,param1.paras[0]);
            }
            else
            {
               updateTargetsBlood(param1.paras[0]);
            }
         }
      }
      
      protected function updateTargetsBlood(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc2_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_] && param1[_loc5_].target && param1[_loc5_].target.isLiving)
            {
               _loc3_ = param1[_loc5_].target;
               _loc3_.isHidden = false;
               if(param1[_loc5_].deadEffect != "")
               {
                  _loc4_.push(param1[_loc5_]);
               }
               else
               {
                  _loc3_.showAttackEffect(param1[_loc5_].attackEffect);
                  _loc3_.updateBlood(param1[_loc5_].targetBlood,param1[_loc5_].type,param1[_loc5_].damage);
               }
               if(!_loc2_)
               {
                  map.setCenter(_loc3_.pos.x,_loc3_.pos.y - 150,true);
               }
               if(_loc3_.isSelf)
               {
                  _loc2_ = true;
               }
            }
            _loc5_++;
         }
         if(_loc4_.length > 0)
         {
            map.act(new LivingDeadEffectAction(_loc4_));
         }
      }
      
      protected function __beginNewTurn(param1:LivingEvent) : void
      {
      }
      
      protected function __playMovie(param1:LivingEvent) : void
      {
         doAction(param1.paras[0],param1.paras[1],param1.paras[2]);
      }
      
      protected function __turnRotation(param1:LivingEvent) : void
      {
         act(new LivingTurnAction(this,param1.paras[0],param1.paras[1],param1.paras[2]));
      }
      
      protected function __bloodChanged(param1:LivingEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         if(!isExist || !_map)
         {
            return;
         }
         var _loc3_:Number = param1.value - param1.old;
         var _loc6_:int = param1.paras[0];
         var _loc7_:* = _loc6_;
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
                        _loc5_ = param1.paras[1];
                        if(_loc5_ < 0)
                        {
                           _loc3_ = _loc5_;
                        }
                        if(_loc3_ != 0)
                        {
                           _loc4_ = new ShootPercentView3D(Math.abs(_loc3_),param1.paras[0],false);
                           _loc4_.x = x + offset();
                           _loc4_.y = y - 50 + offset(25);
                           _loc7_ = 0.8 + Math.random() * 0.4;
                           _loc4_.scaleY = _loc7_;
                           _loc4_.scaleX = _loc7_;
                           _map.addToPhyLayer(_loc4_);
                           if(GameControl.Instance.Current.roomType != 120)
                           {
                              if(_info.isHidden)
                              {
                                 if(_info.team == GameControl.Instance.Current.selfGamePlayer.team)
                                 {
                                    _loc4_.alpha == 0.5;
                                 }
                                 else
                                 {
                                    visible = false;
                                    _loc4_.alpha = 0;
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        _loc5_ = param1.paras[1];
                        if(_loc5_ < 0)
                        {
                           _loc3_ = _loc5_;
                        }
                        if(_loc3_ != 0)
                        {
                           _loc4_ = new ShootPercentView3D(Math.abs(_loc3_),param1.paras[0],false);
                           _loc4_.x = x - 70;
                           _loc4_.y = y - 80;
                           _loc7_ = 0.8 + Math.random() * 0.4;
                           _loc4_.scaleY = _loc7_;
                           _loc4_.scaleX = _loc7_;
                           _map.addToPhyLayer(_loc4_);
                        }
                     }
                  }
                  else
                  {
                     _loc5_ = param1.paras[1];
                     _loc3_ = _loc5_;
                     if(_loc3_ != 0)
                     {
                        _loc4_ = new ShootPercentView3D(Math.abs(_loc3_),1,false);
                        _loc4_.x = x + offset();
                        _loc4_.y = y - 50 + offset(25);
                        _loc7_ = 0.8 + Math.random() * 0.4;
                        _loc4_.scaleY = _loc7_;
                        _loc4_.scaleX = _loc7_;
                        _map.addToPhyLayer(_loc4_);
                     }
                  }
               }
            }
            else
            {
               _loc4_ = new ShootPercentView3D(0,2);
               _loc4_.x = x + offset();
               _loc4_.y = y - 50 + offset(25);
               _loc7_ = 0.8 + Math.random() * 0.4;
               _loc4_.scaleY = _loc7_;
               _loc4_.scaleX = _loc7_;
               _map.addToPhyLayer(_loc4_);
            }
         }
         else
         {
            _loc3_ = param1.paras[1];
            if(_loc3_ != 0 && _info.blood != 0)
            {
               _loc4_ = new ShootPercentView3D(Math.abs(_loc3_),1,true);
               _loc4_.x = x + offset();
               _loc4_.y = y - 50 + offset(25);
               _loc7_ = 0.8 + Math.random() * 0.4;
               _loc4_.scaleY = _loc7_;
               _loc4_.scaleX = _loc7_;
               _map.addToPhyLayer(_loc4_);
               if(_info.isHidden)
               {
                  if(_info.team == GameControl.Instance.Current.selfGamePlayer.team)
                  {
                     _loc4_.alpha == 0.5;
                  }
                  else
                  {
                     visible = false;
                     _loc4_.alpha = 0;
                  }
               }
            }
         }
         updateBloodStrip();
      }
      
      protected function __maxHpChanged(param1:LivingEvent) : void
      {
         updateBloodStrip();
      }
      
      protected function updateBloodStrip() : void
      {
         var _loc1_:Number = NaN;
         if(info.blood < 0)
         {
            _HPStrip.width = 0;
         }
         else
         {
            _loc1_ = Math.floor(_bloodWidth / info.maxBlood * info.blood);
            _HPStrip.width = _loc1_ > _bloodWidth?_bloodWidth:_loc1_;
         }
      }
      
      private function offset(param1:int = 30) : int
      {
         var _loc2_:int = Math.random() * 10;
         if(_loc2_ % 2 == 0)
         {
            return -(int(Math.random() * param1));
         }
         return int(Math.random() * param1);
      }
      
      protected function __die(param1:LivingEvent) : void
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
      
      protected function __dirChanged(param1:LivingEvent) : void
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
      
      protected function __forzenChanged(param1:LivingEvent) : void
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
      
      protected function __lockStateChanged(param1:LivingEvent) : void
      {
      }
      
      protected function _solidIceStateChanged(param1:LivingEvent) : void
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
      
      protected function _targetStealthStateChanged(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = map.gameInfo.livings;
         for each(var _loc2_ in map.gameInfo.livings)
         {
            if(_loc2_.isPlayer() && _loc2_.team != _info.team && !_loc2_.isSelf)
            {
               if(_info.isRemoveStealth)
               {
                  if(_loc2_.isHidden)
                  {
                     _loc2_.removeStealth = true;
                  }
               }
               else if(_loc2_.removeStealth)
               {
                  _loc2_.removeStealth = false;
               }
            }
         }
      }
      
      protected function _enableSpellSkill(param1:LivingEvent) : void
      {
         GameControl.Instance.Current.selfGamePlayer.lockSpellKill = _info.noUseCritical;
      }
      
      protected function _addSkillBuffBar_Handler(param1:LivingEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Array = param1.paras;
         if(_skillBuffBar && _loc4_.length >= 2)
         {
            _loc2_ = _loc4_[1];
            _loc3_ = _loc4_[0];
            !!_loc2_?_skillBuffBar.addIcon(_loc3_):_skillBuffBar.removeIcon(_loc3_);
            _skillBuffBar.x = -(_skillBuffBar.width / 2);
         }
      }
      
      public function showIcon(param1:int, param2:Boolean = true) : void
      {
         !!param2?_skillBuffBar.addIcon(param1):_skillBuffBar.removeIcon(param1);
         _skillBuffBar.x = -(_skillBuffBar.width / 2);
      }
      
      protected function __hiddenChanged(param1:LivingEvent) : void
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
      
      protected function __posChanged(param1:LivingEvent) : void
      {
         var _loc3_:Number = NaN;
         pos = _info.pos;
         var _loc2_:Point = popPos;
         (_chatballview as ChatBallPlayer3D).setPos(_loc2_.x,_loc2_.y);
         if(_isLiving)
         {
            _loc3_ = calcObjectAngle(16);
            _info.playerAngle = _loc3_;
         }
         if(map)
         {
            map.smallMap.updatePos(smallView,pos);
         }
      }
      
      protected function __jump(param1:LivingEvent) : void
      {
         doAction(param1.paras[2]);
         act(new LivingJumpAction(this,param1.paras[0],param1.paras[1],param1.paras[3]));
      }
      
      protected function __moveTo(param1:LivingEvent) : void
      {
         var _loc13_:* = null;
         var _loc10_:String = param1.paras[4];
         doAction(_loc10_);
         var _loc3_:int = param1.paras[5];
         if(_loc3_ == 0)
         {
            _loc3_ = 7;
         }
         var _loc11_:Point = param1.paras[1] as Point;
         var _loc8_:int = param1.paras[2];
         var _loc6_:String = param1.paras[6];
         if(x == _loc11_.x && y == _loc11_.y)
         {
            return;
         }
         var _loc12_:Array = [];
         var _loc7_:int = x;
         var _loc5_:int = y;
         var _loc2_:Point = new Point(x,y);
         var _loc4_:int = _loc11_.x > _loc7_?1:-1;
         var _loc9_:Point = new Point(x,y);
         if(_loc10_.substr(0,3) == "fly")
         {
            _loc13_ = new Point(_loc11_.x - _loc9_.x,_loc11_.y - _loc9_.y);
            while(_loc13_.length > _loc3_)
            {
               _loc13_.normalize(_loc3_);
               _loc9_ = new Point(_loc9_.x + _loc13_.x,_loc9_.y + _loc13_.y);
               _loc13_ = new Point(_loc11_.x - _loc9_.x,_loc11_.y - _loc9_.y);
               if(_loc9_)
               {
                  _loc12_.push(_loc9_);
                  continue;
               }
               _loc12_.push(_loc11_);
               break;
            }
         }
         else
         {
            while((_loc11_.x - _loc7_) * _loc4_ > 0)
            {
               _loc9_ = _map.findNextWalkPoint(_loc7_,_loc5_,_loc4_,_loc3_ * 1,_loc3_ * 3);
               if(_loc9_)
               {
                  _loc12_.push(_loc9_);
                  _loc7_ = _loc9_.x;
                  _loc5_ = _loc9_.y;
                  continue;
               }
               break;
            }
         }
         if(_loc12_.length > 0)
         {
            _info.act(new LivingMoveAction(this,_loc12_,_loc8_,_loc6_));
         }
         else if(_loc6_ != "")
         {
            doAction(_loc6_);
         }
         else
         {
            _info.doDefaultAction();
         }
      }
      
      public function canMoveDirection(param1:Number) : Boolean
      {
         return !map.IsOutMap(x + (15 + Player.MOVE_SPEED) * param1,y);
      }
      
      public function canStand(param1:int, param2:int) : Boolean
      {
         return !map.IsEmpty(param1 - 1,param2) || !map.IsEmpty(param1 + 1,param2);
      }
      
      public function getNextWalkPoint(param1:int) : Point
      {
         if(canMoveDirection(param1))
         {
            return _map.findNextWalkPoint(x,y,param1,stepX,stepY);
         }
         return null;
      }
      
      protected function __playerEffect(param1:ActionMovieEvent) : void
      {
      }
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null) : void
      {
         if(map)
         {
            map.livingSetCenter(x + param1,y + param2 - 150,true,2,param3);
         }
      }
      
      protected function __shoot(param1:LivingEvent) : void
      {
      }
      
      protected function __transmit(param1:LivingEvent) : void
      {
         info.pos = param1.paras[0];
      }
      
      protected function __fall(param1:LivingEvent) : void
      {
         _info.act(new LivingFallingAction(this,param1.paras[0],param1.paras[1],param1.paras[3]));
      }
      
      public function get actionMovie() : ActionMovieBone
      {
         return _actionMovie as ActionMovieBone;
      }
      
      public function get movie() : Sprite
      {
         return _actionMovie;
      }
      
      public function doAction(param1:*, param2:Function = null, param3:Array = null) : void
      {
         actionType = param1;
         callback = param2;
         args = param3;
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
      
      private function doActionCallBack(param1:Function = null, param2:Array = null) : void
      {
         if(param1 != null)
         {
            param1.apply(this,param2);
         }
         else
         {
            info.doDefaultAction();
         }
      }
      
      public function showEffect(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            if(BoneMovieFactory.instance.hasBoneMovie(param1))
            {
               _loc3_ = BoneMovieFactory.instance.creatBoneMovie(param1);
            }
            else
            {
               _loc3_ = StarlingMain.instance.createImage(param1);
            }
            _loc2_ = new AutoDisappearStarling(_loc3_);
            addChild(_loc2_);
         }
      }
      
      public function showBuffEffect(param1:String, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:String = param1.replace("asset.game.AttackEffect2","bonesGameAttackEffect2");
         if(_loc4_ && BoneMovieFactory.instance.model.getBonesStyle(_loc4_))
         {
            if(!_buffEffect)
            {
               return;
            }
            if(_buffEffect && _buffEffect.hasKey(param2))
            {
               removeBuffEffect(param2);
            }
            if(BoneMovieFactory.instance.hasBoneMovie(_loc4_))
            {
               _loc3_ = BoneMovieFactory.instance.creatBoneMovie(_loc4_);
               if(_noRemoveEffect.indexOf(param2) != -1)
               {
                  _buffEffect.add(param2,_loc3_);
               }
            }
            else
            {
               _loc3_ = StarlingMain.instance.createImage(_loc4_);
               _buffEffect.add(param2,_loc3_);
            }
            addChild(_loc3_);
         }
      }
      
      public function removeBuffEffect(param1:int) : void
      {
         var _loc2_:* = null;
         if(_buffEffect && _buffEffect.hasKey(param1))
         {
            _loc2_ = _buffEffect[param1] as DisplayObject;
            StarlingObjectUtils.disposeObject(_loc2_);
            _buffEffect.remove(param1);
         }
      }
      
      public function act(param1:BaseAction) : void
      {
         _info.act(param1);
      }
      
      public function traceCurrentAction() : void
      {
         _info.traceCurrentAction();
      }
      
      override public function update(param1:Number) : void
      {
         if(_isDie)
         {
            return;
         }
         super.update(param1);
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
            for each(var _loc1_ in _buffEffect.list)
            {
               ObjectUtils.disposeObject(_loc1_);
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
            for each(var _loc1_ in _propArray)
            {
               if(_loc1_ is Image)
               {
                  StarlingObjectUtils.disposeObject(_loc1_);
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
      
      protected function __showAttackEffect(param1:LivingEvent) : void
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
         var _loc4_:int = param1.paras[0];
         var _loc2_:BoneMovieStarling = creatAttackEffectAssetByID(_loc4_);
         _loc2_.scaleX = -1 * _info.direction;
         StarlingObjectUtils.disposeObject(_attackEffectPlayer);
         _attackEffectPlayer = new PhysicalObj3D(-1);
         _attackEffectPlayer.addChild(_loc2_);
         var _loc3_:Point = _map.globalToLocal(movie.localToGlobal(_attackEffectPos));
         _attackEffectPlayer.x = _loc3_.x;
         _attackEffectPlayer.y = _loc3_.y;
         _map.addPhysical(_attackEffectPlayer);
         _loc2_.armature.addEventListener("complete",__playComplete);
         _loc2_.play();
      }
      
      protected function __playDeadEffect(param1:LivingEvent) : void
      {
         var _loc2_:Function = param1.paras[2] as Function;
         if(_loc2_ != null)
         {
            _loc2_(param1.paras[3]);
         }
      }
      
      private function __playComplete(param1:AnimationEvent) : void
      {
         param1.currentTarget.removeEventListener("complete",__playComplete);
         if(_map)
         {
            _map.removePhysical(_attackEffectPlayer);
         }
         var _loc2_:BoneMovieStarling = _attackEffectPlayer.getChildAt(0) as BoneMovieStarling;
         delete _moviePool[_loc2_.styleName];
         StarlingObjectUtils.disposeObject(_loc2_);
         StarlingObjectUtils.disposeObject(_attackEffectPlayer);
         _attackEffectPlaying = false;
         _attackEffectPlayer = null;
      }
      
      protected function creatAttackEffectAssetByID(param1:int) : BoneMovieStarling
      {
         var _loc2_:String = "bonesGameAttackEffect" + param1;
         var _loc3_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie(_loc2_);
         _moviePool[_loc2_] = _loc3_;
         return _loc3_;
      }
      
      private function cleanMovies() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _moviePool;
         for(var _loc2_ in _moviePool)
         {
            _loc1_ = _moviePool[_loc2_];
            StarlingObjectUtils.disposeObject(_loc1_);
            delete _moviePool[_loc2_];
         }
      }
      
      public function showBlood(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _HPStrip.visible = _loc2_;
         _bloodStripBg.visible = _loc2_;
         _nickName.visible = param1;
      }
      
      override public function setActionMapping(param1:String, param2:String) : void
      {
         actionMovie.setActionMapping(param1,param2);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(hiddenByServer)
         {
            return;
         }
         .super.visible = param1;
         if(_onSmallMap == false)
         {
            return;
         }
         if(_smallView)
         {
            _smallView.visible = param1;
         }
      }
      
      private function get hiddenByServer() : Boolean
      {
         return _hiddenByServer;
      }
      
      private function set hiddenByServer(param1:Boolean) : void
      {
         if(param1)
         {
            .super.visible = false;
         }
         else
         {
            .super.visible = true;
         }
         _hiddenByServer = param1;
      }
      
      protected function __onLivingCommand(param1:LivingCommandEvent) : void
      {
         var _loc2_:* = param1.commandType;
         if("focusSelf" !== _loc2_)
         {
            if("focus" === _loc2_)
            {
               needFocus(param1.object.x,param1.object.y);
               return;
            }
         }
         else
         {
            map.setCenter(GameControl.Instance.Current.selfGamePlayer.pos.x,GameControl.Instance.Current.selfGamePlayer.pos.x,false);
         }
      }
      
      protected function onChatBallComplete(param1:flash.events.Event) : void
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
      
      protected function doUseItemAnimation(param1:Boolean = false) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("039");
         if(!param1)
         {
            _loc2_ = new BoneMovieWrapper("bonesGameGhostPcikPropAsset",false,true);
            _loc2_.addFrameScript("effect",headPropEffect);
            _loc2_.asDisplay.x = 0;
            _loc2_.asDisplay.y = -10;
            addChild(_loc2_.asDisplay);
            _loc2_.playAction();
         }
         else
         {
            headPropEffect();
         }
      }
      
      protected function headPropEffect(param1:BoneMovieWrapper = null, param2:Array = null) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(_propArray && _propArray.length > 0)
         {
            if(_propArray[0] is String)
            {
               _loc4_ = _propArray.shift();
               if(_loc4_ == "-1")
               {
                  _loc3_ = StarlingMain.instance.createImage("game_specialKillAsset");
               }
               else
               {
                  if(_loc4_ == "wish")
                  {
                     _loc3_ = StarlingMain.instance.createImage("game_wishBtn");
                  }
                  else
                  {
                     _loc3_ = StarlingMain.instance.createImage("game_prop_" + _loc4_);
                  }
                  var _loc6_:int = 60;
                  _loc3_.height = _loc6_;
                  _loc3_.width = _loc6_;
               }
               _loc5_ = new AutoPropEffect3D(_loc3_);
               _loc5_.x = -5;
               _loc5_.y = -140;
            }
            else
            {
               _loc3_ = _propArray.shift() as CellContent3D;
               _loc5_ = new AutoPropEffect3D(_loc3_);
               _loc5_.x = 5;
               _loc5_.y = -140;
            }
            addChild(_loc5_);
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
      
      public function setProperty(param1:String, param2:String) : void
      {
         var _loc3_:StringObject = new StringObject(param2);
         var _loc4_:* = param1;
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
                              info.setProperty(param1,param2);
                           }
                           else
                           {
                              speedMult = _loc3_.getInt();
                           }
                        }
                        else
                        {
                           if(smallView)
                           {
                              smallView.visible = _loc3_.getBoolean();
                           }
                           _onSmallMap = _loc3_.getBoolean();
                           if(_onSmallMap && _smallView)
                           {
                              _smallView.info = _info;
                           }
                        }
                     }
                     else
                     {
                        speedMult = _loc3_.getInt() / _speedY;
                     }
                  }
                  else
                  {
                     speedMult = _loc3_.getInt() / _speedX;
                  }
                  return;
               }
               _offsetY = _loc3_.getInt();
               map.smallMap.updatePos(_smallView,new Point(x,y));
               return;
            }
            _offsetX = _loc3_.getInt();
            map.smallMap.updatePos(_smallView,new Point(x,y));
            return;
         }
         hiddenByServer = !_loc3_.getBoolean();
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
      
      public function playerMoveTo(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         switch(int(_loc2_))
         {
            case 0:
               act(new PlayerWalkAction(this,param1[1],param1[2],getAction("walk"),param1[5]));
               break;
            case 1:
               act(new PlayerFallingAction(this,param1[1],param1[3],false,param1[5]));
               break;
            default:
               act(new PlayerFallingAction(this,param1[1],param1[3],false,param1[5]));
               break;
            case 3:
               act(new PlayerFallingAction(this,param1[1],param1[3],true,param1[5]));
               break;
            case 4:
               act(new PlayerWalkAction(this,param1[1],param1[2],getAction("stand"),param1[5]));
         }
      }
      
      public function getAction(param1:String) : *
      {
         return param1;
      }
      
      public function startAction(param1:Array) : void
      {
         _actionList = param1;
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
      
      public function changeSmallViewColor(param1:int) : void
      {
         if(_smallView)
         {
            _smallView.alpha = 1;
            _smallView.setColor(param1);
         }
      }
   }
}
