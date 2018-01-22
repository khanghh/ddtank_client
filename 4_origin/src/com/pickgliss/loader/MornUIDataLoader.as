package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class MornUIDataLoader extends BaseLoader
   {
       
      
      private var _content;
      
      public function MornUIDataLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET")
      {
         if(param3 == null)
         {
            param3 = new URLVariables();
         }
         if(param3["rnd"] == null)
         {
            param3["rnd"] = TextLoader.TextLoaderKey;
         }
         super(param1,param2,param3,param4);
      }
      
      override protected function __onDataLoadComplete(param1:Event) : void
      {
         removeEvent();
         unload();
         var _loc2_:ByteArray = _loader.data;
         _loc2_.uncompress();
         _content = _loc2_.readObject();
         analysisMornUIData();
         fireCompleteEvent();
      }
      
      private function analysisMornUIData() : void
      {
         var _loc1_:Object = getDefinitionByName("morn.core.components.View");
         if(_loc1_)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _content;
            for(var _loc2_ in _content)
            {
               _loc1_.uiMap[_loc2_] = _content[_loc2_];
            }
         }
         else
         {
            trace("加载.ui文件异常，未导入morn.core.components.View包~~~~~~~~~" + url);
         }
      }
      
      override public function get content() : *
      {
         return _content;
      }
      
      override public function get type() : int
      {
         return 8;
      }
   }
}
