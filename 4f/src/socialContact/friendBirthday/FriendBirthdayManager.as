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
      
      public function FriendBirthdayManager(){super();}
      
      public static function get Instance() : FriendBirthdayManager{return null;}
      
      public function findFriendBirthday() : void{}
      
      private function _countBrithday(param1:Date) : Boolean{return false;}
      
      private function _sendMySelfEmail(param1:Vector.<FriendListPlayer>) : void{}
      
      public function set friendName(param1:String) : void{}
      
      public function get friendName() : String{return null;}
      
      private function _countNameInShare(param1:String) : Boolean{return false;}
   }
}
