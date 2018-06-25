package mark.views{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.events.Event;   import mark.MarkMgr;   import mark.data.MarkChipData;   import mark.data.MarkHammerTemplateData;   import mark.data.MarkProData;   import mark.event.MarkEvent;   import mark.mornUI.views.MarkHammerViewUI;   import morn.core.handlers.Handler;      public class MarkHammerView extends MarkHammerViewUI   {                   private var _item:BaseCell = null;            private var _qualityTxt:FilterFrameText = null;            private var _progessMC:MovieClip = null;            private var _wheelMC:MovieClip = null;            private var _flashMC:MovieClip = null;            private var _successMC:MovieClip = null;            private var _failMC:MovieClip = null;            private var _result:Boolean = false;            private var _cnt:int = 0;            public function MarkHammerView() { super(); }
            override protected function initialize() : void { }
            private function hammer(cnt:int) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function hammerResultHandler(evt:MarkEvent) : void { }
            private function frameHandler(evt:Event) : void { }
            private function frameHandler2(evt:Event) : void { }
            private function frameHandler1(evt:Event) : void { }
            override public function set visible(value:Boolean) : void { }
            private function updateInfo(evt:MarkEvent = null) : void { }
            private function updateMarkMoney(evt:MarkEvent) : void { }
            override public function dispose() : void { }
   }}