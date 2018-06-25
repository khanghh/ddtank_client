package bagAndInfo.info{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.EffortManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;   import hall.event.NewHallEvent;   import newTitle.NewTitleManager;   import newTitle.event.NewTitleEvent;      public class PlayerInfoEffortHonorView extends Sprite implements Disposeable   {                   private var _nameChoose:ComboBox;            private var _honorArray:Array;            public function PlayerInfoEffortHonorView() { super(); }
            private function init() : void { }
            private function __propertyChange(event:PlayerPropertyEvent) : void { }
            private function __buttonClick(event:MouseEvent) : void { }
            private function update() : void { }
            private function __onSelectTitle(event:NewTitleEvent) : void { }
            public function setlist(honorArray:Array) : void { }
            public function dispose() : void { }
   }}