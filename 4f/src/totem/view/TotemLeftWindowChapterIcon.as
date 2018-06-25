package totem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import totem.TotemControl;   import totem.TotemManager;   import totem.data.TotemChapterTipInfo;   import totem.data.TotemDataVo;      public class TotemLeftWindowChapterIcon extends Sprite implements Disposeable   {                   private var _iconList:Vector.<Bitmap>;            private var _iconSprite:Sprite;            private var _icon:Bitmap;            private var _upBtn:BaseButton;            private var _page:int;            private var _cell:TotemTabItemCell;            private var _isSelf:Boolean = false;            private var _fromType:int = -1;            private var _playerInfo:PlayerInfo;            public function TotemLeftWindowChapterIcon(page:int, playerInfo:PlayerInfo, fromType:int) { super(); }
            private function initView() : void { }
            private function get getQulity() : int { return 0; }
            public function updateQuality() : void { }
            public function set disable(value:Boolean) : void { }
            public function set upBtnVisble(value:Boolean) : void { }
            private function __upGradesHandler(evt:MouseEvent) : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            public function set tipData(info:TotemChapterTipInfo) : void { }
            public function get page() : int { return 0; }
            private function showTip(event:MouseEvent) : void { }
            private function hideTip(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}