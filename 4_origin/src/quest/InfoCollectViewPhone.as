package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import flash.net.URLVariables;
   
   public class InfoCollectViewPhone extends InfoCollectView
   {
       
      
      public function InfoCollectViewPhone(id:int = 0)
      {
         super(id);
         Type = 2;
      }
      
      override protected function addLabel() : void
      {
         _dataLabel = ComponentFactory.Instance.creat("core.quest.infoCollect.Label");
         _dataLabel.text = LanguageMgr.GetTranslation("ddt.quest.collectInfo.phone");
      }
      
      override protected function fillArgs(args:URLVariables) : URLVariables
      {
         args["phone"] = args["input"];
         return args;
      }
      
      override protected function updateHelper(value:String) : String
      {
         return "";
      }
   }
}
