package mx.utils
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   [ExcludeClass]
   public dynamic class DescribeTypeCacheRecord extends Proxy
   {
       
      
      private var cache:Object;
      
      public var typeDescription:XML;
      
      public var typeName:String;
      
      public function DescribeTypeCacheRecord(){super();}
      
      override flash_proxy function getProperty(param1:*) : *{return null;}
      
      override flash_proxy function hasProperty(param1:*) : Boolean{return false;}
   }
}
