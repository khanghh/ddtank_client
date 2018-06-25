package dice.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import dice.controller.DiceController;   import dice.event.DiceEvent;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class DiceToolBar extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _currentCouponsCaption:Bitmap;            private var _currentCoupons:FilterFrameText;            private var _currentCouponsBG:Scale9CornerImage;            private var _refreshBtn:BaseButton;            private var _doubleRadio:SelectedButton;            private var _smallRadio:SelectedButton;            private var _bigRadio:SelectedButton;            private var _doubleText:Bitmap;            private var _bigText:Bitmap;            private var _smallText:Bitmap;            private var _baseAlert:BaseAlerFrame;            private var _selectCheckBtn:SelectedCheckButton;            private var _poorManAlert:BaseAlerFrame;            public function DiceToolBar() { super(); }
            private function preInitialize() : void { }
            private function Initialize() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __getDiceResultData(event:DiceEvent) : void { }
            private function __onPlayerState(event:DiceEvent) : void { }
            private function __onRefreshBtnClick(event:MouseEvent) : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
            private function AlertFeedeductionWindow() : void { }
            private function sendRefreshDataToServer() : void { }
            private function openAlertFrame() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function __onCheckBtnClick(event:MouseEvent) : void { }
            private function __changeMoney(event:PlayerPropertyEvent) : void { }
            private function __onSelectBtnClick(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}