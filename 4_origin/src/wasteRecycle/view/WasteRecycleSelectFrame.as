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
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.wasteRecycle.inputFrameTitle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         info = alertInfo;
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
      
      override protected function onResponse(type:int) : void
      {
         var count:int = 0;
         var goodsInfo:* = null;
         var socre:int = 0;
         SoundManager.instance.playButtonSound();
         if(type == 2 || type == 3)
         {
            count = _numberSelect.currentValue;
            if(count > _cell.itemInfo.Count)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.inputCountTips"));
               return;
            }
            goodsInfo = WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID];
            socre = WasteRecycleController.instance.model.lotteryDonateScore + count * goodsInfo.Integral;
            if(socre >= WasteRecycleController.instance.model.lotteryLimitScore + goodsInfo.Integral)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.limitScoreTips"));
               return;
            }
            SocketManager.Instance.out.sendClearStoreBag();
            SocketManager.Instance.out.sendMoveGoods(_cell.itemInfo.BagType,_cell.itemInfo.Place,12,0,count,true);
         }
         else
         {
            _cell.locked = false;
         }
         dispose();
      }
      
      public function show(cell:WasteRecycleCell) : void
      {
         _cell = cell;
         _numberSelect.valueLimit = "1," + _cell.itemInfo.Count;
         updateTips();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __onSelectedChange(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         updateTips();
      }
      
      private function updateTips() : void
      {
         var goodsInfo:* = null;
         var score:int = 0;
         if(_cell && WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID])
         {
            goodsInfo = WasteRecycleController.instance.model.data[_cell.itemInfo.TemplateID];
            score = goodsInfo.Integral * _numberSelect.currentValue;
            if(score + WasteRecycleController.instance.model.lotteryDonateScore > WasteRecycleController.instance.model.lotteryLimitScore)
            {
               score = WasteRecycleController.instance.model.lotteryLimitScore - WasteRecycleController.instance.model.lotteryDonateScore;
            }
            if(score > 0)
            {
               _scoreText.htmlText = LanguageMgr.GetTranslation("ddt.wasteRecycle.recycleTips",score);
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
