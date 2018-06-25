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
      
      public function StrengthDarenItem(type:int, activityId:String, data:GiftBagInfo, giftcurInfo:GiftCurInfo, statusArr:Array)
      {
         super();
         _activityId = activityId;
         _data = data;
         _giftcurInfo = giftcurInfo;
         _strengthGrade = statusArr[0].statusValue;
         _statusArr = statusArr;
         initView(type);
      }
      
      private function initView(type:int = 1) : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.newListItem");
         addChild(_back);
         if(type == 1)
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
         var i:int = 0;
         var flag:Boolean = false;
         for(i = 0; i < _statusArr.length; )
         {
            if(_statusArr[i].statusID == _data.giftConditionArr[0].conditionValue)
            {
               flag = true;
               if(_statusArr[i].statusValue == 0)
               {
                  return true;
               }
            }
            i++;
         }
         if(!flag)
         {
            return true;
         }
         return false;
      }
      
      private function btnHandler(e:MouseEvent) : void
      {
         _btn.enable = false;
         addChild(_btn);
         SoundManager.instance.play("008");
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = _activityId;
         var giftIdArr:Array = [];
         giftIdArr.push(_data.giftbagId);
         sendInfo.giftIdArr = giftIdArr;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      private function initGoods() : void
      {
         var i:int = 0;
         var bagCell:* = null;
         var back:* = null;
         _goodContent = new Sprite();
         addChild(_goodContent);
         for(i = 0; i < _data.giftRewardArr.length; )
         {
            bagCell = createBagCell(0,_data.giftRewardArr[i]);
            back = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
            back.x = (back.width + 5) * i;
            bagCell.x = back.width / 2 - bagCell.width / 2 + back.x + 2;
            bagCell.y = back.height / 2 - bagCell.height / 2 + 1;
            _goodContent.addChild(back);
            _goodContent.addChild(bagCell);
            i++;
         }
         _goodContent.x = 142;
         _goodContent.y = 9;
      }
      
      private function createBagCell(order:int, gift:GiftRewardInfo) : BagCell
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = gift.templateId;
         info = ItemManager.fill(info);
         info.IsBinds = gift.isBind;
         info.ValidDate = gift.validDate;
         var attrArr:Array = gift.property.split(",");
         info.StrengthenLevel = parseInt(attrArr[0]);
         info.AttackCompose = parseInt(attrArr[1]);
         info.DefendCompose = parseInt(attrArr[2]);
         info.AgilityCompose = parseInt(attrArr[3]);
         info.LuckCompose = parseInt(attrArr[4]);
         if(EquipType.isMagicStone(info.CategoryID))
         {
            info.Level = info.StrengthenLevel;
            info.Attack = info.AttackCompose;
            info.Defence = info.DefendCompose;
            info.Agility = info.AgilityCompose;
            info.Luck = info.LuckCompose;
            info.MagicAttack = parseInt(attrArr[6]);
            info.MagicDefence = parseInt(attrArr[7]);
            info.StrengthenExp = parseInt(attrArr[8]);
         }
         var bagCell:BagCell = new BagCell(order);
         bagCell.info = info;
         bagCell.setCount(gift.count);
         bagCell.setBgVisible(false);
         return bagCell;
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
