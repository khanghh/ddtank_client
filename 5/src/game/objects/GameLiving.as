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

    public function GameLiving(param1:Living)
    {
        _buffEffect = new DictionaryData();
        _noRemoveEffect = [20090];
        _attackEffectPos = new Point(0,5);
        _moviePool = {};
        _info = param1;
        initView();
        initListener();
        initInfoChange();
        super(param1.LivingID);
    }

    public static function getAttackEffectAssetByID(param1:int) : MovieClip
    {
        var _loc2_:MovieClip = ClassUtils.CreatInstance("asset.game.AttackEffect" + param1.toString()) as MovieClip;
        return _loc2_;
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

    public function addChildrenByPack(param1:IDisplayPack) : void
    {
        var _loc4_:int = 0;
        var _loc3_:* = param1.content;
        for each(var _loc2_ in param1.content)
        {
            addChild(_loc2_);
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

    protected function __markMeHideDest(param1:LivingEvent) : void
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
        var _loc3_:* = null;
        var _loc2_:* = null;
        var _loc1_:* = null;
        if(_actionMovie && _actionMovie.shouldReplace && info && ModuleLoader.hasDefinition(info.actionMovieName))
        {
            _loc3_ = _actionMovie.labelMapping;
            _loc2_ = _actionMovie.currentAction;
            removeChild(_actionMovie);
            _actionMovie = null;
            _loc1_ = ModuleLoader.getDefinition(info.actionMovieName) as Class;
            _actionMovie = new _loc1_();
            _info.actionMovieBitmap = new Bitmap(getBodyBitmapData("show2"));
            _info.thumbnail = getBodyBitmapData("show");
            _actionMovie.scaleX = -_info.direction;
            _actionMovie.mouseEnabled = false;
            _actionMovie.mouseChildren = false;
            _actionMovie.scrollRect = null;
            _actionMovie.shouldReplace = false;
            _actionMovie.labelMapping = _loc3_;
            _actionMovie.doAction(_loc2_);
            addChild(_actionMovie);
        }
    }

    protected function __addToState(param1:Event) : void
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

    protected function __removeSkillMovie(param1:LivingEvent) : void
    {
    }

    protected function __applySkill(param1:LivingEvent) : void
    {
    }

    protected function __playSkillMovie(param1:LivingEvent) : void
    {
        showEffect(param1.paras[0]);
    }

    protected function __skillMovieComplete(param1:Event) : void
    {
        var _loc2_:MovieClipWrapper = param1.currentTarget as MovieClipWrapper;
        _loc2_.removeEventListener("complete",__skillMovieComplete);
    }

    protected function __bombed(param1:LivingEvent) : void
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

    protected function __shockMap(param1:ActionEvent) : void
    {
        if(map)
        {
            map.animateSet.addAnimation(new ShockMapAnimation(this,param1.param as int,20));
        }
    }

    protected function __shockMap2(param1:Event) : void
    {
        if(map)
        {
            map.animateSet.addAnimation(new ShockMapAnimation(this,30,20));
        }
    }

    protected function __renew(param1:Event) : void
    {
        this._info.showAttackEffect(2);
    }

    protected function __startBlank(param1:Event) : void
    {
        addEventListener("enterFrame",drawBlank);
    }

    protected function drawBlank(param1:Event) : void
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

    protected function __showDefence(param1:Event) : void
    {
        var _loc2_:ShowEffect = new ShowEffect(ShowEffect.GUARD);
        _loc2_.x = x + offset();
        _loc2_.y = y - 50 + offset(25);
        _map.addChild(_loc2_);
    }

    protected function __addEffectHandler(param1:DictionaryEvent) : void
    {
        var _loc2_:BaseMirariEffectIcon = param1.data as BaseMirariEffectIcon;
        EffectIcon.handleEffect(_loc2_.mirariType,_loc2_.getEffectIcon());
    }

    protected function __removeEffectHandler(param1:DictionaryEvent) : void
    {
        var _loc2_:BaseMirariEffectIcon = param1.data as BaseMirariEffectIcon;
        EffectIcon.removeEffect(_loc2_.mirariType);
    }

    protected function __clearEffectHandler(param1:DictionaryEvent) : void
    {
        EffectIcon.clearEffectIcon();
    }

    protected function __sizeChangeHandler(param1:Event) : void
    {
        EffectIcon.x = 5 - EffectIcon.width / 2;
        EffectIcon.y = bodyHeight * -1 - EffectIcon.height;
    }

    protected function __changeState(param1:LivingEvent) : void
    {
    }

    protected function initMovie() : void
    {
        var _loc1_:* = null;
        if(!info)
        {
            return;
        }
        if(ModuleLoader.hasDefinition(info.actionMovieName))
        {
            _loc1_ = ModuleLoader.getDefinition(info.actionMovieName) as Class;
            _actionMovie = new _loc1_();
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
                _loc1_ = ModuleLoader.getDefinition("game.living.defaultSmallEnemyLiving") as Class;
            }
            else
            {
                _loc1_ = ModuleLoader.getDefinition("game.living.defaultSimpleBossLiving") as Class;
            }
            _actionMovie = new _loc1_();
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
        _chatballview.x = 0;
        _chatballview.y = 0;
        addChild(_chatballview);
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

    override public function collidedByObject(param1:PhysicalObj) : void
    {
    }

    protected function __beat(param1:LivingEvent) : void
    {
        if(_isLiving)
        {
            targetAttackEffect = param1.paras[0][0].attackEffect;
            _actionMovie.doAction(param1.paras[0][0].action,updateTargetsBlood,param1.paras);
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
            trace("arg_target:" + param1[_loc5_].target + ",targetID:" + param1[_loc5_].target.LivingID + ",targetState:" + param1[_loc5_].target.isLiving);
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
                    trace("arg_targetID:" + _loc3_.LivingID + ",blood:" + param1[_loc5_].targetBlood);
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
        if(_actionMovie)
        {
            _actionMovie.doAction(param1.paras[0],param1.paras[1],param1.paras[2]);
        }
    }

    protected function __turnRotation(param1:LivingEvent) : void
    {
        act(new LivingTurnAction(this,param1.paras[0],param1.paras[1],param1.paras[2]));
    }


    protected function __maxHpChanged(param1:LivingEvent) : void
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

    protected function __dirChanged(param1:LivingEvent) : void
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

    protected function __forzenChanged(param1:LivingEvent) : void
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

    protected function __lockStateChanged(param1:LivingEvent) : void
    {
        if(_info.LockState)
        {
            lock = ClassUtils.CreatInstance("asset.gameII.LockAsset") as MovieClip;
            lock.x = 10;
            lock.y = 5;
            addChild(lock);
            if(param1.paras[0] == 2)
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

    protected function _solidIceStateChanged(param1:LivingEvent) : void
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


    protected function __posChanged(param1:LivingEvent) : void
    {
        var _loc2_:Number = NaN;
        pos = _info.pos;
        if(_isLiving)
        {
            _loc2_ = calcObjectAngle(16);
            _info.playerAngle = _loc2_;
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

    private function __needFocus(param1:ActionMovieEvent) : void
    {
        if(param1.data)
        {
            needFocus(param1.data.x,param1.data.y,param1.data);
        }
    }

    protected function __playEffect(param1:ActionMovieEvent) : void
    {
    }

    protected function __playerEffect(param1:ActionMovieEvent) : void
    {
    }

    public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null, param4:GameLiving = null) : void
    {
        if(map)
        {
            map.livingSetCenter(x + param1,y + param2 - 150,true,2,param3,param4);
        }
    }

    private function __attackCompleteFocus(param1:ActionMovieEvent) : void
    {
        map.setSelfCenter(true,2,param1.data);
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

    public function get actionMovie() : ActionMovie
    {
        return _actionMovie;
    }

    public function get movie() : Sprite
    {
        return _actionMovie;
    }

    public function doAction(param1:*) : void
    {
        if(_actionMovie != null)
        {
            _actionMovie.doAction(param1);
        }
    }

    public function showEffect(param1:String) : void
    {
        var _loc2_:* = null;
        if(param1 && ModuleLoader.hasDefinition(param1))
        {
            _loc2_ = new AutoDisappear(ClassUtils.CreatInstance(param1));
            addChild(_loc2_);
        }
    }

    public function showBuffEffect(param1:String, param2:int) : void
    {
        var _loc4_:* = null;
        var _loc3_:* = null;
        if(param1 && ModuleLoader.hasDefinition(param1))
        {
            if(!_buffEffect)
            {
                return;
            }
            if(_buffEffect && _buffEffect.hasKey(param2))
            {
                removeBuffEffect(param2);
            }
            _loc4_ = ClassUtils.CreatInstance(param1) as DisplayObject;
            if(_noRemoveEffect.indexOf(param2) != -1)
            {
                _loc3_ = new MovieClipWrapper(_loc4_ as MovieClip,true,true);
                addChild(_loc3_.movie);
            }
            else
            {
                addChild(_loc4_);
                _buffEffect.add(param2,_loc4_);
            }
        }
    }

    public function removeBuffEffect(param1:int) : void
    {
        var _loc2_:* = null;
        if(_buffEffect && _buffEffect.hasKey(param1))
        {
            _loc2_ = _buffEffect[param1] as DisplayObject;
            if(_loc2_ && _loc2_.parent)
            {
                removeChild(_loc2_);
            }
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

    protected function getBodyBmpData(param1:String = "") : BitmapData
    {
        return getBodyBitmapData(param1);
    }

    private function getBodyBitmapData(param1:String = "") : BitmapData
    {
        var _loc5_:Number = _actionMovie.width;
        var _loc3_:Sprite = new Sprite();
        bodyWidth = _actionMovie.width;
        bodyHeight = _actionMovie.height;
        _actionMovie.gotoAndStop(param1);
        var _loc6_:Boolean = false;
        if(120 < _actionMovie.width)
        {
            _actionMovie.width = 120;
            _actionMovie.scaleY = _actionMovie.scaleX;
            _loc6_ = true;
        }
        _loc3_.addChild(_actionMovie);
        var _loc4_:Rectangle = _actionMovie.getBounds(_actionMovie);
        _actionMovie.x = -_loc4_.x * _actionMovie.scaleX;
        _actionMovie.y = -_loc4_.y * _actionMovie.scaleX;
        var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
        _loc2_.draw(_loc3_);
        if(_loc6_)
        {
            _actionMovie.width = _loc5_;
            var _loc7_:int = 1;
            _actionMovie.scaleX = _loc7_;
            _actionMovie.scaleY = _loc7_;
        }
        _actionMovie.doAction("stand");
        _loc7_ = 0;
        _actionMovie.y = _loc7_;
        _actionMovie.x = _loc7_;
        _loc3_.removeChild(_actionMovie);
        return _loc2_;
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
            for each(var _loc1_ in _buffEffect.list)
            {
                ObjectUtils.disposeObject(_loc1_);
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
            for each(var _loc1_ in _propArray)
            {
                ObjectUtils.disposeObject(_loc1_);
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
        var _loc5_:int = param1.paras[0];
        var _loc2_:MovieClip = creatAttackEffectAssetByID(_loc5_);
        _loc2_.scaleX = -1 * _info.direction;
        var _loc3_:MovieClipWrapper = new MovieClipWrapper(_loc2_,true,true);
        _loc3_.addEventListener("complete",__playComplete);
        _loc3_.gotoAndPlay(1);
        _attackEffectPlayer = new PhysicalObj(-1);
        _attackEffectPlayer.addChild(_loc3_.movie);
        var _loc4_:Point = _map.globalToLocal(movie.localToGlobal(_attackEffectPos));
        _attackEffectPlayer.x = _loc4_.x;
        _attackEffectPlayer.y = _loc4_.y;
        _map.addPhysical(_attackEffectPlayer);
    }

    protected function __playDeadEffect(param1:LivingEvent) : void
    {
        var _loc2_:Function = param1.paras[2] as Function;
        if(_loc2_ != null)
        {
            _loc2_(param1.paras[3]);
        }
    }

    private function __playComplete(param1:Event) : void
    {
        if(param1.currentTarget)
        {
            param1.currentTarget.removeEventListener("complete",__playComplete);
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

    protected function hasMovie(param1:String) : Boolean
    {
        return _moviePool.hasOwnProperty(param1);
    }

    protected function creatAttackEffectAssetByID(param1:int) : MovieClip
    {
        var _loc2_:* = null;
        var _loc3_:String = "asset.game.AttackEffect" + param1;
        if(hasMovie(_loc3_))
        {
            return _moviePool[_loc3_] as MovieClip;
        }
        _loc2_ = ClassUtils.CreatInstance("asset.game.AttackEffect" + param1.toString()) as MovieClip;
        _moviePool[_loc3_] = _loc2_;
        return _loc2_;
    }

    private function cleanMovies() : void
    {
        var _loc1_:* = null;
        var _loc4_:int = 0;
        var _loc3_:* = _moviePool;
        for(var _loc2_ in _moviePool)
        {
            _loc1_ = _moviePool[_loc2_];
            _loc1_.stop();
            ObjectUtils.disposeObject(_loc1_);
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
        _actionMovie.setActionMapping(param1,param2);
    }

    override public function set visible(param1:Boolean) : void
    {
        if(hiddenByServer)
        {
            return;
        }
        visible = param1;
        if(_onSmallMap == false)
        {
            return;
        }
        if(_smallView)
        {
            _smallView.visible = param1;
        }
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

    protected function onChatBallComplete(param1:Event) : void
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
        var _loc2_:MovieClipWrapper = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset")),true,true);
        _loc2_.addFrameScriptAt(12,headPropEffect);
        SoundManager.instance.play("039");
        _loc2_.movie.x = 0;
        _loc2_.movie.y = -10;
        if(!param1)
        {
            addChild(_loc2_.movie);
        }
    }

    protected function headPropEffect() : void
    {
        var _loc1_:* = null;
        var _loc3_:* = null;
        var _loc2_:* = null;
        if(_propArray && _propArray.length > 0)
        {
            if(_propArray[0] is String)
            {
                _loc2_ = _propArray.shift();
                if(_loc2_ == "-1")
                {
                    _loc1_ = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.specialKillAsset");
                }
                else
                {
                    _loc1_ = PropItemView.createView(_loc2_,60,60);
                }
                _loc3_ = new AutoPropEffect(_loc1_);
                _loc3_.x = -5;
                _loc3_.y = -140;
            }
            else
            {
                _loc1_ = _propArray.shift() as DisplayObject;
                _loc3_ = new AutoPropEffect(_loc1_);
                _loc3_.x = 5;
                _loc3_.y = -140;
            }
            addChild(_loc3_);
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

    public function changeSmallViewColor(param1:int) : void
    {
        if(_smallView)
        {
            _smallView.alpha = 1;
            _smallView.setColor(param1);
        }
    }

//====================================================================================================================================================================================

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
                    _smallView.visible = true;
                    _smallView.alpha = 0.5;
                }
                alpha = 0.5;
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
            _info.markMeHide = false;
        }
        if(_info.markMeHideDest)
        {
            _info.markMeHideDest = false;
        }
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
                                _loc4_ = new ShootPercentView(Math.abs(_loc3_),param1.paras[0],false);
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
                                            visible = true;
                                            _loc4_.alpha = 0.5;
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
                                _loc4_ = new ShootPercentView(Math.abs(_loc3_),param1.paras[0],false);
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
                            _loc4_ = new ShootPercentView(Math.abs(_loc3_),1,false);
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
                _loc4_ = new ShootPercentView(0,2);
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
                _loc4_ = new ShootPercentView(Math.abs(_loc3_),1,true);
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
                        visible = true;
                        _loc4_.alpha = 0.5;
                    }
                }
            }
        }
        updateBloodStrip();
    }

    protected function __hiddenChanged(param1:LivingEvent) : void
    {
        if(_info.isHidden)
        {
            if(_info.team != GameControl.Instance.Current.selfGamePlayer.team)
            {
                visible = true;
                if(_smallView)
                {
                    _smallView.visible = true;
                    _smallView.alpha = 0.5;
                }
                alpha = 0.5;
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

    private function __fightPowerChanged(param1:LivingEvent) : void
    {
//        if(_info.fightPower > 0 && _info.fightPower <= 100)
//        {
        fightPowerVisible = true;
        _fightPower.text = LanguageMgr.GetTranslation("ddt.games.powerText",_info.fightPower);
//        }
//        else
//        {
//            _fightPower.text = "";
//        }
    }


    public function set fightPowerVisible(param1:Boolean) : void
    {
        _fightPower.visible = true;
    }

    private function get hiddenByServer() : Boolean
    {
        return _hiddenByServer;
    }

    private function set hiddenByServer(param1:Boolean) : void
    {
//        if(param1)
//        {
//            visible = false;
//        }
//        else
//        {
        visible = true;
//        }
        _hiddenByServer = false;
    }

//====================================================================================================================================================================================
}
}
