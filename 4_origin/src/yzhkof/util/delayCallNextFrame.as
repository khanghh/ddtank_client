package yzhkof.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public function delayCallNextFrame(param1:Function, param2:int = 1) : void
   {
      var dobj:Sprite = null;
      var fun_new:Function = null;
      var fun:Function = param1;
      var delay_frame:int = param2;
      dobj = new Sprite();
      fun_new = function(param1:Event):void
      {
         if(--delay_frame <= 0)
         {
            fun();
            dobj.removeEventListener(Event.ENTER_FRAME,fun_new);
         }
      };
      dobj.addEventListener(Event.ENTER_FRAME,fun_new);
   }
}
