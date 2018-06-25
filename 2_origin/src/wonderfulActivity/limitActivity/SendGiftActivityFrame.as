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
      
      public function setData(info:GmActivityInfo) : void
      {
         var i:int = 0;
         var j:int = 0;
         var bagInfo:* = null;
         var item:* = null;
         var now:* = null;
         var itemCheck:* = null;
         var acItem:* = null;
         _info = info;
         nowId = _info.activityId;
         for(i = 0; i < _info.giftbagArray.length; )
         {
            for(j = 0; j < _info.giftbagArray[i].giftRewardArr.length; )
            {
               bagInfo = new GiftRewardInfo();
               bagInfo = _info.giftbagArray[i].giftRewardArr[j];
               item = new GiftItem();
               item.initView(j + i * _info.giftbagArray[i].giftRewardArr.length);
               item.setCellData(bagInfo);
               _prizeHBox.addChild(item);
               j++;
            }
            i++;
         }
         _prizeHBox.x = (this.width - _prizeHBox.width) / 2;
         var activityArr:Array = _info.remain2.split("|");
         var index:int = 0;
         for(i = 0; i < activityArr.length; )
         {
            now = TimeManager.Instance.Now();
            itemCheck = WonderfulActivityManager.Instance.activityData[activityArr[i]];
            if(itemCheck)
            {
               if(!(now.time < Date.parse(itemCheck.beginShowTime) || now.time > Date.parse(itemCheck.endShowTime)))
               {
                  acItem = new ActivityItem();
                  acItem.setData(activityArr[i]);
                  acItem.x = 22;
                  acItem.y = 282 + 34 * index;
                  _activityBox.addChild(acItem);
                  index++;
               }
            }
            i++;
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
      
      private function __sendBtnClickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = _info.activityId;
         var giftIdArr:Array = [];
         giftIdArr.push(_info.giftbagArray[0].giftbagId);
         sendInfo.giftIdArr = giftIdArr;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
         setBtnFalse();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
   
   public function initView(index:int) : void
   {
      this.index = index;
      _bg = ComponentFactory.Instance.creat("wonderful.sendGiftActivity.frame");
      addChild(_bg);
      _bagCell = new BagCell(index);
      var _loc2_:int = 70;
      _bagCell.height = _loc2_;
      _bagCell.width = _loc2_;
      PositionUtils.setPos(_bagCell,"wonderful.SendGiftative.bagCellPos");
      _bagCell.visible = false;
      addChild(_bagCell);
   }
   
   public function setCellData(gift:GiftRewardInfo) : void
   {
      if(!gift)
      {
         _bagCell.visible = false;
         return;
      }
      _bagCell.visible = true;
      var info:InventoryItemInfo = new InventoryItemInfo();
      info.TemplateID = gift.templateId;
      info = ItemManager.fill(info);
      info.IsBinds = gift.isBind;
      info.ValidDate = gift.validDate;
      var attrArr:Array = gift.property.split(",");
      info.StrengthenLevel = parseInt(attrArr[0]);
      info.AttackCompose = parseInt(attrArr[1]);
      info.DefendCompose = parseInt(attrArr[2]);
      info.AgilityCompose = parseInt(attrArr[3]);
      info.LuckCompose = parseInt(attrArr[4]);
      _bagCell.info = info;
      _bagCell.setCount(gift.count);
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
   
   private function linkhandler(e:TextEvent) : void
   {
      SoundManager.instance.play("008");
      WonderfulActivityManager.Instance.selectId = _id;
      WonderfulActivityManager.Instance.clickWonderfulActView = true;
      SocketManager.Instance.out.requestWonderfulActInit(1);
   }
   
   private function clickhandler(e:MouseEvent) : void
   {
      SoundManager.instance.play("008");
      WonderfulActivityManager.Instance.selectId = _id;
      WonderfulActivityManager.Instance.clickWonderfulActView = true;
      SocketManager.Instance.out.requestWonderfulActInit(1);
   }
   
   public function setData(ID:String) : void
   {
      _id = ID;
      var _name:String = WonderfulActivityManager.Instance.activityData[ID].activityName;
      if(_name.length > 40)
      {
         nameTxt.htmlText = "<a href=\'event:\'>" + _name.substr(0,40) + "...</a>";
      }
      else
      {
         nameTxt.htmlText = "<a href=\'event:\'>" + _name + "</a>";
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
