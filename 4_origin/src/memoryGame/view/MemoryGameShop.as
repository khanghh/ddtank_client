package memoryGame.view
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
   import memoryGame.MemoryGameManager;
   import memoryGame.data.MemoryGameGoodsInfo;
   
   public class MemoryGameShop extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function MemoryGameShop()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.memoryGame.shop.bg");
         addChild(_bg);
         _timeText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.dayText");
         _timeText.text = MemoryGameManager.instance.dateToString();
         PositionUtils.setPos(_timeText,"memoryGame.shopTimePos");
         addChild(_timeText);
         _contentText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.contentText");
         _contentText.text = LanguageMgr.GetTranslation("memoryGame.shopTips");
         PositionUtils.setPos(_contentText,"memoryGame.shopContentPos");
         addChild(_contentText);
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.scoreText");
         PositionUtils.setPos(_scoreText,"memoryGame.shopScorePos");
         addChild(_scoreText);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("memoryGame.scroolPanel");
         addChild(_scrollPanel);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("memoryGame.MemoryGameFrame.shop.vBox");
         var list:Vector.<MemoryGameGoodsInfo> = MemoryGameManager.instance.goodsList();
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            item = new MemoryGameShopItem(list[i]);
            _vBox.addChild(item);
            i++;
         }
         _vBox.arrange();
         _scrollPanel.setView(_vBox);
      }
      
      public function update() : void
      {
         var i:int = 0;
         _scoreText.text = MemoryGameManager.instance.score.toString();
         for(i = 0; i < _vBox.numChildren; )
         {
            (_vBox.getChildAt(i) as MemoryGameShopItem).updateState();
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _vBox = null;
         _scrollPanel = null;
      }
   }
}
