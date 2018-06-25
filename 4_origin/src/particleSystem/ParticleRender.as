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
      
      public function registerParticle(emitter:DisplayObjectContainer, particleId:Number, particleIdList:Array, emitterPoint:Point = null) : ParticleRenderInfo
      {
         if(!_renderList)
         {
            throw new Error("Please turnOn Render before registerParticle");
         }
         var _loc8_:int = 0;
         var _loc7_:* = _renderList;
         for each(var i in _renderList)
         {
            if(i.emitter == emitter)
            {
               if(emitterPoint)
               {
                  i.emitterPoint = emitterPoint;
               }
               i.addParticles(particleIdList);
               return i;
            }
         }
         var info:ParticleRenderInfo = new ParticleRenderInfo();
         info.id = particleId;
         info.emitter = emitter;
         if(emitterPoint)
         {
            i.emitterPoint = emitterPoint;
         }
         info.addParticles(particleIdList);
         _renderList.push(info);
         return info;
      }
      
      public function unRegisterParticle(emitter:DisplayObjectContainer) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var i in _renderList)
         {
            if(i.emitter == emitter)
            {
               i.stopParticles();
               _renderList.splice(_renderList.indexOf(i),1);
               break;
            }
         }
      }
      
      public function addWeather(layer:DisplayObjectContainer, particleId:*, particleIdList:Array) : void
      {
         var point:Point = new Point(720,-10);
         addParticleAtPoint(layer,point,particleId,particleIdList);
      }
      
      public function addParticleAtPoint(layer:DisplayObjectContainer, point:Point, particleId:Number, particleIdList:Array) : void
      {
         var info:ParticleRenderInfo = new ParticleRenderInfo();
         var emitter:Sprite = new Sprite();
         emitter.x = point.x;
         emitter.y = point.y;
         layer.addChild(emitter);
         info.id = particleId;
         info.emitter = emitter;
         info.isWeather = true;
         info.addParticles(particleIdList);
         _renderList.push(info);
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
         for each(var info in _renderList)
         {
            info.dispose();
            info = null;
         }
         _renderList = null;
      }
      
      private function __resizeStarling(evt:ResizeEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var info in _renderList)
         {
            if(info.isWeather)
            {
               info.emitter.x = Starling.current.root.stage.stageWidth >> 1;
            }
         }
      }
      
      private function __render(evt:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _renderList;
         for each(var info in _renderList)
         {
            if(info.emitter.parent)
            {
               info.update();
            }
         }
      }
   }
}
