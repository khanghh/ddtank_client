package com.pickgliss.loader
{
   import flash.net.URLVariables;
   
   public class RequestLoader extends TextLoader
   {
       
      
      public function RequestLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super(null,null,null,null);}
      
      override public function get type() : int{return 0;}
   }
}
