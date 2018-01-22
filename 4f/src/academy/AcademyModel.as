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
      
      public function AcademyModel(){super();}
      
      private function init() : void{}
      
      public function set list(param1:Vector.<AcademyPlayerInfo>) : void{}
      
      public function get list() : Vector.<AcademyPlayerInfo>{return null;}
      
      public function set sex(param1:Boolean) : void{}
      
      public function get sex() : Boolean{return false;}
      
      public function set state(param1:Boolean) : void{}
      
      public function get state() : Boolean{return false;}
      
      public function set info(param1:AcademyPlayerInfo) : void{}
      
      public function get info() : AcademyPlayerInfo{return null;}
      
      public function set totalPage(param1:int) : void{}
      
      public function get totalPage() : int{return 0;}
      
      public function set selfIsRegister(param1:Boolean) : void{}
      
      public function get selfIsRegister() : Boolean{return false;}
      
      public function set selfDescribe(param1:String) : void{}
      
      public function get selfDescribe() : String{return null;}
   }
}
