package ddt.manager
{
   import ddt.interfaces.IProcessObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class ProcessManager
   {
      
      private static var _ins:ProcessManager;
       
      
      private var _objects:Vector.<IProcessObject>;
      
      private var _startup:Boolean = false;
      
      private var _shape:Shape;
      
      private var _elapsed:int;
      
      private var _virtualTime:int;
      
      public function ProcessManager()
      {
         _objects = new Vector.<IProcessObject>();
         _shape = new Shape();
         super();
      }
      
      public static function get Instance() : ProcessManager
      {
         return _ins || new ProcessManager();
      }
      
      public function addObject(param1:IProcessObject) : IProcessObject
      {
         if(!param1.onProcess)
         {
            param1.onProcess = true;
            _objects.push(param1);
            startup();
         }
         return param1;
      }
      
      public function removeObject(param1:IProcessObject) : IProcessObject
      {
         var _loc2_:int = 0;
         if(param1.onProcess)
         {
            param1.onProcess = false;
            _loc2_ = _objects.indexOf(param1);
            if(_loc2_ >= 0)
            {
               _objects.splice(_loc2_,1);
            }
         }
         return param1;
      }
      
      public function startup() : void
      {
         if(!_startup)
         {
            _elapsed = getTimer();
            _shape.addEventListener("enterFrame",__enterFrame);
            _startup = true;
         }
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc3_:int = getTimer();
         var _loc2_:Number = _loc3_ - _elapsed;
         var _loc6_:int = 0;
         var _loc5_:* = _objects;
         for each(var _loc4_ in _objects)
         {
            _loc4_.process(_loc2_);
         }
         _elapsed = _loc3_;
      }
      
      public function shutdown() : void
      {
         _shape.removeEventListener("enterFrame",__enterFrame);
         _startup = false;
      }
      
      public function get running() : Boolean
      {
         return _startup;
      }
   }
}
