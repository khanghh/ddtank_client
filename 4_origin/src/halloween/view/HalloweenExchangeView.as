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
      
      protected function __onUpdateExchangeCellInfo(param1:BagEvent) : void
      {
         setExchangeCellInfo();
      }
      
      public function set info(param1:Array) : void
      {
         if(_idArray == param1)
         {
            return;
         }
         _idArray = param1;
         setExchangeCellInfo();
      }
      
      private function setExchangeCellInfo() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_idArray)
         {
            _loc1_ = false;
            _loc3_ = 0;
            while(_loc3_ < _idArray.length)
            {
               if(!_itemsArray[_loc3_])
               {
                  _loc2_ = new BagCell(1);
                  _loc2_.setBgVisible(false);
                  _loc2_.info = ItemManager.Instance.getTemplateById(_idArray[_loc3_]);
                  PositionUtils.setPos(_loc2_,"halloween.exchangeItemsPos" + _loc3_);
                  addChild(_loc2_);
                  _itemsArray.push(_loc2_);
               }
               _loc2_ = _itemsArray[_loc3_];
               if(_loc3_ == _idArray.length - 1)
               {
                  _loc2_.grayFilters = _itemsArray[0].grayFlag || _itemsArray[1].grayFlag || _itemsArray[2].grayFlag || _itemsArray[3].grayFlag;
                  _loc2_.buttonMode = true;
                  _loc2_.addEventListener("click",__onExchange);
               }
               else
               {
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(_idArray[_loc3_]);
                  _loc2_.grayFilters = !_loc1_;
               }
               _loc3_++;
            }
         }
      }
      
      private function __onExchange(param1:MouseEvent) : void
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
         var _loc1_:int = 0;
         removeEvent();
         if(_itemsArray[_idArray.length - 1])
         {
            _itemsArray[_idArray.length - 1].removeEventListener("click",__onExchange);
         }
         _loc1_ = 0;
         while(_loc1_ < _itemsArray.length)
         {
            ObjectUtils.disposeObject(_itemsArray[_loc1_]);
            _itemsArray[_loc1_] = null;
            _loc1_++;
         }
         _itemsArray = null;
         _idArray = null;
      }
   }
}
