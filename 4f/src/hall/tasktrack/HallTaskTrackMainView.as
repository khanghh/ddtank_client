package hall.tasktrack{   import com.greensock.TweenLite;   import com.pickgliss.layout.StageResizeUtils;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import quest.TaskManager;      public class HallTaskTrackMainView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _bg2:Bitmap;            private var _taskBtn:SimpleBitmapButton;            private var _moveInBtn:SimpleBitmapButton;            private var _moveOutBtn:SimpleBitmapButton;            private var _btnGroup:SelectedButtonGroup;            private var _curTaskBtn:SelectedButton;            private var _canGetBtn:SelectedButton;            private var _listView:HallTaskTrackListView;            private var _canGetListView:HallTaskCanGetListView;            private const moveOutDistance:int = -1;            private const moveInDistance:int = 199;            private var m_width:Number = 200;            public function HallTaskTrackMainView(npcBtn:BaseButton) { super(); }
            public function judgeSelectShow(event:Event) : void { }
            private function initView(npcBtn:BaseButton) : void { }
            private function initEvent() : void { }
            private function __changeHandler(event:Event) : void { }
            private function __soundPlay(event:MouseEvent) : void { }
            private function taskClickHandler(event:MouseEvent) : void { }
            public function moveInClickHandler(event:MouseEvent) : void { }
            public function moveOutClickHandler(event:MouseEvent) : void { }
            public function moveInComplete() : void { }
            private function moveOutComplete() : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}