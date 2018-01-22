package flowerGiving.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingController;
   import flowerGiving.FlowerGivingManager;
   import flowerGiving.components.FlowerSendFrameItem;
   import flowerGiving.components.FlowerSendFrameNameInput;
   import flowerGiving.data.FlowerSendRecordInfo;
   import flowerGiving.events.FlowerSendRecordEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import shop.manager.ShopBuyManager;
   
   public class FlowerSendFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _sendBtnBg:ScaleBitmapImage;
      
      private var _leftBit:Bitmap;
      
      private var _rightBit:Bitmap;
      
      private var _sendRecordBtn:SimpleBitmapButton;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _numTxt:FilterFrameText;
      
      private var _otherNumTxt:FilterFrameText;
      
      private var _otherSelectBtn:SelectedCheckButton;
      
      private var _selectBtnGroup:SelectedButtonGroup;
      
      private var _sendBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _sendToOtherTxt:FilterFrameText;
      
      private var _itemArr:Array;
      
      private var _sendRecordFrame:Frame;
      
      private var _dataArr:Array;
      
      private var _myFlowerBagCell:BagCell;
      
      private var _maxNum:int;
      
      private var _nameInput:FlowerSendFrameNameInput;
      
      private var _dropList:DropList;
      
      public function FlowerSendFrame()
      {
         super();
         initView();
         initViewWithData();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemArr = [];
         _bg = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.FlowerSendFrame.scale9ImageBg");
         addToContent(_bg);
         _leftBit = ComponentFactory.Instance.creat("flowerGiving.flowerSendFrame.sendLeft");
         addToContent(_leftBit);
         _selectBtnGroup = new SelectedButtonGroup();
         _otherSelectBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.selectedBtn");
         addToContent(_otherSelectBtn);
         PositionUtils.setPos(_otherSelectBtn,"flowerGiving.flowerSendFrame.oselectBtnPos");
         _selectBtnGroup.addSelectItem(_otherSelectBtn);
         _rightBit = ComponentFactory.Instance.creat("flowerGiving.flowerSendFrame.sendRight");
         addToContent(_rightBit);
         _sendRecordBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendRecordBtn");
         addToContent(_sendRecordBtn);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.numTxt");
         _numTxt.restrict = "0-9";
         addToContent(_numTxt);
         _numTxt.text = "1";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.maxBtn");
         addToContent(_maxBtn);
         _otherNumTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendTxt");
         addToContent(_otherNumTxt);
         PositionUtils.setPos(_otherNumTxt,"flowerGiving.flowerSendFrame.otherNumPos");
         _otherNumTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.otherNumTxt");
         _sendBtnBg = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendBtnBackBg");
         addToContent(_sendBtnBg);
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendBtn");
         addToContent(_sendBtn);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.buyBtn");
         addToContent(_buyBtn);
         _nameInput = ComponentFactory.Instance.creatCustomObject("flowerGiving.FlowerSendFrame.nameInput");
         PositionUtils.setPos(_nameInput,"flowerGiving.flowerSendFrame.searchTxtPos");
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x - 63;
         _dropList.y = _nameInput.y + _nameInput.height;
         addToContent(_nameInput);
         _sendToOtherTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendToOtherTxt");
         addToContent(_sendToOtherTxt);
         _sendToOtherTxt.maxChars = 35;
         _sendToOtherTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.sendToOther");
      }
      
      private function initViewWithData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _dataArr = FlowerGivingController.instance.getDataByRewardMark(5);
         _loc3_ = 0;
         while(_loc3_ < _dataArr.length)
         {
            _loc2_ = new FlowerSendFrameItem(_dataArr[_loc3_]);
            PositionUtils.setPos(_loc2_,"flowerGiving.flowerSendFrame.itemPos" + (_loc3_ + 1));
            addToContent(_loc2_);
            _selectBtnGroup.addSelectItem(_loc2_.selectBtn);
            _itemArr.push(_loc2_);
            _loc3_++;
         }
         _selectBtnGroup.selectIndex = 0;
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _maxNum = _loc1_.getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell = createBagCell(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell.setCount(_maxNum);
         addToContent(_myFlowerBagCell);
         PositionUtils.setPos(_myFlowerBagCell,"flowerGiving.flowerSendFrame.myFlowerBagCell");
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
      
      protected function __hideDropList(param1:Event) : void
      {
         if(param1.target is FilterFrameText && param1.target != _numTxt && param1.target != _sendToOtherTxt)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _sendRecordBtn.removeEventListener("click",__recordHandler);
         _maxBtn.removeEventListener("click",__maxHandler);
         _numTxt.removeEventListener("change",__inputHandler);
         _selectBtnGroup.removeEventListener("change",__changeHandler);
         _sendBtn.removeEventListener("click",__sendHandler);
         _nameInput.removeEventListener("change",__onReceiverChange);
         _buyBtn.removeEventListener("click",__buyHandler);
         StageReferance.stage.removeEventListener("click",__hideDropList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,1),__giveHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,3),__getRecordHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(44),__flowerBuyHandler);
         FlowerGivingController.instance.removeEventListener("huiKuiFlower",_huiKuiHandler);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         _sendRecordBtn.addEventListener("click",__recordHandler);
         _maxBtn.addEventListener("click",__maxHandler);
         _numTxt.addEventListener("change",__inputHandler);
         _selectBtnGroup.addEventListener("change",__changeHandler);
         _sendBtn.addEventListener("click",__sendHandler);
         _nameInput.addEventListener("change",__onReceiverChange);
         StageReferance.stage.addEventListener("click",__hideDropList);
         _buyBtn.addEventListener("click",__buyHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,1),__giveHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,3),__getRecordHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(44),__flowerBuyHandler);
         FlowerGivingController.instance.addEventListener("huiKuiFlower",_huiKuiHandler);
      }
      
      protected function _huiKuiHandler(param1:FlowerSendRecordEvent) : void
      {
         _nameInput.text = param1.nickName;
         if(_sendRecordFrame)
         {
            _sendRecordFrame.dispose();
         }
      }
      
      protected function __flowerBuyHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _loc3_.position = 20;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = _loc3_.readInt();
         updateFlowerNum();
      }
      
      protected function __buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(FlowerGivingManager.instance.flowerTempleteId);
         ShopBuyManager.Instance.buy(_loc2_.GoodsID,_loc2_.isDiscount,_loc2_.getItemPrice(1).PriceType);
      }
      
      protected function __getRecordHandler(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Array = [];
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new FlowerSendRecordInfo();
            _loc5_.date = _loc4_.readUTF();
            _loc5_.selfId = _loc4_.readInt();
            _loc5_.playerId = _loc4_.readInt();
            _loc5_.nickName = _loc4_.readUTF();
            _loc5_.flag = _loc4_.readBoolean();
            _loc5_.num = _loc4_.readInt();
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         _sendRecordFrame = ComponentFactory.Instance.creatCustomObject("flowerGiving.FlowerSendRecordFrame",[_loc3_]);
         _sendRecordFrame.titleText = LanguageMgr.GetTranslation("flowerGiving.flowerSendRecordFrame.title");
         LayerManager.Instance.addToLayer(_sendRecordFrame,3,true,1);
      }
      
      protected function __giveHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         updateFlowerNum();
      }
      
      private function updateFlowerNum() : void
      {
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _maxNum = _loc1_.getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell.setCount(_maxNum);
      }
      
      protected function __sendHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:String = _nameInput.text;
         if(_loc4_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.nameInputTxt"));
            return;
         }
         if(_selectBtnGroup.selectIndex != 0)
         {
            _loc3_ = _dataArr[_selectBtnGroup.selectIndex - 1].giftConditionArr[0].conditionValue;
         }
         else
         {
            _loc3_ = _numTxt.text;
         }
         if(_loc3_ > _maxNum)
         {
            __buyHandler(null);
            return;
         }
         var _loc2_:String = _sendToOtherTxt.text;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
         SocketManager.Instance.out.sendFlower(_loc4_,_loc3_,_loc2_);
      }
      
      protected function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _itemArr;
         for each(var _loc2_ in _itemArr)
         {
            _loc2_.updateShine();
         }
      }
      
      protected function __inputHandler(param1:Event) : void
      {
         if(int(_numTxt.text) < 1)
         {
            _numTxt.text = "1";
         }
         else if(int(_numTxt.text) > _maxNum)
         {
            _numTxt.text = "" + _maxNum;
         }
      }
      
      protected function __maxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _maxNum = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _numTxt.text = _maxNum > 0?"" + _maxNum:"1";
      }
      
      protected function __recordHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendFlowerRecord();
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         _sendRecordFrame = null;
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _itemArr;
         for each(var _loc1_ in _itemArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemArr = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_sendBtnBg)
         {
            ObjectUtils.disposeObject(_sendBtnBg);
         }
         _sendBtnBg = null;
         if(_leftBit)
         {
            ObjectUtils.disposeObject(_leftBit);
         }
         _leftBit = null;
         if(_rightBit)
         {
            ObjectUtils.disposeObject(_rightBit);
         }
         _rightBit = null;
         if(_sendRecordBtn)
         {
            ObjectUtils.disposeObject(_sendRecordBtn);
         }
         _sendRecordBtn = null;
         if(_numTxt)
         {
            ObjectUtils.disposeObject(_numTxt);
         }
         _numTxt = null;
         if(_otherNumTxt)
         {
            ObjectUtils.disposeObject(_otherNumTxt);
         }
         _otherNumTxt = null;
         if(_maxBtn)
         {
            ObjectUtils.disposeObject(_maxBtn);
         }
         _maxBtn = null;
         if(_otherSelectBtn)
         {
            ObjectUtils.disposeObject(_otherSelectBtn);
         }
         _otherSelectBtn = null;
         if(_selectBtnGroup)
         {
            ObjectUtils.disposeObject(_selectBtnGroup);
         }
         _selectBtnGroup = null;
         if(_sendBtn)
         {
            ObjectUtils.disposeObject(_sendBtn);
         }
         _sendBtn = null;
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
         }
         _buyBtn = null;
         ObjectUtils.disposeObject(_dropList);
         _dropList = null;
         _nameInput = null;
         if(_sendToOtherTxt)
         {
            ObjectUtils.disposeObject(_sendToOtherTxt);
         }
         _sendToOtherTxt = null;
         if(_myFlowerBagCell)
         {
            ObjectUtils.disposeObject(_myFlowerBagCell);
         }
         _myFlowerBagCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
