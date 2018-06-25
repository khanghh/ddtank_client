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
      
      public function addObject(object:IProcessObject) : IProcessObject
      {
         if(!object.onProcess)
         {
            object.onProcess = true;
            _objects.push(object);
            startup();
         }
         return object;
      }
      
      public function removeObject(object:IProcessObject) : IProcessObject
      {
         var idx:int = 0;
         if(object.onProcess)
         {
            object.onProcess = false;
            idx = _objects.indexOf(object);
            if(idx >= 0)
            {
               _objects.splice(idx,1);
            }
         }
         return object;
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
      
      private function __enterFrame(event:Event) : void
      {
         var now:int = getTimer();
         var rate:Number = now - _elapsed;
         var _loc6_:int = 0;
         var _loc5_:* = _objects;
         for each(var object in _objects)
         {
            object.process(rate);
         }
         _elapsed = now;
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
