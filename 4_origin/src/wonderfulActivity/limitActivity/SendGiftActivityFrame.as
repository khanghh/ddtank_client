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
      
      public function SendGiftActivityFrame()
      {
         super();
         initview();
         addEvent();
      }
      
      private function initview() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.sendGiftActivityFrame.title");
         _bg = ComponentFactory.Instance.creat("wonderful.sendGiftActivity.bg");
         addToContent(_bg);
         sendBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.sendGiftFrame.sendBtn");
         addToContent(sendBtn);
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.sendGiftActivity.Hbox");
         addToContent(_prizeHBox);
         _activityBox = new Sprite();
         addToContent(_activityBox);
      }
      
      public function setData(param1:GmActivityInfo) : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         _info = param1;
         nowId = _info.activityId;
         _loc10_ = 0;
         while(_loc10_ < _info.giftbagArray.length)
         {
            _loc9_ = 0;
            while(_loc9_ < _info.giftbagArray[_loc10_].giftRewardArr.length)
            {
               _loc4_ = new GiftRewardInfo();
               _loc4_ = _info.giftbagArray[_loc10_].giftRewardArr[_loc9_];
               _loc8_ = new GiftItem();
               _loc8_.initView(_loc9_ + _loc10_ * _info.giftbagArray[_loc10_].giftRewardArr.length);
               _loc8_.setCellData(_loc4_);
               _prizeHBox.addChild(_loc8_);
               _loc9_++;
            }
            _loc10_++;
         }
         _prizeHBox.x = (this.width - _prizeHBox.width) / 2;
         var _loc3_:Array = _info.remain2.split("|");
         var _loc2_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < _loc3_.length)
         {
            _loc7_ = TimeManager.Instance.Now();
            _loc6_ = WonderfulActivityManager.Instance.activityData[_loc3_[_loc10_]];
            if(_loc6_)
            {
               if(!(_loc7_.time < Date.parse(_loc6_.beginShowTime) || _loc7_.time > Date.parse(_loc6_.endShowTime)))
               {
                  _loc5_ = new ActivityItem();
                  _loc5_.setData(_loc3_[_loc10_]);
                  _loc5_.x = 22;
                  _loc5_.y = 282 + 34 * _loc2_;
                  _activityBox.addChild(_loc5_);
                  _loc2_++;
               }
            }
            _loc10_++;
         }
      }
      
      public function setBtnFalse() : void
      {
         if(sendBtn)
         {
            sendBtn.enable = false;
            sendBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function addEvent() : void
      {
         sendBtn.addEventListener("click",__sendBtnClickHandler);
         addEventListener("response",_response);
      }
      
      private function __sendBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc2_:SendGiftInfo = new SendGiftInfo();
         _loc2_.activityId = _info.activityId;
         var _loc3_:Array = [];
         _loc3_.push(_info.giftbagArray[0].giftbagId);
         _loc2_.giftIdArr = _loc3_;
         _loc4_.push(_loc2_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc4_);
         setBtnFalse();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         sendBtn.removeEventListener("click",__sendBtnClickHandler);
         removeEventListener("response",_response);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(sendBtn);
         sendBtn = null;
         ObjectUtils.disposeObject(_goodContent);
         _goodContent = null;
         ObjectUtils.disposeObject(_prizeHBox);
         _prizeHBox = null;
         ObjectUtils.disposeObject(_activityBox);
         _activityBox = null;
      }
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
   
   function GiftItem()
   {
      super();
   }
   
   public function initView(param1:int) : void
   {
      this.index = param1;
      _bg = ComponentFactory.Instance.creat("wonderful.sendGiftActivity.frame");
      addChild(_bg);
      _bagCell = new BagCell(param1);
      var _loc2_:int = 70;
      _bagCell.height = _loc2_;
      _bagCell.width = _loc2_;
      PositionUtils.setPos(_bagCell,"wonderful.SendGiftative.bagCellPos");
      _bagCell.visible = false;
      addChild(_bagCell);
   }
   
   public function setCellData(param1:GiftRewardInfo) : void
   {
      if(!param1)
      {
         _bagCell.visible = false;
         return;
      }
      _bagCell.visible = true;
      var _loc3_:InventoryItemInfo = new InventoryItemInfo();
      _loc3_.TemplateID = param1.templateId;
      _loc3_ = ItemManager.fill(_loc3_);
      _loc3_.IsBinds = param1.isBind;
      _loc3_.ValidDate = param1.validDate;
      var _loc2_:Array = param1.property.split(",");
      _loc3_.StrengthenLevel = parseInt(_loc2_[0]);
      _loc3_.AttackCompose = parseInt(_loc2_[1]);
      _loc3_.DefendCompose = parseInt(_loc2_[2]);
      _loc3_.AgilityCompose = parseInt(_loc2_[3]);
      _loc3_.LuckCompose = parseInt(_loc2_[4]);
      _bagCell.info = _loc3_;
      _bagCell.setCount(param1.count);
      _bagCell.setBgVisible(false);
   }
   
   public function dispose() : void
   {
      if(_bg)
      {
         ObjectUtils.disposeObject(_bg);
      }
      _bg = null;
      if(_bagCell)
      {
         ObjectUtils.disposeObject(_bagCell);
      }
      _bagCell = null;
   }
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
   
   function ActivityItem()
   {
      super();
      txtBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfull.sendGiftActivity.check");
      txtBtn.text = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.view");
      addChild(txtBtn);
      nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfull.sendGiftActivity.nameTxt");
      addChild(nameTxt);
      nameTxt.mouseEnabled = true;
      nameTxt.addEventListener("link",linkhandler);
      txtBtn.addEventListener("click",clickhandler);
   }
   
   private function linkhandler(param1:TextEvent) : void
   {
      SoundManager.instance.play("008");
      WonderfulActivityManager.Instance.selectId = _id;
      WonderfulActivityManager.Instance.clickWonderfulActView = true;
      SocketManager.Instance.out.requestWonderfulActInit(1);
   }
   
   private function clickhandler(param1:MouseEvent) : void
   {
      SoundManager.instance.play("008");
      WonderfulActivityManager.Instance.selectId = _id;
      WonderfulActivityManager.Instance.clickWonderfulActView = true;
      SocketManager.Instance.out.requestWonderfulActInit(1);
   }
   
   public function setData(param1:String) : void
   {
      _id = param1;
      var _loc2_:String = WonderfulActivityManager.Instance.activityData[param1].activityName;
      if(_loc2_.length > 40)
      {
         nameTxt.htmlText = "<a href=\'event:\'>" + _loc2_.substr(0,40) + "...</a>";
      }
      else
      {
         nameTxt.htmlText = "<a href=\'event:\'>" + _loc2_ + "</a>";
      }
   }
   
   public function dispose() : void
   {
      nameTxt.removeEventListener("link",linkhandler);
      txtBtn.removeEventListener("click",clickhandler);
      if(txtBtn)
      {
         ObjectUtils.disposeObject(txtBtn);
      }
      txtBtn = null;
      if(nameTxt)
      {
         ObjectUtils.disposeObject(nameTxt);
      }
      nameTxt = null;
   }
}
