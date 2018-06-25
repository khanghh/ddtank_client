package vipCoupons.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   
   public class VIPCouponsFrame extends Frame
   {
       
      
      private var _contenBg:MutipleImage;
      
      private var _sendBtn:SimpleBitmapButton;
      
      private var _nameInput:VIPCouponsNameInput;
      
      private var _dropList:DropList;
      
      private var _sendToOtherTxt:FilterFrameText;
      
      private var _vipCell:BagCell;
      
      private var _bagType:int;
      
      private var _place:int;
      
      public function VIPCouponsFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function setVipPlace(bagType:int, place:int) : void
      {
         _bagType = bagType;
         _place = place;
      }
      
      public function get getSendButton() : SimpleBitmapButton
      {
         return _sendBtn;
      }
      
      public function get getnameInput() : VIPCouponsNameInput
      {
         return _nameInput;
      }
      
      public function get content() : FilterFrameText
      {
         return _sendToOtherTxt;
      }
      
      private function initView() : void
      {
         _contenBg = ComponentFactory.Instance.creatComponentByStylename("vipCoupons.mainPageBg");
         addToContent(_contenBg);
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("vipCoupons.sendBtn");
         addToContent(_sendBtn);
         _nameInput = ComponentFactory.Instance.creatCustomObject("vipCoupons.sendNameInput.friendList");
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x - 29;
         _dropList.y = _nameInput.y + _nameInput.height;
         addToContent(_nameInput);
         _sendToOtherTxt = ComponentFactory.Instance.creatComponentByStylename("vipCoupons.sendToOtherTxt");
         addToContent(_sendToOtherTxt);
         _sendToOtherTxt.maxChars = 100;
         _sendToOtherTxt.text = LanguageMgr.GetTranslation("game.vipCoupons.vipSendFrame.sendToOther");
         titleText = LanguageMgr.GetTranslation("game.vipCoupons.sendVip.titleTxt");
         var temId:int = 12568;
         _vipCell = createBagCell(temId);
         _vipCell.x = 46;
         _vipCell.y = 379;
         _vipCell.setCount(getItemCount(temId));
         addToContent(_vipCell);
      }
      
      private function getItemCount(temId:int) : int
      {
         return PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(temId);
      }
      
      private function createBagCell(templeteId:int) : BagCell
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templeteId;
         info = ItemManager.fill(info);
         info.IsBinds = true;
         var bagCell:BagCell = new BagCell(0);
         bagCell.info = info;
         bagCell.setBgVisible(false);
         return bagCell;
      }
      
      private function initEvent() : void
      {
         if(_nameInput)
         {
            _nameInput.addEventListener("change",__onReceiverChange);
         }
         StageReferance.stage.addEventListener("click",__hideDropList);
      }
      
      private function removeEvent() : void
      {
         if(_nameInput)
         {
            _nameInput.removeEventListener("change",__onReceiverChange);
         }
         StageReferance.stage.removeEventListener("click",__hideDropList);
      }
      
      protected function __hideDropList(event:Event) : void
      {
         if(event.target is FilterFrameText && event.target != _sendToOtherTxt)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      protected function __onReceiverChange(event:Event) : void
      {
         if(_nameInput.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var list:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterSearch(filterRepeatInArray(list),_nameInput.text);
      }
      
      private function filterRepeatInArray(filterArr:Array) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = [];
         for(i = 0; i < filterArr.length; )
         {
            if(i == 0)
            {
               arr.push(filterArr[i]);
            }
            j = 0;
            while(j < arr.length)
            {
               if(arr[j].NickName != filterArr[i].NickName)
               {
                  if(j == arr.length - 1)
                  {
                     arr.push(filterArr[i]);
                  }
                  j++;
                  continue;
               }
               break;
            }
            i++;
         }
         return arr;
      }
      
      private function filterSearch(list:Array, targetStr:String) : Array
      {
         var i:int = 0;
         var result:Array = [];
         for(i = 0; i < list.length; )
         {
            if(list[i].NickName.indexOf(targetStr) != -1)
            {
               result.push(list[i]);
            }
            i++;
         }
         return result;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_contenBg)
         {
            ObjectUtils.disposeObject(_contenBg);
         }
         _contenBg = null;
         if(_sendBtn)
         {
            ObjectUtils.disposeObject(_sendBtn);
         }
         _sendBtn = null;
         if(_vipCell)
         {
            ObjectUtils.disposeObject(_vipCell);
         }
         _vipCell = null;
         if(_sendToOtherTxt)
         {
            ObjectUtils.disposeObject(_sendToOtherTxt);
         }
         _sendToOtherTxt = null;
         if(_nameInput)
         {
            ObjectUtils.disposeObject(_nameInput);
         }
         _nameInput = null;
         if(_dropList)
         {
            _dropList.removeChildren();
         }
         _dropList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
