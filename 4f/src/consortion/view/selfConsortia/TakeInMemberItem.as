package consortion.view.selfConsortia{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import consortion.data.ConsortiaApplyInfo;   import ddt.data.player.BasePlayer;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import flash.display.Sprite;   import flash.events.MouseEvent;   import vip.VipController;      public class TakeInMemberItem extends Sprite implements Disposeable   {                   public var FightPower:int;            public var Level:int;            private var _selected:Boolean;            private var _info:ConsortiaApplyInfo;            private var _nameSelect:SelectedCheckButton;            private var _name:FilterFrameText;            private var _nameForVip:GradientText;            private var _level:LevelIcon;            private var _power:FilterFrameText;            private var _check:TextButton;            private var _agree:TextButton;            private var _refuse:TextButton;            public function TakeInMemberItem() { super(); }
            override public function get height() : Number { return 0; }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set info(value:ConsortiaApplyInfo) : void { }
            public function get info() : ConsortiaApplyInfo { return null; }
            private function __selectHandler(event:MouseEvent) : void { }
            private function __checkHandler(event:MouseEvent) : void { }
            private function __agreeHandler(event:MouseEvent) : void { }
            private function __refuseHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}