package farm.view.compose{   import baglocked.BaglockedManager;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.control.FarmComposeHouseController;   import farm.view.compose.event.SelectComposeItemEvent;   import farm.view.compose.item.ComposeItem;   import farm.view.compose.item.ComposeMoveScroll;   import farm.view.compose.vo.FoodComposeListTemplateInfo;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import petsBag.PetsBagManager;   import shop.view.ShopItemCell;      public class FarmComposePnl extends Sprite implements Disposeable   {                   private var _selectComposeBtn:BaseButton;            private var _composeActionBtn:SimpleBitmapButton;            private var _itemComposeVec:Vector.<ComposeItem>;            private var _composeScroll:ComposeMoveScroll;            private var _bg1:DisplayObject;            private var _bg2:DisplayObject;            private var _maxCount:int = -1;            private var _foodID:int;            private var _selectComposeBtnShine:IEffect;            private var _result:ShopItemCell;            private var _configmPnl:ConfirmComposeAlertFrame;            private var _confirmComposeFoodAlertFrame:ConfirmComposeFoodAlertFrame;            public function FarmComposePnl() { super(); }
            private function initView() : void { }
            private function upComposeBtn() : void { }
            private function setCellInfo(index:int, info:ItemTemplateInfo, detail:int = 1) : void { }
            private function initEvent() : void { }
            protected function __bagUpdate(event:Event) : void { }
            private function __showComfigCompose(e:MouseEvent) : void { }
            private function __showConfirmComposeFoodAlertFrame(e:MouseEvent) : void { }
            private function closeConfirmComposeFoodAlertFrame() : void { }
            private function __confirmComposeFoodAlertFrameResponse(event:FrameEvent) : void { }
            private function __selectFood(e:SelectComposeItemEvent) : void { }
            private function __configmCount(event:SelectComposeItemEvent) : void { }
            public function clearInfo() : void { }
            private function stopSelectComposeBtnShine() : void { }
            private function playSelectComposeBtnShine() : void { }
            private function __onMouseDown(e:MouseEvent) : void { }
            private function __onMouseRollover(e:MouseEvent) : void { }
            private function __onMouseRollout(e:MouseEvent) : void { }
            private function update() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}