package gameAuto.autoControl
{

import ddt.events.LivingEvent;
import ddt.manager.AutoSocketManager;
import ddt.manager.AutoSocketManager;
import ddt.manager.ChatManager;
import ddt.manager.DDTManager;
import ddt.manager.DebugEvent;
import ddt.manager.DebugManager;
import ddt.manager.view.DDTConsole;
import ddt.view.character.GameCharacter;
import ddt.view.character.ShowCharacter;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import flash.external.ExternalInterface;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.clearTimeout;
import flash.utils.getTimer;
import flash.utils.setTimeout;
import game.view.map.MapView;
import gameAuto.AutoGameManager;

import gameCommon.GameControl;

import gameCommon.model.GameInfo;
import gameCommon.model.Living;
import gameCommon.model.LocalPlayer;
import gameCommon.model.SmallEnemy;
import org.aswing.KeyStroke;
import org.aswing.KeyboardManager;
import phy.math.EulerVector;
import road7th.data.DictionaryData;
import room.RoomManager;

import store.view.exalt.ExaltItemCell;

public class MatchGameAutoControl extends EventDispatcher implements IAutoControl
{


    private var _keyBoards:Array;

    private var _isAuto:Boolean = false;

    private var _stateFlag:int;

    private var _arf:int;

    private var _gf:int;

    private var _ga:int;

    private var _wa:int;

    private var _mass:Number = 10;

    private var _gravityFactor:Number = 70;

    private var _dt:Number = 0.04;

    protected var _windFactor:Number = 240;

    private var _mapWind:Number = 0;

    private var _currentLivID:int;

    public var _drawRoute:Sprite;

    private var _collideRect:Rectangle;

    private var _keyBoardTime:uint = 0;

    private var _shootTime:uint = 0;

    private var _selfWeaponAngle:int = 0;

    private const ONE_THREE_KILL_SHOOT_ACTION:int = 1;

    private const TWO_THREE_KILL_SHOOT_ACTION:int = 2;

    private const DAME_TWO_KILL_SHOOT_ACTION:int = 3;

    private const DAME_ONE_KILL_SHOOT_ACTION:int = 4;

    private const DAME_ZERO_KILL_SHOOT_ACTION:int = 5;

    private const PASSING_TURN_SHOOT_ACTION:int = 6;

    private const FLY_SHOOT_ACTION:int = 7;

    public function MatchGameAutoControl()
    {
        _keyBoards = [];
        _collideRect = new Rectangle(-45,-30,100,80);
        super();
        initCanvas();
        AutoGameManager.Instance.addEventListener(AutoGameManager.AUTO_MATCH_GAME_TOGGLED, __autoMatchGameToggled)

    }

    private function initCanvas() : void
    {
        _drawRoute = new Sprite();
        map.addChild(_drawRoute);
    }

    private function shoot() : void
    {
        readyShoot(function () {
            if(_isAuto)
            {
                if (selfPlayer.isLiving && selfPlayer.isAttacking)
                {
                    selfPlayer.dispatchEvent(new LivingEvent("sendShootAction",0,0,selfPlayer.force));
                }
            }
        });
    }

    private function readyShoot(param1:Function) : void
    {
        var shootType:int = initShootAction();
        initAddKey(shootType);
        exeKeyBoard(param1);

    }

    private function initRoute() : void
    {

    }

    private function getRouteData(force:Number, bombAngle:Number, selfPoint:Point, targetPoint:Point) : Vector.<Point>
    {
        var _loc9_:* = null;
        var _loc7_:* = null;
        var _loc6_:int = 0;
        var _loc5_:int = 0;
        if(force > 2000)
        {
            return null;
        }
        _loc6_ = force * Math.cos(bombAngle / 180 * 3.14159265358979);
        _loc9_ = new EulerVector(selfPoint.x,_loc6_,_wa);
        _loc5_ = force * Math.sin(bombAngle / 180 * 3.14159265358979);
        _loc7_ = new EulerVector(selfPoint.y,_loc5_,_ga);
        var _loc8_:Vector.<Point> = new Vector.<Point>();
        _loc8_.push(new Point(selfPoint.x,selfPoint.y));
        while(!isOutOfMap(_loc9_,_loc7_))
        {
            if(ifHit(_loc9_.x0,_loc7_.x0,targetPoint))
            {
                return _loc8_;
            }
            _loc9_.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
            _loc7_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            _loc8_.push(new Point(_loc9_.x0,_loc7_.x0));
        }
        return _loc8_;
    }

    public function isMapLineEmpty(x1:Number, y1:Number, x2:Number, y2:Number) : Boolean
    {
        var num1:Number = Math.atan2(y2 - y1,x2 - x1);
        var deltaX:int = x2 - x1;
        var deltaY:int = y2 - y1;
        var _x:Number = NaN;
        var _y:Number = NaN;
        var distance:Number = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
        var tmp:Number = 0;
        while (tmp < distance)
        {
            _x = x1 + Math.cos(num1) * tmp;
            _y = y1 + Math.sin(num1) * tmp;
            if (((map.ground != null && !map.ground.IsEmpty(_x, _y)) || (map.stone != null && !map.stone.IsEmpty(_x, _y))))
                return false;
            tmp += 1;
        }
        return true;
    }

    public function doMoveLeft() : void
    {
        addKeyBoard(KeyStroke.VK_A.getCode());
        addKeyBoard(KeyStroke.VK_A.getCode());
        addKeyBoard(KeyStroke.VK_A.getCode());
        addKeyBoard(KeyStroke.VK_A.getCode());
        exeKeyBoard(initFlyAction);
    }

    function sleep(ms:int):void {
        var init:int = getTimer();
        while(true) {
            if(getTimer() - init >= ms) {
                break;
            }
        }
    }

    private function initFlyAction():void
    {
        var _selfBombAngle:int = 0;
        var _selfMinBombAngle:int = 0;
        var _selfMaxBombAngle:int = 0;
        var _selfPoint:Point = null;
        _arf = map.airResistance;
        _gf = map.gravity * _mass * _gravityFactor;
        _ga = _gf / _mass;
        _wa = _mapWind / _mass;
        for (var i:int = 0; i < 2; i++)
        {
            if (selfPlayer.direction > 0)
            {
                _selfPoint = getSelfPoint();
                _selfMinBombAngle = selfPlayer.playerAngle;
                _selfMaxBombAngle = selfPlayer.playerAngle - 90;
                if (_selfMaxBombAngle > -65)
                {
                    ChatManager.Instance.sysChatYellow("angle < 65");
                    addKeyBoard(KeyStroke.VK_D.getCode());
                    addKeyBoard(KeyStroke.VK_D.getCode());
                    exeKeyBoard(initFlyAction);
                    return;
                }
                if (_selfMinBombAngle > -65) _selfMinBombAngle = -65;
                if (_selfMaxBombAngle < -90) _selfMaxBombAngle = -90;
                for (_selfBombAngle = _selfMaxBombAngle; _selfBombAngle < _selfMinBombAngle; ++_selfBombAngle)
                {
                    for (var _iforce:int = 2000; _iforce > 500; _iforce-= 10)
                    {
                        if (checkFlyRoute(_selfPoint,_selfBombAngle,_iforce))
                        {
                            selfPlayer.direction = 1;
                            selfPlayer.manuallySetGunAngle(selfPlayer.playerAngle - _selfBombAngle);
                            selfPlayer.force = _iforce;
                            ChatManager.Instance.sysChatYellow("direction: " + selfPlayer.direction);
                            ChatManager.Instance.sysChatYellow("angle: " + (selfPlayer.playerAngle - _selfBombAngle).toString());
                            ChatManager.Instance.sysChatYellow("force: " + _iforce);
                            return;
                        }
                    }
                    sleep(10);
                }
                selfPlayer.direction = -1;
            }
            else if (selfPlayer.direction < 0)
            {
                _selfPoint = getSelfPoint();
                _selfMinBombAngle = selfPlayer.playerAngle - 180;
                _selfMaxBombAngle = selfPlayer.playerAngle - 90;
                if (_selfMaxBombAngle < -115)
                {
                    ChatManager.Instance.sysChatYellow("angle < 65");
                    addKeyBoard(KeyStroke.VK_A.getCode());
                    addKeyBoard(KeyStroke.VK_A.getCode());
                    exeKeyBoard(initFlyAction);
                    return;
                }
                if (_selfMinBombAngle < -115) _selfMinBombAngle = -115;
                if (_selfMaxBombAngle > -90) _selfMaxBombAngle = -90;
                for (_selfBombAngle = _selfMaxBombAngle; _selfBombAngle >= _selfMinBombAngle; --_selfBombAngle)
                {
                    for (var _iforce:int = 2000; _iforce > 500; _iforce-= 10)
                    {
                        if (checkFlyRoute(_selfPoint,_selfBombAngle,_iforce))
                        {
                            selfPlayer.direction = -1;
                            selfPlayer.manuallySetGunAngle(_selfBombAngle - selfPlayer.playerAngle + 180);
                            selfPlayer.force = _iforce;
                            ChatManager.Instance.sysChatYellow("direction: " + selfPlayer.direction);
                            ChatManager.Instance.sysChatYellow("angle: " + (selfPlayer.playerAngle - _selfBombAngle).toString());
                            ChatManager.Instance.sysChatYellow("force: " + _iforce);
                            return;
                        }
                    }
                    sleep(10);
                }
                selfPlayer.direction = 1;
            }
        }
    }

    private function checkFlyRoute(selfPoint:Point, bombAngle:Number, force:Number ) : Boolean
    {
        var v1:* = null;
        var v2:* = null;
        var num1:int = 0;
        var num2:int = 0;
        var _x:Number = 0;
        var _y:Number = 0;
        var _oldY:Number = 0;
        var _oldX:Number = 0;
        var deltaX:int = 0;
        var deltaY:int = 0;
        var _tAngle:Number = NaN;
        var _tx:Number = NaN;
        var _ty:Number = NaN;
        var distance:Number = NaN;
        var _tmpMapHeight:int = 0;
        var _tmpMapDigable:Boolean = true;

        num1 = force * Math.cos(bombAngle / 180 * 3.14159265358979);
        v1 = new EulerVector(selfPoint.x,num1,_wa);
        num2 = force * Math.sin(bombAngle / 180 * 3.14159265358979);
        v2 = new EulerVector(selfPoint.y,num2,_ga);

        v1.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
        v2.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
        _oldX = v1.x0;
        _oldY = v2.x0;

        while(!isOutOfMap(v1,v2))
        {
            v1.ComputeOneEulerStep(_mass,_arf,_mapWind,_dt);
            v2.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            _x = v1.x0;
            _y = v2.x0;

            deltaX = _x - _oldX;
            deltaY = _y - _oldY;
            _tAngle = Math.atan2(deltaY, deltaX);
            distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
            for (var _td = 0; _td < distance; _td++)
            {
                _tx = _oldX + Math.cos(_tAngle) * _td;
                _ty = _oldY + Math.sin(_tAngle) * _td;

                if (((map.ground != null && !map.ground.IsEmpty(_tx, _ty)) || (map.stone != null && !map.stone.IsEmpty(_tx, _ty))))
                {
                    if (_oldY < _ty)
                    {
                        _tmpMapHeight = 0;
                        for (var j:int = _ty; j < map.bound.height; ++j)
                        {
                            if((map.ground != null && !map.ground.IsEmpty(_tx, j)))
                            {
                                ++_tmpMapHeight;
                                _tmpMapDigable = map.ground.digable;
                            }
                            else if (map.stone != null && !map.stone.IsEmpty(_tx, j))
                            {
                                ++_tmpMapHeight;
                                _tmpMapDigable = map.stone.digable;
                            }
                        }
                        if (_tmpMapHeight > 250 || !_tmpMapDigable)
                        {
                            ChatManager.Instance.sysChatYellow("_tmpMapHeight: " + _tmpMapHeight);
                            ChatManager.Instance.sysChatYellow("_tmpMapDigable: " + _tmpMapDigable);
                            return true;
                        }
                    }
                    else return false;
                }
            }
            _oldY = _y;
            _oldX = _x;
        }
        return false;
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

    private function initShotEnermyAction():void
    {
        selfPlayer.manuallySetGunAngle(_selfWeaponAngle);
//        if(selfPlayer.isLiving && selfPlayer.isAttacking) {
//            _stateFlag = 0;
//            if (_force > 2000) {
//                if (_target.state) {
//                    _stateFlag = 1;
//                }
//                else {
//                    _stateFlag = 2;
//                }
//                _target.state = false;
//            }
//            else {
//                if (_target.state) {
//                    _stateFlag = 3;
//                }
//                else {
//                    _stateFlag = 4;
//                }
//                _target.state = true;
//            }
//            if (_force < 2100) {
//                selfPlayer.force = _force;
//            }
//            //selfPlayer.dispatchEvent(new LivingEvent("sendShootAction", 0, 0, _force));
//            //setKeyEventDisenable(false);
//        }
    }

    private function initShootAction() : int
    {
        try
        {
            var _force:* = NaN;
            var _loc6_:Boolean = false;
            var _loc7_:Boolean = false;
            var _selfPoint:* = null;
            var _target:Living = null;
            var _targetPoint:Point = null;
            var _selfBombAngle:int = 0;
            var _selfMinBombAngle:int = 0;
            var _selfMaxBombAngle:int = 0;
            var _distanceX:Number = NaN;
            var _selfMapHeight:int = 0;
            var _selfMapDigable:Boolean = false;
            _selfPoint = selfPlayer.pos;
            _selfMapHeight = 0;
            for (var i:int = _selfPoint.y; i < map.bound.height; ++i)
            {
                if((map.ground != null && !map.ground.IsEmpty(_selfPoint.x, i)))
                {
                    ++_selfMapHeight;
                    _selfMapDigable = map.ground.digable;
                }
                else if (map.stone != null && !map.stone.IsEmpty(_selfPoint.x, i))
                {
                    ++_selfMapHeight;
                    _selfMapDigable = map.stone.digable;
                }
            }
            ChatManager.Instance.sysChatYellow("_selfMapHeight: " + _selfMapHeight);
            ChatManager.Instance.sysChatYellow("_selfMapDigable: " + _selfMapDigable);
            if (_selfMapHeight < 200 && _selfMapDigable)
            {
                if (selfPlayer.flyEnabled)
                {
                    selfPlayer.useFly();
                    ChatManager.Instance.sysChatYellow("Use Fly");
                    initFlyAction();
                    return FLY_SHOOT_ACTION;
                }
            }

//            _target = getTarget(_selfPoint);
//            _targetPoint = _target.pos;
//            if (_targetPoint == null)
//            {
//                return PASSING_TURN_SHOOT_ACTION;
//            }

//            _targetDir = _selfPoint.x > _targetPoint.x?-1:1; //check if target is on the left of selfPlayer

//            _distanceX = Math.abs(_selfPoint.x - _targetPoint.x);

            //selfPlayer.manuallySetGunAngle(25 + selfPlayer.playerAngle * selfPlayer.direction);

        }
        catch (error:Error)
        {
            ChatManager.Instance.sysChatYellow(error.message + " at " + error.getStackTrace());
        }

        return PASSING_TURN_SHOOT_ACTION;
    }

    private function initAddKey(shootAction:int) : void
    {
        switch (shootAction)
        {
            case ONE_THREE_KILL_SHOOT_ACTION:
                break;
            case TWO_THREE_KILL_SHOOT_ACTION:
                break;
            case DAME_ZERO_KILL_SHOOT_ACTION:
                break;
            case DAME_TWO_KILL_SHOOT_ACTION:
                addKeyBoard(int(KeyStroke.VK_1.getCode()));
                addKeyBoard(int(KeyStroke.VK_4.getCode()));
                if(selfPlayer.energy < 700)
                {
                    addKeyBoard(int(KeyStroke.VK_4.getCode()));
                }
                if (selfPlayer.dander >= 200)
                {
                    addKeyBoard(int(KeyStroke.VK_B.getCode()));
                }
                break;
            case DAME_ONE_KILL_SHOOT_ACTION:
                addKeyBoard(int(KeyStroke.VK_3.getCode()));
                addKeyBoard(int(KeyStroke.VK_4.getCode()));
                if(selfPlayer.energy < 700)
                {
                    addKeyBoard(int(KeyStroke.VK_4.getCode()));
                }
                if (selfPlayer.dander >= 200)
                {
                    addKeyBoard(int(KeyStroke.VK_B.getCode()));
                }
                break;
            case PASSING_TURN_SHOOT_ACTION:
                addKeyBoard(int(KeyStroke.VK_P.getCode()));
                break;
            case FLY_SHOOT_ACTION:
                break;
        }

    }

    private function exeKeyBoard(calFun:Function) : void
    {
        if(_keyBoards.length > 0)
        {
            var keyObj:Object = _keyBoards.shift();
            KeyboardManager.getInstance().customDispatchEvent(new KeyboardEvent(keyObj["type"],true,false,0,keyObj["code"]));
            if(_keyBoardTime != 0)
            {
                clearTimeout(_keyBoardTime);
            }
            _keyBoardTime = setTimeout(function():void
            {
                exeKeyBoard(calFun);
            },200);
        }
        else
        {
//            ChatManager.Instance.sysChatYellow("readyshoot exeKeyBoard calFun");
            calFun();
        }
    }

    private function addKeyBoard(param1:int, param2:Function = null) : void
    {
        _keyBoards.push({
            "type":"keyDown",
            "code":param1,
            "backFun":null
        });
        _keyBoards.push({
            "type":"keyUp",
            "code":param1,
            "backFun":param2
        });
    }

    private function initTargetPriority() : void
    {
//        ChatManager.Instance.sysChatYellow("initTargetPriority");
        try
        {
            var minFightPower:* = 2147483647;
            var _weakTarget:Living = null;
            var _allivings:DictionaryData = gameInfo.livings;
            var curLiv:Living = null;
            var otherLiv:Living = null;
            for each(curLiv in _allivings) {
                curLiv.shotPriority = 0;
                if (curLiv.LivingID != selfPlayer.LivingID && curLiv.team != selfPlayer.team && curLiv.blood > 0) {
                    ++curLiv.shotPriority;
                    for each(otherLiv in _allivings) {
                        if (otherLiv != curLiv) {
                            if (otherLiv.team != selfPlayer.team && otherLiv.LivingID != selfPlayer.LivingID && curLiv.blood > 0) {
                                if (Math.abs(otherLiv.pos.x - curLiv.pos.x) < 50 && Math.abs(otherLiv.pos.y - curLiv.pos.y) < 20)
                                    ++curLiv.shotPriority;
                            }
                        }
                    }
                    if (curLiv.blood / curLiv.maxBlood < 0.35) ++curLiv.shotPriority;
                    if (_weakTarget == null) _weakTarget = curLiv;
                    ChatManager.Instance.sysChatYellow(curLiv.playerInfo.NickName + " fp:" + curLiv.fightPower);
                    ChatManager.Instance.sysChatYellow("minFightPower:" + minFightPower);
                    if (_weakTarget.playerInfo.FightPower < minFightPower)
                    {
                        _weakTarget = curLiv;
                        minFightPower = curLiv.playerInfo.FightPower;
                    }
                }
            }
            _weakTarget.shotPriority++;
            ChatManager.Instance.sysChatYellow("_weakTarget: " + _weakTarget.playerInfo.NickName);
            for each (curLiv in _allivings)
            {
                ChatManager.Instance.sysChatYellow(curLiv.playerInfo.NickName + ":" + curLiv.shotPriority);
            }
        }
        catch (error:Error)
        {
            ChatManager.Instance.sysChatYellow(error.message + error.getStackTrace());
        }
    }

    private function getTarget(selfPoint:Point) : Living
    {
        initTargetPriority();
        var _allivings:DictionaryData = gameInfo.livings;
        var _target:Living = selfPlayer;
        for each(var liv:Living in _allivings)
        {
            if (liv.shotPriority > _target.shotPriority)
            {
                _target = liv;
            }
        }
        return _target;
    }

    private function getSelfPoint() : Point
    {
        return localToGlcbalByPoint((gameInfo.selfGamePlayer.movie as GameCharacter).localToGlobal(new Point(30,-20)));
    }

    private function localToGlcbalByPoint(param1:Point) : Point
    {
        if(selfPlayer.currentMap)
        {
            return selfPlayer.currentMap.globalToLocal(param1);
        }
        return new Point(0,0);
    }

    private function get map() : MapView
    {
        return selfPlayer.currentMap;
    }

    public function setAutoState(param1:Boolean) : void
    {
        ChatManager.Instance.sysChatYellow("setAutoState: " + param1);
        if(_isAuto != param1)
        {
            _isAuto = param1;
            if(_isAuto)
            {
                ChatManager.Instance.sysChatYellow("AutoGame initEvent");
                initEvent();
            }
            else
            {
                removeEvent();
            }
        }
    }

    private function initEvent() : void
    {
        selfPlayer.addEventListener("attackingChanged",__autoShootHandler);
        selfPlayer.addEventListener("gunangleChanged",__changeAngle);
        selfPlayer.addEventListener("posChanged",__changeAngle);
        selfPlayer.addEventListener("dirChanged",__changeAngle);
    }

    private function removeEvent() : void
    {
        selfPlayer.removeEventListener("attackingChanged",__autoShootHandler);
        selfPlayer.removeEventListener("gunangleChanged",__changeAngle);
        selfPlayer.removeEventListener("posChanged",__changeAngle);
        selfPlayer.removeEventListener("dirChanged",__changeAngle);
    }

    private function __autoMatchGameToggled(e:Event) : void
    {
        if (AutoGameManager.Instance.IsAutoMatchGame)
        {
            if (selfPlayer.isAttacking)
            {
                __autoShootHandler(null);
            }
        }
    }

    protected function __changeAngle(param1:LivingEvent) : void
    {
        _mapWind = GameControl.Instance.Current.wind * _windFactor;
    }

    public function updateWind(param1:Number) : void
    {
        _mapWind = param1 / 10 * _windFactor;
    }

    private function __autoShootHandler(param1:LivingEvent) : void
    {
        if((RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1) && selfPlayer.isAttacking)
        {
            //setKeyEventDisenable(true);
            if(_shootTime != 0)
            {
                clearTimeout(_shootTime);
            }
            _shootTime = setTimeout(shoot,1000);
        }
    }

    private function get selfPlayer() : LocalPlayer
    {
        if(GameControl.Instance.Current)
        {
            return GameControl.Instance.Current.selfGamePlayer;
        }
        return null;
    }

    private function get gameInfo() : GameInfo
    {
        return GameControl.Instance.Current;
    }

    public function clear() : void
    {
        if(_shootTime != 0)
        {
            clearTimeout(_shootTime);
        }
        if(_keyBoardTime != 0)
        {
            clearTimeout(_keyBoardTime);
        }
        removeEvent();
        AutoGameManager.Instance.removeEventListener(AutoGameManager.AUTO_MATCH_GAME_TOGGLED, __autoMatchGameToggled)
        _keyBoards = [];
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
                if(_loc10_.x0 > map.bound.width)
                {
                    return true;
                }
                if(_loc10_.x0 < map.bound.x || _loc8_.x0 > map.bound.height)
                {
                    return false;
                }
            }
            else
            {
                if(_loc10_.x0 < map.bound.x)
                {
                    break;
                }
                if(_loc10_.x0 > map.bound.width || _loc8_.x0 > map.bound.height)
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

    protected function ifHit(param1:Number, param2:Number, param3:Point) : Boolean
    {
        if(param1 > param3.x - 15 && param1 < param3.x + 20 && param2 > param3.y - 20 && param2 < param3.y + 30)
        {
            return true;
        }
        return false;
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
                if(_loc9_.x0 > map.bound.width)
                {
                    _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                    break;
                }
                if(_loc8_.x0 > map.bound.height)
                {
                    _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                    break;
                }
                if(_loc9_.x0 < map.bound.x)
                {
                    _loc12_ = 2100;
                    return 2100;
                }
            }
            else
            {
                if(_loc9_.x0 < map.bound.x)
                {
                    _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                    break;
                }
                if(_loc8_.x0 > map.bound.height)
                {
                    _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                    break;
                }
                if(_loc9_.x0 > map.bound.width)
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

    private function isOutOfMap(param1:EulerVector, param2:EulerVector) : Boolean
    {
        if(param1.x0 < map.bound.x || param1.x0 > map.bound.width || param2.x0 > map.bound.height)
        {
            return true;
        }
        return false;
    }

    public function get currentLivID() : int
    {
        return _currentLivID;
    }

    public function set currentLivID(param1:int) : void
    {
        _currentLivID = param1;
    }

    private function calculateRecent() : int
    {
        var _loc3_:* = undefined;
        var _loc5_:int = 0;
        var _loc4_:int = 0;
        var _loc2_:* = 2147483647;
        var _loc1_:int = -1;
        var _loc8_:int = 0;
        var _loc7_:* = gameInfo.livings;
        for each(var _loc6_ in gameInfo.livings)
        {
            if(_loc6_.route)
            {
                if(RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1|| !(_loc6_ is SmallEnemy))
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

    private function setKeyEventDisenable(param1:Boolean) : void
    {
        KeyboardManager.getInstance().isStopDispatching = param1;
    }
}
}
