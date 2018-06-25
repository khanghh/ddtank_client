package flashP2P{   import com.pickgliss.utils.GeneralUtils;   import ddt.data.player.SelfInfo;   import ddt.manager.ChatManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.NetStatusEvent;   import flash.net.NetConnection;   import flash.utils.ByteArray;   import flashP2P.event.StreamEvent;   import flashP2P.stream.ReadStream;   import flashP2P.stream.SendStream;   import road7th.data.DictionaryData;      public class FlashP2PManager extends EventDispatcher   {            private static var _instance:FlashP2PManager;                   public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";            public const AdobeKey:String = "rtmfp://p2p.rtmfp.net";            private const CirrusAddress:String = "rtmfp://p2p.rtmfp.net";            private var _netConnection:NetConnection;            private var _sendStream:SendStream;            private var _selfNearID:String;            private var _readStreams:DictionaryData;            public function FlashP2PManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : FlashP2PManager { return null; }
            public function connect() : void { }
            public function close() : void { }
            protected function __netConnectionHandler(event:NetStatusEvent) : void { }
            private function connectSuccess() : void { }
            private function connectClosed() : void { }
            private function connectFailed() : void { }
            private function initSendStream() : void { }
            public function getPeerIDByPlayerID(playerID:int) : String { return null; }
            public function addReadStream(peerID:String, playerID:int) : void { }
            protected function __onNetStatus(event:NetStatusEvent) : void { }
            public function sendPlivateMsg(peerID:String, toNick:String, msg:String, toId:Number = 0, isAutoReply:Boolean = false) : void { }
            public function sendLookPlayerInfo(peerID:String) : void { }
            public function sendShowPlayerInfo(peerID:String, self:SelfInfo) : void { }
            public function getPeerIndex(peerID:String) : int { return 0; }
            protected function onReadStreamHandler(event:StreamEvent) : void { }
   }}