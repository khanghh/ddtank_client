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
      
      public function BaseMotionFunc(paramsObject:Object)
      {
         super();
         _lifetime = 0;
         _initial = new Point(0,0);
         if(paramsObject.initial)
         {
            _initial = paramsObject.initial;
         }
         _final = new Point(0,0);
         if(paramsObject.final)
         {
            _final = paramsObject.final;
         }
      }
      
      public function getVectorByTime(t:int) : Object
      {
         return null;
      }
      
      public function getResult() : Object
      {
         if(!_isPlaying)
         {
            return null;
         }
         return null;
      }
   }
}
