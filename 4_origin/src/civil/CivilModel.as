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
      
      public function CivilModel(param1:Boolean)
      {
         _IsFirst = param1;
         super();
      }
      
      public function set currentcivilItemInfo(param1:CivilPlayerInfo) : void
      {
         _currentcivilItemInfo = param1;
         dispatchEvent(new CivilEvent("selected_change"));
      }
      
      public function get currentcivilItemInfo() : CivilPlayerInfo
      {
         return _currentcivilItemInfo;
      }
      
      public function upSelfPublishEquit(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _civilPlayers.length)
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[_loc2_].UserId)
            {
               (_civilPlayers[_loc2_] as CivilPlayerInfo).IsPublishEquip = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function upSelfIntroduction(param1:String) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _civilPlayers.length)
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[_loc2_].UserId)
            {
               (_civilPlayers[_loc2_] as CivilPlayerInfo).Introduction = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function set civilPlayers(param1:Array) : void
      {
         var _loc3_:int = 0;
         _civilPlayers = param1;
         var _loc2_:int = _civilPlayers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(PlayerManager.Instance.Self.ID == _civilPlayers[_loc3_].UserId && PlayerManager.Instance.Self.Introduction == "")
            {
               PlayerManager.Instance.Self.Introduction = (_civilPlayers[_loc3_] as CivilPlayerInfo).Introduction;
               break;
            }
            _loc3_++;
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
      
      public function set TotalPage(param1:int) : void
      {
         _totalPage = param1;
      }
      
      public function get TotalPage() : int
      {
         return _totalPage;
      }
      
      public function get sex() : Boolean
      {
         return _currentLeafSex;
      }
      
      public function set sex(param1:Boolean) : void
      {
         _currentLeafSex = param1;
      }
      
      public function get registed() : Boolean
      {
         return _register;
      }
      
      public function set registed(param1:Boolean) : void
      {
         _register = param1;
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
