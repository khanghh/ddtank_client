package org.aswing
{
   import flash.utils.Dictionary;
   
   public class KeyMap
   {
       
      
      private var map:Dictionary;
      
      public function KeyMap()
      {
         super();
         map = new Dictionary();
      }
      
      public static function getCodec(param1:KeyType) : String
      {
         return getCodecWithKeySequence(param1.getCodeSequence());
      }
      
      public static function getCodecWithKeySequence(param1:Array) : String
      {
         return param1.join("|");
      }
      
      public function registerKeyAction(param1:KeyType, param2:Function) : void
      {
         var _loc4_:String = getCodec(param1);
         var _loc3_:Array = map[_loc4_];
         if(_loc3_ == null)
         {
            _loc3_ = [];
         }
         _loc3_.push(new KeyAction(param1,param2));
         map[_loc4_] = _loc3_;
      }
      
      public function unregisterKeyAction(param1:KeyType, param2:Function) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:String = getCodec(param1);
         var _loc4_:Array = map[_loc5_];
         if(_loc4_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc6_];
               if(_loc3_.action == param2)
               {
                  _loc4_.splice(_loc6_,1);
                  _loc6_--;
               }
               _loc6_++;
            }
         }
      }
      
      public function getKeyAction(param1:KeyType) : Function
      {
         return getKeyActionWithCodec(getCodec(param1));
      }
      
      private function getKeyActionWithCodec(param1:String) : Function
      {
         var _loc2_:Array = map[param1];
         if(_loc2_ != null && _loc2_.length > 0)
         {
            return _loc2_[_loc2_.length - 1].action;
         }
         return null;
      }
      
      public function fireKeyAction(param1:Array) : Boolean
      {
         var _loc3_:String = getCodecWithKeySequence(param1);
         var _loc2_:Function = getKeyActionWithCodec(_loc3_);
         if(_loc2_ != null)
         {
            _loc2_();
            return true;
         }
         return false;
      }
      
      public function containsKey(param1:KeyType) : Boolean
      {
         return map[getCodec(param1)] != null;
      }
   }
}

import org.aswing.KeyType;

class KeyAction
{
    
   
   private var key:KeyType;
   
   private var action:Function;
   
   function KeyAction(param1:KeyType, param2:Function)
   {
      super();
      this.key = param1;
      this.action = param2;
   }
}
