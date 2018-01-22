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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
            _loc2_ = 0;
            while(_loc2_ < SHOP_ITEM_NUM)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("TheWinningLog.WinningLogListItem");
               itemList.push(_loc1_);
               itemList[_loc2_].initView(_logArr[_loc2_].nickName,_loc2_);
               itemList[_loc2_].y = (itemList[_loc2_].height + 1) * _loc2_;
               _list.addChild(itemList[_loc2_]);
               _loc2_++;
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
      
      private function setList(param1:Vector.<WinningLogItemInfo>) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < SHOP_ITEM_NUM)
         {
            if(param1)
            {
               if(_loc2_ < param1.length && param1[_loc2_])
               {
                  itemList[_loc2_].shopItemInfo = param1[_loc2_];
                  itemList[_loc2_].itemID = param1[_loc2_].TemplateID;
               }
               _loc2_++;
               continue;
            }
            break;
         }
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         if(itemList[_loc1_] == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < SHOP_ITEM_NUM)
         {
            itemList[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      private function disposeItems() : void
      {
         var _loc1_:int = 0;
         if(itemList)
         {
            _loc1_ = 0;
            while(_loc1_ < itemList.length)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
               _loc1_++;
            }
            itemList = null;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
