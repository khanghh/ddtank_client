package wonderfulActivity.items{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import dayActivity.ActivityTypeData;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import firstRecharge.FirstRechargeManger;   import firstRecharge.data.RechargeData;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class RightListItem extends Sprite implements Disposeable   {                   private var _back:MovieClip;            private var _nameTxt:FilterFrameText;            private var _goodContent:Sprite;            private var _btn:SimpleBitmapButton;            private var _btnTxt:FilterFrameText;            private var _tipsBtn:Bitmap;            private var _data:ActivityTypeData;            public function RightListItem(type:int, data:ActivityTypeData) { super(); }
            public function getItemID() : int { return 0; }
            private function init(type:int, data:ActivityTypeData) : void { }
            public function getBtn() : SimpleBitmapButton { return null; }
            public function initBtnState(type:int = 1, num:int = 0) : void { }
            public function setBtnTxt(num:int) : void { }
            private function btnHandler(e:MouseEvent) : void { }
            private function initGoods(data:ActivityTypeData) : void { }
            private function clearBtn() : void { }
            public function dispose() : void { }
   }}