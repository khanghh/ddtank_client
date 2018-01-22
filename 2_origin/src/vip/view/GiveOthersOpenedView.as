package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.FriendDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import road7th.utils.StringHelper;
   import vip.VipController;
   
   public class GiveOthersOpenedView extends GiveYourselfOpenView implements Disposeable
   {
       
      
      public var isBand:Boolean;
      
      private var _nametxt:FilterFrameText;
      
      private var _repeatNametxt:FilterFrameText;
      
      private var _friendName:FriendDropListTarget;
      
      private var _amountOfMoneyTxt:FilterFrameText;
      
      private var _amountOfMoney:FilterFrameText;
      
      private var _moneyIcon:Image;
      
      private var _dropList:DropList;
      
      private var _repeatName:TextInput;
      
      private var _friendListBtn:TextButton;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _list:VBox;
      
      private var _itemArray:Array;
      
      private var _listBG:Scale9CornerImage;
      
      private var _inputBG:Scale9CornerImage;
      
      private var _listScrollPanel:ScrollPanel;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      public function GiveOthersOpenedView(param1:Boolean, param2:int)
      {
         super(param2);
         init();
         isBand = param1;
      }
      
      private function init() : void
      {
         _isSelf = false;
         _nametxt = ComponentFactory.Instance.creatComponentByStylename("vip.name");
         _nametxt.text = LanguageMgr.GetTranslation("ddt.vip.nametxt");
         addChild(_nametxt);
         _repeatNametxt = ComponentFactory.Instance.creatComponentByStylename("vip.repeatName");
         _repeatNametxt.text = LanguageMgr.GetTranslation("ddt.vip.repeatNametxt");
         addChild(_repeatNametxt);
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("asset.vip.friendNameBG");
         addChild(_inputBG);
         _friendName = ComponentFactory.Instance.creat("GiveOthersOpenedView.friendName");
         addChild(_friendName);
         _dropList = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.DropList");
         _dropList.targetDisplay = _friendName;
         _dropList.x = _inputBG.x;
         _dropList.y = _inputBG.y + _inputBG.height;
         _repeatName = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.repeatName");
         addChild(_repeatName);
         _friendListBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.friendList");
         _friendListBtn.text = LanguageMgr.GetTranslation("ddt.vip.friendListBtn");
         addChild(_friendListBtn);
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName);
         _listBG = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.searchListBG");
         addChild(_listBG);
         _listBG.visible = false;
         _list = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.searchList");
         addChild(_list);
         _itemArray = [];
         _amountOfMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.amountOfMoneyTxt");
         _amountOfMoneyTxt.text = LanguageMgr.GetTranslation("ddt.vip.amountOfMoneyTxt");
         addChild(_amountOfMoneyTxt);
         _amountOfMoney = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.amountOfMoney");
         _amountOfMoney.text = PlayerManager.Instance.Self.Money + LanguageMgr.GetTranslation("ddt.vip.amountOfMoneyUnit");
         addChild(_amountOfMoney);
         _moneyIcon = ComponentFactory.Instance.creatComponentByStylename("GiveOthersOpenedView.MoneyIcon");
         addChild(_moneyIcon);
         _vipPrivilegeTxt.visible = false;
         showOpenOrRenewal();
         rewardBtnCanUse();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _friendName.addEventListener("textInput",__textInputHandler);
         _friendName.addEventListener("change",__textChange);
         _repeatName.addEventListener("textInput",__repeattextInputHandler);
         _friendListBtn.addEventListener("click",__friendListView);
         StageReferance.stage.addEventListener("click",__listAction);
         _friendName.addEventListener("focusIn",__textChange);
         _dropList.addEventListener("selected",__seletected);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChangedHandler);
      }
      
      protected function __propertyChangedHandler(param1:Event) : void
      {
         _amountOfMoney.text = PlayerManager.Instance.Self.Money + LanguageMgr.GetTranslation("ddt.vip.amountOfMoneyUnit");
      }
      
      private function removeEvent() : void
      {
         _friendName.removeEventListener("textInput",__textInputHandler);
         _friendName.removeEventListener("change",__textChange);
         _repeatName.removeEventListener("textInput",__repeattextInputHandler);
         _friendListBtn.removeEventListener("click",__friendListView);
         StageReferance.stage.removeEventListener("click",__listAction);
         _friendName.removeEventListener("focusIn",__textChange);
         _dropList.removeEventListener("selected",__seletected);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChangedHandler);
      }
      
      private function __seletected(param1:Event) : void
      {
         _repeatName.text = _friendName.text;
      }
      
      private function __listAction(param1:MouseEvent) : void
      {
         if(param1.target is FriendDropListTarget)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function __textChange(param1:Event) : void
      {
         if(_friendName.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var _loc2_:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterSearch(filterRepeatInArray(_loc2_),_friendName.text);
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
      
      private function __textInputHandler(param1:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_friendName,14);
      }
      
      private function __repeattextInputHandler(param1:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_repeatName.textField,14);
      }
      
      override protected function __openVip(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < payNum)
         {
            _moneyConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _moneyConfirm.moveEnable = false;
            _moneyConfirm.addEventListener("response",__moneyConfirmHandler);
            return;
         }
         if(_friendName.text == "" || _repeatName.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipView.finish"));
            return;
         }
         if(_friendName.text != _repeatName.text)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipView.checkName"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.vip.vipView.confirmforOther",_friendName.text,time,payNum);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __moneyConfirmHandler(param1:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
         }
         _moneyConfirm.dispose();
         if(_moneyConfirm.parent)
         {
            _moneyConfirm.parent.removeChild(_moneyConfirm);
         }
         _moneyConfirm = null;
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirm);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               sendVip();
               _friendName.text = "";
               _repeatName.text = "";
               upPayMoneyText();
         }
         _confirmFrame.dispose();
         if(_confirmFrame.parent)
         {
            _confirmFrame.parent.removeChild(_confirmFrame);
         }
      }
      
      override protected function send() : void
      {
         VipController.instance.sendOpenVip(_friendName.text,days,false);
      }
      
      private function selectName(param1:String, param2:int = 0) : void
      {
         _friendName.text = param1;
         _repeatName.text = param1;
         _friendList.setVisible = false;
      }
      
      private function __friendListView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Point = _friendListBtn.localToGlobal(new Point(0,0));
         _friendList.x = _loc2_.x;
         _friendList.y = _loc2_.y + _friendListBtn.height;
         _friendList.setVisible = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_dropList)
         {
            ObjectUtils.disposeObject(_dropList);
         }
         _dropList = null;
         if(_repeatNametxt)
         {
            ObjectUtils.disposeObject(_repeatNametxt);
         }
         _repeatNametxt = null;
         if(_friendName)
         {
            ObjectUtils.disposeObject(_friendName);
         }
         _friendName = null;
         if(_repeatName)
         {
            ObjectUtils.disposeObject(_repeatName);
         }
         _repeatName = null;
         if(_friendListBtn)
         {
            ObjectUtils.disposeObject(_friendListBtn);
         }
         _friendListBtn = null;
         if(_friendList)
         {
            ObjectUtils.disposeObject(_friendList);
         }
         _friendList = null;
         if(_confirmFrame)
         {
            _confirmFrame.dispose();
         }
         _confirmFrame = null;
         if(_moneyConfirm)
         {
            _moneyConfirm.dispose();
         }
         _moneyConfirm = null;
         if(_inputBG)
         {
            ObjectUtils.disposeObject(_inputBG);
         }
         _inputBG = null;
         if(_listBG)
         {
            ObjectUtils.disposeObject(_listBG);
         }
         _listBG = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_nametxt);
         _nametxt = null;
         ObjectUtils.disposeObject(_amountOfMoneyTxt);
         _amountOfMoneyTxt = null;
         ObjectUtils.disposeObject(_amountOfMoney);
         _amountOfMoney = null;
         ObjectUtils.disposeObject(_moneyIcon);
         _moneyIcon = null;
         ObjectUtils.disposeObject(_listScrollPanel);
         _listScrollPanel = null;
      }
   }
}
