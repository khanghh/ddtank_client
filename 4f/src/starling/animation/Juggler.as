package starling.animation
{
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class Juggler implements IAnimatable
   {
       
      
      private var mObjects:Vector.<IAnimatable>;
      
      private var mElapsedTime:Number;
      
      public function Juggler(){super();}
      
      public function add(param1:IAnimatable) : void{}
      
      public function contains(param1:IAnimatable) : Boolean{return false;}
      
      public function remove(param1:IAnimatable) : void{}
      
      public function removeTweens(param1:Object) : void{}
      
      public function containsTweens(param1:Object) : Boolean{return false;}
      
      public function purge() : void{}
      
      public function delayCall(param1:Function, param2:Number, ... rest) : IAnimatable{return null;}
      
      public function repeatCall(param1:Function, param2:Number, param3:int = 0, ... rest) : IAnimatable{return null;}
      
      private function onPooledDelayedCallComplete(param1:Event) : void{}
      
      public function tween(param1:Object, param2:Number, param3:Object) : IAnimatable{return null;}
      
      private function onPooledTweenComplete(param1:Event) : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      private function onRemove(param1:Event) : void{}
      
      public function get elapsedTime() : Number{return 0;}
      
      protected function get objects() : Vector.<IAnimatable>{return null;}
   }
}
