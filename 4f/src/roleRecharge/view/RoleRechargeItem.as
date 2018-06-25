package roleRecharge.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import roleRecharge.RoleRechargeMgr;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.data.GiftCurInfo;   import wonderfulActivity.data.GiftRewardInfo;   import wonderfulActivity.data.PlayerCurInfo;   import wonderfulActivity.data.SendGiftInfo;      public class RoleRechargeItem extends Sprite   {                   private var _btn:BaseButton;            private var _goodItemContainerAll:Sprite;            private var _moneyTxt:FilterFrameText;            private var giftInfo:GiftBagInfo;            private var _money:int;            private var _index:int;            private var condition:int;            public function RoleRechargeItem($money:int, $index:int) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function setGetBtnEnalbe($flag:*) : void { }
            public function setGoods(info:GiftBagInfo) : void { }
            public function setStatus(statusArr:Array, giftStatusDic:Dictionary) : void { }
            private function getRewardBtnClick(e:MouseEvent) : void { }
            private function clearBtn() : void { }
            public function dispose() : void { }
   }}