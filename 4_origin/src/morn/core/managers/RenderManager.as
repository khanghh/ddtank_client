package morn.core.managers
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class RenderManager
   {
       
      
      private var _methods:Dictionary;
      
      public function RenderManager()
      {
         _methods = new Dictionary();
         super();
      }
      
      private function invalidate() : void
      {
         if(App.stage)
         {
            App.stage.addEventListener("enterFrame",onValidate);
            App.stage.addEventListener("render",onValidate);
            App.stage.invalidate();
         }
      }
      
      private function onValidate(e:Event) : void
      {
         App.stage.removeEventListener("render",onValidate);
         App.stage.removeEventListener("enterFrame",onValidate);
         renderAll();
         App.stage.dispatchEvent(new Event("renderCompleted"));
      }
      
      public function renderAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _methods;
         for(var method in _methods)
         {
            exeCallLater(method as Function);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _methods;
         for each(method in _methods)
         {
            return renderAll();
         }
      }
      
      public function callLater(method:Function, args:Array = null) : void
      {
         if(_methods[method] == null)
         {
            _methods[method] = args || [];
            invalidate();
         }
      }
      
      public function exeCallLater(method:Function) : void
      {
         var args:* = null;
         if(_methods[method] != null)
         {
            args = _methods[method];
            delete _methods[method];
            args.splice(0,1);
            method.apply(null,args);
         }
      }
      
      public function removeCallLaterByObj(obj:Object) : void
      {
         var args:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _methods;
         for(var method in _methods)
         {
            args = _methods[method];
            if(obj == args[0])
            {
               delete _methods[method];
            }
         }
      }
      
      public function removeCallLater(fun:Function) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _methods;
         for(var method in _methods)
         {
            if(method == fun)
            {
               delete _methods[method];
            }
         }
      }
   }
}
