package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class StrengthDarenItem extends Sprite implements Disposeable
   {
       
      
      private var _back:MovieClip;
      
      private var _icon:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _goodContent:Sprite;
      
      private var _btn:SimpleBitmapButton;
      
      private var _data:GiftBagInfo;
      
      private var _giftcurInfo:GiftCurInfo;
      
      private var _strengthGrade:int;
      
      private var _statusArr:Array;
      
      private var _activityId:String;
      
      public function StrengthDarenItem(param1:int, param2:String, param3:GiftBagInfo, param4:GiftCurInfo, param5:Array)
      {
         super();
         _activityId = param2;
         _data = param3;
         _giftcurInfo = param4;
         _strengthGrade = param5[0].statusValue;
         _statusArr = param5;
         initView(param1);
      }
      
      private function initView(param1:int = 1) : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.newListItem");
         addChild(_back);
         if(param1 == 1)
         {
            _back.gotoAndStop(1);
         }
         else
         {
            _back.gotoAndStop(2);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.strength.nameTxt");
         addChild(_nameTxt);
         _nameTxt.text = LanguageMgr.GetTranslation("wonderfulActivity.strength.nameTxt",_data.giftConditionArr[0].conditionValue);
         _icon = ComponentFactory.Instance.creat("wonderfulactivity.strength" + _data.giftConditionArr[0].conditionValue);
         addChild(_icon);
         _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
         PositionUtils.setPos(_icon,"wonderful.strengthdaren.iconPos");
         if(_strengthGrade < _data.giftConditionArr[0].conditionValue || checkBtnState())
         {
            _btn.enable = false;
         }
         else
         {
            _btn.enable = true;
         }
         addChild(_btn);
         _btn.addEventListener("click",btnHandler);
         initGoods();
      }
      
      private function checkBtnState() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _statusArr.length)
         {
            if(_statusArr[_loc2_].statusID == _data.giftConditionArr[0].conditionValue)
            {
               _loc1_ = true;
               if(_statusArr[_loc2_].statusValue == 0)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         if(!_loc1_)
         {
            return true;
         }
         return false;
      }
      
      private function btnHandler(param1:MouseEvent) : void
      {
         _btn.enable = false;
         addChild(_btn);
         SoundManager.instance.play("008");
         var _loc4_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc2_:SendGiftInfo = new SendGiftInfo();
         _loc2_.activityId = _activityId;
         var _loc3_:Array = [];
         _loc3_.push(_data.giftbagId);
         _loc2_.giftIdArr = _loc3_;
         _loc4_.push(_loc2_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc4_);
      }
      
      private function initGoods() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _goodContent = new Sprite();
         addChild(_goodContent);
         _loc3_ = 0;
         while(_loc3_ < _data.giftRewardArr.length)
         {
            _loc1_ = createBagCell(0,_data.giftRewardArr[_loc3_]);
            _loc2_ = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
            _loc2_.x = (_loc2_.width + 5) * _loc3_;
            _loc1_.x = _loc2_.width / 2 - _loc1_.width / 2 + _loc2_.x + 2;
            _loc1_.y = _loc2_.height / 2 - _loc1_.height / 2 + 1;
            _goodContent.addChild(_loc2_);
            _goodContent.addChild(_loc1_);
            _loc3_++;
         }
         _goodContent.x = 142;
         _goodContent.y = 9;
      }
      
      private function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell
      {
         var _loc5_:InventoryItemInfo = new InventoryItemInfo();
         _loc5_.TemplateID = param2.templateId;
         _loc5_ = ItemManager.fill(_loc5_);
         _loc5_.IsBinds = param2.isBind;
         _loc5_.ValidDate = param2.validDate;
         var _loc4_:Array = param2.property.split(",");
         _loc5_.StrengthenLevel = parseInt(_loc4_[0]);
         _loc5_.AttackCompose = parseInt(_loc4_[1]);
         _loc5_.DefendCompose = parseInt(_loc4_[2]);
         _loc5_.AgilityCompose = parseInt(_loc4_[3]);
         _loc5_.LuckCompose = parseInt(_loc4_[4]);
         if(EquipType.isMagicStone(_loc5_.CategoryID))
         {
            _loc5_.Level = _loc5_.StrengthenLevel;
            _loc5_.Attack = _loc5_.AttackCompose;
            _loc5_.Defence = _loc5_.DefendCompose;
            _loc5_.Agility = _loc5_.AgilityCompose;
            _loc5_.Luck = _loc5_.LuckCompose;
            _loc5_.MagicAttack = parseInt(_loc4_[6]);
            _loc5_.MagicDefence = parseInt(_loc4_[7]);
            _loc5_.StrengthenExp = parseInt(_loc4_[8]);
         }
         var _loc3_:BagCell = new BagCell(param1);
         _loc3_.info = _loc5_;
         _loc3_.setCount(param2.count);
         _loc3_.setBgVisible(false);
         return _loc3_;
      }
      
      public function dispose() : void
      {
         _btn.removeEventListener("click",btnHandler);
         while(_goodContent.numChildren)
         {
            ObjectUtils.disposeObject(_goodContent.getChildAt(0));
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
         _goodContent = null;
         _back = null;
         _nameTxt = null;
         _btn = null;
         _icon = null;
      }
   }
}
