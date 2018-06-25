package church.view.churchFire{   import church.controller.ChurchRoomController;   import church.events.WeddingRoomEvent;   import church.model.ChurchRoomModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ChurchFireView extends Sprite implements Disposeable   {            public static const FIRE_USE_GOLD:int = 200;                   private var _controller:ChurchRoomController;            private var _model:ChurchRoomModel;            private var _fireBg:Bitmap;            private var _fireClose:BaseButton;            private var _fireGlodLabel:FilterFrameText;            private var _fireGlod:FilterFrameText;            private var _fireGoldIcon:Bitmap;            private var _fireIcon21002:Bitmap;            private var _fireIcon21006:Bitmap;            private var All_Fires:Array;            private var All_FireIcons:Array;            private var _fireListBox:HBox;            private var _fireUseGold:int;            private var _fireListFilter:Array;            private var _alert:BaseAlerFrame;            public function ChurchFireView(controller:ChurchRoomController, model:ChurchRoomModel) { super(); }
            private function initialize() : void { }
            private function setView() : void { }
            private function removeView() : void { }
            private function setEvent() : void { }
            private function removeEvent() : void { }
            private function getFireList() : void { }
            private function itemClickHandler(e:MouseEvent) : void { }
            private function _responseV(event:FrameEvent) : void { }
            private function okFastPurchaseGold() : void { }
            private function updateGold(evt:PlayerPropertyEvent) : void { }
            private function fireEnableChange(e:WeddingRoomEvent) : void { }
            private function setButtnEnable(obj:Sprite, value:Boolean) : void { }
            private function onCloseClick(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}