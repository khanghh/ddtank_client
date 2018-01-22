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
      
      private function __particleLoaded(param1:ParticleEvent) : void
      {
         var _loc7_:* = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc3_:* = null;
         param1.currentTarget.removeEventListener("particle_loaded",__particleLoaded);
         if(_idList == null)
         {
            return;
         }
         if(_idList.length > 0)
         {
            _loc7_ = uint(0);
            while(_loc7_ < _idList.length)
            {
               if(_idList[_loc7_] == param1.ID)
               {
                  particleList.push(ParticleManager.Instance.getParticle(param1.ID));
                  _idList.splice(_loc7_,1);
                  break;
               }
               _loc7_++;
            }
            _loc2_ = ParticleManager.Instance.emitters[this.id];
            _loc4_ = _loc2_.particleIds;
            if(_loc4_.length == particleList.length)
            {
               _loc5_ = uint(0);
               while(_loc5_ < _loc4_.length)
               {
                  _loc6_ = uint(0);
                  while(_loc6_ < particleList.length)
                  {
                     if(particleList[_loc6_].ID == _loc4_[_loc5_] && _loc6_ != _loc5_)
                     {
                        _loc3_ = particleList[_loc5_];
                        particleList[_loc5_] = particleList[_loc6_];
                        particleList[_loc6_] = _loc3_;
                        break;
                     }
                     _loc6_++;
                  }
                  _loc5_++;
               }
            }
         }
         updateProperties();
      }
      
      private function updateProperties() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = particleList;
         for each(var _loc1_ in particleList)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _propertiesDic;
            for(var _loc2_ in _propertiesDic)
            {
               if(_loc1_.hasOwnProperty(_loc2_))
               {
                  _loc1_[_loc2_] = _propertiesDic[_loc2_];
               }
            }
         }
      }
      
      public function set emitterPoint(param1:Point) : void
      {
         _emitterPoint = param1;
      }
      
      public function addParticles(param1:Array) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _idList = _idList.concat(param1);
         _loc3_ = uint(0);
         while(_loc3_ < param1.length)
         {
            _loc2_ = ParticleManager.Instance.createParticleLoader(param1[_loc3_]);
            _loc2_.addEventListener("particle_loaded",__particleLoaded);
            _loc2_.loadZip();
            _loc3_++;
         }
      }
      
      public function removeParticleById(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = particleList;
         for each(var _loc2_ in particleList)
         {
            if(_loc2_.ID == param1)
            {
               _loc2_.stop();
               particleList.splice(particleList.indexOf(_loc2_),1);
               _loc2_ = null;
               break;
            }
         }
      }
      
      public function stopParticles() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = particleList;
         for each(var _loc1_ in particleList)
         {
            _loc1_.addEventListener("complete",__particleComplete);
            _loc1_.stop();
         }
      }
      
      private function __particleComplete(param1:Event) : void
      {
         var _loc2_:PDParticleSystemWithID = param1.target as PDParticleSystemWithID;
         _loc2_.removeEventListener("complete",__particleComplete);
         Starling.juggler.remove(_loc2_);
         var _loc5_:int = 0;
         var _loc4_:* = particleList;
         for each(var _loc3_ in particleList)
         {
            if(_loc3_.numParticles > 0)
            {
               return;
            }
         }
         dispose();
      }
      
      public function update(param1:Number = 1.7976931348623157E308) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         if(!isEmitting)
         {
            start(param1);
         }
         var _loc9_:int = 0;
         var _loc8_:* = particleList;
         for each(var _loc3_ in particleList)
         {
            _loc4_ = _loc3_.mconfig.rotationStart.@value;
            _loc6_ = _loc3_.mconfig.rotationEnd.@value;
            if(_loc4_ == 0 && _loc6_ == 0)
            {
               _loc2_ = new Point(emitter.x - _loc3_.emitterX,emitter.y - _loc3_.emitterY);
               if(_loc3_.emitterX != 0 && _loc3_.emitterY != 0 && _loc2_.x != 0 && _loc2_.y != 0)
               {
                  _loc2_.normalize(1);
                  _loc5_ = Math.atan2(_loc2_.y,_loc2_.x) + _addAngle;
                  _loc7_ = _loc5_ / 3.14159265358979 * 180;
                  _loc3_.startRotation = _loc5_;
                  _loc3_.endRotation = _loc5_;
               }
            }
            _loc3_.emitterX = emitter.x + _emitterPoint.x;
            _loc3_.emitterY = emitter.y + _emitterPoint.y;
         }
      }
      
      public function set addAngle(param1:Number) : void
      {
         _addAngle = param1;
      }
      
      public function start(param1:Number = 1.7976931348623157E308) : void
      {
         if(isEmitting || particleList.length == 0 || !emitter.parent)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = particleList;
         for each(var _loc2_ in particleList)
         {
            emitter.parent.addChildAt(_loc2_,emitter.parent.getChildIndex(emitter));
            _loc2_.start(param1);
            Starling.juggler.add(_loc2_);
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
         for each(var _loc1_ in particleList)
         {
            _loc1_.stop();
            Starling.juggler.remove(_loc1_);
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
         for each(var _loc1_ in particleList)
         {
            _loc1_.removeEventListener("complete",__particleComplete);
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            if(Starling.juggler.contains(_loc1_))
            {
               Starling.juggler.remove(_loc1_);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         _idList = null;
         particleList = null;
         _propertiesDic = null;
         _emitterPoint = null;
      }
      
      public function setPropertiesDic(param1:String, param2:int) : void
      {
         _propertiesDic[param1] = param2;
         updateProperties();
      }
   }
}
