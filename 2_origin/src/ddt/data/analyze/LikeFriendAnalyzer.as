package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.LikeFriendInfo;
   
   public class LikeFriendAnalyzer extends DataAnalyzer
   {
       
      
      public var likeFriendList:Array;
      
      public function LikeFriendAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         likeFriendList = [];
         var _loc2_:XML = new XML(param1);
         var _loc3_:XMLList = _loc2_..Item;
         if(_loc2_.@value == "true")
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new LikeFriendInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.isOld = int(_loc3_[_loc5_].@OldPlayer) == 1;
               _loc4_.IsShow = _loc3_[_loc5_].@IsShow == "true"?true:false;
               _loc4_.ImagePath = _loc3_[_loc5_].@ImagePath;
               _loc4_.isAttest = _loc3_[_loc5_].@IsBeauty == "false"?false:true;
               likeFriendList.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
