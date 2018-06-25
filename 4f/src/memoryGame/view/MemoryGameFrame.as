package memoryGame.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.events.Event;   import invite.InviteManager;   import memoryGame.MemoryGameManager;      public class MemoryGameFrame extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _selectedBtnsHBox:HBox;            private var _btnGroup:SelectedButtonGroup;            private var _gameBtn:SelectedButton;            private var _rewardsBtn:SelectedButton;            private var _gameView:MemoryGameView;            private var _shopView:MemoryGameShop;            private var _btnHelp:BaseButton;            public function MemoryGameFrame() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override protected function onResponse(type:int) : void { }
            public function show() : void { }
            private function __changeHandler(e:Event) : void { }
            public function shopViewUpdate() : void { }
            private function checkActivity() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}