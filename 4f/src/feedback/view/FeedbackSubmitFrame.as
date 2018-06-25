package feedback.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import feedback.FeedbackManager;   import feedback.data.FeedbackInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Rectangle;   import road7th.utils.DateUtils;      public class FeedbackSubmitFrame extends BaseAlerFrame   {                   private var _box:Sprite;            private var _dayCombox:ComboBox;            private var _dayTextImg:FilterFrameText;            private var _feedbackSp:Disposeable;            private var _monthCombox:ComboBox;            private var _monthTextImg:FilterFrameText;            private var _occurrenceTimeTextImg:FilterFrameText;            private var _problemCombox:ComboBox;            private var _problemTitleAsterisk:Bitmap;            private var _problemTitleInput:TextInput;            private var _problemTitleTextImg:FilterFrameText;            private var _problemTypesAsterisk:Bitmap;            private var _problemTypesTextImg:FilterFrameText;            private var _yearCombox:ComboBox;            private var _yearTextImg:FilterFrameText;            private var _feedbackBg:ScaleBitmapImage;            public function FeedbackSubmitFrame() { super(); }
            public function get problemCombox() : ComboBox { return null; }
            public function get problemTitleInput() : TextInput { return null; }
            override public function dispose() : void { }
            public function get feedbackInfo() : FeedbackInfo { return null; }
            public function show() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function __problemComboxChanged(event:Event) : void { }
            private function fixFeedBackTopImg($type:int) : void { }
            private function _init() : void { }
            private function addEvent() : void { }
            private function __comboxClick(event:Event) : void { }
            private function _dateChanged(event:InteractiveEvent) : void { }
            private function getFeedbackSp($type:int) : Disposeable { return null; }
            private function remvoeEvent() : void { }
   }}