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
      
      public function PreviewFrame(){super();}
      
      public function setStyle(param1:String, param2:String, param3:String, param4:Function = null, param5:Boolean = true, param6:Bitmap = null) : void{}
      
      public function show() : void{}
      
      public function initContent() : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
