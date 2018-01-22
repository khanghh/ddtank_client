package email.view
{
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.email.EmailInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   
   public class EmailListView extends VBox
   {
       
      
      private var _strips:Array;
      
      public function EmailListView(){super();}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function update(param1:Array, param2:Boolean = false) : void{}
      
      public function switchSeleted() : void{}
      
      private function allHasSelected() : Boolean{return false;}
      
      private function changeAll(param1:Boolean) : void{}
      
      private function isHaveConsortionMail() : Boolean{return false;}
      
      public function getSelectedMails() : Array{return null;}
      
      public function updateInfo(param1:EmailInfo) : void{}
      
      private function clearElements() : void{}
      
      private function __select(param1:Event) : void{}
      
      function canChangePage() : Boolean{return false;}
   }
}
