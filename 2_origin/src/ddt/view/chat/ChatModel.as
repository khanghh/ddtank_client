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
      
      public function addChat(data:ChatData) : void
      {
         tryAddToCurrentChats(data);
         tryAddToRecent(data);
         tryAddToClubChats(data);
         tryAddToPrivateChats(data);
         dispatchEvent(new ChatEvent("addChat",data));
      }
      
      public function get customFastReply() : Vector.<String>
      {
         return _customFastReply;
      }
      
      public function addLink(key:String, info:ItemTemplateInfo) : void
      {
         _linkInfoMap[key] = info;
      }
      
      public function getLink(itemIDLv:String) : ItemTemplateInfo
      {
         return _linkInfoMap[itemIDLv];
      }
      
      public function addCardGrooveLink(key:String, info:GrooveInfo) : void
      {
         _linkInfoMap[key] = info;
      }
      
      public function getCardGrooveLink(itemIDLv:String) : GrooveInfo
      {
         return _linkInfoMap[itemIDLv];
      }
      
      public function addCardInfoLink(key:String, info:CardInfo) : void
      {
         _linkInfoMap[key] = info;
      }
      
      public function getCardInfoLink(itemIDLv:String) : CardInfo
      {
         return _linkInfoMap[itemIDLv];
      }
      
      public function removeAllLink() : void
      {
         _linkInfoMap = new Dictionary();
      }
      
      public function getChatsByOutputChannel(channel:int, offset:int, count:int) : Object
      {
         offset = offset < 0?0:offset;
         var list:Array = [];
         if(channel == 0)
         {
            list = _currentChats;
         }
         else if(channel == 1)
         {
            list = _clubChats;
         }
         else if(channel == 2)
         {
            list = _privateChats;
         }
         if(list.length <= count)
         {
            return {
               "offset":0,
               "result":list
            };
         }
         if(list.length <= count + offset)
         {
            return {
               "offset":list.length - count,
               "result":list.slice(0,count)
            };
         }
         return {
            "offset":offset,
            "result":list.slice(list.length - count - offset,list.length - offset)
         };
      }
      
      public function getInputInOutputChannel(inputChannel:int, outputChannel:int) : Boolean
      {
         if(outputChannel == 1)
         {
            switch(int(inputChannel))
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
         else if(outputChannel == 2)
         {
            switch(int(inputChannel))
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
         else if(outputChannel == 0)
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
      
      private function checkOverCount(chatDatas:Array) : void
      {
         if(chatDatas.length > 200)
         {
            chatDatas.shift();
         }
      }
      
      public function getRowsByOutputChangel(channel:int) : int
      {
         return channel == 0?_currentChats.length:uint(channel == 1?_clubChats.length:uint(_privateChats.length));
      }
      
      private function tryAddToClubChats(data:ChatData) : void
      {
         if(getInputInOutputChannel(data.channel,1))
         {
            _clubChats.push(data);
         }
         checkOverCount(_clubChats);
      }
      
      private function tryAddToCurrentChats(chats:ChatData) : void
      {
         _currentChats.push(chats);
         checkOverCount(_currentChats);
      }
      
      private function tryAddToPrivateChats(data:ChatData) : void
      {
         if(getInputInOutputChannel(data.channel,2))
         {
            _privateChats.push(data);
            if(PlayerManager.Instance.Self.playerState.AutoReply != "" && !StringUtils.isEmpty(data.sender) && data.receiver == PlayerManager.Instance.Self.NickName && data.isAutoReply == false)
            {
               ChatManager.Instance.sendPrivateMessage(data.sender,FilterWordManager.filterWrod(PlayerManager.Instance.Self.playerState.AutoReply),data.senderID,true);
            }
         }
         checkOverCount(_privateChats);
      }
      
      private function tryAddToRecent(data:ChatData) : void
      {
         if(data.sender == PlayerManager.Instance.Self.NickName)
         {
            _resentChats.push(data);
         }
         checkOverCount(_resentChats);
      }
   }
}
