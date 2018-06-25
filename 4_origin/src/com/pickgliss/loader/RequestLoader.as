package com.pickgliss.loader
{
   import flash.net.URLVariables;
   
   public class RequestLoader extends TextLoader
   {
       
      
      public function RequestLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super(id,url,args,requestMethod);
      }
      
      override public function get type() : int
      {
         return 6;
      }
   }
}
