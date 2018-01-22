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
      
      public function setVipPlace(param1:int, param2:int) : void
      {
         _bagType = param1;
         _place = param2;
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
         var _loc1_:int = 12568;
         _vipCell = createBagCell(_loc1_);
         _vipCell.x = 46;
         _vipCell.y = 379;
         _vipCell.setCount(getItemCount(_loc1_));
         addToContent(_vipCell);
      }
      
      private function getItemCount(param1:int) : int
      {
         return PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(param1);
      }
      
      private function createBagCell(param1:int) : BagCell
      {
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = param1;
         _loc3_ = ItemManager.fill(_loc3_);
         _loc3_.IsBinds = true;
         var _loc2_:BagCell = new BagCell(0);
         _loc2_.info = _loc3_;
         _loc2_.setBgVisible(false);
         return _loc2_;
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
      
      protected function __hideDropList(param1:Event) : void
      {
         if(param1.target is FilterFrameText && param1.target != _sendToOtherTxt)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      protected function __onReceiverChange(param1:Event) : void
      {
         if(_nameInput.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var _loc2_:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterSearch(filterRepeatInArray(_loc2_),_nameInput.text);
      }
      
      private function filterRepeatInArray(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(_loc4_ == 0)
            {
               _loc2_.push(param1[_loc4_]);
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].NickName != param1[_loc4_].NickName)
               {
                  if(_loc3_ == _loc2_.length - 1)
                  {
                     _loc2_.push(param1[_loc4_]);
                  }
                  _loc3_++;
                  continue;
               }
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function filterSearch(param1:Array, param2:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].NickName.indexOf(param2) != -1)
            {
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
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
