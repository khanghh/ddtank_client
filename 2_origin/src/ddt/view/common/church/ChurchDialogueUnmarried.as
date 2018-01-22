package ddt.view.common.church
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ChurchDialogueUnmarried extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      public function ChurchDialogueUnmarried()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.showSubmit = false;
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("close");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.church.UnmarriedAsset");
         addToContent(_bg);
         addEventListener("response",onFrameResponse);
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.bitmapData.dispose();
            _bg.bitmapData = null;
         }
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
