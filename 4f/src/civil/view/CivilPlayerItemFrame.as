package civil.view{   import civil.CivilEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.CivilPlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import flash.display.Sprite;   import flash.events.MouseEvent;   import vip.VipController;      public class CivilPlayerItemFrame extends Sprite implements Disposeable   {                   private var _info:CivilPlayerInfo;            private var _level:int = 1;            private var _levelIcon:LevelIcon;            private var _isSelect:Boolean;            private var _selectEffect:Scale9CornerImage;            private var _nameTxt:FilterFrameText;            private var _vipName:GradientText;            private var _stateIcon:ScaleFrameImage;            private var _bg:ScaleFrameImage;            private var _line1:ScaleBitmapImage;            private var _line2:ScaleBitmapImage;            private var _selected:Boolean = false;            private var _index:int;            private var _attestBtn:ScaleFrameImage;            public function CivilPlayerItemFrame(index:int) { super(); }
            private function init() : void { }
            public function set info(info:CivilPlayerInfo) : void { }
            public function get info() : CivilPlayerInfo { return null; }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __offerChange(evt:PlayerPropertyEvent) : void { }
            private function __clickHandle(e:MouseEvent) : void { }
            private function __overHandle(e:MouseEvent) : void { }
            private function __outHandle(e:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(val:Boolean) : void { }
            private function upView() : void { }
            private function creatAttestBtn() : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}