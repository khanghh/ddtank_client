package org.aswing
{
   import flash.utils.Dictionary;
   
   public class KeyMap
   {
       
      
      private var map:Dictionary;
      
      public function KeyMap(){super();}
      
      public static function getCodec(param1:KeyType) : String{return null;}
      
      public static function getCodecWithKeySequence(param1:Array) : String{return null;}
      
      public function registerKeyAction(param1:KeyType, param2:Function) : void{}
      
      public function unregisterKeyAction(param1:KeyType, param2:Function) : void{}
      
      public function getKeyAction(param1:KeyType) : Function{return null;}
      
      private function getKeyActionWithCodec(param1:String) : Function{return null;}
      
      public function fireKeyAction(param1:Array) : Boolean{return false;}
      
      public function containsKey(param1:KeyType) : Boolean{return false;}
   }
}

import org.aswing.KeyType;

class KeyAction
{
    
   
   private var key:KeyType;
   
   private var action:Function;
   
   function KeyAction(param1:KeyType, param2:Function){super();}
}
