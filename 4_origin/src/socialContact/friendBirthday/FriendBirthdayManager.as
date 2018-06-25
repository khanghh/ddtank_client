package socialContact.friendBirthday
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import road7th.data.DictionaryData;
   
   public class FriendBirthdayManager
   {
      
      private static var _instance:FriendBirthdayManager;
       
      
      private const INTERVAL:int = 86400;
      
      private var _friendName:String;
      
      public function FriendBirthdayManager()
      {
         super();
      }
      
      public static function get Instance() : FriendBirthdayManager
      {
         if(_instance == null)
         {
            _instance = new FriendBirthdayManager();
         }
         return _instance;
      }
      
      public function findFriendBirthday() : void
      {
         var friend:* = null;
         var brithdayVec:Vector.<FriendListPlayer> = new Vector.<FriendListPlayer>();
         var dic:DictionaryData = PlayerManager.Instance.friendList;
         var _loc6_:int = 0;
         var _loc5_:* = dic;
         for(var str in dic)
         {
            friend = dic[str] as FriendListPlayer;
            if(friend.BirthdayDate && _countBrithday(friend.BirthdayDate) && _countNameInShare(friend.NickName))
            {
               brithdayVec.push(friend);
               SharedManager.Instance.friendBrithdayName = SharedManager.Instance.friendBrithdayName + "," + friend.NickName;
               SharedManager.Instance.save();
            }
         }
         if(brithdayVec.length > 0)
         {
            _sendMySelfEmail(brithdayVec);
         }
      }
      
      private function _countBrithday(date:Date) : Boolean
      {
         var nowDate:Date = new Date();
         var boo:Boolean = false;
         if(nowDate.monthUTC == date.monthUTC && date.dateUTC - nowDate.dateUTC <= 1 && date.dateUTC - nowDate.dateUTC > -1)
         {
            boo = true;
         }
         return boo;
      }
      
      private function _sendMySelfEmail(vec:Vector.<FriendListPlayer>) : void
      {
         SocketManager.Instance.out.sendWithBrithday(vec);
      }
      
      public function set friendName(str:String) : void
      {
         _friendName = str;
      }
      
      public function get friendName() : String
      {
         return _friendName;
      }
      
      private function _countNameInShare(str:String) : Boolean
      {
         var i:int = 0;
         var arr:Array = SharedManager.Instance.friendBrithdayName.split(/,/);
         for(i = 0; i < arr.length; )
         {
            if(str == arr[i])
            {
               return false;
            }
            i++;
         }
         return true;
      }
   }
}
