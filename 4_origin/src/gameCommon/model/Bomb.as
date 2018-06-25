package gameCommon.model
{
   import ddt.data.BallInfo;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class Bomb extends EventDispatcher
   {
      
      public static const FLY_BOMB:int = 3;
      
      public static const FREEZE_BOMB:int = 1;
       
      
      public var Id:int;
      
      public var X:int;
      
      public var Y:int;
      
      public var VX:int;
      
      public var VY:int;
      
      public var Actions:Array;
      
      public var UsedActions:Array;
      
      public var Template:BallInfo;
      
      public var targetX:Number;
      
      public var targetY:Number;
      
      public var damageMod:Number;
      
      public var changedPartical:String;
      
      private var i:int = 0;
      
      public var number:int;
      
      public var shootCount:int;
      
      public var IsHole:Boolean;
      
      public var pid:int;
      
      public var childs:Array;
      
      public function Bomb()
      {
         Actions = [];
         UsedActions = [];
         childs = [];
         super();
      }
      
      private function checkFly(arr1:Array, arr2:Array) : Boolean
      {
         if(int(arr1[0]) != int(arr2[0]))
         {
            return true;
         }
         return false;
      }
      
      public function get target() : Point
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < Actions.length; )
         {
            if(Actions[i].type == 2)
            {
               return new Point(Actions[i].param1,Actions[i].param2);
            }
            if(Actions[i].type == 4)
            {
               return new Point(Actions[i].param1,Actions[i].param2);
            }
            i++;
         }
         for(j = 0; j < UsedActions.length; )
         {
            if(UsedActions[j].type == 2)
            {
               return new Point(UsedActions[j].param1,UsedActions[j].param2);
            }
            if(UsedActions[j].type == 4)
            {
               return new Point(UsedActions[j].param1,UsedActions[j].param2);
            }
            j++;
         }
         return null;
      }
      
      public function get isCritical() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < Actions.length; )
         {
            if(Actions[i].type == 17)
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }
}
