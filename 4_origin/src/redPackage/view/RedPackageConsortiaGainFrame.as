package redPackage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import redPackage.RedPackageManager;
   
   public class RedPackageConsortiaGainFrame extends Frame
   {
       
      
      public var _bg:Bitmap;
      
      public var _listPanel:ListPanel;
      
      public function RedPackageConsortiaGainFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("redpkg.frameTitle.gainPkg");
         escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.redpkg.consortion.Gain.bg");
         _bg.x = 16;
         _bg.y = 42;
         addToContent(_bg);
         _listPanel = ComponentFactory.Instance.creat("redpkg.List");
         addToContent(_listPanel);
         addEvents();
      }
      
      public function update() : void
      {
         var _loc1_:Number = _listPanel.list.viewPosition.y;
         var _loc2_:Number = _listPanel.vScrollbar.scrollValue;
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(RedPackageManager.getInstance().sendRecordArr);
         _listPanel.list.viewPosition.y = _loc1_;
         _listPanel.vScrollbar.scrollValue = _loc2_;
      }
      
      private function addEvents() : void
      {
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvents();
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_listPanel != null)
         {
            ObjectUtils.disposeObject(_listPanel);
            _listPanel = null;
         }
      }
   }
}
