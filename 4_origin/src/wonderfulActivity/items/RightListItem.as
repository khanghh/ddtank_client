package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityTypeData;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.data.RechargeData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class RightListItem extends Sprite implements Disposeable
   {
       
      
      private var _back:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _goodContent:Sprite;
      
      private var _btn:SimpleBitmapButton;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _data:ActivityTypeData;
      
      public function RightListItem(param1:int, param2:ActivityTypeData)
      {
         super();
         _data = param2;
         init(param1,param2);
      }
      
      public function getItemID() : int
      {
         return _data.ID;
      }
      
      private function init(param1:int, param2:ActivityTypeData) : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.listItem");
         addChild(_back);
         if(param1 == 1)
         {
            _back.gotoAndStop(1);
         }
         else
         {
            _back.gotoAndStop(2);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.nameTxt");
         addChild(_nameTxt);
         _nameTxt.text = param2.Description.replace(/\{\d+\}/,param2.Condition);
         _nameTxt.y = _back.height / 2 - _nameTxt.height / 2;
         initGoods(param2);
      }
      
      public function getBtn() : SimpleBitmapButton
      {
         return _btn;
      }
      
      public function initBtnState(param1:int = 1, param2:int = 0) : void
      {
         clearBtn();
         if(param1 == 0)
         {
            if(_data.RegetType == 0)
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
               addChild(_btn);
               _btnTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.btnTxt");
               _btn.addChild(_btnTxt);
               _tipsBtn = ComponentFactory.Instance.creat("wonderfulactivity.can.repeat");
               _btn.addChild(_tipsBtn);
            }
            else
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.overBtn");
               addChild(_btn);
            }
            return;
         }
         if(_data.RegetType == 0)
         {
            if(param2 == 0)
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
            }
            else
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.smallGetBtn");
            }
            _btnTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.btnTxt");
            _btn.addChild(_btnTxt);
            _tipsBtn = ComponentFactory.Instance.creat("wonderfulactivity.can.repeat");
            _btn.addChild(_tipsBtn);
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
         }
         addChild(_btn);
         _btn.addEventListener("click",btnHandler);
      }
      
      public function setBtnTxt(param1:int) : void
      {
         if(_btnTxt)
         {
            _btnTxt.text = "(" + param1 + ")";
         }
      }
      
      private function btnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendWonderfulActivity(1,_data.ID);
      }
      
      private function initGoods(param1:ActivityTypeData) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         _goodContent = new Sprite();
         addChild(_goodContent);
         var _loc5_:Vector.<RechargeData> = FirstRechargeManger.Instance.getGoodsList();
         var _loc6_:int = _loc5_.length;
         var _loc2_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(param1.ID == _loc5_[_loc8_].RewardID)
            {
               _loc3_ = new BagCell(0);
               _loc4_ = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
               addChild(_loc4_);
               _loc7_ = new InventoryItemInfo();
               _loc7_.TemplateID = _loc5_[_loc8_].RewardItemID;
               _loc7_ = ItemManager.fill(_loc7_);
               _loc7_.IsBinds = _loc5_[_loc8_].IsBind;
               _loc7_.ValidDate = _loc5_[_loc8_].RewardItemValid;
               _loc7_.StrengthenLevel = _loc5_[_loc8_].StrengthenLevel;
               _loc7_.AttackCompose = _loc5_[_loc8_].AttackCompose;
               _loc7_.DefendCompose = _loc5_[_loc8_].DefendCompose;
               _loc7_.AgilityCompose = _loc5_[_loc8_].AgilityCompose;
               _loc7_.LuckCompose = _loc5_[_loc8_].LuckCompose;
               _loc3_.info = _loc7_;
               _loc3_.setBgVisible(false);
               _loc3_.setCount(_loc5_[_loc8_].RewardItemCount);
               _loc4_.x = (_loc4_.width + 5) * _loc2_;
               _loc3_.x = _loc4_.width / 2 - _loc3_.width / 2 + _loc4_.x + 2;
               _loc3_.y = _loc4_.height / 2 - _loc3_.height / 2 + 1;
               _goodContent.addChild(_loc4_);
               _goodContent.addChild(_loc3_);
               _loc2_++;
            }
            _loc8_++;
         }
         _goodContent.x = 142;
         _goodContent.y = 11;
      }
      
      private function clearBtn() : void
      {
         if(!_btn)
         {
            return;
         }
         while(_btn.numChildren)
         {
            ObjectUtils.disposeObject(_btn.getChildAt(0));
         }
         _btn = null;
      }
      
      public function dispose() : void
      {
         while(_goodContent.numChildren)
         {
            ObjectUtils.disposeObject(_goodContent.getChildAt(0));
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _goodContent = null;
         _back = null;
         _nameTxt = null;
         _btn = null;
         _btnTxt = null;
         _tipsBtn = null;
      }
   }
}
