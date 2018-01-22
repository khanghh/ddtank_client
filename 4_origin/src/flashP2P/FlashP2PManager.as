package flashP2P
{
   import com.pickgliss.utils.GeneralUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.utils.ByteArray;
   import flashP2P.event.StreamEvent;
   import flashP2P.stream.ReadStream;
   import flashP2P.stream.SendStream;
   import road7th.data.DictionaryData;
   
   public class FlashP2PManager extends EventDispatcher
   {
      
      private static var _instance:FlashP2PManager;
       
      
      public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";
      
      public const AdobeKey:String = "rtmfp://p2p.rtmfp.net";
      
      private const CirrusAddress:String = "rtmfp://p2p.rtmfp.net";
      
      private var _netConnection:NetConnection;
      
      private var _sendStream:SendStream;
      
      private var _selfNearID:String;
      
      private var _readStreams:DictionaryData;
      
      public function FlashP2PManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : FlashP2PManager
      {
         if(_instance == null)
         {
            _instance = new FlashP2PManager();
         }
         return _instance;
      }
      
      public function connect() : void
      {
         _netConnection = new NetConnection();
         _netConnection.addEventListener("netStatus",__netConnectionHandler);
         _netConnection.connect(PathManager.flashP2PCirrusUrl,PathManager.flashP2PKey);
      }
      
      public function close() : void
      {
         _netConnection.close();
      }
      
      protected function __netConnectionHandler(param1:NetStatusEvent) : void
      {
         var _loc2_:* = param1.info.code;
         if("NetConnection.Connect.Success" !== _loc2_)
         {
            if("NetConnection.Connect.Closed" !== _loc2_)
            {
               if("NetConnection.Connect.Failed" === _loc2_)
               {
                  connectFailed();
               }
            }
            else
            {
               connectClosed();
            }
         }
         else
         {
            connectSuccess();
         }
      }
      
      private function connectSuccess() : void
      {
         _selfNearID = _netConnection.nearID;
         SocketManager.Instance.out.sendPeerID(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID,_selfNearID);
         initSendStream();
      }
      
      private function connectClosed() : void
      {
         _selfNearID = "";
         SocketManager.Instance.out.sendPeerID(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID,_selfNearID);
      }
      
      private function connectFailed() : void
      {
         _selfNearID = "";
         SocketManager.Instance.out.sendPeerID(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID,_selfNearID);
      }
      
      private function initSendStream() : void
      {
         _sendStream = new SendStream(_netConnection,"directConnections");
      }
      
      public function getPeerIDByPlayerID(param1:int) : String
      {
         return null;
      }
      
      public function addReadStream(param1:String, param2:int) : void
      {
         var _loc3_:ReadStream = new ReadStream(_netConnection,param2,param1);
         _loc3_.addEventListener("defaultEvent",onReadStreamHandler);
         _loc3_.addEventListener("netStatus",__onNetStatus);
         _loc3_.play("DDT-P2P-PUBLISH-NAME");
      }
      
      protected function __onNetStatus(param1:NetStatusEvent) : void
      {
         ChatManager.Instance.sysChatRed(param1.info.code);
      }
      
      public function sendPlivateMsg(param1:String, param2:String, param3:String, param4:Number = 0, param5:Boolean = false) : void
      {
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.writeInt(param4);
         _loc6_.writeUTF(param2);
         _loc6_.writeUTF(PlayerManager.Instance.Self.NickName);
         _loc6_.writeInt(PlayerManager.Instance.Self.ID);
         _loc6_.writeUTF(param3);
         _loc6_.writeBoolean(param5);
         if(getPeerIndex(param1) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(param1)].send("readByteArray","PrivateMsg",_loc6_);
         }
      }
      
      public function sendLookPlayerInfo(param1:String) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTF(param1);
         if(getPeerIndex(param1) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(param1)].send("readByteArray","LookPlayerInfo",_loc2_);
         }
      }
      
      public function sendShowPlayerInfo(param1:String, param2:SelfInfo) : void
      {
         var _loc3_:Object = GeneralUtils.serializeObject(param2);
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTF(param1);
         _loc4_.writeObject(_loc3_);
         if(getPeerIndex(param1) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(param1)].send("readByteArray","ShowPlayerInfo",_loc4_);
         }
      }
      
      public function getPeerIndex(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _sendStream.peerStreams.length)
         {
            if(_sendStream.peerStreams[_loc2_].nearID == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      protected function onReadStreamHandler(param1:StreamEvent) : void
      {
         var _loc2_:* = param1.eventType;
         if("PrivateMsg" !== _loc2_)
         {
            if("LookPlayerInfo" !== _loc2_)
            {
               if("ShowPlayerInfo" === _loc2_)
               {
                  dispatchEvent(new StreamEvent("ShowPlayerInfo","",param1.readByteArray));
               }
            }
            else
            {
               dispatchEvent(new StreamEvent("LookPlayerInfo","",param1.readByteArray));
            }
         }
         else
         {
            dispatchEvent(new StreamEvent("PrivateMsg","",param1.readByteArray));
         }
      }
   }
}
