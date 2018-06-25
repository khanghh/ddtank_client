package oldPlayerRegress.view.itemView.packs
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class PacksGiftView extends Frame
   {
       
      
      private var _packsGiftBgArray:Array;
      
      private var _giftContentList:Vector.<BagCell>;
      
      private var _getGiftData:Vector.<GiftData>;
      
      public function PacksGiftView(giftData:Vector.<GiftData> = null)
      {
         super();
         getGiftData = giftData;
         _init();
      }
      
      private function _init() : void
      {
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _packsGiftBgArray = new Array(new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage(),new ScaleBitmapImage());
         _giftContentList = new Vector.<BagCell>();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var giftCell:* = null;
         for(i = 0; i < _packsGiftBgArray.length; )
         {
            _packsGiftBgArray[i] = ComponentFactory.Instance.creatComponentByStylename("regress.packstemCellBg");
            if(i > 0)
            {
               _packsGiftBgArray[i].x = _packsGiftBgArray[i - 1].x + _packsGiftBgArray[i - 1].width + 8;
            }
            addChild(_packsGiftBgArray[i]);
            giftCell = new BagCell(i);
            giftCell.x = _packsGiftBgArray[i].x;
            giftCell.y = _packsGiftBgArray[i].y;
            _giftContentList.push(giftCell);
            i++;
         }
         setGiftInfo();
      }
      
      public function setGoods(id:int) : InventoryItemInfo
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = getGiftData[id].giftID;
         info = ItemManager.fill(info);
         info.IsBinds = true;
         return info;
      }
      
      public function setGiftInfo() : void
      {
         var i:int = 0;
         for(i = 0; i < _giftContentList.length; )
         {
            if(getGiftData)
            {
               if(i < getGiftData.length)
               {
                  _giftContentList[i].info = setGoods(i);
                  _giftContentList[i].setCount(getGiftData[i].giftCount);
                  addChild(_giftContentList[i]);
               }
            }
            i++;
         }
      }
      
      public function removeGiftChild() : void
      {
         var i:int = 0;
         if(getGiftData)
         {
            i = 0;
            while(i < getGiftData.length && i < 8)
            {
               removeChild(_giftContentList[i]);
               i++;
            }
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.dispose();
         removeEvent();
         for(i = 0; i < _packsGiftBgArray.length; )
         {
            _packsGiftBgArray[i] = null;
            i++;
         }
         if(getGiftData)
         {
            j = 0;
            while(j < getGiftData.length && i < 8)
            {
               _giftContentList[j] = null;
               j++;
            }
         }
         if(_getGiftData)
         {
            _getGiftData = null;
         }
      }
      
      public function get getGiftData() : Vector.<GiftData>
      {
         return _getGiftData;
      }
      
      public function set getGiftData(value:Vector.<GiftData>) : void
      {
         _getGiftData = value;
      }
   }
}
