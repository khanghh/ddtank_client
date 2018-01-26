package ddt.view.edictum
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   
   public class EdictumFrame extends BaseAlerFrame
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _titleTxt:FilterFrameText;
      
      private var _contenTxt:FilterFrameText;
      
      public function EdictumFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      public function set data(param1:Object) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
