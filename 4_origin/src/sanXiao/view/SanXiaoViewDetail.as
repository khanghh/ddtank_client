package sanXiao.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoViewDetail extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _detailText:FilterFrameText;
      
      private var _priseText:FilterFrameText;
      
      private var _itemList:Vector.<SXRewardItem>;
      
      private var _itemContainer:VBox;
      
      private var _scroll:ScrollPanel;
      
      public function SanXiaoViewDetail()
      {
         super();
         init();
         addEvents();
      }
      
      private function init() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ast.sanxiao.bg.detail");
         addChild(_bg);
         _timeRemainText = ComponentFactory.Instance.creat("sanxiao.storeText.Txt");
         _timeRemainText.text = "00:00:00";
         PositionUtils.setPos(_timeRemainText,"sanxiao.detailTimeRemain.pt");
         addChild(_timeRemainText);
         _detailText = ComponentFactory.Instance.creat("sanxiao.storeText.Txt");
         _detailText.text = "测试";
         PositionUtils.setPos(_detailText,"sanxiao.detailDescribe.pt");
         addChild(_detailText);
         _priseText = ComponentFactory.Instance.creat("sanxiao.storeItemPrice.Txt");
         _priseText.text = "000";
         PositionUtils.setPos(_priseText,"sanxiao.detailPriseScore.pt");
         addChild(_priseText);
         _itemList = new Vector.<SXRewardItem>();
         _itemContainer = new VBox();
         _itemContainer.spacing = 0;
         var _loc1_:Array = SanXiaoManager.getInstance().scoreRewardList;
         var _loc2_:int = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new SXRewardItem();
            _loc3_.update(_loc1_[_loc4_]);
            _itemContainer.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _itemContainer.arrange();
         _scroll = ComponentFactory.Instance.creatComponentByStylename("sanxiao.Detail.scrollList");
         _scroll.setView(_itemContainer);
         addChild(_scroll);
      }
      
      private function addEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         _timeRemainText.text = DateUtils.dateFormat(SanXiaoManager.getInstance().endTime);
         _detailText.text = LanguageMgr.GetTranslation("sanxiao.detailDescribe");
         _priseText.text = SanXiaoManager.getInstance().score.toString();
         var _loc1_:Array = SanXiaoManager.getInstance().scoreRewardList;
         var _loc2_:int = _itemList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _itemList[_loc3_].update(_loc1_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_itemList)
         {
            _itemList.length = 0;
            _itemList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _scroll = null;
         _itemContainer = null;
         _timeRemainText = null;
         _detailText = null;
         _priseText = null;
      }
   }
}
