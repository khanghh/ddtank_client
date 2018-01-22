package cmodule.decry
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_delegate;
   
   public dynamic class DynamicProxy extends Proxy
   {
       
      
      flash_delegate var nextValue:Function;
      
      flash_delegate var getProperty:Function;
      
      flash_delegate var isAttribute:Function;
      
      flash_delegate var nextNameIndex:Function;
      
      flash_delegate var hasProperty:Function;
      
      flash_delegate var callProperty:Function;
      
      flash_delegate var nextName:Function;
      
      flash_delegate var getDescendants:Function;
      
      flash_delegate var deleteProperty:Function;
      
      flash_delegate var setProperty:Function;
      
      public function DynamicProxy(){super();}
      
      override flash_proxy function hasProperty(param1:*) : Boolean{return false;}
      
      override flash_proxy function callProperty(param1:*, ... rest) : *{return null;}
      
      override flash_proxy function setProperty(param1:*, param2:*) : void{}
      
      override flash_proxy function isAttribute(param1:*) : Boolean{return false;}
      
      override flash_proxy function getProperty(param1:*) : *{return null;}
      
      override flash_proxy function nextNameIndex(param1:int) : int{return 0;}
      
      override flash_proxy function deleteProperty(param1:*) : Boolean{return false;}
      
      override flash_proxy function nextName(param1:int) : String{return null;}
      
      override flash_proxy function getDescendants(param1:*) : *{return null;}
      
      override flash_proxy function nextValue(param1:int) : *{return null;}
   }
}
