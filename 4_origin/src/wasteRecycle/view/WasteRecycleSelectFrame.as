package wasteRecycle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import wasteRecycle.WasteRecycleController;
   import wasteRecycle.data.WasteRecycleGoodsInfo;
   
   public class WasteRecycleSelectFrame extends BaseAlerFrame
   {
       
      
      private var _nameText:FilterFrameText;
      
      private var _numberSelect:NumberSelecter;
      
      private var _scoreText:FilterFrameText;
      
      private var _cell:WasteRecycleCell;
      
      public function WasteRecycleSelectFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.wasteRecycle.inputFrameTitle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         info = _loc1_;
      }
      
      override protected function init() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.selectFrameText");
         _nameText.text = LanguageMgr.GetTranslation("ddt.wasteRecycle.selectGoodsCount");
         _numberSelect = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         _numberSelect.addEventListener("change",__onSelectedChange);
         PositionUtils.setPos(_numberSelect,"wasteRecycle.numberSelectPos");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.selectFrameScoreText");
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_nameText)
         {
            addToContent(_nameText);
         }
         if(_numberSelect)
         {
            addToContent(_numberSelect);
         }
         if(_scoreText)
         {
            addToContent(_scoreText);
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1 == 2 || param1 == 3)
         {
            _loc4_ = _numberSelect.currentValue;
            if(_loc4_ > _cell.itemInfo.Count)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.inputCountTips"));
               return;
            }
            _loc2_ = WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID];
            _loc3_ = WasteRecycleController.instance.model.lotteryDonateScore + _loc4_ * _loc2_.Integral;
            if(_loc3_ >= WasteRecycleController.instance.model.lotteryLimitScore + _loc2_.Integral)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.limitScoreTips"));
               return;
            }
            SocketManager.Instance.out.sendClearStoreBag();
            SocketManager.Instance.out.sendMoveGoods(_cell.itemInfo.BagType,_cell.itemInfo.Place,12,0,_loc4_,true);
         }
         else
         {
            _cell.locked = false;
         }
         dispose();
      }
      
      public function show(param1:WasteRecycleCell) : void
      {
         _cell = param1;
         _numberSelect.valueLimit = "1," + _cell.itemInfo.Count;
         updateTips();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __onSelectedChange(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         updateTips();
      }
      
      private function updateTips() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_cell && WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID])
         {
            _loc1_ = WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID];
            _loc2_ = _loc1_.Integral * _numberSelect.currentValue;
            if(_loc2_ + WasteRecycleController.instance.model.lotteryDonateScore > WasteRecycleController.instance.model.lotteryLimitScore)
            {
               _loc2_ = WasteRecycleController.instance.model.lotteryLimitScore - WasteRecycleController.instance.model.lotteryDonateScore;
            }
            if(_loc2_ > 0)
            {
               _scoreText.htmlText = LanguageMgr.GetTranslation("ddt.wasteRecycle.recycleTips",_loc2_);
            }
            return;
         }
         _scoreText.text = "";
      }
      
      override public function dispose() : void
      {
         _numberSelect.removeEventListener("change",__onSelectedChange);
         super.dispose();
         _numberSelect = null;
         _nameText = null;
         _scoreText = null;
      }
   }
}
