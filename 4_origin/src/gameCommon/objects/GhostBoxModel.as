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
      
      public function set psychics(val:String) : void
      {
         _psychicArr = val.split(",");
      }
      
      public function getPsychicByType(type:int) : int
      {
         if(_psychicArr == null || type - 2 > _psychicArr.length || type - 2 < 0)
         {
            return 0;
         }
         return _psychicArr[type - 2];
      }
   }
}
