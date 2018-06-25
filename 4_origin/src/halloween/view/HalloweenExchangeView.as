package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HalloweenExchangeView extends Sprite implements Disposeable
   {
       
      
      private var _idArray:Array;
      
      private var _itemsArray:Array;
      
      public function HalloweenExchangeView()
      {
         super();
         _idArray = [];
         _itemsArray = [];
         initEvent();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onUpdateExchangeCellInfo);
      }
      
      protected function __onUpdateExchangeCellInfo(event:BagEvent) : void
      {
         setExchangeCellInfo();
      }
      
      public function set info(value:Array) : void
      {
         if(_idArray == value)
         {
            return;
         }
         _idArray = value;
         setExchangeCellInfo();
      }
      
      private function setExchangeCellInfo() : void
      {
         var hasItemFlag:Boolean = false;
         var i:int = 0;
         var items:* = null;
         if(_idArray)
         {
            hasItemFlag = false;
            for(i = 0; i < _idArray.length; )
            {
               if(!_itemsArray[i])
               {
                  items = new BagCell(1);
                  items.setBgVisible(false);
                  items.info = ItemManager.Instance.getTemplateById(_idArray[i]);
                  PositionUtils.setPos(items,"halloween.exchangeItemsPos" + i);
                  addChild(items);
                  _itemsArray.push(items);
               }
               items = _itemsArray[i];
               if(i == _idArray.length - 1)
               {
                  items.grayFilters = _itemsArray[0].grayFlag || _itemsArray[1].grayFlag || _itemsArray[2].grayFlag || _itemsArray[3].grayFlag;
                  items.buttonMode = true;
                  items.addEventListener("click",__onExchange);
               }
               else
               {
                  hasItemFlag = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(_idArray[i]);
                  items.grayFilters = !hasItemFlag;
               }
               i++;
            }
         }
      }
      
      private function __onExchange(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_itemsArray[_idArray.length - 1].grayFlag)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SocketManager.Instance.out.getHalloweenSetExchange();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("halloween.view.exchangeFail"));
         }
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onUpdateExchangeCellInfo);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         if(_itemsArray[_idArray.length - 1])
         {
            _itemsArray[_idArray.length - 1].removeEventListener("click",__onExchange);
         }
         i = 0;
         while(i < _itemsArray.length)
         {
            ObjectUtils.disposeObject(_itemsArray[i]);
            _itemsArray[i] = null;
            i++;
         }
         _itemsArray = null;
         _idArray = null;
      }
   }
}
