package ddt.manager
{
   import com.pickgliss.utils.StringUtils;
   import flash.utils.Dictionary;
   
   public class LanguageMgr
   {
      
      private static var _dic:Dictionary;
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function LanguageMgr()
      {
         super();
      }
      
      public static function setup(param1:String) : void
      {
         _dic = new Dictionary();
         analyze(param1);
      }
      
      private static function analyze(param1:String) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Array = String(param1).split("\r\n");
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc7_];
            if(_loc3_.indexOf("#") != 0)
            {
               _loc3_ = _loc3_.replace(/\\r/g,"\r");
               _loc3_ = _loc3_.replace(/\\n/g,"\n");
               _loc2_ = _loc3_.indexOf(":");
               if(_loc2_ != -1)
               {
                  _loc4_ = _loc3_.substring(0,_loc2_);
                  _loc5_ = _loc3_.substr(_loc2_ + 1);
                  _loc5_ = _loc5_.split("##")[0];
                  _dic[_loc4_] = StringUtils.trimRight(_loc5_);
               }
            }
            _loc7_++;
         }
      }
      
      public static function GetTranslation(param1:String, ... rest) : String
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:String = !!_dic[param1]?_dic[param1]:"";
         var _loc7_:Object = _reg.exec(_loc4_);
         while(_loc7_ && rest.length > 0)
         {
            _loc3_ = _loc7_[1];
            _loc6_ = String(rest[_loc3_]);
            if(_loc3_ >= 0 && _loc3_ < rest.length)
            {
               _loc5_ = _loc6_.indexOf("$");
               if(_loc5_ > -1)
               {
                  _loc6_ = _loc6_.slice(0,_loc5_) + "$" + _loc6_.slice(_loc5_);
               }
               _loc4_ = _loc4_.replace(_reg,_loc6_);
            }
            else
            {
               _loc4_ = _loc4_.replace(_reg,"{}");
            }
            _loc7_ = _reg.exec(_loc4_);
         }
         return _loc4_;
      }
   }
}
