package ddt.view.chat
{
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.FilterWordManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public final class ChatModel extends EventDispatcher
   {
      
      private static const OVERCOUNT:int = 200;
       
      
      private var _clubChats:Array;
      
      private var _currentChats:Array;
      
      private var _privateChats:Array;
      
      private var _resentChats:Array;
      
      private var _linkInfoMap:Dictionary;
      
      private var _customFastReply:Vector.<String>;
      
      public function ChatModel(){super();}
      
      public function addChat(param1:ChatData) : void{}
      
      public function get customFastReply() : Vector.<String>{return null;}
      
      public function addLink(param1:String, param2:ItemTemplateInfo) : void{}
      
      public function getLink(param1:String) : ItemTemplateInfo{return null;}
      
      public function addCardGrooveLink(param1:String, param2:GrooveInfo) : void{}
      
      public function getCardGrooveLink(param1:String) : GrooveInfo{return null;}
      
      public function addCardInfoLink(param1:String, param2:CardInfo) : void{}
      
      public function getCardInfoLink(param1:String) : CardInfo{return null;}
      
      public function removeAllLink() : void{}
      
      public function getChatsByOutputChannel(param1:int, param2:int, param3:int) : Object{return null;}
      
      public function getInputInOutputChannel(param1:int, param2:int) : Boolean{return false;}
      
      public function reset() : void{}
      
      public function get clubChats() : Array{return null;}
      
      public function get currentChats() : Array{return null;}
      
      public function get privateChats() : Array{return null;}
      
      public function get resentChats() : Array{return null;}
      
      private function checkOverCount(param1:Array) : void{}
      
      public function getRowsByOutputChangel(param1:int) : int{return 0;}
      
      private function tryAddToClubChats(param1:ChatData) : void{}
      
      private function tryAddToCurrentChats(param1:ChatData) : void{}
      
      private function tryAddToPrivateChats(param1:ChatData) : void{}
      
      private function tryAddToRecent(param1:ChatData) : void{}
   }
}
