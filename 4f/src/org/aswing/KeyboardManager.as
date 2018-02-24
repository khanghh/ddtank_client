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
      
      public function KeyboardManager(){super();}
      
      public static function getInstance() : KeyboardManager{return null;}
      
      public static function isDown(param1:uint) : Boolean{return false;}
      
      public function customDispatchEvent(param1:Event) : Boolean{return false;}
      
      public function init(param1:Stage) : void{}
      
      override public function dispatchEvent(param1:Event) : Boolean{return false;}
      
      public function registerKeyMap(param1:KeyMap) : void{}
      
      public function unregisterKeyMap(param1:KeyMap) : void{}
      
      public function registerKeyAction(param1:KeyType, param2:Function) : void{}
      
      public function unregisterKeyAction(param1:KeyType, param2:Function) : void{}
      
      public function isKeyDown(param1:uint) : Boolean{return false;}
      
      public function setMnemonicModifier(param1:Array) : void{}
      
      public function isMnemonicModifierDown() : Boolean{return false;}
      
      public function isKeyJustActed() : Boolean{return false;}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      private function __onKeyUp(param1:KeyboardEvent) : void{}
      
      private function __deactived(param1:Event) : void{}
      
      public function reset() : void{}
      
      public function get isStopDispatching() : Boolean{return false;}
      
      public function set isStopDispatching(param1:Boolean) : void{}
   }
}
