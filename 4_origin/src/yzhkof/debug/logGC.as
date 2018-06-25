package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public function logGC(obj:*, tag:String = "", allChild:Boolean = false) : void
   {
      var i:int = 0;
      if(DebugSystem.isInited == false)
      {
         return;
      }
      if(allChild == false)
      {
         DebugSystem.weakLogViewer.addLog(obj,tag);
      }
      else if(obj is DisplayObjectContainer)
      {
         for(i = 0; i < DisplayObjectContainer(obj).numChildren; i++)
         {
            logGC(DisplayObjectContainer(obj).getChildAt(i),tag,true);
            DebugSystem.weakLogViewer.addLog(obj,tag);
         }
      }
      else if(obj is DisplayObject)
      {
         DebugSystem.weakLogViewer.addLog(obj,tag);
      }
   }
}
