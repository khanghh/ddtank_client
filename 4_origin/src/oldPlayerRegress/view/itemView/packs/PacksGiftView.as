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
      
      public function PacksGiftView(param1:Vector.<GiftData> = null)
      {
         super();
         getGiftData = param1;
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _packsGiftBgArray.length)
         {
            _packsGiftBgArray[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("regress.packstemCellBg");
            if(_loc2_ > 0)
            {
               _packsGiftBgArray[_loc2_].x = _packsGiftBgArray[_loc2_ - 1].x + _packsGiftBgArray[_loc2_ - 1].width + 8;
            }
            addChild(_packsGiftBgArray[_loc2_]);
            _loc1_ = new BagCell(_loc2_);
            _loc1_.x = _packsGiftBgArray[_loc2_].x;
            _loc1_.y = _packsGiftBgArray[_loc2_].y;
            _giftContentList.push(_loc1_);
            _loc2_++;
         }
         setGiftInfo();
      }
      
      public function setGoods(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = getGiftData[param1].giftID;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.IsBinds = true;
         return _loc2_;
      }
      
      public function setGiftInfo() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _giftContentList.length)
         {
            if(getGiftData)
            {
               if(_loc1_ < getGiftData.length)
               {
                  _giftContentList[_loc1_].info = setGoods(_loc1_);
                  _giftContentList[_loc1_].setCount(getGiftData[_loc1_].giftCount);
                  addChild(_giftContentList[_loc1_]);
               }
            }
            _loc1_++;
         }
      }
      
      public function removeGiftChild() : void
      {
         var _loc1_:int = 0;
         if(getGiftData)
         {
            _loc1_ = 0;
            while(_loc1_ < getGiftData.length && _loc1_ < 8)
            {
               removeChild(_giftContentList[_loc1_]);
               _loc1_++;
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.dispose();
         removeEvent();
         _loc2_ = 0;
         while(_loc2_ < _packsGiftBgArray.length)
         {
            _packsGiftBgArray[_loc2_] = null;
            _loc2_++;
         }
         if(getGiftData)
         {
            _loc1_ = 0;
            while(_loc1_ < getGiftData.length && _loc2_ < 8)
            {
               _giftContentList[_loc1_] = null;
               _loc1_++;
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
      
      public function set getGiftData(param1:Vector.<GiftData>) : void
      {
         _getGiftData = param1;
      }
   }
}
