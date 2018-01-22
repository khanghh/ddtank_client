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
      
      public function ParticleRender()
      {
         super();
         Starling.current.stage.addEventListener("resize",__resizeStarling);
      }
      
      public static function get Instance() : ParticleRender
      {
         if(_instance == null)
         {
            _instance = new ParticleRender();
            return new ParticleRender();
         }
         return _instance;
      }
      
      public function registerParticle(param1:DisplayObjectContainer, param2:Number, param3:Array, param4:Point = null) : ParticleRenderInfo
      {
         if(!_renderList)
         {
            throw new Error("Please turnOn Render before registerParticle");
         }
         var _loc8_:int = 0;
         var _loc7_:* = _renderList;
         for each(var _loc6_ in _renderList)
         {
            if(_loc6_.emitter == param1)
            {
               if(param4)
               {
                  _loc6_.emitterPoint = param4;
               }
               _loc6_.addParticles(param3);
               return _loc6_;
            }
         }
         var _loc5_:ParticleRenderInfo = new ParticleRenderInfo();
         _loc5_.id = param2;
         _loc5_.emitter = param1;
         if(param4)
         {
            _loc6_.emitterPoint = param4;
         }
         _loc5_.addParticles(param3);
         _renderList.push(_loc5_);
         return _loc5_;
      }
      
      public function unRegisterParticle(param1:DisplayObjectContainer) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var _loc2_ in _renderList)
         {
            if(_loc2_.emitter == param1)
            {
               _loc2_.stopParticles();
               _renderList.splice(_renderList.indexOf(_loc2_),1);
               break;
            }
         }
      }
      
      public function addWeather(param1:DisplayObjectContainer, param2:*, param3:Array) : void
      {
         var _loc4_:Point = new Point(720,-10);
         addParticleAtPoint(param1,_loc4_,param2,param3);
      }
      
      public function addParticleAtPoint(param1:DisplayObjectContainer, param2:Point, param3:Number, param4:Array) : void
      {
         var _loc6_:ParticleRenderInfo = new ParticleRenderInfo();
         var _loc5_:Sprite = new Sprite();
         _loc5_.x = param2.x;
         _loc5_.y = param2.y;
         param1.addChild(_loc5_);
         _loc6_.id = param3;
         _loc6_.emitter = _loc5_;
         _loc6_.isWeather = true;
         _loc6_.addParticles(param4);
         _renderList.push(_loc6_);
      }
      
      public function turnOn() : void
      {
         _renderList = new Vector.<ParticleRenderInfo>();
         Starling.current.root.addEventListener("enterFrame",__render);
      }
      
      public function turnOff() : void
      {
         Starling.current.root.removeEventListener("enterFrame",__render);
         var _loc3_:int = 0;
         var _loc2_:* = _renderList;
         for each(var _loc1_ in _renderList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _renderList = null;
      }
      
      private function __resizeStarling(param1:ResizeEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var _loc2_ in _renderList)
         {
            if(_loc2_.isWeather)
            {
               _loc2_.emitter.x = Starling.current.root.stage.stageWidth >> 1;
            }
         }
      }
      
      private function __render(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var _loc2_ in _renderList)
         {
            if(_loc2_.emitter.parent)
            {
               _loc2_.update();
            }
         }
      }
   }
}
