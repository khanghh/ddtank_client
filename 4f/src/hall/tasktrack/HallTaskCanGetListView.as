package hall.tasktrack{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TextEvent;   import quest.TaskManager;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class HallTaskCanGetListView extends Sprite implements Disposeable   {                   private var _titleTxt:FilterFrameText;            private var _scrollPanel:ScrollPanel;            private var _sprite:Sprite;            private var _dataList:DictionaryData;            private var _npcBtn:BaseButton;            private var _pointDownArrow:MovieClip;            public function HallTaskCanGetListView(npcBtn:BaseButton) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function addHandler(event:DictionaryEvent) : void { }
            private function removeHandler(event:DictionaryEvent) : void { }
            private function refreshView() : void { }
            private function textClickHandler(event:TextEvent) : void { }
            public function isEmpty() : Boolean { return false; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}