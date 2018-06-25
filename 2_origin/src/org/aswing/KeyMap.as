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
      
      public static function getCodec(key:KeyType) : String
      {
         return getCodecWithKeySequence(key.getCodeSequence());
      }
      
      public static function getCodecWithKeySequence(keySequence:Array) : String
      {
         return keySequence.join("|");
      }
      
      public function registerKeyAction(key:KeyType, action:Function) : void
      {
         var codec:String = getCodec(key);
         var list:Array = map[codec];
         if(list == null)
         {
            list = [];
         }
         list.push(new KeyAction(key,action));
         map[codec] = list;
      }
      
      public function unregisterKeyAction(key:KeyType, action:Function) : void
      {
         var i:int = 0;
         var ka:* = null;
         var codec:String = getCodec(key);
         var list:Array = map[codec];
         if(list)
         {
            for(i = 0; i < list.length; )
            {
               ka = list[i];
               if(ka.action == action)
               {
                  list.splice(i,1);
                  i--;
               }
               i++;
            }
         }
      }
      
      public function getKeyAction(key:KeyType) : Function
      {
         return getKeyActionWithCodec(getCodec(key));
      }
      
      private function getKeyActionWithCodec(codec:String) : Function
      {
         var list:Array = map[codec];
         if(list != null && list.length > 0)
         {
            return list[list.length - 1].action;
         }
         return null;
      }
      
      public function fireKeyAction(keySequence:Array) : Boolean
      {
         var codec:String = getCodecWithKeySequence(keySequence);
         var action:Function = getKeyActionWithCodec(codec);
         if(action != null)
         {
            action();
            return true;
         }
         return false;
      }
      
      public function containsKey(key:KeyType) : Boolean
      {
         return map[getCodec(key)] != null;
      }
   }
}

import org.aswing.KeyType;

class KeyAction
{
    
   
   private var key:KeyType;
   
   private var action:Function;
   
   function KeyAction(key:KeyType, action:Function)
   {
      super();
      this.key = key;
      this.action = action;
   }
}
