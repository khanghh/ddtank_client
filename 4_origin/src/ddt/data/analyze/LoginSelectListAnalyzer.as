package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Role;
   import road7th.utils.DateUtils;
   
   public class LoginSelectListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<Role>;
      
      public var totalCount:int;
      
      public function LoginSelectListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            list = new Vector.<Role>();
            totalCount = int(_loc2_.@total);
            _loc3_ = XML(_loc2_)..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new Role();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.lastDate = DateUtils.decodeDated(_loc3_[_loc5_].@LastDate);
               list.push(_loc4_);
               _loc5_++;
            }
            list.sort(sortLastDate);
            list.sort(sortLoginState);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
      
      private function sortLastDate(param1:Role, param2:Role) : int
      {
         var _loc3_:int = 0;
         if(param1.lastDate.time < param2.lastDate.time)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = -1;
         }
         return _loc3_;
      }
      
      private function sortLoginState(param1:Role, param2:Role) : int
      {
         if(param1.LoginState == 1 && param2.LoginState != 1)
         {
            return 1;
         }
         if(param1.LoginState != -1 && param2.LoginState == 1)
         {
            return -1;
         }
         return sortLastDate(param1,param2);
      }
   }
}
