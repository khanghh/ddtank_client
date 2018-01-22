package ddt.manager
{
   import ddt.data.Role;
   import ddt.data.analyze.LoginSelectListAnalyzer;
   
   public class SelectListManager
   {
      
      private static var _instance:SelectListManager;
       
      
      private var _isNewBie:Boolean;
      
      private var _list:Vector.<Role>;
      
      private var _currentLoginRole:Role;
      
      public function SelectListManager(){super();}
      
      public static function get Instance() : SelectListManager{return null;}
      
      public function setup(param1:LoginSelectListAnalyzer) : void{}
      
      public function get list() : Vector.<Role>{return null;}
      
      public function set currentLoginRole(param1:Role) : void{}
      
      public function get currentLoginRole() : Role{return null;}
      
      public function get mustShowSelectWindow() : Boolean{return false;}
      
      public function get isNewbie() : Boolean{return false;}
      
      public function get haveNotDeleteRoleNum() : int{return 0;}
   }
}
