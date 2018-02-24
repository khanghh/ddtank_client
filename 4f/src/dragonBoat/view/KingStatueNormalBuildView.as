package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class KingStatueNormalBuildView extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _item2:InventoryItemInfo;
      
      private var _itemMax:int;
      
      private var _itemMax2:int;
      
      private var _checkBtn1:SelectedCheckButton;
      
      private var _checkBtn2:SelectedCheckButton;
      
      private var _selectedGroup:SelectedButtonGroup;
      
      private var _sprite1:Sprite;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _sprite2:Sprite;
      
      private var _inputBg2:Bitmap;
      
      private var _inputText2:FilterFrameText;
      
      private var _maxBtn2:SimpleBitmapButton;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _type:int;
      
      public function KingStatueNormalBuildView(){super();}
      
      public function init2(param1:int) : void{}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initEvent() : void{}
      
      private function __groupChangeHandler(param1:Event) : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      private function changeMaxHandler(param1:MouseEvent) : void{}
      
      private function enterKeyHandler() : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
