package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import consortion.ConsortionModelManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.NameInputDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GetFriendPackFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _checkOutViewBg:Image;
      
      private var _cellBg:Bitmap;
      
      protected var _comboBoxLabel:FilterFrameText;
      
      protected var _nameInput:NameInputDropListTarget;
      
      protected var _dropList:DropList;
      
      protected var _friendList:ChatFriendListPanel;
      
      private var _textAreaBg:Image;
      
      private var _textArea:TextArea;
      
      protected var _chooseFriendBtn:TextButton;
      
      private var _certainBtn:TextButton;
      
      private var _deselectBtn:TextButton;
      
      private var _awardCell:BagCell;
      
      protected var _cellNameLabel:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _bagType:int;
      
      private var _place:int;
      
      public function GetFriendPackFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("shop.view.present");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.PresentFrameBg1");
         addToContent(_bg);
         _checkOutViewBg = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.CheckOutViewBg");
         addToContent(_checkOutViewBg);
         _cellBg = ComponentFactory.Instance.creatBitmap("asset.getFriendPackFrame.cellBg1");
         addToContent(_cellBg);
         _comboBoxLabel = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.ComboBoxLabel");
         _comboBoxLabel.text = LanguageMgr.GetTranslation("shop.PresentFrame.ComboBoxLabel");
         addToContent(_comboBoxLabel);
         _nameInput = ComponentFactory.Instance.creatCustomObject("bag.getFriendPackFrame.nameInput");
         addToContent(_nameInput);
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x;
         _dropList.y = _nameInput.y + _nameInput.height;
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName,false);
         _textAreaBg = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.TextAreaBg");
         _textArea = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.PresentClearingTextArea");
         _textArea.maxChars = 100;
         addToContent(_textArea);
         _textArea.addChild(_textAreaBg);
         _chooseFriendBtn = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.ChooseFriendBtn");
         _chooseFriendBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.ChooseFriendButtonText");
         addToContent(_chooseFriendBtn);
         _certainBtn = ComponentFactory.Instance.creat("bag.getFriendPackFrame.certainBtn");
         _certainBtn.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_certainBtn);
         _deselectBtn = ComponentFactory.Instance.creat("bag.getFriendPackFrame.deselectBtn");
         _deselectBtn.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_deselectBtn);
         _awardCell = new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.getFriendPackFrame.cellBg2"));
         PositionUtils.setPos(_awardCell,"getFriendPackFrame.cellPos");
         addToContent(_awardCell);
         _cellNameLabel = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.cellNameLabel");
         addToContent(_cellNameLabel);
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame.tipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("bag.getFriendPackFrame.tipTxtMsg");
         addToContent(_tipTxt);
      }
      
      public function updateView(param1:ItemTemplateInfo, param2:int, param3:int) : void
      {
         _info = param1;
         _bagType = param2;
         _place = param3;
         var _loc4_:InventoryItemInfo = new InventoryItemInfo();
         _loc4_.TemplateID = _info.TemplateID;
         ItemManager.fill(_loc4_);
         _loc4_.IsBinds = true;
         _loc4_.MaxCount = 1;
         _loc4_.Count = 1;
         _awardCell.info = _loc4_;
         _cellNameLabel.text = _loc4_.Name;
      }
      
      private function addEvent() : void
      {
         _certainBtn.addEventListener("click",__certainBtnClick);
         _deselectBtn.addEventListener("click",__deselectBtnClick);
         addEventListener("response",__frameEventHandler);
         _nameInput.addEventListener("change",__onReceiverChange);
         _chooseFriendBtn.addEventListener("click",__showFramePanel);
         StageReferance.stage.addEventListener("click",__hideDropList);
      }
      
      protected function selectName(param1:String, param2:int = 0) : void
      {
         setName(param1);
         _friendList.setVisible = false;
      }
      
      public function setName(param1:String) : void
      {
         _nameInput.text = param1;
      }
      
      private function __certainBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:String = _nameInput.text;
         if(_loc2_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         if(_loc2_ == PlayerManager.Instance.Self.NickName)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bag.getFriendPackFrame.getSelfMsg"));
            return;
         }
         GameInSocketOut.sendGetFriendPack(_loc2_,_textArea.text,_bagType,_place);
         dispose();
      }
      
      private function __deselectBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.playButtonSound();
               dispose();
         }
      }
      
      protected function __hideDropList(param1:Event) : void
      {
         if(param1.target is FilterFrameText)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function __showFramePanel(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Point = _chooseFriendBtn.localToGlobal(new Point(0,0));
         _friendList.x = _loc2_.x - 95;
         _friendList.y = _loc2_.y + _chooseFriendBtn.height;
         _friendList.setVisible = true;
         LayerManager.Instance.addToLayer(_friendList,3);
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
      
      private function removeEvent() : void
      {
         if(_certainBtn)
         {
            _certainBtn.removeEventListener("click",__certainBtnClick);
         }
         if(_deselectBtn)
         {
            _deselectBtn.removeEventListener("click",__deselectBtnClick);
         }
         removeEventListener("response",__frameEventHandler);
         if(_nameInput)
         {
            _nameInput.removeEventListener("change",__onReceiverChange);
         }
         if(_chooseFriendBtn)
         {
            _chooseFriendBtn.removeEventListener("click",__showFramePanel);
         }
         StageReferance.stage.removeEventListener("click",__hideDropList);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         _cellBg = null;
         _certainBtn = null;
         _deselectBtn = null;
         _awardCell = null;
         _info = null;
         _comboBoxLabel = null;
         _nameInput = null;
         _dropList = null;
         _friendList = null;
         _textArea = null;
         _textAreaBg = null;
         _chooseFriendBtn = null;
         _cellNameLabel = null;
         _tipTxt = null;
         _checkOutViewBg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
