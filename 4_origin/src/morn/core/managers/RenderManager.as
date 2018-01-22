package morn.core.managers
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import morn.core.events.UIEvent;
   
   public class RenderManager
   {
       
      
      private var _methods:Dictionary;
      
      public function RenderManager()
      {
         this._methods = new Dictionary();
         super();
      }
      
      private function invalidate() : void
      {
         if(App.stage)
         {
            App.stage.addEventListener(Event.ENTER_FRAME,this.onValidate);
            App.stage.addEventListener(Event.RENDER,this.onValidate);
            App.stage.invalidate();
         }
      }
      
      private function onValidate(param1:Event) : void
      {
         App.stage.removeEventListener(Event.RENDER,this.onValidate);
         App.stage.removeEventListener(Event.ENTER_FRAME,this.onValidate);
         this.renderAll();
         App.stage.dispatchEvent(new Event(UIEvent.RENDER_COMPLETED));
      }
      
      public function renderAll() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._methods)
         {
            this.exeCallLater(_loc1_ as Function);
         }
         for each(_loc1_ in this._methods)
         {
            return this.renderAll();
         }
      }
      
      public function callLater(param1:Function, param2:Array = null) : void
      {
         if(this._methods[param1] == null)
         {
            this._methods[param1] = param2 || [];
            this.invalidate();
         }
      }
      
      public function exeCallLater(param1:Function) : void
      {
         var _loc2_:Array = null;
         if(this._methods[param1] != null)
         {
            _loc2_ = this._methods[param1];
            delete this._methods[param1];
            _loc2_.splice(0,1);
            param1.apply(null,_loc2_);
         }
      }
      
      public function removeCallLaterByObj(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = null;
         for(_loc2_ in this._methods)
         {
            _loc3_ = this._methods[_loc2_];
            if(param1 == _loc3_[0])
            {
               delete this._methods[_loc2_];
            }
         }
      }
      
      public function removeCallLater(param1:Function) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this._methods)
         {
            if(_loc2_ == param1)
            {
               delete this._methods[_loc2_];
            }
         }
      }
   }
}
