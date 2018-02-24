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
      
      public function GetFriendPackFrame(){super();}
      
      private function initView() : void{}
      
      public function updateView(param1:ItemTemplateInfo, param2:int, param3:int) : void{}
      
      private function addEvent() : void{}
      
      protected function selectName(param1:String, param2:int = 0) : void{}
      
      public function setName(param1:String) : void{}
      
      private function __certainBtnClick(param1:MouseEvent) : void{}
      
      private function __deselectBtnClick(param1:MouseEvent) : void{}
      
      public function show() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      protected function __hideDropList(param1:Event) : void{}
      
      private function __showFramePanel(param1:MouseEvent) : void{}
      
      protected function __onReceiverChange(param1:Event) : void{}
      
      private function filterRepeatInArray(param1:Array) : Array{return null;}
      
      private function filterSearch(param1:Array, param2:String) : Array{return null;}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
