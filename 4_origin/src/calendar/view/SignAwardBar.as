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
      
      public function SignAwardBar(param1:CalendarModel)
      {
         _items = new Vector.<NavigItem>();
         super();
         _model = param1;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Boolean = false;
         _signCoundField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.SignCountField");
         _signCoundField.text = _model.signCount.toString();
         addChild(_signCoundField);
         _awardHolder = ComponentFactory.Instance.creatCustomObject("ddtcalendar.SignedAwardHolder",[_model]);
         addChild(_awardHolder);
         _itemsHbox = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.hBox");
         addChild(_itemsHbox);
         drawCells();
         var _loc1_:Object = returnPetID();
         if(_loc1_ != null)
         {
            _loc5_ = ItemManager.Instance.getTemplateById(_loc1_.Remark) as ItemTemplateInfo;
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc5_);
            _loc3_.ValidDate = _loc1_.ValidDate;
            _loc3_.IsBinds = true;
            _loc3_.Count = _loc1_.Count;
            _loc4_ = new BagCell(0,_loc3_,false);
            _loc4_.setBgVisible(false);
            _loc4_.width = 38;
            _loc4_.height = 37;
            _loc4_.x = 247;
            _loc4_.y = 0;
            _petBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.petBtn");
            addChild(_petBtn);
            addChild(_loc4_);
            _loc2_ = returnPetIsShow(CalendarManager.getInstance().model.signCount);
            var _loc6_:* = _loc2_;
            _petBtn.mouseEnabled = _loc6_;
            _loc6_ = _loc6_;
            _petBtn.mouseChildren = _loc6_;
            _petBtn.enable = _loc6_;
            receivedBG = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.received");
            receivedBG.visible = CalendarManager.getInstance().isOK;
            addChild(receivedBG);
         }
      }
      
      private function returnPetIsShow(param1:int) : Boolean
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc3_:Date = new Date(_loc2_.getFullYear(),_loc2_.getMonth() + 1);
         _loc3_.time = _loc3_.time - 1;
         var _loc4_:int = _loc3_.date;
         if(param1 == _loc4_ && !CalendarManager.getInstance().isOK)
         {
            return true;
         }
         return false;
      }
      
      private function returnPetID() : Object
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Date = TimeManager.Instance.Now();
         _loc3_ = 0;
         while(_loc3_ < CalendarManager.getInstance().signPetInfo.length)
         {
            if(CalendarManager.getInstance().signPetInfo[_loc3_].AwardDays == _loc2_.getMonth() + 1)
            {
               _loc1_ = {};
               _loc1_.Remark = CalendarManager.getInstance().signPetInfo[_loc3_].Remark;
               _loc1_.ValidDate = CalendarManager.getInstance().signPetInfo[_loc3_].ValidDate;
               _loc1_.Count = CalendarManager.getInstance().signPetInfo[_loc3_].Count;
               return _loc1_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function drawCells() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = _model.awardCounts.length;
         var _loc3_:int = 0;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.Award.TopLeft");
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = new NavigItem(_model.awardCounts[_loc5_]);
            _loc2_.addEventListener("click",__itemClick);
            _items.push(_loc2_);
            _itemsHbox.addChild(_loc2_);
            if(_model.hasReceived(_model.awardCounts[_loc5_]))
            {
               _loc2_.received = true;
               _loc3_++;
            }
            _loc5_++;
         }
         if(_loc3_ < _items.length)
         {
            _items[_loc3_].selected = true;
            _selectedItem = _items[_loc3_];
            _awardHolder.setAwardsByCount(_selectedItem.count);
         }
         else if(_loc3_ == _items.length)
         {
            _items[_loc3_ - 1].selected = true;
            _selectedItem = _items[_loc3_ - 1];
            _awardHolder.setAwardsByCount(_selectedItem.count);
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc2_:NavigItem = param1.currentTarget as NavigItem;
         if(_selectedItem != _loc2_)
         {
            _selectedItem.selected = false;
            _selectedItem = _loc2_;
            _selectedItem.selected = true;
            _awardHolder.setAwardsByCount(_selectedItem.count);
            SoundManager.instance.play("008");
         }
      }
      
      private function reset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _model.awardCounts.length;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var _loc4_:Boolean = false;
            _items[_loc3_].received = _loc4_;
            _items[_loc3_].selected = _loc4_;
            _loc3_++;
         }
         _selectedItem = _items[0];
         _selectedItem.selected = true;
         _awardHolder.setAwardsByCount(_selectedItem.count);
      }
      
      private function __signCountChanged(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _signCoundField.text = _model.signCount.toString();
         if(_model.signCount == 0)
         {
            reset();
         }
         else
         {
            _loc3_ = _model.awardCounts.length;
            _loc2_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_model.hasReceived(_model.awardCounts[_loc4_]))
               {
                  _items[_loc4_].received = true;
                  if(_items[_loc4_] == _selectedItem)
                  {
                     _selectedItem = null;
                  }
                  _loc2_++;
               }
               _loc4_++;
            }
            if(_loc2_ < _items.length && _selectedItem == null)
            {
               _items[_loc2_].selected = true;
               _selectedItem = _items[_loc2_];
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
      
      private function __onPetShow(param1:Event) : void
      {
         var _loc2_:* = true;
         _petBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _petBtn.mouseChildren = _loc2_;
         _petBtn.enable = _loc2_;
      }
      
      private function __onPetBtnClick(param1:MouseEvent) : void
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
         var _loc1_:NavigItem = _items.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _items.shift();
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
