package gameCommon.motions
{
   import flash.geom.Point;
   
   public class BaseMotionFunc implements IMotionFunction
   {
       
      
      protected var _initial:Point;
      
      protected var _final:Point;
      
      protected var _result:Object;
      
      protected var _lifetime:int;
      
      protected var _isPlaying:Boolean;
      
      public function BaseMotionFunc(param1:Object){super();}
      
      public function getVectorByTime(param1:int) : Object{return null;}
      
      public function getResult() : Object{return null;}
   }
}
