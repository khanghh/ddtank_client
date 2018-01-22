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
      
      public function set list(param1:Vector.<AcademyPlayerInfo>) : void
      {
         _academyPlayers = param1;
      }
      
      public function get list() : Vector.<AcademyPlayerInfo>
      {
         return _academyPlayers;
      }
      
      public function set sex(param1:Boolean) : void
      {
         _currentSex = param1;
      }
      
      public function get sex() : Boolean
      {
         return _currentSex;
      }
      
      public function set state(param1:Boolean) : void
      {
         _appshipStateType = param1;
      }
      
      public function get state() : Boolean
      {
         return _appshipStateType;
      }
      
      public function set info(param1:AcademyPlayerInfo) : void
      {
         _currentAcademyItemInfo = param1;
      }
      
      public function get info() : AcademyPlayerInfo
      {
         return _currentAcademyItemInfo;
      }
      
      public function set totalPage(param1:int) : void
      {
         _totalPage = param1;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set selfIsRegister(param1:Boolean) : void
      {
         _selfIsRegister = param1;
      }
      
      public function get selfIsRegister() : Boolean
      {
         return _selfIsRegister;
      }
      
      public function set selfDescribe(param1:String) : void
      {
         _selfDescribe = param1;
      }
      
      public function get selfDescribe() : String
      {
         return _selfDescribe;
      }
   }
}
