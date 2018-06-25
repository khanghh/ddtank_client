package quest{   import com.pickgliss.ui.ComponentFactory;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;   import flash.net.URLVariables;      public class InfoCollectViewMail extends InfoCollectView   {                   private const DomainArray:Array = ["163.com","qq.com"];            public function InfoCollectViewMail(id:int = 0) { super(null); }
            override protected function fillArgs(args:URLVariables) : URLVariables { return null; }
            override protected function modifyView() : void { }
            override protected function addLabel() : void { }
            override protected function updateHelper(value:String) : String { return null; }
            private function cansearch(domain:String) : Boolean { return false; }
            override protected function __onSendBtn(evt:MouseEvent) : void { }
            override protected function addResetBtn() : void { }
   }}