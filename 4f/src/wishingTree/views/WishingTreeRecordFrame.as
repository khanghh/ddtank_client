package wishingTree.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import road7th.comm.PackageIn;
   
   public class WishingTreeRecordFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _desc:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _txtArr:Array;
      
      public function WishingTreeRecordFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      protected function __getRecord(param1:PkgEvent) : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
