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
      
      public function FlashP2PManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __netConnectionHandler(event:NetStatusEvent) : void
      {
         var _loc2_:* = event.info.code;
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
      
      public function getPeerIDByPlayerID(playerID:int) : String
      {
         return null;
      }
      
      public function addReadStream(peerID:String, playerID:int) : void
      {
         var readStream:ReadStream = new ReadStream(_netConnection,playerID,peerID);
         readStream.addEventListener("defaultEvent",onReadStreamHandler);
         readStream.addEventListener("netStatus",__onNetStatus);
         readStream.play("DDT-P2P-PUBLISH-NAME");
      }
      
      protected function __onNetStatus(event:NetStatusEvent) : void
      {
         ChatManager.Instance.sysChatRed(event.info.code);
      }
      
      public function sendPlivateMsg(peerID:String, toNick:String, msg:String, toId:Number = 0, isAutoReply:Boolean = false) : void
      {
         var pkg:ByteArray = new ByteArray();
         pkg.writeInt(toId);
         pkg.writeUTF(toNick);
         pkg.writeUTF(PlayerManager.Instance.Self.NickName);
         pkg.writeInt(PlayerManager.Instance.Self.ID);
         pkg.writeUTF(msg);
         pkg.writeBoolean(isAutoReply);
         if(getPeerIndex(peerID) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(peerID)].send("readByteArray","PrivateMsg",pkg);
         }
      }
      
      public function sendLookPlayerInfo(peerID:String) : void
      {
         var pkg:ByteArray = new ByteArray();
         pkg.writeUTF(peerID);
         if(getPeerIndex(peerID) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(peerID)].send("readByteArray","LookPlayerInfo",pkg);
         }
      }
      
      public function sendShowPlayerInfo(peerID:String, self:SelfInfo) : void
      {
         var selfObj:Object = GeneralUtils.serializeObject(self);
         var pkg:ByteArray = new ByteArray();
         pkg.writeUTF(peerID);
         pkg.writeObject(selfObj);
         if(getPeerIndex(peerID) != -1)
         {
            _sendStream.peerStreams[getPeerIndex(peerID)].send("readByteArray","ShowPlayerInfo",pkg);
         }
      }
      
      public function getPeerIndex(peerID:String) : int
      {
         var i:int = 0;
         for(i = 0; i < _sendStream.peerStreams.length; )
         {
            if(_sendStream.peerStreams[i].nearID == peerID)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      protected function onReadStreamHandler(event:StreamEvent) : void
      {
         var _loc2_:* = event.eventType;
         if("PrivateMsg" !== _loc2_)
         {
            if("LookPlayerInfo" !== _loc2_)
            {
               if("ShowPlayerInfo" === _loc2_)
               {
                  dispatchEvent(new StreamEvent("ShowPlayerInfo","",event.readByteArray));
               }
            }
            else
            {
               dispatchEvent(new StreamEvent("LookPlayerInfo","",event.readByteArray));
            }
         }
         else
         {
            dispatchEvent(new StreamEvent("PrivateMsg","",event.readByteArray));
         }
      }
   }
}
