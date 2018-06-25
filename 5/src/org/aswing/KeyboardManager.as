package org.aswing
{
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

        public static function isDown(keyCode:uint) : Boolean
        {
            return getInstance().isKeyDown(keyCode);
        }

        // modified
        public function customDispatchEvent(event:Event) : Boolean
        {
            return _stage.dispatchEvent(event);
        }

        // modified
        public function init(stage:Stage) : void
        {
            if(!inited)
            {
                inited = true;
                _stage = stage;
                stage.addEventListener("keyDown",__onKeyDown,false,0,true);
                stage.addEventListener("keyUp",__onKeyUp,false,0,true);
                stage.addEventListener("deactivate",__deactived,false,0,true);
            }
        }

        override public function dispatchEvent(event:Event) : Boolean
        {
            if(isStopDispatching)
            {
                return false;
            }
            return super.dispatchEvent(event);
        }

        public function registerKeyMap(keyMap:KeyMap) : void
        {
            if(!keymaps.contains(keyMap))
            {
                keymaps.append(keyMap);
            }
        }

        public function unregisterKeyMap(keyMap:KeyMap) : void
        {
            keymaps.remove(keyMap);
        }

        public function registerKeyAction(key:KeyType, action:Function) : void
        {
            selfKeyMap.registerKeyAction(key,action);
        }

        public function unregisterKeyAction(key:KeyType, action:Function) : void
        {
            selfKeyMap.unregisterKeyAction(key,action);
        }

        public function isKeyDown(keyCode:uint) : Boolean
        {
            return keySequence.contains(keyCode);
        }

        public function setMnemonicModifier(keyCodes:Array) : void
        {
            mnemonicModifier = keyCodes.concat();
        }

        public function isMnemonicModifierDown() : Boolean
        {
            var i:int = 0;
            for(i = 0; i < mnemonicModifier.length; )
            {
                if(!isKeyDown(mnemonicModifier[i]))
                {
                    return false;
                }
                i++;
            }
            return mnemonicModifier.length > 0;
        }

        public function isKeyJustActed() : Boolean
        {
            return keyJustActed;
        }

        private function __onKeyDown(e:KeyboardEvent) : void
        {
            var i:int = 0;
            var keymap:* = null;
            dispatchEvent(e);
            var code:uint = e.keyCode;
            if(!keySequence.contains(code) && code < 139)
            {
                keySequence.append(code);
            }
            keyJustActed = false;
            var n:int = keymaps.size();
            for(i = 0; i < n; )
            {
                keymap = KeyMap(keymaps.get(i));
                if(keymap.fireKeyAction(keySequence.toArray()))
                {
                    keyJustActed = true;
                }
                i++;
            }
        }

        private function __onKeyUp(e:KeyboardEvent) : void
        {
            dispatchEvent(e);
            var code:uint = e.keyCode;
            keySequence.remove(code);
            if(!e.ctrlKey)
            {
                keySequence.remove(17);
            }
            if(!e.shiftKey)
            {
                keySequence.remove(16);
            }
        }

        private function __deactived(e:Event) : void
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

        public function set isStopDispatching(value:Boolean) : void
        {
            _isStopDispatching = value;
        }
    }
}
