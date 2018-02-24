package org.aswing
{
import ddt.manager.ChatManager;

import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import org.aswing.util.ASWingVector;

[Event(name="keyDown",type="flash.events.KeyboardEvent")]
[Event(name="keyUp",type="flash.events.KeyboardEvent")]
public class KeyboardManager extends EventDispatcher
{

    private static var instance:KeyboardManager;


    private var keymaps:ASWingVector;

    private var keySequence:ASWingVector;

    private var selfKeyMap:KeyMap;

    private var inited:Boolean;

    private var keyJustActed:Boolean;

    private var _isStopDispatching:Boolean;

    private var mnemonicModifier:Array;

    private var _stage:Stage;

    public function KeyboardManager()
    {
        super();
        inited = false;
        keyJustActed = false;
        keymaps = new ASWingVector();
        keySequence = new ASWingVector();
        selfKeyMap = new KeyMap();
        mnemonicModifier = [17,16];
        registerKeyMap(selfKeyMap);
    }

    public static function getInstance() : KeyboardManager
    {
        if(instance == null)
        {
            instance = new KeyboardManager();
        }
        return instance;
    }

    public static function isDown(param1:uint) : Boolean
    {
        return getInstance().isKeyDown(param1);
    }

    override public function dispatchEvent(param1:Event) : Boolean
    {
        if(isStopDispatching)
        {
            return false;
        }
        return super.dispatchEvent(param1);
    }

    public function registerKeyMap(param1:KeyMap) : void
    {
        if(!keymaps.contains(param1))
        {
            keymaps.append(param1);
        }
    }

    public function unregisterKeyMap(param1:KeyMap) : void
    {
        keymaps.remove(param1);
    }

    public function registerKeyAction(param1:KeyType, param2:Function) : void
    {
        selfKeyMap.registerKeyAction(param1,param2);
    }

    public function unregisterKeyAction(param1:KeyType, param2:Function) : void
    {
        selfKeyMap.unregisterKeyAction(param1,param2);
    }

    public function isKeyDown(param1:uint) : Boolean
    {
        return keySequence.contains(param1);
    }

    public function setMnemonicModifier(param1:Array) : void
    {
        mnemonicModifier = param1.concat();
    }

    public function isMnemonicModifierDown() : Boolean
    {
        var _loc1_:int = 0;
        _loc1_ = 0;
        while(_loc1_ < mnemonicModifier.length)
        {
            if(!isKeyDown(mnemonicModifier[_loc1_]))
            {
                return false;
            }
            _loc1_++;
        }
        return mnemonicModifier.length > 0;
    }

    public function isKeyJustActed() : Boolean
    {
        return keyJustActed;
    }

    private function __onKeyDown(param1:KeyboardEvent) : void
    {
        var _loc5_:int = 0;
        var _loc2_:* = null;
        dispatchEvent(param1);
        var _loc4_:uint = param1.keyCode;
        if(!keySequence.contains(_loc4_) && _loc4_ < 139)
        {
            keySequence.append(_loc4_);
        }
        keyJustActed = false;
        var _loc3_:int = keymaps.size();
        _loc5_ = 0;
        while(_loc5_ < _loc3_)
        {
            _loc2_ = KeyMap(keymaps.get(_loc5_));
            if(_loc2_.fireKeyAction(keySequence.toArray()))
            {
                keyJustActed = true;
            }
            _loc5_++;
        }
    }

    private function __onKeyUp(param1:KeyboardEvent) : void
    {
        dispatchEvent(param1);
        var _loc2_:uint = param1.keyCode;
        keySequence.remove(_loc2_);
        if(!param1.ctrlKey)
        {
            keySequence.remove(17);
        }
        if(!param1.shiftKey)
        {
            keySequence.remove(16);
        }
    }

    private function __deactived(param1:Event) : void
    {
        keySequence.clear();
    }

    public function reset() : void
    {
        keySequence.clear();
    }

    public function get isStopDispatching() : Boolean
    {
        return _isStopDispatching;
    }

    public function set isStopDispatching(param1:Boolean) : void
    {
        _isStopDispatching = param1;
    }
//======================================================================================================================
    public function customDispatchEvent(param1:Event) : Boolean
    {
        return _stage.dispatchEvent(param1);
    }

    public function init(param1:Stage) : void
    {
        if(!inited)
        {
            inited = true;
            _stage = param1;
            param1.addEventListener("keyDown",__onKeyDown,false,0,true);
            param1.addEventListener("keyUp",__onKeyUp,false,0,true);
            param1.addEventListener("deactivate",__deactived,false,0,true);
        }
    }

//======================================================================================================================
}
}
