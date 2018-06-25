package store.view.embed
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   
   public class EmbedAlertFrame extends BaseAlerFrame
   {
      
      public static const ADDFrameHeight:int = 60;
       
      
      public function EmbedAlertFrame()
      {
         super();
      }
      
      public function show(_data:DisplayObject) : void
      {
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.cancelLabel = LanguageMgr.GetTranslation("cancel");
         alertInfo.data = _data;
         info = alertInfo;
         addToContent(_data);
         width = _data.width + _containerX * 2;
         height = _data.height + _containerY + 60;
         moveEnable = false;
         LayerManager.Instance.addToLayer(this,2,true,2);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
