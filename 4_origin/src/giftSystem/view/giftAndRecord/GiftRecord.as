package giftSystem.view.giftAndRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RecordInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import giftSystem.GiftEvent;
   import giftSystem.GiftManager;
   import giftSystem.element.RecordItem;
   
   public class GiftRecord extends Sprite implements Disposeable
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _canClick:Boolean = false;
      
      private var _noGift:Bitmap;
      
      private var _container:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _itemArr:Vector.<RecordItem>;
      
      public function GiftRecord()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemArr = new Vector.<RecordItem>();
         _container = ComponentFactory.Instance.creatComponentByStylename("RecordParent.container");
         _panel = ComponentFactory.Instance.creatComponentByStylename("RecordParent.Panel");
         _panel.setView(_container);
         addChild(_panel);
      }
      
      private function initEvent() : void
      {
         GiftManager.Instance.addEventListener("loadRecordComplete",__setRecordList);
      }
      
      private function removeEvent() : void
      {
         GiftManager.Instance.removeEventListener("loadRecordComplete",__setRecordList);
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         if(_playerInfo == param1)
         {
            return;
         }
         _playerInfo = param1;
         if(_playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _canClick = true;
         }
      }
      
      private function __setRecordList(param1:GiftEvent) : void
      {
         if(param1.str == "GiftRecieveLog.ashx")
         {
            setList(GiftManager.Instance.recordInfo);
         }
      }
      
      private function setList(param1:RecordInfo) : void
      {
         clear();
         _itemArr = new Vector.<RecordItem>();
         setReceived(param1);
      }
      
      private function setReceived(param1:RecordInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(param1)
         {
            _loc3_ = param1.recordList.length;
            if(_loc3_ != 0)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = new RecordItem();
                  _loc2_.setup(_playerInfo);
                  if(param1.recordList[_loc4_].Receive == 1)
                  {
                     _loc2_.setItemInfoType(param1.recordList[_loc4_],1);
                  }
                  if(param1.recordList[_loc4_].Receive == 0)
                  {
                     _loc2_.setItemInfoType(param1.recordList[_loc4_],0);
                  }
                  _container.addChild(_loc2_);
                  _itemArr.push(_loc2_);
                  _loc4_++;
               }
            }
         }
         _panel.invalidateViewport();
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         if(_noGift)
         {
            ObjectUtils.disposeObject(_noGift);
         }
         _noGift = null;
         _loc1_ = 0;
         while(_loc1_ < _itemArr.length)
         {
            if(_itemArr[_loc1_])
            {
               _itemArr[_loc1_].dispose();
            }
            _itemArr[_loc1_] = null;
            _loc1_++;
         }
         _itemArr = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clear();
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
