package roleRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import roleRecharge.RoleRechargeMgr;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class RoleRechargeItem extends Sprite
   {
       
      
      private var _btn:BaseButton;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _moneyTxt:FilterFrameText;
      
      private var giftInfo:GiftBagInfo;
      
      private var _money:int;
      
      private var _index:int;
      
      private var condition:int;
      
      public function RoleRechargeItem(param1:int, param2:int)
      {
         super();
         _money = param1;
         _index = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeItem.moneyTxt");
         _moneyTxt.text = LanguageMgr.GetTranslation("RoleRechargeItem.moneyL",_money);
         addChild(_moneyTxt);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",getRewardBtnClick);
         }
      }
      
      public function setGetBtnEnalbe(param1:*) : void
      {
         _btn.enable = param1;
      }
      
      public function setGoods(param1:GiftBagInfo) : void
      {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc3_:Number = NaN;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         giftInfo = param1;
         condition = _money;
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         _goodItemContainerAll = new Sprite();
         _goodItemContainerAll.x = 128;
         _goodItemContainerAll.y = -18;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = giftInfo.giftRewardArr;
         for each(var _loc5_ in giftInfo.giftRewardArr)
         {
            _loc9_ = _loc5_.property.split(",");
            _loc8_ = ComponentFactory.Instance.creatBitmap("roleRecharge.item");
            _loc3_ = _loc8_.width + 5;
            _loc3_ = _loc3_ * (int(_loc6_ % 5));
            _loc8_.x = _loc3_;
            _loc8_.y = 20;
            _loc7_ = ItemManager.Instance.getTemplateById(_loc5_.templateId) as ItemTemplateInfo;
            _loc2_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc2_,_loc7_);
            _loc2_.StrengthenLevel = _loc9_[0];
            _loc2_.AttackCompose = _loc9_[1];
            _loc2_.DefendCompose = _loc9_[2];
            _loc2_.AgilityCompose = _loc9_[3];
            _loc2_.LuckCompose = _loc9_[4];
            _loc2_.MagicAttack = _loc9_[6];
            _loc2_.MagicDefence = _loc9_[7];
            _loc2_.ValidDate = _loc5_.validDate;
            _loc2_.IsBinds = _loc5_.isBind;
            _loc2_.Count = _loc5_.count;
            _loc4_ = new BagCell(0,_loc2_,false);
            _loc4_.x = _loc3_ + 2;
            _loc4_.y = 23;
            _loc4_.setBgVisible(false);
            _goodItemContainerAll.addChild(_loc8_);
            _goodItemContainerAll.addChild(_loc4_);
            _loc6_++;
         }
         addChild(_goodItemContainerAll);
      }
      
      public function setStatus(param1:Array, param2:Dictionary) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         clearBtn();
         var _loc3_:int = (param2[giftInfo.giftbagId] as GiftCurInfo).times;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc5_ in param1)
         {
            if(_loc5_.statusID == condition)
            {
               _loc4_ = _loc5_.statusValue - _loc3_;
            }
         }
         if(_loc3_ == 0)
         {
            _btn = ComponentFactory.Instance.creat("RoleRechargeItem.getBtn");
            addChild(_btn);
            _btn.enable = false;
            if(_loc4_ > 0)
            {
               _btn.enable = true;
               _btn.addEventListener("click",getRewardBtnClick);
            }
         }
         else
         {
            _btn = ComponentFactory.Instance.creat("RoleRechargeItem.getBtn");
            _btn.enable = false;
            addChild(_btn);
         }
      }
      
      private function getRewardBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SendGiftInfo = new SendGiftInfo();
         _loc5_.activityId = RoleRechargeMgr.instance.model.actId;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < giftInfo.giftRewardArr.length)
         {
            _loc2_[_loc4_] = giftInfo.giftbagId;
            _loc4_++;
         }
         _loc5_.giftIdArr = _loc2_;
         var _loc3_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         _loc3_.push(_loc5_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc3_);
         setGetBtnEnalbe(false);
      }
      
      private function clearBtn() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
      }
   }
}
