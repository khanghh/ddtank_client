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
      
      public function SelectListManager()
      {
         super();
      }
      
      public static function get Instance() : SelectListManager
      {
         if(_instance == null)
         {
            _instance = new SelectListManager();
         }
         return _instance;
      }
      
      public function setup(analyzer:LoginSelectListAnalyzer) : void
      {
         _list = analyzer.list;
         if(_list.length == 0)
         {
            _isNewBie = true;
         }
         if(_list.length == 1)
         {
            currentLoginRole = _list[0];
         }
      }
      
      public function get list() : Vector.<Role>
      {
         return _list;
      }
      
      public function set currentLoginRole(role:Role) : void
      {
         _currentLoginRole = role;
      }
      
      public function get currentLoginRole() : Role
      {
         return _currentLoginRole;
      }
      
      public function get mustShowSelectWindow() : Boolean
      {
         if(_list.length == 1 && _list[0].Rename == false && _list[0].ConsortiaRename == false)
         {
            return false;
         }
         return true;
      }
      
      public function get isNewbie() : Boolean
      {
         return _isNewBie;
      }
      
      public function get haveNotDeleteRoleNum() : int
      {
         var count:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var tmpRole in _list)
         {
            if(tmpRole.LoginState == 0 || tmpRole.LoginState == 2)
            {
               count++;
            }
         }
         return count;
      }
   }
}
