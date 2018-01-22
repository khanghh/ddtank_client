package sanXiao.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.pageSelector.PageSelector;
   import ddt.view.pageSelector.PageSelectorFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoViewStore extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemList:Vector.<SXStoreItem>;
      
      private var _pageSelecter:PageSelector;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _crystalRemainText:FilterFrameText;
      
      private var _crystalIconBmp:Bitmap;
      
      public function SanXiaoViewStore()
      {
         super();
         init();
         addEvents();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("ast.sanxiao.bg.store");
         addChild(_bg);
         _itemList = new Vector.<SXStoreItem>();
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _itemList[_loc1_] = new SXStoreItem();
            _itemList[_loc1_].x = 216 + 256 * (_loc1_ % 2);
            _itemList[_loc1_].y = 60 + int(_loc1_ / 2) * 94;
            addChild(_itemList[_loc1_]);
            _loc1_++;
         }
         _pageSelecter = PageSelectorFactory.getInstance().getPageSelector("normal");
         _pageSelecter.itemDataArr = SanXiaoManager.getInstance().itemDataList;
         _pageSelecter.itemList = _itemList;
         PositionUtils.setPos(_pageSelecter,"sanxiao.storePageNumber.pt");
         addChild(_pageSelecter);
         _timeRemainText = ComponentFactory.Instance.creat("sanxiao.storeText.Txt");
         PositionUtils.setPos(_timeRemainText,"sanxiao.storeTimeRemain.pt");
         addChild(_timeRemainText);
         _timeRemainText.text = "00:00:00";
         _crystalRemainText = ComponentFactory.Instance.creat("sanxiao.storeText.Txt");
         PositionUtils.setPos(_crystalRemainText,"sanxiao.storeCrystalRemain.pt");
         addChild(_crystalRemainText);
         _crystalRemainText.text = "0";
         _crystalIconBmp = ComponentFactory.Instance.creatBitmap("ast.sanxiao.crystal");
         PositionUtils.setPos(_crystalIconBmp,"sanxiao.storeCrystalIcon.pt");
         addChild(_crystalIconBmp);
      }
      
      private function addEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function update() : void
      {
         _timeRemainText.text = DateUtils.dateFormat(SanXiaoManager.getInstance().endTime);
         _crystalRemainText.text = SanXiaoManager.getInstance().crystalNum.toString();
         _pageSelecter.itemDataArr = SanXiaoManager.getInstance().itemDataList;
         _pageSelecter.itemList = _itemList;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(_itemList)
         {
            _itemList.length = 0;
            _itemList = null;
         }
         if(_pageSelecter)
         {
            ObjectUtils.disposeObject(_pageSelecter);
            _pageSelecter = null;
         }
         _timeRemainText = null;
         _crystalRemainText = null;
         _crystalIconBmp = null;
      }
   }
}
