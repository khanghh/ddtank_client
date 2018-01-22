package email.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.BagFrames;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import consortion.ConsortionModelManager;
   import ddt.command.QuickBuyFrame;
   import ddt.data.email.EmailInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.EmailEvent;
   import ddt.events.PkgEvent;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.FriendDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import email.manager.MailControl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import road7th.utils.StringHelper;
   
   public class WritingView extends Frame implements IAcceptDrag
   {
       
      
      private var _bag:Frame;
      
      private var _selectInfo:EmailInfo;
      
      private var isChargeMail:Boolean = false;
      
      private var _hours:uint;
      
      private var _titleIsManMade:Boolean = false;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _writingViewBG:MovieClip;
      
      private var _receiver:FriendDropListTarget;
      
      private var _senderTip:FilterFrameText;
      
      private var _topicTip:FilterFrameText;
      
      private var _dropList:DropList;
      
      private var _topic:TextInput;
      
      private var _content:TextArea;
      
      private var _friendsBtn:TextButton;
      
      private var _houerBtnGroup:SelectedButtonGroup;
      
      private var _oneHouerBtn:SelectedCheckButton;
      
      private var _sixHouerBtn:SelectedCheckButton;
      
      private var _payForBtn:SelectedCheckButton;
      
      private var _moneyInput:TextInput;
      
      private var _sendBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var bagContent:BagFrames;
      
      private var _type:int;
      
      private var _diamonds:DiamondOfWriting;
      
      private var _payTipTxt1:FilterFrameText;
      
      private var _payTipTxt2:FilterFrameText;
      
      private var _lowestPrice:Number;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _currentHourBtn:SelectedButton;
      
      public function WritingView(){super();}
      
      private function initView() : void{}
      
      private function setTip(param1:SelectedCheckButton, param2:String) : void{}
      
      private function addEvent() : void{}
      
      protected function __onBagTabChanged(param1:Event) : void{}
      
      private function __hideDropList(param1:MouseEvent) : void{}
      
      private function __onReceiverChange(param1:Event) : void{}
      
      private function filterRepeatInArray(param1:Array) : Array{return null;}
      
      private function filterSearch(param1:Array, param2:String) : Array{return null;}
      
      private function removeEvent() : void{}
      
      public function set selectInfo(param1:EmailInfo) : void{}
      
      public function isHasWrite() : Boolean{return false;}
      
      private function selectName(param1:String, param2:int = 0) : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function reset() : void{}
      
      private function btnSound() : void{}
      
      private function getFirstDiamond() : DiamondOfWriting{return null;}
      
      public function closeWin() : void{}
      
      public function okCancel() : void{}
      
      private function payEnable(param1:Boolean) : void{}
      
      private function atLeastOneDiamond() : Boolean{return false;}
      
      private function setDiamondMoneyType() : void{}
      
      private function switchHourBtnState(param1:Boolean) : void{}
      
      private function __selectHourListener(param1:MouseEvent) : void{}
      
      private function __selectMoneyType(param1:MouseEvent) : void{}
      
      private function __moneyChange(param1:Event) : void{}
      
      private function __send(param1:MouseEvent) : void{}
      
      private function __quickBuyResponse(param1:FrameEvent) : void{}
      
      private function __friendListView(param1:MouseEvent) : void{}
      
      private function __taInput(param1:TextEvent) : void{}
      
      private function __sendEmailBack(param1:PkgEvent) : void{}
      
      private function __StopEnter(param1:KeyboardEvent) : void{}
      
      private function addToStageListener(param1:Event) : void{}
      
      private function __showBag(param1:EmailEvent) : void{}
      
      private function __hideBag(param1:EmailEvent) : void{}
      
      private function __doDragIn(param1:EmailEvent) : void{}
      
      private function __doDragOut(param1:EmailEvent) : void{}
      
      private function __sound(param1:Event) : void{}
      
      private function __frameClose(param1:FrameEvent) : void{}
      
      private function __close(param1:MouseEvent) : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      public function set type(param1:int) : void{}
      
      public function get type() : int{return 0;}
      
      public function setName(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
