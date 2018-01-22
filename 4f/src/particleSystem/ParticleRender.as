package particleSystem
{
   import flash.geom.Point;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.ResizeEvent;
   
   public class ParticleRender
   {
      
      private static var _instance:ParticleRender;
       
      
      private var _renderList:Vector.<ParticleRenderInfo>;
      
      public function ParticleRender(){super();}
      
      public static function get Instance() : ParticleRender{return null;}
      
      public function registerParticle(param1:DisplayObjectContainer, param2:Number, param3:Array, param4:Point = null) : ParticleRenderInfo{return null;}
      
      public function unRegisterParticle(param1:DisplayObjectContainer) : void{}
      
      public function addWeather(param1:DisplayObjectContainer, param2:*, param3:Array) : void{}
      
      public function addParticleAtPoint(param1:DisplayObjectContainer, param2:Point, param3:Number, param4:Array) : void{}
      
      public function turnOn() : void{}
      
      public function turnOff() : void{}
      
      private function __resizeStarling(param1:ResizeEvent) : void{}
      
      private function __render(param1:Event) : void{}
   }
}
