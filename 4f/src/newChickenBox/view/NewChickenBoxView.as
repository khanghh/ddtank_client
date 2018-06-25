package newChickenBox.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import newChickenBox.data.NewChickenBoxGoodsTempInfo;   import newChickenBox.model.NewChickenBoxModel;      public class NewChickenBoxView extends Sprite implements Disposeable   {            private static const NUM:int = 18;                   private var _model:NewChickenBoxModel;            private var eyeItem:NewChickenBoxItem;            private var frame:BaseAlerFrame;            private var moveBackArr:Array;            public function NewChickenBoxView() { super(); }
            private function init() : void { }
            public function getAllItem() : void { }
            private function openAlertFrame(item:NewChickenBoxItem) : BaseAlerFrame { return null; }
            private function noAlertEable(e:MouseEvent) : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function openAlertFrame2(item:NewChickenBoxItem) : BaseAlerFrame { return null; }
            private function noAlertEable2(e:MouseEvent) : void { }
            private function __onResponse2(evt:FrameEvent) : void { }
            public function getItemEvent(item:NewChickenBoxItem) : void { }
            public function removeItemEvent(item:NewChickenBoxItem) : void { }
            public function tackoverCard(e:MouseEvent) : void { }
            private function getNum(num:int) : int { return 0; }
            public function updataAllItem() : void { }
            public function dispose() : void { }
   }}