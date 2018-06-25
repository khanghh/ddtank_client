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
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         if(_playerInfo == value)
         {
            return;
         }
         _playerInfo = value;
         if(_playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _canClick = true;
         }
      }
      
      private function __setRecordList(event:GiftEvent) : void
      {
         if(event.str == "GiftRecieveLog.ashx")
         {
            setList(GiftManager.Instance.recordInfo);
         }
      }
      
      private function setList(info:RecordInfo) : void
      {
         clear();
         _itemArr = new Vector.<RecordItem>();
         setReceived(info);
      }
      
      private function setReceived(info:RecordInfo) : void
      {
         var len:int = 0;
         var i:int = 0;
         var item:* = null;
         if(info)
         {
            len = info.recordList.length;
            if(len != 0)
            {
               for(i = 0; i < len; )
               {
                  item = new RecordItem();
                  item.setup(_playerInfo);
                  if(info.recordList[i].Receive == 1)
                  {
                     item.setItemInfoType(info.recordList[i],1);
                  }
                  if(info.recordList[i].Receive == 0)
                  {
                     item.setItemInfoType(info.recordList[i],0);
                  }
                  _container.addChild(item);
                  _itemArr.push(item);
                  i++;
               }
            }
         }
         _panel.invalidateViewport();
      }
      
      private function clear() : void
      {
         var i:int = 0;
         if(_noGift)
         {
            ObjectUtils.disposeObject(_noGift);
         }
         _noGift = null;
         for(i = 0; i < _itemArr.length; )
         {
            if(_itemArr[i])
            {
               _itemArr[i].dispose();
            }
            _itemArr[i] = null;
            i++;
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
