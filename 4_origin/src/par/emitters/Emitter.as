package par.emitters
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import par.enginees.ParticleEnginee;
   import par.particals.Particle;
   import par.particals.ParticleInfo;
   import road7th.math.randRange;
   
   [Event(name="complete",type="flash.events.Event")]
   public class Emitter extends EventDispatcher
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      private var _info:EmitterInfo;
      
      private var _enginee:ParticleEnginee;
      
      private var _interval:Number = 0;
      
      private var _age:Number = 0;
      
      public var angle:Number = 0;
      
      public var autoRestart:Boolean = false;
      
      public function Emitter()
      {
         super();
         _interval = 0;
      }
      
      public function setEnginee(param1:ParticleEnginee) : void
      {
         _enginee = param1;
      }
      
      public function restart() : void
      {
         _age = 0;
      }
      
      public function get info() : EmitterInfo
      {
         return _info;
      }
      
      public function set info(param1:EmitterInfo) : void
      {
         _info = param1;
         _interval = _info.interval;
      }
      
      public function execute(param1:Number) : void
      {
         if(_enginee && info)
         {
            _age = _age + param1;
            if(info.life <= 0 || _age < info.life)
            {
               _interval = _interval + param1;
               if(_interval > info.interval)
               {
                  _interval = 0;
                  emit();
               }
            }
            else if(autoRestart)
            {
               restart();
            }
            else
            {
               dispose();
            }
         }
      }
      
      public function dispose() : void
      {
         _enginee.removeEmitter(this);
         dispatchEvent(new Event("complete"));
      }
      
      protected function emit() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = info.particales;
         for each(var _loc3_ in info.particales)
         {
            if(_loc3_.beginTime < _age && _loc3_.endTime > _age)
            {
               _loc1_ = _loc3_.countOrient + int(randRange(0,_loc3_.countSize));
               _loc4_ = 0;
               while(_loc4_ < _loc1_)
               {
                  _loc2_ = _enginee.createParticle(_loc3_);
                  _loc2_.life = _loc3_.lifeOrient + randRange(0,_loc3_.lifeSize);
                  _loc2_.size = _loc3_.sizeOrient + randRange(0,_loc3_.sizeSize);
                  _loc2_.v = _loc3_.vOrient + randRange(0,_loc3_.vSize);
                  _loc2_.angle = angle + randRange(info.beginAngle,info.endAngle);
                  _loc2_.motionV = _loc3_.motionVOrient + randRange(0,_loc3_.motionVOrient);
                  _loc2_.weight = _loc3_.weightOrient + randRange(0,_loc3_.weightSize);
                  _loc2_.spin = _loc3_.spinOrient + randRange(0,_loc3_.spinSize);
                  _loc2_.rotation = _loc3_.rotation + angle;
                  _loc2_.x = x;
                  _loc2_.y = y;
                  _loc2_.color = _loc3_.colorOrient;
                  _loc2_.alpha = _loc3_.alphaOrient;
                  _enginee.addParticle(_loc2_);
                  _loc4_++;
               }
               continue;
            }
         }
      }
   }
}
