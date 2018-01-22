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
      
      public function InfoCollectViewMail(param1:int = 0){super(null);}
      
      override protected function fillArgs(param1:URLVariables) : URLVariables{return null;}
      
      override protected function modifyView() : void{}
      
      override protected function addLabel() : void{}
      
      override protected function updateHelper(param1:String) : String{return null;}
      
      private function cansearch(param1:String) : Boolean{return false;}
      
      override protected function __onSendBtn(param1:MouseEvent) : void{}
      
      override protected function addResetBtn() : void{}
   }
}
