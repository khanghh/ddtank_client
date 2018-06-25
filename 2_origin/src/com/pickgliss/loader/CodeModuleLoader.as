package com.pickgliss.loader
{
   import com.pickgliss.utils.ClassUtils;
   import flash.system.ApplicationDomain;
   import road7th.data.DictionaryData;
   
   public class CodeModuleLoader extends ModuleLoader
   {
      
      private static var LoadClassName:DictionaryData = new DictionaryData();
       
      
      public var className:String;
      
      public function CodeModuleLoader(id:int, url:String, domain:ApplicationDomain)
      {
         super(id,url,domain);
      }
      
      override protected function fireCompleteEvent() : void
      {
         var code:* = undefined;
         if(!LoadClassName.hasKey(className))
         {
            code = ClassUtils.CreatInstance(className);
            if(code)
            {
               CodeLoader.addLoadURL("4.png");
               code["setup"]();
               LoadClassName.add(className,true);
            }
            else
            {
               throw new Error("CodeModuleLoader :: 代码加载出错!!!!立刻检查!!" + _url);
            }
         }
         super.fireCompleteEvent();
      }
      
      override public function get type() : int
      {
         return 9;
      }
   }
}
