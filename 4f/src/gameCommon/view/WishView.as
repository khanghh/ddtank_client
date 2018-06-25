package gameCommon.view{   import baglocked.BaglockedManager;   import com.greensock.TweenMax;   import com.greensock.easing.Elastic;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;      public class WishView extends Sprite implements Disposeable   {            public static const WISH_CLICK:String = "wishClick";                   private const MOVE_DISTANCE:int = 150;            private var _wishButtom:BaseButton;            private var _timesRecording:Number;            private var _text:FilterFrameText;            private var _self:LocalPlayer;            private var _level:int;            private var _isFirstWish:Boolean;            private var _textBg:ScaleBitmapImage;            private var _panelBtn:SelectedButton;            private var _useReduceEnerge:int;            private var _freeTimes:int;            public function WishView(info:LocalPlayer, pop:Boolean) { super(); }
            protected function addEvent() : void { }
            private function stateInit() : void { }
            protected function __transparentChanged(SharedEvent:Event) : void { }
            private function __movePanle(e:MouseEvent) : void { }
            protected function removeEvent() : void { }
            public function get freeTimes() : int { return 0; }
            public function set freeTimes(value:int) : void { }
            private function __playerChange(event:CrazyTankSocketEvent) : void { }
            private function __ennergChange(event:LivingEvent) : void { }
            protected function get needMoney() : Number { return 0; }
            protected function __wishBtnClick(event:MouseEvent) : void { }
            private function initPosition(isPop:Boolean) : void { }
            public function dispose() : void { }
   }}