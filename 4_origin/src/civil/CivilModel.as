package civil
{
   import ddt.data.player.CivilPlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   
   public class CivilModel extends EventDispatcher
   {
       
      
      private var _civilPlayers:Array;
      
      private var _currentcivilItemInfo:CivilPlayerInfo;
      
      private var _totalPage:int;
      
      private var _currentLeafSex:Boolean = true;
      
      private var _register:Boolean = false;
      
      private var _IsFirst:Boolean = false;
      
      public function CivilModel(isFirst:Boolean)
      {
         _IsFirst = isFirst;
         super();
      }
      
      public function set currentcivilItemInfo($info:CivilPlayerInfo) : void
      {
         _currentcivilItemInfo = $info;
         dispatchEvent(new CivilEvent("selected_change"));
      }
      
      public function get currentcivilItemInfo() : CivilPlayerInfo
      {
         return _currentcivilItemInfo;
      }
      
      public function upSelfPublishEquit(b:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < _civilPlayers.length; )
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[i].UserId)
            {
               (_civilPlayers[i] as CivilPlayerInfo).IsPublishEquip = b;
               break;
            }
            i++;
         }
      }
      
      public function upSelfIntroduction(msg:String) : void
      {
         var i:int = 0;
         for(i = 0; i < _civilPlayers.length; )
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[i].UserId)
            {
               (_civilPlayers[i] as CivilPlayerInfo).Introduction = msg;
               break;
            }
            i++;
         }
      }
      
      public function set civilPlayers(value:Array) : void
      {
         var i:int = 0;
         _civilPlayers = value;
         var len:int = _civilPlayers.length;
         for(i = 0; i < len; )
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[i].UserId && PlayerManager.Instance.Self.Introduction == "")
            {
               PlayerManager.Instance.Self.Introduction = (_civilPlayers[i] as CivilPlayerInfo).Introduction;
               break;
            }
            i++;
         }
         dispatchEvent(new CivilEvent("civilplayerinfoarraychange"));
      }
      
      public function update() : void
      {
      }
      
      public function updateBtn() : void
      {
         dispatchEvent(new CivilEvent("CivilUpdateBtn"));
      }
      
      public function get civilPlayers() : Array
      {
         return _civilPlayers;
      }
      
      public function set TotalPage(value:int) : void
      {
         _totalPage = value;
      }
      
      public function get TotalPage() : int
      {
         return _totalPage;
      }
      
      public function get sex() : Boolean
      {
         return _currentLeafSex;
      }
      
      public function set sex(value:Boolean) : void
      {
         _currentLeafSex = value;
      }
      
      public function get registed() : Boolean
      {
         return _register;
      }
      
      public function set registed(val:Boolean) : void
      {
         _register = val;
         dispatchEvent(new CivilEvent("register_change"));
      }
      
      public function get IsFirst() : Boolean
      {
         return _IsFirst;
      }
      
      public function dispose() : void
      {
         _civilPlayers = null;
         currentcivilItemInfo = null;
      }
   }
}
