package consortion.view.selfConsortia{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import consortion.ConsortionModelManager;   import consortion.data.ConsortiaDutyInfo;   import consortion.event.ConsortionEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;      public class ConsortionJobManageFrame extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _textBG:ScaleBitmapImage;            private var _cancel:TextButton;            private var _list:VBox;            private var _items:Vector.<JobManageItem>;            private var _jobManager:FilterFrameText;            private var _limits:FilterFrameText;            private var _textArea:FilterFrameText;            private var _dottedline:MutipleImage;            public function ConsortionJobManageFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function __cancelHandler(event:MouseEvent) : void { }
            private function __dutyListChange(event:ConsortionEvent) : void { }
            private function setDataList(list:Vector.<ConsortiaDutyInfo>) : void { }
            private function clearList() : void { }
            private function __itemClickHandler(event:MouseEvent) : void { }
            private function setText(type:int) : String { return null; }
            override public function dispose() : void { }
   }}