package cloudBuyLottery.view
{
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   
   public class TheWinningLog extends Frame
   {
       
      
      private var SHOP_ITEM_NUM:int;
      
      private var itemList:Array;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _logArr:Array;
      
      private var _bg:Bitmap;
      
      public function TheWinningLog()
      {
         super();
         initView();
         loadList();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.dituBG");
         addToContent(_bg);
         _titleText = LanguageMgr.GetTranslation("TheWinningLog.titleText");
         _list = ComponentFactory.Instance.creatComponentByStylename("TheWinningLog.goodsListBox");
         _list.spacing = 0;
         _panel = ComponentFactory.Instance.creatComponentByStylename("TheWinningLog.right.scrollpanel");
         _panel.x = 0;
         _panel.y = -4;
         _panel.width = 210;
         _panel.height = 465;
         itemList = [];
         _logArr = CloudBuyLotteryManager.Instance.logArr;
         if(_logArr != null)
         {
            SHOP_ITEM_NUM = _logArr.length;
            if(SHOP_ITEM_NUM <= 0)
            {
               return;
            }
            i = 0;
            while(i < SHOP_ITEM_NUM)
            {
               item = ComponentFactory.Instance.creatCustomObject("TheWinningLog.WinningLogListItem");
               itemList.push(item);
               itemList[i].initView(_logArr[i].nickName,i);
               itemList[i].y = (itemList[i].height + 1) * i;
               _list.addChild(itemList[i]);
               i++;
            }
         }
         _panel.setView(_list);
         addToContent(_panel);
         _panel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function loadList() : void
      {
         setList(CloudBuyLotteryManager.Instance.model.myGiftData);
      }
      
      private function setList(list:Vector.<WinningLogItemInfo>) : void
      {
         var i:int = 0;
         if(list == null)
         {
            return;
         }
         clearitems();
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            if(list)
            {
               if(i < list.length && list[i])
               {
                  itemList[i].shopItemInfo = list[i];
                  itemList[i].itemID = list[i].TemplateID;
               }
               i++;
               continue;
            }
            break;
         }
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         if(itemList[i] == null)
         {
            return;
         }
         i = 0;
         while(i < SHOP_ITEM_NUM)
         {
            itemList[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         if(itemList)
         {
            for(i = 0; i < itemList.length; )
            {
               ObjectUtils.disposeObject(itemList[i]);
               itemList[i] = null;
               i++;
            }
            itemList = null;
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         disposeItems();
         CloudBuyLotteryFrame.logFrameFlag = false;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
