package com.pickgliss.loader
{
   import flash.net.URLVariables;
   
   public class CompressRequestLoader extends CompressTextLoader
   {
       
      
      public function CompressRequestLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super(id,url,args,requestMethod);
      }
      
      override public function get type() : int
      {
         return 7;
      }
   }
}
