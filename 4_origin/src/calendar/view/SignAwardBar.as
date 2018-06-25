package calendar.view
{
   import bagAndInfo.cell.BagCell;
   import calendar.CalendarControl;
   import calendar.CalendarManager;
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SignAwardBar extends Sprite implements Disposeable
   {
       
      
      private var _items:Vector.<NavigItem>;
      
      private var _itemsHbox:HBox;
      
      private var _current:NavigItem;
      
      private var _model:CalendarModel;
      
      private var _back:DisplayObject;
      
      private var _title:DisplayObject;
      
      private var _awardHolder:SignedAwardHolder;
      
      private var _signCoundField:FilterFrameText;
      
      private var _selectedItem:NavigItem;
      
      private var _signedTimesPanel:Image;
      
      public var _petBtn:SimpleBitmapButton;
      
      private var receivedBG:Bitmap;
      
      public function SignAwardBar(model:CalendarModel)
      {
         _items = new Vector.<NavigItem>();
         super();
         _model = model;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         var flag:Boolean = false;
         _signCoundField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.SignCountField");
         _signCoundField.text = _model.signCount.toString();
         addChild(_signCoundField);
         _awardHolder = ComponentFactory.Instance.creatCustomObject("ddtcalendar.SignedAwardHolder",[_model]);
         addChild(_awardHolder);
         _itemsHbox = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.hBox");
         addChild(_itemsHbox);
         drawCells();
         var goodaObj:Object = returnPetID();
         if(goodaObj != null)
         {
            itemInfo = ItemManager.Instance.getTemplateById(goodaObj.Remark) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.ValidDate = goodaObj.ValidDate;
            tInfo.IsBinds = true;
            tInfo.Count = goodaObj.Count;
            cell = new BagCell(0,tInfo,false);
            cell.setBgVisible(false);
            cell.width = 38;
            cell.height = 37;
            cell.x = 247;
            cell.y = 0;
            _petBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.petBtn");
            addChild(_petBtn);
            addChild(cell);
            flag = returnPetIsShow(CalendarManager.getInstance().model.signCount);
            var _loc6_:* = flag;
            _petBtn.mouseEnabled = _loc6_;
            _loc6_ = _loc6_;
            _petBtn.mouseChildren = _loc6_;
            _petBtn.enable = _loc6_;
            receivedBG = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.received");
            receivedBG.visible = CalendarManager.getInstance().isOK;
            addChild(receivedBG);
         }
      }
      
      private function returnPetIsShow(count:int) : Boolean
      {
         var serverTime:Date = TimeManager.Instance.Now();
         var date:Date = new Date(serverTime.getFullYear(),serverTime.getMonth() + 1);
         date.time = date.time - 1;
         var totalDay:int = date.date;
         if(count == totalDay && !CalendarManager.getInstance().isOK)
         {
            return true;
         }
         return false;
      }
      
      private function returnPetID() : Object
      {
         var i:int = 0;
         var obj:* = null;
         var serverDate:Date = TimeManager.Instance.Now();
         for(i = 0; i < CalendarManager.getInstance().signPetInfo.length; )
         {
            if(CalendarManager.getInstance().signPetInfo[i].AwardDays == serverDate.getMonth() + 1)
            {
               obj = {};
               obj.Remark = CalendarManager.getInstance().signPetInfo[i].Remark;
               obj.ValidDate = CalendarManager.getInstance().signPetInfo[i].ValidDate;
               obj.Count = CalendarManager.getInstance().signPetInfo[i].Count;
               return obj;
            }
            i++;
         }
         return null;
      }
      
      private function drawCells() : void
      {
         var i:int = 0;
         var item:* = null;
         var len:int = _model.awardCounts.length;
         var receivedCount:int = 0;
         var start:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.Award.TopLeft");
         for(i = 0; i < len; )
         {
            item = new NavigItem(_model.awardCounts[i]);
            item.addEventListener("click",__itemClick);
            _items.push(item);
            _itemsHbox.addChild(item);
            if(_model.hasReceived(_model.awardCounts[i]))
            {
               item.received = true;
               receivedCount++;
            }
            i++;
         }
         if(receivedCount < _items.length)
         {
            _items[receivedCount].selected = true;
            _selectedItem = _items[receivedCount];
            _awardHolder.setAwardsByCount(_selectedItem.count);
         }
         else if(receivedCount == _items.length)
         {
            _items[receivedCount - 1].selected = true;
            _selectedItem = _items[receivedCount - 1];
            _awardHolder.setAwardsByCount(_selectedItem.count);
         }
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         var item:NavigItem = event.currentTarget as NavigItem;
         if(_selectedItem != item)
         {
            _selectedItem.selected = false;
            _selectedItem = item;
            _selectedItem.selected = true;
            _awardHolder.setAwardsByCount(_selectedItem.count);
            SoundManager.instance.play("008");
         }
      }
      
      private function reset() : void
      {
         var i:int = 0;
         var len:int = _model.awardCounts.length;
         var receivedCount:int = 0;
         for(i = 0; i < len; )
         {
            var _loc4_:Boolean = false;
            _items[i].received = _loc4_;
            _items[i].selected = _loc4_;
            i++;
         }
         _selectedItem = _items[0];
         _selectedItem.selected = true;
         _awardHolder.setAwardsByCount(_selectedItem.count);
      }
      
      private function __signCountChanged(event:Event) : void
      {
         var len:int = 0;
         var receivedCount:int = 0;
         var i:int = 0;
         _signCoundField.text = _model.signCount.toString();
         if(_model.signCount == 0)
         {
            reset();
         }
         else
         {
            len = _model.awardCounts.length;
            receivedCount = 0;
            for(i = 0; i < len; )
            {
               if(_model.hasReceived(_model.awardCounts[i]))
               {
                  _items[i].received = true;
                  if(_items[i] == _selectedItem)
                  {
                     _selectedItem = null;
                  }
                  receivedCount++;
               }
               i++;
            }
            if(receivedCount < _items.length && _selectedItem == null)
            {
               _items[receivedCount].selected = true;
               _selectedItem = _items[receivedCount];
               _awardHolder.setAwardsByCount(_selectedItem.count);
            }
            else if(_selectedItem == null)
            {
               _awardHolder.clean();
            }
         }
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SignCountChanged",__signCountChanged);
         CalendarControl.getInstance().addEventListener("petBtnShow",__onPetShow);
         _petBtn.addEventListener("click",__onPetBtnClick);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("SignCountChanged",__signCountChanged);
         CalendarControl.getInstance().removeEventListener("petBtnShow",__onPetShow);
         _petBtn.removeEventListener("click",__onPetBtnClick);
      }
      
      private function __onPetShow(e:Event) : void
      {
         var _loc2_:* = true;
         _petBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _petBtn.mouseChildren = _loc2_;
         _petBtn.enable = _loc2_;
      }
      
      private function __onPetBtnClick(e:MouseEvent) : void
      {
         _petBtn.removeEventListener("click",__onPetBtnClick);
         CalendarManager.getInstance().isOK = true;
         receivedBG.visible = CalendarManager.getInstance().isOK;
         var _loc2_:* = false;
         _petBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _petBtn.mouseChildren = _loc2_;
         _petBtn.enable = _loc2_;
         GameInSocketOut.sendCalendarPet();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_signCoundField);
         _signCoundField = null;
         ObjectUtils.disposeObject(_awardHolder);
         _awardHolder = null;
         if(_itemsHbox)
         {
            ObjectUtils.disposeObject(_itemsHbox);
         }
         _itemsHbox = null;
         var item:NavigItem = _items.shift();
         while(item != null)
         {
            ObjectUtils.disposeObject(item);
            item = _items.shift();
         }
         _selectedItem = null;
         _current = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
