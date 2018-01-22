package ddt.view.common
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class PreviewFrame extends BaseAlerFrame implements Disposeable
   {
       
      
      private var _previewBitmap:DisplayObject;
      
      private var _scroll:ScrollPanel;
      
      private var _titleTxt:String;
      
      private var _previewBitmapStyle:String;
      
      private var _scrollStyle:String;
      
      private var _submitFunction:Function;
      
      private var _submitEnable:Boolean;
      
      private var _previewBmp:Bitmap;
      
      public function PreviewFrame()
      {
         super();
      }
      
      public function setStyle(param1:String, param2:String, param3:String, param4:Function = null, param5:Boolean = true, param6:Bitmap = null) : void
      {
         _titleTxt = param1;
         _previewBitmapStyle = param2;
         _scrollStyle = param3;
         _submitFunction = param4;
         _submitEnable = param5;
         _previewBmp = param6;
         initContent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function initContent() : void
      {
         if(_previewBitmapStyle != "")
         {
            _previewBitmap = ComponentFactory.Instance.creat(_previewBitmapStyle);
         }
         else
         {
            _previewBitmap = _previewBmp;
         }
         _scroll = ComponentFactory.Instance.creatComponentByStylename(_scrollStyle);
         var _loc1_:AlertInfo = new AlertInfo(_titleTxt,LanguageMgr.GetTranslation("ok"));
         _loc1_.autoDispose = false;
         var _loc2_:Boolean = false;
         _loc1_.moveEnable = _loc2_;
         _loc1_.showCancel = _loc2_;
         _loc1_.bottomGap = 8;
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.customPos = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.framebuttonPos");
         info = _loc1_;
         this.submitButtonEnable = _submitEnable;
         _scroll.setView(_previewBitmap);
         addToContent(_scroll);
         addEventListener("response",__frameEvent);
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(_submitFunction != null && _submitEnable)
               {
                  _submitFunction();
               }
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",__frameEvent);
         _previewBmp = null;
         if(_previewBitmap && _previewBitmap.parent)
         {
            _previewBitmap.parent.removeChild(_previewBitmap);
         }
         if(_previewBitmap)
         {
            ObjectUtils.disposeObject(_previewBitmap);
            _previewBitmap = null;
         }
         if(_scroll)
         {
            _scroll.dispose();
         }
         _scroll = null;
      }
   }
}
