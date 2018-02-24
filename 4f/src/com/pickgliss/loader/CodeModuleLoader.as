package com.pickgliss.loader
{
   import com.pickgliss.utils.ClassUtils;
   import flash.system.ApplicationDomain;
   import road7th.data.DictionaryData;
   
   public class CodeModuleLoader extends ModuleLoader
   {
      
      private static var LoadClassName:DictionaryData = new DictionaryData();
       
      
      public var className:String;
      
      public function CodeModuleLoader(param1:int, param2:String, param3:ApplicationDomain){super(null,null,null);}
      
      override protected function fireCompleteEvent() : void{}
      
      override public function get type() : int{return 0;}
   }
}
