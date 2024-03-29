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
      
      public function Bomb(){super();}
      
      private function checkFly(param1:Array, param2:Array) : Boolean{return false;}
      
      public function get target() : Point{return null;}
      
      public function get isCritical() : Boolean{return false;}
   }
}
