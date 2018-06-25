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
         var i:int = 0;
         var flowerItem:* = null;
         _dataArr = FlowerGivingController.instance.getDataByRewardMark(5);
         for(i = 0; i < _dataArr.length; )
         {
            flowerItem = new FlowerSendFrameItem(_dataArr[i]);
            PositionUtils.setPos(flowerItem,"flowerGiving.flowerSendFrame.itemPos" + (i + 1));
            addToContent(flowerItem);
            _selectBtnGroup.addSelectItem(flowerItem.selectBtn);
            _itemArr.push(flowerItem);
            i++;
         }
         _selectBtnGroup.selectIndex = 0;
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _maxNum = bagInfo.getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell = createBagCell(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell.setCount(_maxNum);
         addToContent(_myFlowerBagCell);
         PositionUtils.setPos(_myFlowerBagCell,"flowerGiving.flowerSendFrame.myFlowerBagCell");
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
      
      protected function __hideDropList(event:Event) : void
      {
         if(event.target is FilterFrameText && event.target != _numTxt && event.target != _sendToOtherTxt)
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
      
      protected function _huiKuiHandler(event:FlowerSendRecordEvent) : void
      {
         _nameInput.text = event.nickName;
         if(_sendRecordFrame)
         {
            _sendRecordFrame.dispose();
         }
      }
      
      protected function __flowerBuyHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         pkg.position = 20;
         var successType:int = pkg.readInt();
         var buyFrom:int = pkg.readInt();
         updateFlowerNum();
      }
      
      protected function __buyHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _shopItemInfo:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(FlowerGivingManager.instance.flowerTempleteId);
         ShopBuyManager.Instance.buy(_shopItemInfo.GoodsID,_shopItemInfo.isDiscount,_shopItemInfo.getItemPrice(1).PriceType);
      }
      
      protected function __getRecordHandler(event:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var arr:Array = [];
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            info = new FlowerSendRecordInfo();
            info.date = pkg.readUTF();
            info.selfId = pkg.readInt();
            info.playerId = pkg.readInt();
            info.nickName = pkg.readUTF();
            info.flag = pkg.readBoolean();
            info.num = pkg.readInt();
            arr.push(info);
            i++;
         }
         _sendRecordFrame = ComponentFactory.Instance.creatCustomObject("flowerGiving.FlowerSendRecordFrame",[arr]);
         _sendRecordFrame.titleText = LanguageMgr.GetTranslation("flowerGiving.flowerSendRecordFrame.title");
         LayerManager.Instance.addToLayer(_sendRecordFrame,3,true,1);
      }
      
      protected function __giveHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var isSuccess:Boolean = pkg.readBoolean();
         updateFlowerNum();
      }
      
      private function updateFlowerNum() : void
      {
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _maxNum = bagInfo.getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _myFlowerBagCell.setCount(_maxNum);
      }
      
      protected function __sendHandler(event:MouseEvent) : void
      {
         var num:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var playerName:String = _nameInput.text;
         if(playerName == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.nameInputTxt"));
            return;
         }
         if(_selectBtnGroup.selectIndex != 0)
         {
            num = _dataArr[_selectBtnGroup.selectIndex - 1].giftConditionArr[0].conditionValue;
         }
         else
         {
            num = _numTxt.text;
         }
         if(num > _maxNum)
         {
            __buyHandler(null);
            return;
         }
         var text:String = _sendToOtherTxt.text;
         text = StringHelper.trim(text);
         text = FilterWordManager.filterWrod(text);
         text = StringHelper.rePlaceHtmlTextField(text);
         SocketManager.Instance.out.sendFlower(playerName,num,text);
      }
      
      protected function __changeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _itemArr;
         for each(var item in _itemArr)
         {
            item.updateShine();
         }
      }
      
      protected function __inputHandler(event:Event) : void
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
      
      protected function __maxHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _maxNum = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(FlowerGivingManager.instance.flowerTempleteId);
         _numTxt.text = _maxNum > 0?"" + _maxNum:"1";
      }
      
      protected function __recordHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendFlowerRecord();
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
         for each(var item in _itemArr)
         {
            ObjectUtils.disposeObject(item);
            item = null;
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
