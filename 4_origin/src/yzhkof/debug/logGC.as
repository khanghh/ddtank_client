package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public function logGC(param1:*, param2:String = "", param3:Boolean = false) : void
   {
      var _loc4_:int = 0;
      if(DebugSystem.isInited == false)
      {
         return;
      }
      if(param3 == false)
      {
         DebugSystem.weakLogViewer.addLog(param1,param2);
      }
      else if(param1 is DisplayObjectContainer)
      {
         _loc4_ = 0;
         while(_loc4_ < DisplayObjectContainer(param1).numChildren)
         {
            logGC(DisplayObjectContainer(param1).getChildAt(_loc4_),param2,true);
            DebugSystem.weakLogViewer.addLog(param1,param2);
            _loc4_++;
         }
      }
      else if(param1 is DisplayObject)
      {
         DebugSystem.weakLogViewer.addLog(param1,param2);
      }
   }
}
