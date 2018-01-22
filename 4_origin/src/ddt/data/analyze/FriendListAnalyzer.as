package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import ddt.manager.IMManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import im.CustomInfo;
   import road7th.data.DictionaryData;
   
   public class FriendListAnalyzer extends DataAnalyzer
   {
       
      
      public var customList:Vector.<CustomInfo>;
      
      public var friendlist:DictionaryData;
      
      public var blackList:DictionaryData;
      
      public function FriendListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc11_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc13_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc12_:* = null;
         var _loc4_:XML = new XML(param1);
         friendlist = new DictionaryData();
         blackList = new DictionaryData();
         customList = new Vector.<CustomInfo>();
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..customList;
            _loc11_ = 0;
            while(_loc11_ < _loc5_.length())
            {
               if(_loc5_[_loc11_].@Name != "")
               {
                  _loc6_ = new CustomInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc6_,_loc5_[_loc11_]);
                  customList.push(_loc6_);
               }
               _loc11_++;
            }
            _loc3_ = 0;
            while(_loc3_ < customList.length)
            {
               if(customList[_loc3_].ID == 1)
               {
                  _loc2_ = customList[_loc3_];
                  customList.splice(_loc3_,1);
                  customList.push(_loc2_);
               }
               _loc3_++;
            }
            _loc13_ = _loc4_..Item;
            _loc9_ = 0;
            while(_loc9_ < _loc13_.length())
            {
               _loc10_ = new FriendListPlayer();
               ObjectUtils.copyPorpertiesByXML(_loc10_,_loc13_[_loc9_]);
               _loc10_.isOld = int(_loc13_[_loc9_].@OldPlayer) == 1;
               _loc10_.ddtKingGrade = int(_loc13_[_loc9_].@MaxLevelLevel);
               _loc8_ = String(_loc13_[_loc9_].@LastDate).replace(/-/g,"/");
               _loc10_.LastLoginDate = new Date(_loc8_);
               if(_loc10_.Birthday != "Null")
               {
                  _loc7_ = _loc10_.Birthday.split(/-/g);
                  _loc10_.BirthdayDate = new Date();
                  _loc10_.BirthdayDate.fullYearUTC = Number(_loc7_[0]);
                  _loc10_.BirthdayDate.monthUTC = _loc7_[1] - 1;
                  _loc10_.BirthdayDate.dateUTC = Number(_loc7_[2]);
               }
               _loc12_ = new PlayerState(int(_loc4_.Item[_loc9_].@State));
               _loc10_.playerState = _loc12_;
               _loc10_.apprenticeshipState = _loc4_.Item[_loc9_].@ApprenticeshipState;
               _loc10_.IsShow = _loc4_.Item[_loc9_].@IsShow == "true"?true:false;
               _loc10_.ImagePath = _loc4_.Item[_loc9_].@ImagePath;
               _loc10_.isAttest = _loc4_.Item[_loc9_].@IsBeauty == "false"?false:true;
               if(_loc10_.Relation != 1)
               {
                  friendlist.add(_loc10_.ID,_loc10_);
               }
               else
               {
                  blackList.add(_loc10_.ID,_loc10_);
               }
               _loc9_++;
            }
            if(PlayerManager.Instance.Self.IsFirst == 1 && PathManager.CommunityExist())
            {
               IMManager.Instance.createConsortiaLoader();
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
