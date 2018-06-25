package bagAndInfo.bag
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class OpenBatchView extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _txt:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      public function OpenBatchView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set item(value:InventoryItemInfo) : void
      {
         _item = value;
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.bag.item.openBatch.titleStr"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         _alertInfo.autoDispose = false;
         _alertInfo.sound = "008";
         info = _alertInfo;
         _txt = ComponentFactory.Instance.creatComponentByStylename("openBatchView.promptTxt");
         _txt.text = LanguageMgr.GetTranslation("ddt.bag.item.openBatch.promptStr");
         _inputBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.openBatchView.inputBg");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("openBatchView.inputTxt");
         _inputText.text = "1";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("openBatchView.maxBtn");
         addToContent(_txt);
         addToContent(_inputBg);
         addToContent(_inputText);
         addToContent(_maxBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
      }
      
      private function changeMaxHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_item)
         {
            _inputText.text = String(_item.Count > getOpenMaxCount()?getOpenMaxCount():int(_item.Count));
         }
      }
      
      private function inputTextChangeHandler(event:Event) : void
      {
         var num:int = 0;
         var maxCount:int = 0;
         var count:int = 0;
         if(_item)
         {
            num = _inputText.text;
            maxCount = 99;
            if(num > 99)
            {
               maxCount = getOpenMaxCount();
            }
            count = _item.Count > maxCount?maxCount:int(_item.Count);
            if(num > count)
            {
               _inputText.text = count.toString();
            }
            if(num < 1)
            {
               _inputText.text = "1";
            }
         }
      }
      
      private function getOpenMaxCount() : int
      {
         var allItemArr:DictionaryData = ServerConfigManager.instance.batchOpenConfig;
         var maxCount:int = 99;
         if(allItemArr.hasKey(_item.TemplateID))
         {
            maxCount = allItemArr[_item.TemplateID];
         }
         return maxCount;
      }
      
      private function responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(_item)
               {
                  if(_item.TemplateID == 11998 || _item.TemplateID == 11997 || _item.TemplateID == 11901 || _item.TemplateID == 11902 || _item.TemplateID == 11903 || _item.TemplateID == 11904 || _item.TemplateID == 11905 || _item.TemplateID == 12535 || _item.TemplateID == 11956 || _item.TemplateID == 11955 || EquipType.isFireworks(_item))
                  {
                     SocketManager.Instance.out.sendUseCard(_item.BagType,_item.Place,[_item.TemplateID],_item.PayType,false,true,int(_inputText.text));
                  }
                  else if(_item.TemplateID == 112108 || _item.TemplateID == 112150 || _item.TemplateID == 1120538 || _item.TemplateID == 1120539)
                  {
                     SocketManager.Instance.out.sendOpenRandomBox(_item.Place,int(_inputText.text));
                  }
                  else if(_item.TemplateID == 11961 || _item.TemplateID == 11965 || _item.TemplateID == 11967)
                  {
                     SocketManager.Instance.out.sendOpenNationWord(_item.BagType,_item.Place,int(_inputText.text));
                  }
                  else if(_item.CategoryID == 18)
                  {
                     SocketManager.Instance.out.sendOpenCardBox(_item.Place,int(_inputText.text),_item.BagType);
                  }
                  else if(_item.CategoryID == 66)
                  {
                     SocketManager.Instance.out.sendOpenSpecialCardBox(_item.Place,int(_inputText.text),_item.BagType);
                  }
                  else if(_item.TemplateID == 1120412 || _item.TemplateID == 1120413 || _item.TemplateID == 1120414 || _item.TemplateID == 1120433 || _item.TemplateID == 1120434)
                  {
                     SocketManager.Instance.out.sendChangeSex(_item.BagType,_item.Place,int(_inputText.text));
                  }
                  else if(_item.CategoryID == 68)
                  {
                     SocketManager.Instance.out.sendOpenAmuletBox(_item.BagType,_item.Place,int(_inputText.text));
                  }
                  else if(EquipType.GOURD_EXP_BOTTLE.indexOf(_item.TemplateID) >= 0)
                  {
                     SocketManager.Instance.out.sendUseCard(_item.BagType,_item.Place,[_item.TemplateID],_item.PayType,false,true,int(_inputText.text));
                  }
                  else
                  {
                     SocketManager.Instance.out.sendItemOpenUp(_item.BagType,_item.Place,int(_inputText.text));
                  }
               }
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _maxBtn.removeEventListener("click",changeMaxHandler);
         _inputText.removeEventListener("change",inputTextChangeHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _item = null;
         _txt = null;
         _inputBg = null;
         _inputText = null;
         _maxBtn = null;
      }
   }
}
