package giftSystem.view.giftAndRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftManager;
   import giftSystem.MyGiftCellInfo;
   import road7th.data.DictionaryEvent;
   
   public class GiftAndRecord extends Sprite implements Disposeable
   {
      
      public static const MYGIFT:int = 0;
      
      public static const GIFTRECORD:int = 1;
       
      
      private var _BG:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _myGiftBtn:SelectedTextButton;
      
      private var _giftRecordBtn:SelectedTextButton;
      
      private var _myGiftView:MyGiftView;
      
      private var _giftRecord:GiftRecord;
      
      private var _info:PlayerInfo;
      
      public function GiftAndRecord()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("GiftAndRecord.BG1");
         _myGiftBtn = ComponentFactory.Instance.creatComponentByStylename("GiftAndRecord.myGiftBtn");
         _giftRecordBtn = ComponentFactory.Instance.creatComponentByStylename("GiftAndRecord.recordBtn");
         _myGiftBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.myGift");
         _giftRecordBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.giftRecord");
         addChild(_myGiftBtn);
         addChild(_giftRecordBtn);
         addChild(_BG);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_myGiftBtn);
         _btnGroup.addSelectItem(_giftRecordBtn);
         _btnGroup.selectIndex = 0;
         __changeHandler(null);
      }
      
      private function initEvent() : void
      {
         _myGiftBtn.addEventListener("click",__soundPlay);
         _giftRecordBtn.addEventListener("click",__soundPlay);
         _btnGroup.addEventListener("change",__changeHandler);
         PlayerManager.Instance.addEventListener("giftInfoChange",__upMyGiftView);
      }
      
      private function removeEvent() : void
      {
         _myGiftBtn.removeEventListener("click",__soundPlay);
         _giftRecordBtn.removeEventListener("click",__soundPlay);
         _btnGroup.removeEventListener("change",__changeHandler);
         PlayerManager.Instance.removeEventListener("giftInfoChange",__upMyGiftView);
         if(_info.ID == PlayerManager.Instance.Self.ID)
         {
            _info.removeEventListener("propertychange",__upData);
            PlayerManager.Instance.removeEventListener("add",__addItem);
            PlayerManager.Instance.removeEventListener("update",__upItem);
         }
      }
      
      private function __upMyGiftView(param1:Event) : void
      {
         if(_myGiftView && _info)
         {
            _myGiftView.setList(_info.myGiftData);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               showMyGiftView();
               break;
            case 1:
               showGiftRecord();
         }
      }
      
      private function showMyGiftView() : void
      {
         if(_myGiftView == null)
         {
            _myGiftView = ComponentFactory.Instance.creatCustomObject("myGiftView");
            addChild(_myGiftView);
         }
         if(_info)
         {
            _myGiftView.setList(_info.myGiftData);
         }
         _myGiftView.visible = true;
         if(_giftRecord)
         {
            _giftRecord.visible = false;
         }
      }
      
      private function showGiftRecord() : void
      {
         if(_giftRecord == null)
         {
            _giftRecord = ComponentFactory.Instance.creatCustomObject("giftRecord");
            addChild(_giftRecord);
         }
         if(_info)
         {
            _giftRecord.playerInfo = _info;
         }
         _giftRecord.visible = true;
         if(_myGiftView)
         {
            _myGiftView.visible = false;
         }
         GiftManager.Instance.loadRecord("GiftRecieveLog.ashx",_info.ID);
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         if(_myGiftView)
         {
            _myGiftView.setList(_info.myGiftData);
            if(_info.ID == PlayerManager.Instance.Self.ID)
            {
               _info.addEventListener("propertychange",__upData);
               PlayerManager.Instance.addEventListener("add",__addItem);
               PlayerManager.Instance.addEventListener("update",__upItem);
            }
         }
         _btnGroup.selectIndex = 0;
         __changeHandler(null);
      }
      
      private function __upItem(param1:DictionaryEvent) : void
      {
         _myGiftView.upItem(param1.data as MyGiftCellInfo);
      }
      
      private function __addItem(param1:DictionaryEvent) : void
      {
         _myGiftView.addItem(param1.data as MyGiftCellInfo);
      }
      
      private function __upData(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["myGiftData"])
         {
            _myGiftView.setList(_info.myGiftData);
         }
      }
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_myGiftBtn)
         {
            ObjectUtils.disposeObject(_myGiftBtn);
         }
         _myGiftBtn = null;
         if(_giftRecordBtn)
         {
            ObjectUtils.disposeObject(_giftRecordBtn);
         }
         _giftRecordBtn = null;
         if(_btnGroup)
         {
            _btnGroup.dispose();
         }
         _btnGroup = null;
         if(_myGiftView)
         {
            _myGiftView.dispose();
         }
         _myGiftView = null;
         if(_giftRecord)
         {
            _giftRecord.dispose();
         }
         _giftRecord = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
