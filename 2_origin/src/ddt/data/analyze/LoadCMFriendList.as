package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.CMFriendInfo;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class LoadCMFriendList extends DataAnalyzer
   {
       
      
      public function LoadCMFriendList(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:DictionaryData = new DictionaryData();
         var _loc5_:XML = new XML(param1);
         var _loc6_:XMLList = _loc5_..Item;
         if(_loc5_.@value == "true")
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length())
            {
               _loc7_ = new CMFriendInfo();
               _loc7_.NickName = _loc6_[_loc8_].@NickName;
               _loc7_.UserName = _loc6_[_loc8_].@UserName;
               _loc7_.UserId = _loc6_[_loc8_].@UserId;
               _loc7_.Photo = _loc6_[_loc8_].@Photo;
               _loc7_.PersonWeb = _loc6_[_loc8_].@PersonWeb;
               _loc7_.OtherName = _loc6_[_loc8_].@OtherName;
               _loc7_.level = _loc6_[_loc8_].@Level;
               _loc2_ = _loc6_[_loc8_].@Sex;
               if(_loc2_ == 0)
               {
                  _loc7_.sex = false;
               }
               else
               {
                  _loc7_.sex = true;
               }
               _loc4_ = _loc6_[_loc8_].@IsExist;
               if(_loc4_ == "true")
               {
                  _loc7_.IsExist = true;
               }
               else
               {
                  _loc7_.IsExist = false;
               }
               if(!(_loc7_.IsExist && PlayerManager.Instance.friendList[_loc7_.UserId]))
               {
                  _loc3_.add(_loc7_.UserName,_loc7_);
               }
               _loc8_++;
            }
            PlayerManager.Instance.CMFriendList = _loc3_;
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
