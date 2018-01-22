package im
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.CMFriendInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.PlayerTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class IMLookupView extends Sprite implements Disposeable
   {
       
      
      public const MAX_ITEM_NUM:int = 8;
      
      public const ITEM_MAX_HEIGHT:int = 33;
      
      public const ITEM_MIN_HEIGHT:int = 28;
      
      private var _bg:Scale9CornerImage;
      
      private var _cleanUpBtn:BaseButton;
      
      private var _inputText:TextInput;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _currentList:Array;
      
      private var _itemArray:Array;
      
      private var _listType:int;
      
      private var _currentItemInfo;
      
      private var _currentItem:IMLookupItem;
      
      private var _list:VBox;
      
      private var _NAN:FilterFrameText;
      
      private var _lookBtn:Bitmap;
      
      public function IMLookupView(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __inputClick(param1:MouseEvent) : void{}
      
      private function __stageClick(param1:MouseEvent) : void{}
      
      private function hide() : void{}
      
      private function __stopEvent(param1:KeyboardEvent) : void{}
      
      private function __cleanUpClick(param1:MouseEvent) : void{}
      
      private function __updateList(param1:Event) : void{}
      
      private function __textInput(param1:Event) : void{}
      
      private function strTest() : void{}
      
      private function friendStrTest() : void{}
      
      private function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function CMFriendStrTest() : void{}
      
      private function setFlexBg() : void{}
      
      private function disposeItems() : void{}
      
      private function updateList() : void{}
      
      private function testAlikeName(param1:String) : Boolean{return false;}
      
      public function set listType(param1:int) : void{}
      
      public function get currentItemInfo() : *{return null;}
      
      public function dispose() : void{}
   }
}
