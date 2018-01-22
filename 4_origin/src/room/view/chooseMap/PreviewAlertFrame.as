package room.view.chooseMap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class PreviewAlertFrame extends Frame
   {
       
      
      private var _scrollPanel:ScrollPanel;
      
      private var _bg:Bitmap;
      
      private var _okBtn:TextButton;
      
      public function PreviewAlertFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("room.PreviewScrollPanel");
         _bg = ComponentFactory.Instance.creatBitmap("asset.room.fifthPreviewAsset");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("room.PreviewBtn");
         titleText = LanguageMgr.GetTranslation("tank.room.DungeonSneak");
         addToContent(_scrollPanel);
         _scrollPanel.setView(_bg);
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         addToContent(_okBtn);
         escEnable = true;
      }
      
      private function initEvents() : void
      {
         _okBtn.addEventListener("click",__onClick);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         super.__onCloseClick(param1);
      }
      
      private function removeEvents() : void
      {
         _okBtn.removeEventListener("click",__onClick);
      }
      
      override public function dispose() : void
      {
         SoundManager.instance.play("008");
         removeEvents();
         super.dispose();
      }
   }
}
