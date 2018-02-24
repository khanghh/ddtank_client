package wonderfulActivity.limitActivity
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class SendGiftActivityFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var sendBtn:SimpleBitmapButton;
      
      private var _info:GmActivityInfo;
      
      private var _goodContent:Sprite;
      
      private var _prizeHBox:HBox;
      
      private var _activityBox:Sprite;
      
      public var nowId:String;
      
      public function SendGiftActivityFrame(){super();}
      
      private function initview() : void{}
      
      public function setData(param1:GmActivityInfo) : void{}
      
      public function setBtnFalse() : void{}
      
      private function addEvent() : void{}
      
      private function __sendBtnClickHandler(param1:MouseEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}

import bagAndInfo.cell.BagCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;
import ddt.data.goods.InventoryItemInfo;
import ddt.manager.ItemManager;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import wonderfulActivity.data.GiftRewardInfo;

class GiftItem extends Sprite implements Disposeable
{
    
   
   private var index:int;
   
   private var _bg:Bitmap;
   
   private var _bagCell:BagCell;
   
   function GiftItem(){super();}
   
   public function initView(param1:int) : void{}
   
   public function setCellData(param1:GiftRewardInfo) : void{}
   
   public function dispose() : void{}
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.TextButton;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.LanguageMgr;
import ddt.manager.SocketManager;
import ddt.manager.SoundManager;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import wonderfulActivity.WonderfulActivityManager;

class ActivityItem extends Sprite implements Disposeable
{
    
   
   private var txtBtn:TextButton;
   
   private var nameTxt:FilterFrameText;
   
   private var _id:String;
   
   function ActivityItem(){super();}
   
   private function linkhandler(param1:TextEvent) : void{}
   
   private function clickhandler(param1:MouseEvent) : void{}
   
   public function setData(param1:String) : void{}
   
   public function dispose() : void{}
}
