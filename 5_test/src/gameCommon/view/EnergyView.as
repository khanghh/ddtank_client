package gameCommon.view
{
import com.pickgliss.toplevel.StageReferance;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;
import ddt.events.CrazyTankSocketEvent;
import ddt.events.LivingEvent;
import ddt.manager.ChatManager;
import ddt.manager.LanguageMgr;
import ddt.manager.MessageTipManager;
import ddt.manager.SocketManager;
import ddt.manager.SoundManager;
import fightLib.FightLibManager;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import game.view.map.MapView;
import gameCommon.GameControl;
import gameCommon.model.LocalPlayer;
import org.aswing.KeyboardManager;
import trainer.controller.NewHandGuideManager;

public class EnergyView extends Sprite implements Disposeable
{

    public static var canPower:Boolean = false;

    public static const STRIP_WIDTH:Number = 498;

    public static const FORCE_MAX:Number = 2000;

    public static const SHOOT_FORCE_STEP:Number = 20;

    public static const HIT_FORCE_STEP:Number = 40;


    private var _recordeWidth:Number;

    private var _self:LocalPlayer;

    private var _force:Number = 0;

    private var _hitArea:Sprite;

    private var _forceSpeed:Number = 20;

    private var _hitX:int;

    private var _bg:Bitmap;

    private var _grayStrip:Bitmap;

    private var _lightStrip:Bitmap;

    private var _ruling:Bitmap;

    private var _slider:Sprite;

    private var _maxForce:int = 2000;

    private var _shootMsgShape:DisplayObject;

    private var _firstShoot:Boolean = false;

    private var _dynamismImg:Bitmap;

    private var _onProcess:Boolean = false;

    private var _keyDown:Boolean;

    private var _dir:int = 1;

    public function EnergyView(param1:LocalPlayer, param2:MapView = null)
    {
        var _loc3_:* = null;
        super();
        if(NewHandGuideManager.Instance.mapID == 111)
        {
            _loc3_ = "asset.trainer1.power.back";
        }
        else
        {
            _loc3_ = "asset.game.power.back";
        }
        _bg = ComponentFactory.Instance.creatBitmap(_loc3_);
        addChild(_bg);
        _lightStrip = ComponentFactory.Instance.creatBitmap("asset.game.rulingLightStripAsset");
        addChild(_lightStrip);
        _grayStrip = ComponentFactory.Instance.creatBitmap("asset.game.rulingGrayStripAsset");
        addChild(_grayStrip);
        _ruling = ComponentFactory.Instance.creatBitmap("asset.game.rulingAsset");
        addChild(_ruling);
        _slider = new Sprite();
        _slider.addChild(ComponentFactory.Instance.creatBitmap("asset.game.rulingBtnAsset"));
        addChild(_slider);
        _slider.x = _lightStrip.x;
        _slider.y = _lightStrip.y;
        _hitArea = new Sprite();
        _hitArea.graphics.beginFill(16776960,1);
        _hitArea.graphics.drawRect(0,0,499,25);
        _hitArea.graphics.endFill();
        _hitArea.x = _lightStrip.x;
        _hitArea.y = _lightStrip.y;
        _hitArea.buttonMode = true;
        _hitArea.alpha = 0;
        addChild(_hitArea);
        _lightStrip.width = 0;
        _recordeWidth = 0;
        _grayStrip.width = 0;
        _self = param1;
        if(NewHandGuideManager.Instance.hasShowEnergyMsg())
        {
            _shootMsgShape = ComponentFactory.Instance.creatBitmap("asset.game.power.ShootMsg");
            addChildAt(_shootMsgShape,getChildIndex(_hitArea));
        }
        SocketManager.Instance.addEventListener("missionOver",__over);
        SocketManager.Instance.addEventListener("gameOver",__over);
    }

    private function __visiableDynamismBar(param1:LivingEvent) : void
    {
        if(_self.showDisturb)
        {
            if(_dynamismImg == null)
            {
                _dynamismImg = ComponentFactory.Instance.creatBitmap("asset.game.skillBuff.dynamismbar");
            }
            addChild(_dynamismImg);
            var _loc2_:* = false;
            _lightStrip.visible = _loc2_;
            _loc2_ = _loc2_;
            _ruling.visible = _loc2_;
            _bg.visible = _loc2_;
        }
        else
        {
            if(_dynamismImg != null)
            {
                removeChild(_dynamismImg);
                _dynamismImg = null;
            }
            _loc2_ = true;
            _lightStrip.visible = _loc2_;
            _loc2_ = _loc2_;
            _ruling.visible = _loc2_;
            _bg.visible = _loc2_;
        }
    }

    private function __maxForceChanged(param1:LivingEvent) : void
    {
        _maxForce = param1.value;
    }

    private function __over(param1:CrazyTankSocketEvent) : void
    {
        StageReferance.stage.removeEventListener("keyDown",__keyDownSpace);
        SocketManager.Instance.removeEventListener("missionOver",__over);
        SocketManager.Instance.removeEventListener("gameOver",__over);
    }

    private function __keyDownSpace(param1:KeyboardEvent) : void
    {
        if(param1.keyCode == 32)
        {
            if(_self.isLiving)
            {
                if(!_self.isAttacking && !_onProcess)
                {
                    MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.ArrowViewIII.fall"));
                }
            }
            if(FightLibManager.Instance.isWork == true)
            {
                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.AngleMessage"));
            }
        }
    }

    private function __attackingChanged(param1:LivingEvent) : void
    {
        if(_self.isAttacking && _self.isLiving && !_self.autoOnHook)
        {
            addEventListener("enterFrame",__enterFrame);
            _keyDown = false;
            _force = 0;
            _dir = 1;
            _onProcess = true;
        }
        else
        {
            removeEventListener("enterFrame",__enterFrame);
            _onProcess = false;
        }
    }

    private function __enterFrame(param1:Event) : void
    {
        if(KeyboardManager.isDown(32))
        {
            if(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI && !canPower)
            {
                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.useEnergy.error"));
                return;
            }
            if(_keyDown)
            {
                calcForce();
            }
            else if(!_self.isMoving)
            {
                _keyDown = true;
                _onProcess = true;
                _self.beginShoot();
                _self.setCenter(_self.pos.x,_self.pos.y - 150,true);
                if(!_firstShoot)
                {
                    _firstShoot = true;
                    ObjectUtils.disposeObject(_shootMsgShape);
                    _shootMsgShape = null;
                }
            }
        }
        else if(_keyDown)
        {
            SoundManager.instance.stop("020");
            SoundManager.instance.play("019");
            _onProcess = false;
            if(_self.shootType == 0)
            {
                _self.sendShootAction(_force);
            }
            else
            {
                _self.sendShootAction(_force - _hitX);
            }
            removeEventListener("enterFrame",__enterFrame);
        }
    }

    private function calcForce() : void
    {
        if(_force >= _maxForce)
        {
            _dir = -1;
        }
        _self.iscalcForce = true;
        _force = _force + _dir * _forceSpeed;
        _force = _force > _maxForce?_maxForce:_force;
        _lightStrip.width = Math.ceil(498 / 2000 * _force);
        _recordeWidth = _lightStrip.width;
        SoundManager.instance.play("020",false,false);
        if(_force <= 0)
        {
            removeEventListener("enterFrame",__enterFrame);
            SoundManager.instance.stop("020");
            _self.skip();
        }
    }

    public function get force() : Number
    {
        return (_slider.x - _hitArea.x) / 498 * 2000;
    }


    public function leaving() : void
    {
        removeEvent();
    }

    public function dispose() : void
    {
        removeEvent();
        _self = null;
        ObjectUtils.disposeObject(_shootMsgShape);
        _shootMsgShape = null;
        ObjectUtils.disposeObject(_bg);
        _bg = null;
        if(_dynamismImg != null)
        {
            ObjectUtils.disposeObject(_dynamismImg);
            _dynamismImg = null;
        }
        removeChild(_grayStrip);
        _grayStrip.bitmapData.dispose();
        _grayStrip = null;
        removeChild(_lightStrip);
        _lightStrip.bitmapData.dispose();
        _lightStrip = null;
        removeChild(_ruling);
        _ruling.bitmapData.dispose();
        _ruling = null;
        ObjectUtils.disposeAllChildren(_slider);
        removeChild(_slider);
        _slider = null;
        if(parent)
        {
            parent.removeChild(this);
        }
    }

//============================================================================================================


    public function enter() : void
    {
        _self.addEventListener("attackingChanged",__attackingChanged);
        _self.addEventListener("beginNewTurn",__beginNewTurn);
        _self.addEventListener("maxforceChanged",__maxForceChanged);
        _self.addEventListener("DisturbStateChanged",__visiableDynamismBar);
        _self.addEventListener("forceChanged", __forceChanged);
        SocketManager.Instance.addEventListener("missionOver",__over);
        SocketManager.Instance.addEventListener("gameOver",__over);
        StageReferance.stage.addEventListener("keyDown",__keyDownSpace);
        KeyboardManager.getInstance().addEventListener("keyDown",__KeyDown);
        _hitArea.addEventListener("click",__click);
        if(_self.isAttacking && _self.isLiving)
        {
            addEventListener("enterFrame",__enterFrame);
            canPower = false;
            _keyDown = false;
            _force = 0;
            _dir = 1;
            _onProcess = true;
        }
        else
        {
            removeEventListener("enterFrame",__enterFrame);
            _onProcess = false;
        }
    }

    private function removeEvent() : void
    {
        KeyboardManager.getInstance().removeEventListener("keyDown",__KeyDown);
        StageReferance.stage.removeEventListener("keyDown",__keyDownSpace);
        SocketManager.Instance.removeEventListener("missionOver",__over);
        SocketManager.Instance.removeEventListener("gameOver",__over);
        SocketManager.Instance.removeEventListener("missionOver",__over);
        SocketManager.Instance.removeEventListener("gameOver",__over);
        removeEventListener("enterFrame",__enterFrame);
        if(_hitArea)
        {
            _hitArea.removeEventListener("click",__click);
        }
        if(_self)
        {
            _self.removeEventListener("attackingChanged",__attackingChanged);
            _self.removeEventListener("beginNewTurn",__beginNewTurn);
            _self.removeEventListener("maxforceChanged",__maxForceChanged);
            _self.removeEventListener("forceChanged", __forceChanged);
            _self.removeEventListener("DisturbStateChanged",__visiableDynamismBar);
        }
    }

    private function __forceChanged(event:Event):void{
        _slider.x = (_self.force  * 498 / 2000) + _hitArea.x;
    }

    private function __click(param1:MouseEvent) : void
    {
        if(!_firstShoot)
        {
            _firstShoot = true;
            ObjectUtils.disposeObject(_shootMsgShape);
            _shootMsgShape = null;
        }
        _slider.x = _hitArea.x + param1.localX;
        _self.force = force;
        //dispatchEvent(new Event("change"));
    }

    private function __beginNewTurn(param1:LivingEvent) : void
    {
        _self.iscalcForce = false;
        _lightStrip.width = 0;
        _grayStrip.width = _recordeWidth;
        _forceSpeed = 20;
        _slider.x = _lightStrip.x;
    }

    protected function __KeyDown(param1:KeyboardEvent) : void
    {
        if (param1.keyCode == 188)
        {
            var num1:Number = _self.force / 20  - 0.5;
            ChatManager.Instance.sysChatYellow("num1: " + num1.toString());
            var num2:Number = num1 - int(num1);
            ChatManager.Instance.sysChatYellow("num2: " + num2.toString());
            num1 = int(num1);
            ChatManager.Instance.sysChatYellow("int(num1): " + num1.toString());
            if (num2 > 0.5) num1 += 1;
            else if(num2 > 0) num1 += 0.5;
            _self.force = num1 * 20;
            //dispatchEvent(new Event("change"));
        }
        else if (param1.keyCode == 190)
        {
            var num1:Number = _self.force / 20  + 0.5;
            var num2:Number = num1 - int(num1);
            num1 = int(num1);
            if (num2 >= 0.5)  num1 = int(num1) + 0.5;
            else num1 = int(num1);
            _self.force = num1 * 20;
            //dispatchEvent(new Event("change"));

        }
    }

    public function  updateForce(val : Number) : void {

    }
//============================================================================================================
}
}
