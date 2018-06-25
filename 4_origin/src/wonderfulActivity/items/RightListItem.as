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
      
      public function RightListItem(type:int, data:ActivityTypeData)
      {
         super();
         _data = data;
         init(type,data);
      }
      
      public function getItemID() : int
      {
         return _data.ID;
      }
      
      private function init(type:int, data:ActivityTypeData) : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.listItem");
         addChild(_back);
         if(type == 1)
         {
            _back.gotoAndStop(1);
         }
         else
         {
            _back.gotoAndStop(2);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.nameTxt");
         addChild(_nameTxt);
         _nameTxt.text = data.Description.replace(/\{\d+\}/,data.Condition);
         _nameTxt.y = _back.height / 2 - _nameTxt.height / 2;
         initGoods(data);
      }
      
      public function getBtn() : SimpleBitmapButton
      {
         return _btn;
      }
      
      public function initBtnState(type:int = 1, num:int = 0) : void
      {
         clearBtn();
         if(type == 0)
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
            if(num == 0)
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
      
      public function setBtnTxt(num:int) : void
      {
         if(_btnTxt)
         {
            _btnTxt.text = "(" + num + ")";
         }
      }
      
      private function btnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendWonderfulActivity(1,_data.ID);
      }
      
      private function initGoods(data:ActivityTypeData) : void
      {
         var i:int = 0;
         var cell:* = null;
         var back:* = null;
         var info:* = null;
         _goodContent = new Sprite();
         addChild(_goodContent);
         var list:Vector.<RechargeData> = FirstRechargeManger.Instance.getGoodsList();
         var len:int = list.length;
         var index:int = 0;
         for(i = 0; i < len; )
         {
            if(data.ID == list[i].RewardID)
            {
               cell = new BagCell(0);
               back = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
               addChild(back);
               info = new InventoryItemInfo();
               info.TemplateID = list[i].RewardItemID;
               info = ItemManager.fill(info);
               info.IsBinds = list[i].IsBind;
               info.ValidDate = list[i].RewardItemValid;
               info.StrengthenLevel = list[i].StrengthenLevel;
               info.AttackCompose = list[i].AttackCompose;
               info.DefendCompose = list[i].DefendCompose;
               info.AgilityCompose = list[i].AgilityCompose;
               info.LuckCompose = list[i].LuckCompose;
               cell.info = info;
               cell.setBgVisible(false);
               cell.setCount(list[i].RewardItemCount);
               back.x = (back.width + 5) * index;
               cell.x = back.width / 2 - cell.width / 2 + back.x + 2;
               cell.y = back.height / 2 - cell.height / 2 + 1;
               _goodContent.addChild(back);
               _goodContent.addChild(cell);
               index++;
            }
            i++;
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
