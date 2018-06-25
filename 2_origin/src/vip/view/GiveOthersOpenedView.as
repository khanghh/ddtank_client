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
      
      public function GiveOthersOpenedView(bool:Boolean, $discountCode:int)
      {
         super($discountCode);
         init();
         isBand = bool;
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
      
      protected function __propertyChangedHandler(event:Event) : void
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
      
      private function __seletected(e:Event) : void
      {
         _repeatName.text = _friendName.text;
      }
      
      private function __listAction(evt:MouseEvent) : void
      {
         if(evt.target is FriendDropListTarget)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function __textChange(evt:Event) : void
      {
         if(_friendName.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var list:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterSearch(filterRepeatInArray(list),_friendName.text);
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
      
      private function __textInputHandler(evt:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_friendName,14);
      }
      
      private function __repeattextInputHandler(evt:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_repeatName.textField,14);
      }
      
      override protected function __openVip(evt:MouseEvent) : void
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
         var msg:String = LanguageMgr.GetTranslation("ddt.vip.vipView.confirmforOther",_friendName.text,time,payNum);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __moneyConfirmHandler(evt:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         switch(int(evt.responseCode) - 2)
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
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirm);
         switch(int(evt.responseCode) - 2)
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
      
      private function selectName(nick:String, id:int = 0) : void
      {
         _friendName.text = nick;
         _repeatName.text = nick;
         _friendList.setVisible = false;
      }
      
      private function __friendListView(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var pos:Point = _friendListBtn.localToGlobal(new Point(0,0));
         _friendList.x = pos.x;
         _friendList.y = pos.y + _friendListBtn.height;
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
