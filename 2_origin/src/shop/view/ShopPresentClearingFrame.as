package shop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.NameInputDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ShopPresentClearingFrame extends Frame
   {
      
      public static const GIVETYPE:int = 0;
      
      public static const FPAYTYPE_LIHUN:int = 1;
      
      public static const FPAYTYPE_SHOP:int = 2;
      
      public static const FPAYTYPE_PAIMAI:int = 3;
       
      
      protected var _titleTxt:FilterFrameText;
      
      protected var _descriptTxt:FilterFrameText;
      
      protected var _type:int;
      
      protected var _BG:Image;
      
      protected var _BG1:ScaleBitmapImage;
      
      private var _textAreaBg:Image;
      
      protected var _comboBoxLabel:FilterFrameText;
      
      protected var _chooseFriendBtn:TextButton;
      
      protected var _nameInput:NameInputDropListTarget;
      
      protected var _dropList:DropList;
      
      protected var _friendList:ChatFriendListPanel;
      
      protected var _cancelBtn:TextButton;
      
      protected var _okBtn:TextButton;
      
      private var _textArea:TextArea;
      
      private var _selectPlayerId:int = -1;
      
      public function ShopPresentClearingFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get titleTxt() : FilterFrameText
      {
         return _titleTxt;
      }
      
      public function get nameInput() : NameInputDropListTarget
      {
         return _nameInput;
      }
      
      public function get presentBtn() : BaseButton
      {
         return _okBtn;
      }
      
      public function get textArea() : TextArea
      {
         return _textArea;
      }
      
      public function get selectPlayerId() : int
      {
         return _selectPlayerId;
      }
      
      public function setType(param1:int = 0) : void
      {
         _type = param1;
         if(_type == 0)
         {
            this.titleText = LanguageMgr.GetTranslation("shop.view.present");
            _comboBoxLabel.text = LanguageMgr.GetTranslation("shop.PresentFrame.ComboBoxLabel");
            _friendList.setup(selectName,true);
         }
         else if(_type == 1)
         {
            this.titleText = LanguageMgr.GetTranslation("shop.view.friendPay");
            _descriptTxt.text = LanguageMgr.GetTranslation("shop.ShopIIPresentView.askunwedding");
            _friendList.setup(selectName,false);
            _comboBoxLabel.text = "";
            _titleTxt.text = "";
         }
         else if(_type == 2)
         {
            this.titleText = LanguageMgr.GetTranslation("shop.view.friendPay");
            _descriptTxt.text = LanguageMgr.GetTranslation("shop.ShopIIPresentView.askpay");
            _comboBoxLabel.text = "";
            _titleTxt.text = "";
            _friendList.setup(selectName,true);
         }
         else if(_type == 3)
         {
            this.titleText = LanguageMgr.GetTranslation("shop.view.friendPay");
            _descriptTxt.text = LanguageMgr.GetTranslation("shop.ShopIIPresentView.askpay");
            _comboBoxLabel.text = "";
            _titleTxt.text = "";
            _friendList.setup(selectName,true);
         }
      }
      
      protected function initView() : void
      {
         escEnable = true;
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PresentFrame.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("shop.PresentFrame.titleText");
         _descriptTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.decriptTxt");
         addToContent(_descriptTxt);
         _BG = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrameBg1");
         _comboBoxLabel = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.ComboBoxLabel");
         _comboBoxLabel.text = LanguageMgr.GetTranslation("shop.PresentFrame.ComboBoxLabel");
         _chooseFriendBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.ChooseFriendBtn");
         _chooseFriendBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.ChooseFriendButtonText");
         _nameInput = ComponentFactory.Instance.creatCustomObject("ddtshop.ClearingInterface.nameInput");
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x;
         _dropList.y = _nameInput.y + _nameInput.height;
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName,false);
         _textArea = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PresentClearingTextArea");
         _textArea.maxChars = 200;
         _textAreaBg = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.TextAreaBg");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.CancelBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.OkBtn");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         addToContent(_titleTxt);
         addToContent(_BG);
         addToContent(_comboBoxLabel);
         addToContent(_chooseFriendBtn);
         addToContent(_nameInput);
         addToContent(_textArea);
         _textArea.addChild(_textAreaBg);
         addToContent(_cancelBtn);
         addToContent(_okBtn);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function onlyFriendSelectView() : void
      {
         _BG.height = _BG.height - 172;
         _BG.y = _BG.y + 2;
         _textArea.visible = false;
         _cancelBtn.y = _cancelBtn.y - 172;
         _okBtn.y = _okBtn.y - 172;
         this.height = this.height - 172;
      }
      
      protected function selectName(param1:String, param2:int = 0) : void
      {
         _selectPlayerId = param2;
         setName(param1);
         _friendList.setVisible = false;
      }
      
      public function setName(param1:String) : void
      {
         _nameInput.text = param1;
      }
      
      public function get Name() : String
      {
         return _nameInput.text;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _nameInput.addEventListener("change",__onReceiverChange);
         _chooseFriendBtn.addEventListener("click",__showFramePanel);
         _cancelBtn.addEventListener("click",__cancelPresent);
         StageReferance.stage.addEventListener("click",__hideDropList);
      }
      
      private function __cancelPresent(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new FrameEvent(4));
         dispose();
      }
      
      private function __buyMoney(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LeavePageManager.leaveToFillPath();
      }
      
      private function __showFramePanel(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Point = _chooseFriendBtn.localToGlobal(new Point(0,0));
         _friendList.x = _loc2_.x - 95;
         _friendList.y = _loc2_.y + _chooseFriendBtn.height;
         _friendList.setVisible = true;
         LayerManager.Instance.addToLayer(_friendList,3);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_nameInput)
         {
            _nameInput.removeEventListener("change",__onReceiverChange);
         }
         if(_chooseFriendBtn)
         {
            _chooseFriendBtn.removeEventListener("click",__showFramePanel);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__buyMoney);
         }
         StageReferance.stage.removeEventListener("click",__hideDropList);
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
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         if(_dropList)
         {
            _dropList = null;
         }
         if(_friendList)
         {
            ObjectUtils.disposeObject(_friendList);
         }
         _friendList = null;
         _titleTxt = null;
         _BG = null;
         _comboBoxLabel = null;
         _chooseFriendBtn = null;
         _nameInput = null;
         _dropList = null;
         _cancelBtn = null;
         _okBtn = null;
         ObjectUtils.disposeObject(_textAreaBg);
         _textAreaBg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
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
   }
}
