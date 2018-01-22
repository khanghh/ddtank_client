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
      
      public function ChatModel()
      {
         super();
         reset();
      }
      
      public function addChat(param1:ChatData) : void
      {
         tryAddToCurrentChats(param1);
         tryAddToRecent(param1);
         tryAddToClubChats(param1);
         tryAddToPrivateChats(param1);
         dispatchEvent(new ChatEvent("addChat",param1));
      }
      
      public function get customFastReply() : Vector.<String>
      {
         return _customFastReply;
      }
      
      public function addLink(param1:String, param2:ItemTemplateInfo) : void
      {
         _linkInfoMap[param1] = param2;
      }
      
      public function getLink(param1:String) : ItemTemplateInfo
      {
         return _linkInfoMap[param1];
      }
      
      public function addCardGrooveLink(param1:String, param2:GrooveInfo) : void
      {
         _linkInfoMap[param1] = param2;
      }
      
      public function getCardGrooveLink(param1:String) : GrooveInfo
      {
         return _linkInfoMap[param1];
      }
      
      public function addCardInfoLink(param1:String, param2:CardInfo) : void
      {
         _linkInfoMap[param1] = param2;
      }
      
      public function getCardInfoLink(param1:String) : CardInfo
      {
         return _linkInfoMap[param1];
      }
      
      public function removeAllLink() : void
      {
         _linkInfoMap = new Dictionary();
      }
      
      public function getChatsByOutputChannel(param1:int, param2:int, param3:int) : Object
      {
         param2 = param2 < 0?0:param2;
         var _loc4_:Array = [];
         if(param1 == 0)
         {
            _loc4_ = _currentChats;
         }
         else if(param1 == 1)
         {
            _loc4_ = _clubChats;
         }
         else if(param1 == 2)
         {
            _loc4_ = _privateChats;
         }
         if(_loc4_.length <= param3)
         {
            return {
               "offset":0,
               "result":_loc4_
            };
         }
         if(_loc4_.length <= param3 + param2)
         {
            return {
               "offset":_loc4_.length - param3,
               "result":_loc4_.slice(0,param3)
            };
         }
         return {
            "offset":param2,
            "result":_loc4_.slice(_loc4_.length - param3 - param2,_loc4_.length - param2)
         };
      }
      
      public function getInputInOutputChannel(param1:int, param2:int) : Boolean
      {
         if(param2 == 1)
         {
            switch(int(param1))
            {
               case 0:
               case 1:
                  return true;
               default:
               case 3:
               default:
               default:
               case 6:
               case 7:
               default:
               default:
               default:
               case 11:
               case 12:
               default:
               default:
               case 15:
                  return true;
            }
         }
         else if(param2 == 2)
         {
            switch(int(param1))
            {
               case 0:
               case 1:
               case 2:
                  return true;
               default:
               default:
               default:
               case 6:
               case 7:
               default:
               default:
               default:
               case 11:
               case 12:
               default:
               default:
               case 15:
                  return true;
            }
         }
         else if(param2 == 0)
         {
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         _currentChats = [];
         _clubChats = [];
         _privateChats = [];
         _resentChats = [];
         _customFastReply = new Vector.<String>();
         _linkInfoMap = new Dictionary();
      }
      
      public function get clubChats() : Array
      {
         return _clubChats;
      }
      
      public function get currentChats() : Array
      {
         return _currentChats;
      }
      
      public function get privateChats() : Array
      {
         return _privateChats;
      }
      
      public function get resentChats() : Array
      {
         return _resentChats;
      }
      
      private function checkOverCount(param1:Array) : void
      {
         if(param1.length > 200)
         {
            param1.shift();
         }
      }
      
      public function getRowsByOutputChangel(param1:int) : int
      {
         return param1 == 0?_currentChats.length:uint(param1 == 1?_clubChats.length:uint(_privateChats.length));
      }
      
      private function tryAddToClubChats(param1:ChatData) : void
      {
         if(getInputInOutputChannel(param1.channel,1))
         {
            _clubChats.push(param1);
         }
         checkOverCount(_clubChats);
      }
      
      private function tryAddToCurrentChats(param1:ChatData) : void
      {
         _currentChats.push(param1);
         checkOverCount(_currentChats);
      }
      
      private function tryAddToPrivateChats(param1:ChatData) : void
      {
         if(getInputInOutputChannel(param1.channel,2))
         {
            _privateChats.push(param1);
            if(PlayerManager.Instance.Self.playerState.AutoReply != "" && !StringUtils.isEmpty(param1.sender) && param1.receiver == PlayerManager.Instance.Self.NickName && param1.isAutoReply == false)
            {
               ChatManager.Instance.sendPrivateMessage(param1.sender,FilterWordManager.filterWrod(PlayerManager.Instance.Self.playerState.AutoReply),param1.senderID,true);
            }
         }
         checkOverCount(_privateChats);
      }
      
      private function tryAddToRecent(param1:ChatData) : void
      {
         if(param1.sender == PlayerManager.Instance.Self.NickName)
         {
            _resentChats.push(param1);
         }
         checkOverCount(_resentChats);
      }
   }
}
