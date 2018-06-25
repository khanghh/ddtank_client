package auctionHouse.view
{
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class AuctionCellViewII extends LinkedBagCell
   {
      
      public static const SELECT_BID_GOOD:String = "selectBidGood";
      
      public static const SELECT_GOOD:String = "selectGood";
       
      
      public function AuctionCellViewII()
      {
         var bgSprite:Sprite = new Sprite();
         var _bg:MovieClip = ClassUtils.CreatInstance("asset.core.ItemCellUnSelected");
         _bg.width = 50;
         _bg.height = 50;
         bgSprite.addChild(_bg);
         super(bgSprite);
         tipDirctions = "7,5,2,6,4,1";
         PicPos = new Point(2,1);
      }
      
      override protected function addEnchantMc() : void
      {
         _enchantMcPosStr = "auctionSell.enchant.levelMcPos";
         super.addEnchantMc();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _tbxCount = null;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
