package ddt.view.chat
{
   import ddt.utils.Helpers;
   
   public class ChatData
   {
      
      public static const B_BUGGLE_TYPE_NORMAL:uint = 0;
      
      public static const BUGLE_ANIMATION:String = "bugleAnimation";
       
      
      public var channel:uint;
      
      public var htmlMessage:String = "";
      
      public var msg:String = "";
      
      private var _receiver:String = "";
      
      public var redType:int;
      
      public var receiverID:int;
      
      public var sender:String = "";
      
      public var isAutoReply:Boolean = false;
      
      public var senderID:int;
      
      public var zoneID:int = -1;
      
      public var zoneName:String = "";
      
      public var type:int = -1;
      
      public var bigBuggleType:uint = 0;
      
      public var link:Array;
      
      public var roomId:int;
      
      public var password:String;
      
      public var playerCharacterID:int;
      
      public var playerName:String;
      
      public var teamplateID:int;
      
      public var itemCount:int;
      
      public var mouthful:int;
      
      public var payType:int;
      
      public var price:int;
      
      public var rise:int;
      
      public var validDate:int;
      
      public var auctionGoodName:String;
      
      public var auctionID:int;
      
      public var childChannelArr:Array;
      
      public var actId:String;
      
      public function ChatData()
      {
         super();
      }
      
      public function set receiver(param1:String) : void
      {
         _receiver = param1;
      }
      
      public function get receiver() : String
      {
         return _receiver;
      }
      
      public function clone() : ChatData
      {
         var _loc1_:ChatData = new ChatData();
         Helpers.copyProperty(this,_loc1_,["channel","htmlMessage","msg","receiver","receiverID","sender","senderID","zoneID","type"]);
         _loc1_.link = [].concat(link);
         return _loc1_;
      }
   }
}
