package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   
   public class InfoCollectViewMail extends InfoCollectView
   {
       
      
      private const DomainArray:Array = ["163.com","qq.com"];
      
      public function InfoCollectViewMail(id:int = 0)
      {
         super(id);
         Type = 1;
      }
      
      override protected function fillArgs(args:URLVariables) : URLVariables
      {
         args["mail"] = args["input"];
         return args;
      }
      
      override protected function modifyView() : void
      {
         _inputData.maxChars = 50;
      }
      
      override protected function addLabel() : void
      {
         _dataLabel = ComponentFactory.Instance.creat("core.quest.infoCollect.Label");
         _dataLabel.text = LanguageMgr.GetTranslation("ddt.quest.collectInfo.email");
      }
      
      override protected function updateHelper(value:String) : String
      {
         if(value == "")
         {
            return "";
         }
         if(value.indexOf("@") < 0)
         {
            return "ddt.quest.collectInfo.notValidMailAddress";
         }
         var domain:String = value.substr(value.indexOf("@") + 1);
         if(domain.indexOf(".") < 0)
         {
            return "ddt.quest.collectInfo.notValidMailAddress";
         }
         return "ddt.quest.collectInfo.validMailAddress";
      }
      
      private function cansearch(domain:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = DomainArray;
         for each(var i in DomainArray)
         {
            if(i == domain)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function __onSendBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_inputData.text.length < 1)
         {
            alert("ddt.quest.collectInfo.noMail");
            return;
         }
         sendData();
      }
      
      override protected function addResetBtn() : void
      {
      }
   }
}
