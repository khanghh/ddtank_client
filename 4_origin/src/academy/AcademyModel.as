package academy
{
   import ddt.data.player.AcademyPlayerInfo;
   
   public class AcademyModel
   {
       
      
      private var _requestType:Boolean;
      
      private var _currentSex:Boolean;
      
      private var _register:Boolean;
      
      private var _appshipStateType:Boolean;
      
      private var _academyPlayers:Vector.<AcademyPlayerInfo>;
      
      private var _currentAcademyItemInfo:AcademyPlayerInfo;
      
      private var _totalPage:int;
      
      private var _selfIsRegister:Boolean;
      
      private var _selfDescribe:String;
      
      public function AcademyModel()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _academyPlayers = new Vector.<AcademyPlayerInfo>();
      }
      
      public function set list(players:Vector.<AcademyPlayerInfo>) : void
      {
         _academyPlayers = players;
      }
      
      public function get list() : Vector.<AcademyPlayerInfo>
      {
         return _academyPlayers;
      }
      
      public function set sex(value:Boolean) : void
      {
         _currentSex = value;
      }
      
      public function get sex() : Boolean
      {
         return _currentSex;
      }
      
      public function set state(value:Boolean) : void
      {
         _appshipStateType = value;
      }
      
      public function get state() : Boolean
      {
         return _appshipStateType;
      }
      
      public function set info(value:AcademyPlayerInfo) : void
      {
         _currentAcademyItemInfo = value;
      }
      
      public function get info() : AcademyPlayerInfo
      {
         return _currentAcademyItemInfo;
      }
      
      public function set totalPage(value:int) : void
      {
         _totalPage = value;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set selfIsRegister(value:Boolean) : void
      {
         _selfIsRegister = value;
      }
      
      public function get selfIsRegister() : Boolean
      {
         return _selfIsRegister;
      }
      
      public function set selfDescribe(value:String) : void
      {
         _selfDescribe = value;
      }
      
      public function get selfDescribe() : String
      {
         return _selfDescribe;
      }
   }
}
