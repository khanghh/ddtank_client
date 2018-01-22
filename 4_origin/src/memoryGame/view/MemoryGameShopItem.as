package memoryGame.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import memoryGame.MemoryGameManager;
   import memoryGame.data.MemoryGameGoodsInfo;
   
   public class MemoryGameShopItem extends Sprite implements Disposeable
   {
       
      
      private var _scoreText:FilterFrameText;
      
      private var _cell:BagCell;
      
      private var _info:MemoryGameGoodsInfo;
      
      private var _gainGoodsBtn:SimpleBitmapButton;
      
      private var _get:Bitmap;
      
      public function MemoryGameShopItem(param1:MemoryGameGoodsInfo)
      {
         super();
         _info = param1;
         init();
      }
      
      private function init() : void
      {
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.scoreText");
         _scoreText.text = _info.Point.toString();
         PositionUtils.setPos(_scoreText,"memoryGame.shopItemTextPos");
         addChild(_scoreText);
         _gainGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("memoryGame.gainGoodsBtn");
         _gainGoodsBtn.addEventListener("click",__onClick);
         addChild(_gainGoodsBtn);
         var _loc1_:InventoryItemInfo = ItemManager.fillByID(_info.ItemID);
         _loc1_.ValidDate = _info.Valid;
         _loc1_.Count = _info.Count;
         _loc1_.IsBinds = _info.IsBind;
         _cell = new BagCell(0);
         _cell.info = _loc1_;
         PositionUtils.setPos(_cell,"memoryGame.shopItemCellPos");
         addChild(_cell);
         _get = ComponentFactory.Instance.creatBitmap("asset.memoryGame.get");
         addChild(_get);
      }
      
      public function updateState() : void
      {
         if(MemoryGameManager.instance.getRewardList.hasKey(_info.ID))
         {
            _gainGoodsBtn.visible = false;
            _get.visible = true;
         }
         else
         {
            _get.visible = false;
            _gainGoodsBtn.visible = true;
            if(MemoryGameManager.instance.score >= _info.Point)
            {
               _gainGoodsBtn.enable = true;
            }
            else
            {
               _gainGoodsBtn.enable = false;
            }
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(MemoryGameManager.instance.score >= _info.Point)
         {
            _gainGoodsBtn.visible = false;
            _get.visible = true;
            MemoryGameManager.instance.getRewardList.add(_info.ID,true);
            SocketManager.Instance.out.sendMemoryGameGetReward(_info.ID);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.pointTips"));
         }
      }
      
      override public function get height() : Number
      {
         return 45;
      }
      
      public function dispose() : void
      {
         _gainGoodsBtn.removeEventListener("click",__onClick);
         ObjectUtils.disposeAllChildren(this);
         _get = null;
         _scoreText = null;
         _cell = null;
         _gainGoodsBtn = null;
      }
   }
}
