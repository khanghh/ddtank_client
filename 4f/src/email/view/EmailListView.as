package email.view{   import com.pickgliss.ui.controls.container.VBox;   import ddt.data.email.EmailInfo;   import ddt.manager.LanguageMgr;   import flash.events.Event;      public class EmailListView extends VBox   {                   private var _strips:Array;            public function EmailListView() { super(); }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function update(emails:Array, isSendedMail:Boolean = false) : void { }
            public function switchSeleted() : void { }
            private function allHasSelected() : Boolean { return false; }
            private function changeAll(value:Boolean) : void { }
            private function isHaveConsortionMail() : Boolean { return false; }
            public function getSelectedMails() : Array { return null; }
            public function updateInfo(info:EmailInfo) : void { }
            private function clearElements() : void { }
            private function __select(event:Event) : void { }
            protected function canChangePage() : Boolean { return false; }
   }}