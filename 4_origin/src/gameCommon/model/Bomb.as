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
      
      private function checkFly(param1:Array, param2:Array) : Boolean
      {
         if(int(param1[0]) != int(param2[0]))
         {
            return true;
         }
         return false;
      }
      
      public function get target() : Point
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < Actions.length)
         {
            if(Actions[_loc2_].type == 2)
            {
               return new Point(Actions[_loc2_].param1,Actions[_loc2_].param2);
            }
            if(Actions[_loc2_].type == 4)
            {
               return new Point(Actions[_loc2_].param1,Actions[_loc2_].param2);
            }
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < UsedActions.length)
         {
            if(UsedActions[_loc1_].type == 2)
            {
               return new Point(UsedActions[_loc1_].param1,UsedActions[_loc1_].param2);
            }
            if(UsedActions[_loc1_].type == 4)
            {
               return new Point(UsedActions[_loc1_].param1,UsedActions[_loc1_].param2);
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get isCritical() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Actions.length)
         {
            if(Actions[_loc1_].type == 17)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}
