package yzhkof.util
{
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class DebugUtil
   {
       
      
      public function DebugUtil()
      {
         super();
      }
      
      public static function analyseInstance(param1:Object) : String
      {
         var _loc2_:String = "*********************************\n";
         if(param1 == null)
         {
            _loc2_ = _loc2_ + "null\n";
         }
         else
         {
            _loc2_ = _loc2_ + analyseMenbers(param1);
         }
         _loc2_ = _loc2_ + "**********************************\n";
         return _loc2_;
      }
      
      private static function analyseMenbers(param1:Object) : String
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc2_:String = "";
         if(param1 is EventDispatcher)
         {
            _loc3_ = param1[QNameUtil.getObjectQname(param1,QNameUtil.LISTENERS)];
            _loc4_ = !!_loc3_?int(_loc3_.length):0;
            _loc2_ = _loc2_ + ("监听器数 ： " + _loc4_ + "\n");
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_[_loc5_];
               if(_loc6_ is Function)
               {
                  _loc2_ = _loc2_ + ("\t" + _loc5_ + " ： 监听器this指向[" + _loc6_[QNameUtil.getObjectQname(_loc6_,QNameUtil.SAVEDTHIS)] + "]\n");
               }
               else
               {
                  _loc2_ = _loc2_ + ("\t" + _loc5_ + " ： 监听器为 " + getQualifiedClassName(_loc6_) + "\n");
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
   }
}
