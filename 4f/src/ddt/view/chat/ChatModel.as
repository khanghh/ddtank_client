package ddt.view.chat{   import cardSystem.data.CardInfo;   import cardSystem.data.GrooveInfo;   import com.pickgliss.utils.StringUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.utils.FilterWordManager;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;      public final class ChatModel extends EventDispatcher   {            private static const OVERCOUNT:int = 200;                   private var _clubChats:Array;            private var _currentChats:Array;            private var _privateChats:Array;            private var _resentChats:Array;            private var _linkInfoMap:Dictionary;            private var _customFastReply:Vector.<String>;            public function ChatModel() { super(); }
            public function addChat(data:ChatData) : void { }
            public function get customFastReply() : Vector.<String> { return null; }
            public function addLink(key:String, info:ItemTemplateInfo) : void { }
            public function getLink(itemIDLv:String) : ItemTemplateInfo { return null; }
            public function addCardGrooveLink(key:String, info:GrooveInfo) : void { }
            public function getCardGrooveLink(itemIDLv:String) : GrooveInfo { return null; }
            public function addCardInfoLink(key:String, info:CardInfo) : void { }
            public function getCardInfoLink(itemIDLv:String) : CardInfo { return null; }
            public function removeAllLink() : void { }
            public function getChatsByOutputChannel(channel:int, offset:int, count:int) : Object { return null; }
            public function getInputInOutputChannel(inputChannel:int, outputChannel:int) : Boolean { return false; }
            public function reset() : void { }
            public function get clubChats() : Array { return null; }
            public function get currentChats() : Array { return null; }
            public function get privateChats() : Array { return null; }
            public function get resentChats() : Array { return null; }
            private function checkOverCount(chatDatas:Array) : void { }
            public function getRowsByOutputChangel(channel:int) : int { return 0; }
            private function tryAddToClubChats(data:ChatData) : void { }
            private function tryAddToCurrentChats(chats:ChatData) : void { }
            private function tryAddToPrivateChats(data:ChatData) : void { }
            private function tryAddToRecent(data:ChatData) : void { }
   }}