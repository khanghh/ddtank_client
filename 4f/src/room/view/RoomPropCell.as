package room.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.horse.HorseSkillCell;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import horse.HorseManager;      public class RoomPropCell extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _container:HorseSkillCell;            protected var _skillId:int;            protected var _isself:Boolean;            protected var _place:int;            private var _xyz:FilterFrameText;            public function RoomPropCell(isself:Boolean, place:int, isHorse:Boolean = false) { super(); }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function set skillId(skillId:int) : void { }
            protected function __mouseClick(evt:MouseEvent) : void { }
            private function __mouseOver(evt:MouseEvent) : void { }
            private function __mouseOut(evt:MouseEvent) : void { }
            override public function get width() : Number { return 0; }
            public function dispose() : void { }
   }}