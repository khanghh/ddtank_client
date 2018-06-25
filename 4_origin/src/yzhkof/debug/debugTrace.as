package yzhkof.debug
{
   public function debugTrace(... text) : void
   {
      var i:Object = null;
      if(DebugSystem.isInited == false)
      {
         return;
      }
      for each(i in text)
      {
         try
         {
            TextTrace.textPlus(i.toString() + " ");
            TextTrace.visible = true;
         }
         catch(e:Error)
         {
            continue;
         }
      }
      TextTrace.textPlus("\n");
      trace(text);
   }
}
