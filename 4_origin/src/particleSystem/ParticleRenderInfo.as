package particleSystem
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import particleSystem.events.ParticleEvent;
   import particleSystem.loader.ParticleZipLoader;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class ParticleRenderInfo implements Disposeable
   {
       
      
      public var emitter:DisplayObjectContainer;
      
      public var particleList:Vector.<PDParticleSystemWithID>;
      
      public var isEmitting:Boolean;
      
      public var isWeather:Boolean;
      
      private var _propertiesDic:Dictionary;
      
      private var _idList:Array;
      
      private var _emitterPoint:Point;
      
      public var id:Number = 0;
      
      public var name:String = "";
      
      private var _addAngle:Number = 0;
      
      public function ParticleRenderInfo()
      {
         super();
         _idList = [];
         _propertiesDic = new Dictionary();
         _emitterPoint = new Point(0,0);
         particleList = new Vector.<PDParticleSystemWithID>();
      }
      
      private function __particleLoaded(evt:ParticleEvent) : void
      {
         var i:* = 0;
         var currentEmitter:* = null;
         var tempIdList:* = null;
         var j:* = 0;
         var h:* = 0;
         var obj:* = null;
         evt.currentTarget.removeEventListener("particle_loaded",__particleLoaded);
         if(_idList == null)
         {
            return;
         }
         if(_idList.length > 0)
         {
            for(i = uint(0); i < _idList.length; )
            {
               if(_idList[i] == evt.ID)
               {
                  particleList.push(ParticleManager.Instance.getParticle(evt.ID));
                  _idList.splice(i,1);
                  break;
               }
               i++;
            }
            currentEmitter = ParticleManager.Instance.emitters[this.id];
            tempIdList = currentEmitter.particleIds;
            if(tempIdList.length == particleList.length)
            {
               for(j = uint(0); j < tempIdList.length; )
               {
                  for(h = uint(0); h < particleList.length; )
                  {
                     if(particleList[h].ID == tempIdList[j] && h != j)
                     {
                        obj = particleList[j];
                        particleList[j] = particleList[h];
                        particleList[h] = obj;
                        break;
                     }
                     h++;
                  }
                  j++;
               }
            }
         }
         updateProperties();
      }
      
      private function updateProperties() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = particleList;
         for each(var particle in particleList)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _propertiesDic;
            for(var name in _propertiesDic)
            {
               if(particle.hasOwnProperty(name))
               {
                  particle[name] = _propertiesDic[name];
               }
            }
         }
      }
      
      public function set emitterPoint(p:Point) : void
      {
         _emitterPoint = p;
      }
      
      public function addParticles(arr:Array) : void
      {
         var i:* = 0;
         var zipLoader:* = null;
         _idList = _idList.concat(arr);
         for(i = uint(0); i < arr.length; )
         {
            zipLoader = ParticleManager.Instance.createParticleLoader(arr[i]);
            zipLoader.addEventListener("particle_loaded",__particleLoaded);
            zipLoader.loadZip();
            i++;
         }
      }
      
      public function removeParticleById(id:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = particleList;
         for each(var particle in particleList)
         {
            if(particle.ID == id)
            {
               particle.stop();
               particleList.splice(particleList.indexOf(particle),1);
               particle = null;
               break;
            }
         }
      }
      
      public function stopParticles() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = particleList;
         for each(var particle in particleList)
         {
            particle.addEventListener("complete",__particleComplete);
            particle.stop();
         }
      }
      
      private function __particleComplete(evt:Event) : void
      {
         var particle:PDParticleSystemWithID = evt.target as PDParticleSystemWithID;
         particle.removeEventListener("complete",__particleComplete);
         Starling.juggler.remove(particle);
         var _loc5_:int = 0;
         var _loc4_:* = particleList;
         for each(var i in particleList)
         {
            if(i.numParticles > 0)
            {
               return;
            }
         }
         dispose();
      }
      
      public function update(duration:Number = 1.7976931348623157E308) : void
      {
         var rotationStart:Number = NaN;
         var rotationEnd:Number = NaN;
         var point:* = null;
         var angleNum:Number = NaN;
         var angle:Number = NaN;
         if(!isEmitting)
         {
            start(duration);
         }
         var _loc9_:int = 0;
         var _loc8_:* = particleList;
         for each(var particle in particleList)
         {
            rotationStart = particle.mconfig.rotationStart.@value;
            rotationEnd = particle.mconfig.rotationEnd.@value;
            if(rotationStart == 0 && rotationEnd == 0)
            {
               point = new Point(emitter.x - particle.emitterX,emitter.y - particle.emitterY);
               if(particle.emitterX != 0 && particle.emitterY != 0 && point.x != 0 && point.y != 0)
               {
                  point.normalize(1);
                  angleNum = Math.atan2(point.y,point.x) + _addAngle;
                  angle = angleNum / 3.14159265358979 * 180;
                  particle.startRotation = angleNum;
                  particle.endRotation = angleNum;
               }
            }
            particle.emitterX = emitter.x + _emitterPoint.x;
            particle.emitterY = emitter.y + _emitterPoint.y;
         }
      }
      
      public function set addAngle(value:Number) : void
      {
         _addAngle = value;
      }
      
      public function start(duration:Number = 1.7976931348623157E308) : void
      {
         if(isEmitting || particleList.length == 0 || !emitter.parent)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = particleList;
         for each(var particle in particleList)
         {
            emitter.parent.addChildAt(particle,emitter.parent.getChildIndex(emitter));
            particle.start(duration);
            Starling.juggler.add(particle);
         }
         isEmitting = true;
      }
      
      public function stop() : void
      {
         if(!isEmitting)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = particleList;
         for each(var particle in particleList)
         {
            particle.stop();
            Starling.juggler.remove(particle);
         }
         isEmitting = false;
      }
      
      public function reset() : void
      {
         stop();
         _idList = [];
         _propertiesDic = new Dictionary();
         _emitterPoint = new Point(0,0);
         particleList = new Vector.<PDParticleSystemWithID>();
      }
      
      public function dispose() : void
      {
         ParticleRender.Instance.unRegisterParticle(emitter);
         emitter = null;
         var _loc3_:int = 0;
         var _loc2_:* = particleList;
         for each(var i in particleList)
         {
            i.removeEventListener("complete",__particleComplete);
            if(i.parent)
            {
               i.parent.removeChild(i);
            }
            if(Starling.juggler.contains(i))
            {
               Starling.juggler.remove(i);
            }
            i.dispose();
            i = null;
         }
         _idList = null;
         particleList = null;
         _propertiesDic = null;
         _emitterPoint = null;
      }
      
      public function setPropertiesDic(name:String, value:int) : void
      {
         _propertiesDic[name] = value;
         updateProperties();
      }
   }
}
