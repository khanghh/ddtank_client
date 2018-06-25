package horse.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import horse.HorseManager;   import road7th.data.DictionaryData;   import room.view.RoomPropCell;      public class HorseSkillFrame extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _upCellsContainer:HBox;            private var _upCells:Vector.<RoomPropCell>;            private var _skillUpView:HorseSkillUpFrame;            public function HorseSkillFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function updateSkillStatus(event:Event) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}