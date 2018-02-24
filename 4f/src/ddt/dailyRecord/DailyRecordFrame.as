package ddt.dailyRecord
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class DailyRecordFrame extends Frame
   {
       
      
      private var _titleImg:Bitmap;
      
      private var _bg:MutipleImage;
      
      private var _vbox:VBox;
      
      private var _list:ScrollPanel;
      
      public function DailyRecordFrame(){super();}
      
      private function initView() : void{}
      
      private function setData(param1:Vector.<DailiyRecordInfo>) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __dataIsOk(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
