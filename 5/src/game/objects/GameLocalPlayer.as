package game.objects
{
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.utils.ClassUtils;
import com.pickgliss.utils.ObjectUtils;
import ddt.data.goods.ItemTemplateInfo;
import ddt.events.LivingEvent;
import ddt.manager.GameInSocketOut;
import ddt.manager.LanguageMgr;
import ddt.manager.MessageTipManager;
import ddt.manager.PetSkillManager;
import ddt.manager.SoundManager;
import ddt.view.character.GameCharacter;
import ddt.view.character.ShowCharacter;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.Timer;
import flash.utils.getTimer;
import game.actions.FocusInLivingAction;
import game.actions.PlayerBeatAction;
import game.actions.SelfPlayerWalkAction;
import game.actions.SelfSkipAction;
import game.actions.newHand.NewHandFightHelpAction;
import game.animations.BaseSetCenterAnimation;
import game.animations.DragMapAnimation;
import game.view.map.MapView;
import gameCommon.GameControl;
import gameCommon.model.LocalPlayer;
import org.aswing.KeyStroke;
import org.aswing.KeyboardManager;
import pet.data.PetSkillTemplateInfo;
import room.RoomManager;

public class GameLocalPlayer extends GamePlayer
{

    private static const MAX_MOVE_TIME:int = 10;


    private var _takeAim:MovieClip;

    private var _moveStripContainer:Sprite;

    private var _moveStrip:Bitmap;

    private var _ballpos:Point;

    protected var _shootTimer:Timer;

    private var mouseAsset:MovieClip;

    private var _turned:Boolean;

    private var _transmissionEffoct:MovieClip;

    private var _keyDownTime:int;

    private var _currentReverse:int = 1;

    private var _isChangeReverse:Boolean = true;

    protected var _isShooting:Boolean = false;

    protected var _shootCount:int = 0;

    protected var _shootPoint:Point;

    private var _shootOverCount:int = 0;

    public function GameLocalPlayer(param1:LocalPlayer, param2:ShowCharacter, param3:GameCharacter = null, param4:int = 0)
    {
        super(param1,param2,param3,param4);
    }

    public function get localPlayer() : LocalPlayer
    {
        return info as LocalPlayer;
    }

    public function get aim() : MovieClip
    {
        return _takeAim;
    }

    override public function set pos(param1:Point) : void
    {
        if(param1.x < 1000)
        {
        }
        x = param1.x;
        y = param1.y;
    }

    override protected function initView() : void
    {
        super.initView();
        _ballpos = new Point(30,-20);
        _takeAim = ClassUtils.CreatInstance("asset.game.TakeAimAsset");
        _takeAim.x = _ballpos.x * -1;
        _takeAim.y = _ballpos.y;
        _takeAim["hand"].rotation = localPlayer.currentWeapInfo.armMinAngle;
        var _loc1_:Boolean = false;
        _takeAim.mouseEnabled = _loc1_;
        _takeAim.mouseChildren = _loc1_;
        _moveStripContainer = new Sprite();
        _moveStripContainer.addChild(ComponentFactory.Instance.creatBitmap("asset.game.moveStripBgAsset"));
        _moveStrip = ComponentFactory.Instance.creatBitmap("asset.game.moveStripAsset");
        _moveStripContainer.addChild(_moveStrip);
        _loc1_ = false;
        _moveStripContainer.mouseEnabled = _loc1_;
        _moveStripContainer.mouseChildren = _loc1_;
        if(_consortiaName)
        {
            _moveStripContainer.x = 0;
            _moveStripContainer.y = _consortiaName.y + 22;
        }
        else
        {
            _moveStripContainer.x = 0;
            _moveStripContainer.y = _nickName.y + 22;
        }
        localPlayer.energy = localPlayer.maxEnergy;
        mouseAsset = ClassUtils.CreatInstance("asset.game.MouseShape") as MovieClip;
        mouseAsset.visible = false;
        _shootTimer = new Timer(1000);
    }

    override protected function initListener() : void
    {
        super.initListener();
        localPlayer.addEventListener("sendShootAction",__sendShoot);
        localPlayer.addEventListener("energyChanged",__energyChanged);
        localPlayer.addEventListener("gunangleChanged",__gunangleChanged);
        localPlayer.addEventListener("beginShoot",__beginShoot);
        localPlayer.addEventListener("skip",__skip);
        localPlayer.addEventListener("setCenter",__setCenter);
        _shootTimer.addEventListener("timer",__shootTimer);
        if(!_info.autoOnHook)
        {
            KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_LEFT,__turnLeft);
            KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_A,__turnLeft);
            KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_RIGHT,__turnRight);
            KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_D,__turnRight);
        }
        KeyboardManager.getInstance().addEventListener("keyUp",__keyUp);
    }

    private function __setCenter(param1:LivingEvent) : void
    {
        var _loc2_:Array = param1.paras;
        map.animateSet.addAnimation(new DragMapAnimation(_loc2_[0],_loc2_[1],true));
    }

    override public function dispose() : void
    {
        _shootTimer.removeEventListener("timer",__shootTimer);
        localPlayer.removeEventListener("sendShootAction",__sendShoot);
        localPlayer.removeEventListener("energyChanged",__energyChanged);
        localPlayer.removeEventListener("gunangleChanged",__gunangleChanged);
        localPlayer.removeEventListener("beginShoot",__beginShoot);
        localPlayer.removeEventListener("skip",__skip);
        localPlayer.removeEventListener("setCenter",__setCenter);
        if(!_info.autoOnHook)
        {
            KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_LEFT,__turnLeft);
            KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_A,__turnLeft);
            KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_RIGHT,__turnRight);
            KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_D,__turnRight);
        }
        KeyboardManager.getInstance().removeEventListener("keyUp",__keyUp);
        _map.removeEventListener("click",__mouseClick);
        if(_takeAim && _takeAim.parent)
        {
            _takeAim.parent.removeChild(_takeAim);
        }
        _takeAim.stop();
        _takeAim = null;
        _moveStripContainer.removeChild(_moveStrip);
        _moveStrip.bitmapData.dispose();
        _moveStrip = null;
        if(_moveStripContainer && _moveStripContainer.parent)
        {
            _moveStripContainer.parent.removeChild(_moveStripContainer);
        }
        _moveStripContainer = null;
        _shootTimer.stop();
        _shootTimer = null;
        mouseAsset.stop();
        if(mouseAsset.parent)
        {
            mouseAsset.parent.removeChild(mouseAsset);
        }
        mouseAsset = null;
        ObjectUtils.disposeObject(_transmissionEffoct);
        _transmissionEffoct;
        super.dispose();
    }

    protected function __skip(param1:LivingEvent) : void
    {
        act(new SelfSkipAction(localPlayer));
    }

    public function showTransmissionEffoct() : void
    {
        if(_transmissionEffoct)
        {
            ObjectUtils.disposeObject(_transmissionEffoct);
            _transmissionEffoct = null;
        }
        if(_player)
        {
            _player.visible = false;
        }
        if(_nickName)
        {
            _nickName.visible = false;
        }
        if(_bloodStripBg)
        {
            _bloodStripBg.visible = false;
        }
        if(_HPStrip)
        {
            _HPStrip.visible = false;
        }
        if(_consortiaName)
        {
            _consortiaName.visible = false;
        }
        if(_buffBar)
        {
            _buffBar.visible = false;
        }
        _transmissionEffoct = ClassUtils.CreatInstance("asset.game.transmittedEffoct");
        _transmissionEffoct.x = _player.x;
        _transmissionEffoct.y = _player.y;
        _transmissionEffoct.play();
        addChild(_transmissionEffoct);
    }

    private function __keyUp(param1:KeyboardEvent) : void
    {
        _keyDownTime = 0;
        _isChangeReverse = true;
    }

    private function __turnLeft() : void
    {
        if(!_isShooting)
        {
            if(_isChangeReverse)
            {
                _currentReverse = this.player.reverse;
                _isChangeReverse = false;
            }
            if(_currentReverse == 1)
            {
                if(info.direction == 1)
                {
                    info.direction = -1;
                    if(_keyDownTime == 0)
                    {
                        _keyDownTime = getTimer();
                    }
                }
            }
            else if(info.direction == -1)
            {
                info.direction = 1;
                if(_keyDownTime == 0)
                {
                    _keyDownTime = getTimer();
                }
            }
            walk();
        }
    }

    private function __turnRight() : void
    {
        if(!_isShooting)
        {
            if(_isChangeReverse)
            {
                _currentReverse = this.player.reverse;
                _isChangeReverse = false;
            }
            if(_currentReverse == 1)
            {
                if(info.direction == -1)
                {
                    info.direction = 1;
                    if(_keyDownTime == 0)
                    {
                        _keyDownTime = getTimer();
                    }
                }
            }
            else if(info.direction == 1)
            {
                info.direction = -1;
                if(_keyDownTime == 0)
                {
                    _keyDownTime = getTimer();
                }
            }
            walk();
        }
    }

    protected function walk() : void
    {
        if(info.isLocked)
        {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
            return;
        }
        if(!_isMoving && localPlayer.isAttacking && (_keyDownTime == 0 || getTimer() - _keyDownTime > 10) && !localPlayer.forbidMoving)
        {
            act(new SelfPlayerWalkAction(this,_currentReverse));
        }
    }

    override public function startMoving() : void
    {
        _isMoving = true;
    }

    override public function stopMoving() : void
    {
        _vx.clearMotion();
        _vy.clearMotion();
        _isMoving = false;
    }

    override protected function __attackingChanged(param1:LivingEvent) : void
    {
        super.__attackingChanged(param1);
        if(localPlayer.isAttacking && localPlayer.isLiving)
        {
            act(new SelfPlayerWalkAction(this,_currentReverse));
        }
        localPlayer.clearPropArr();
    }

    override protected function attackingViewChanged() : void
    {
        super.attackingViewChanged();
        if(localPlayer.isAttacking && localPlayer.isLiving)
        {
            _player.addChild(_takeAim);
            addChild(_moveStripContainer);
        }
        else
        {
            if(_player.contains(_takeAim))
            {
                _player.removeChild(_takeAim);
            }
            if(_moveStripContainer.parent)
            {
                removeChild(_moveStripContainer);
            }
        }
    }

    override public function die() : void
    {
        localPlayer.dander = 0;
        if(_takeAim && _player.contains(_takeAim))
        {
            _player.removeChild(_takeAim);
        }
        if(_moveStripContainer && _moveStripContainer.parent)
        {
            _moveStripContainer.parent.removeChild(_moveStripContainer);
        }
        if(map)
        {
            map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,50,false,1));
            if(RoomManager.Instance.current.type != 21 || RoomManager.Instance.current.type != 41 || RoomManager.Instance.current.type != 42 || RoomManager.Instance.current.type != 56)
            {
                map.addEventListener("click",__mouseClick);
            }
        }
        if(_shootTimer)
        {
            _shootTimer.removeEventListener("timer",__shootTimer);
        }
        setCollideRect(-8,-8,16,16);
        super.die();
    }

    override public function revive() : void
    {
        super.revive();
        if(map)
        {
            map.removeEventListener("click",__mouseClick);
        }
        if(_shootTimer)
        {
            _shootTimer.addEventListener("timer",__shootTimer);
        }
        setCollideRect(-5,-5,5,5);
    }

    private function __mouseClick(param1:MouseEvent) : void
    {
        var _loc2_:Point = _map.globalToLocal(new Point(param1.stageX,param1.stageY));
        _map.addChild(mouseAsset);
        SoundManager.instance.play("041");
        mouseAsset.x = _loc2_.x;
        mouseAsset.y = _loc2_.y;
        mouseAsset.visible = true;
        GameInSocketOut.sendGhostTarget(_loc2_);
    }

    public function hideTargetMouseTip() : void
    {
        mouseAsset.visible = false;
    }

    override protected function __usingItem(param1:LivingEvent) : void
    {
        super.__usingItem(param1);
        if(param1.paras[0] is ItemTemplateInfo)
        {
            localPlayer.energy = localPlayer.energy - int(param1.paras[0].Property4);
        }
    }

    protected function __sendShoot(param1:LivingEvent) : void
    {
        _shootPoint = shootPoint();
        _shootCount = 0;
        shootOverCount = 0;
        localPlayer.isAttacking = false;
        _isShooting = true;
        map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,1,false,2));
        GameInSocketOut.sendGameCMDDirection(info.direction);
        GameInSocketOut.sendShootTag(true,localPlayer.shootTime);
        if(localPlayer.shootType == 0)
        {
            localPlayer.force = param1.paras[0];
            _shootTimer.start();
            __shootTimer(null);
        }
        else
        {
            act(new PlayerBeatAction(this));
        }
    }

    private function __shootTimer(param1:Event) : void
    {
        var _loc3_:Number = NaN;
        var _loc2_:int = 0;
        if(localPlayer && localPlayer.isLiving && _shootCount < localPlayer.shootCount)
        {
            _loc3_ = localPlayer.calcBombAngle();
            _loc2_ = localPlayer.force;
            GameInSocketOut.sendGameCMDShoot(_shootPoint.x,_shootPoint.y,_loc2_,_loc3_);
            MapView(_map).gameView.setRecordRotation();
            _shootCount = Number(_shootCount) + 1;
        }
    }

    override protected function __shoot(param1:LivingEvent) : void
    {
        super.__shoot(param1);
        localPlayer.lastFireBombs = param1.paras[0];
        if(GameControl.Instance.Current.roomType == 21)
        {
            if(_shootCount >= localPlayer.shootCount && map)
            {
                map.act(new FocusInLivingAction(map.getOneSimpleBoss));
            }
        }
    }

    override protected function __beginNewTurn(param1:LivingEvent) : void
    {
        super.__beginNewTurn(param1);
        if(localPlayer.isSelf)
        {
            map.act(new NewHandFightHelpAction(localPlayer,_shootOverCount,map));
        }
        _shootCount = 0;
        shootOverCount = 0;
        _shootTimer.reset();
        if(_player.contains(_takeAim))
        {
            _player.removeChild(_takeAim);
        }
        _isShooting = false;
    }

    public function get shootOverCount() : int
    {
        return _shootOverCount;
    }

    public function set shootOverCount(param1:int) : void
    {
        _shootOverCount = param1;
        if(_shootOverCount == _shootCount)
        {
            _isShooting = false;
        }
    }

    protected function __gunangleChanged(param1:LivingEvent) : void
    {
        _takeAim["hand"].rotation = localPlayer.gunAngle;
    }

    protected function __beginShoot(param1:LivingEvent) : void
    {
    }

    protected function __energyChanged(param1:LivingEvent) : void
    {
        if(localPlayer.isLiving)
        {
            _moveStrip.scaleX = localPlayer.energy / localPlayer.maxEnergy;
        }
    }

    override protected function __usePetSkill(param1:LivingEvent) : void
    {
        if(_info.isLocked)
        {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
            return;
        }
        super.__usePetSkill(param1);
        var _loc2_:PetSkillTemplateInfo = PetSkillManager.getSkillByID(param1.value);
        if(_loc2_.isActiveSkill)
        {
            switch(int(_loc2_.BallType))
            {
                case 0:
                    localPlayer.spellKillEnabled = false;
                    break;
                case 1:
                case 2:
                case 3:
                    var _loc3_:* = false;
                    localPlayer.spellKillEnabled = _loc3_;
                    _loc3_ = _loc3_;
                    localPlayer.rightPropEnabled = _loc3_;
                    _loc3_ = _loc3_;
                    localPlayer.deputyWeaponEnabled = _loc3_;
                    _loc3_ = _loc3_;
                    localPlayer.flyEnabled = _loc3_;
                    _loc3_ = _loc3_;
                    localPlayer.propEnabled = _loc3_;
                    localPlayer.soulPropEnabled = _loc3_;
            }
        }
    }
}
}
