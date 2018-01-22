package ddt.view.scenePathSearcher
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SceneMTween extends EventDispatcher
   {
      
      public static const FINISH:String = "finish";
      
      public static const CHANGE:String = "change";
      
      public static const START:String = "start";
      
      public static const STOP:String = "stop";
       
      
      private var _obj:Object;
      
      private var _prop:String;
      
      private var _prop2:String;
      
      private var _isPlaying:Boolean;
      
      private var _finish:Number;
      
      private var _finish2:Number;
      
      private var vectors:Number;
      
      private var vectors2:Number;
      
      private var currentCount:Number;
      
      private var repeatCount:Number;
      
      private var _time:Number;
      
      public function SceneMTween(param1:Object)
      {
         super();
         this._obj = param1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:* = _prop;
         var _loc3_:* = _obj[_loc2_] + vectors / repeatCount;
         _obj[_loc2_] = _loc3_;
         if(_prop2)
         {
            _loc3_ = _prop2;
            _loc2_ = _obj[_loc3_] + vectors2 / repeatCount;
            _obj[_loc3_] = _loc2_;
         }
         currentCount = Number(currentCount) + 1;
         if(currentCount >= repeatCount)
         {
            stop();
            _obj[_prop] = _finish;
            if(_prop2)
            {
               _obj[_prop2] = _finish2;
            }
            dispatchEvent(new Event("finish"));
         }
         dispatchEvent(new Event("change"));
      }
      
      public function start(param1:Number, param2:String, param3:Number, param4:String = null, param5:Number = 0) : void
      {
         if(_isPlaying)
         {
            stop();
         }
         _time = param1;
         _prop = param2;
         _finish = param3;
         _finish2 = param5;
         _prop2 = param4;
         currentCount = 0;
         vectors = _finish - _obj[_prop];
         if(_prop2)
         {
            vectors2 = _finish2 - _obj[_prop2];
         }
         else
         {
            _finish2 = 0;
         }
         startGo();
      }
      
      public function startGo() : void
      {
         if(_isPlaying)
         {
            stop();
         }
         repeatCount = _time / 1000 * 25;
         _obj.removeEventListener("enterFrame",onEnterFrame);
         _obj.addEventListener("enterFrame",onEnterFrame);
         _isPlaying = true;
         dispatchEvent(new Event("start"));
      }
      
      public function stop() : void
      {
         _obj.removeEventListener("enterFrame",onEnterFrame);
         _isPlaying = false;
         dispatchEvent(new Event("stop"));
      }
      
      public function dispose() : void
      {
         stop();
         _obj = null;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set time(param1:Number) : void
      {
         _time = param1;
      }
   }
}
