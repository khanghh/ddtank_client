package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class MornUIDataLoader extends BaseLoader
   {
       
      
      private var _content;
      
      public function MornUIDataLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super(null,null,null,null);}
      
      override protected function __onDataLoadComplete(param1:Event) : void{}
      
      private function analysisMornUIData() : void{}
      
      override public function get content() : *{return null;}
      
      override public function get type() : int{return 0;}
   }
}
