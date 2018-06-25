package wonderfulActivity.items{   import activeEvents.data.ActiveEventsInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class LimitListItem extends Sprite   {            public static const ITEM_CHANGE:String = "itemChange";                   private var _info:ActiveEventsInfo;            private var _btn:ScaleFrameImage;            private var _txt:FilterFrameText;            private var _isSeleted:Boolean;            private var _func:Function;            private var _selecetHander:Function;            public function LimitListItem(info:ActiveEventsInfo, func:Function, selecteHander:Function) { super(); }
            private function initView() : void { }
            public function setSelectBtn(bool:Boolean) : void { }
            private function initTxt() : void { }
            private function changeTitle() : String { return null; }
            public function initRightView() : Function { return null; }
            protected function clickHander(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}