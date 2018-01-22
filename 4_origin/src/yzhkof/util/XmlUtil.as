package yzhkof.util
{
   public class XmlUtil
   {
       
      
      public function XmlUtil()
      {
         super();
      }
      
      public static function deleteXmlList(param1:XMLList) : void
      {
         var _loc2_:int = param1.length();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            delete param1[0];
            _loc3_++;
         }
      }
      
      public static function sortOnXMLList(param1:XMLList, param2:Object, param3:Object = null) : XMLList
      {
         var _loc5_:XML = null;
         var _loc4_:Array = new Array();
         for each(_loc5_ in param1)
         {
            _loc4_.push(_loc5_);
         }
         if(param2)
         {
            _loc4_.sortOn(param2,param3);
         }
         else
         {
            _loc4_.sort();
         }
         var _loc6_:XMLList = new XMLList();
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = _loc6_ + _loc5_;
         }
         return _loc6_;
      }
      
      public static function enableSpecialCode(param1:String) : String
      {
         return param1.replace("\\n","\n");
      }
   }
}
