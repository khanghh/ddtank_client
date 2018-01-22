package gameCommon.objects
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class GhostBoxModel
   {
      
      private static var _ins:GhostBoxModel;
       
      
      private var _psychicArr:Array;
      
      public function GhostBoxModel()
      {
         super();
      }
      
      public static function getInstance() : GhostBoxModel
      {
         if(_ins == null)
         {
            _ins = ComponentFactory.Instance.creatCustomObject("GhostBoxModel");
         }
         return _ins;
      }
      
      public function set psychics(param1:String) : void
      {
         _psychicArr = param1.split(",");
      }
      
      public function getPsychicByType(param1:int) : int
      {
         if(_psychicArr == null || param1 - 2 > _psychicArr.length || param1 - 2 < 0)
         {
            return 0;
         }
         return _psychicArr[param1 - 2];
      }
   }
}
