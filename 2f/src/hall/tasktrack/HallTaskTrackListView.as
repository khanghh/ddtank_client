package hall.tasktrack{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestCategory;   import ddt.data.quest.QuestInfo;   import ddt.events.CEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import quest.TaskManager;   import road7th.data.DictionaryData;   import trainer.view.NewHandContainer;      public class HallTaskTrackListView extends Sprite implements Disposeable   {                   private var _list:ListPanel;            private var _questData:DictionaryData;            private var _pointDownArrow:MovieClip;            public function HallTaskTrackListView() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function refreshViewPet(e:CEvent) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function refreshView(event:Event = null) : void { }
            public function isNoMainTask() : Boolean { return false; }
            public function isEmpty() : Boolean { return false; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}