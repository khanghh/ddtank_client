package memoryGame.view
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.Shape;
   
   public class MemoryGameRewardCell extends BagCell
   {
       
      
      private var _tips:Bitmap;
      
      private var _tween:TweenLite;
      
      public function MemoryGameRewardCell()
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,65,65);
         _loc1_.graphics.endFill();
         super(0,null,true,_loc1_,false);
         _tips = ComponentFactory.Instance.creatBitmap("asset.memoryGame.gain");
         addChild(_tips);
         isGain = false;
      }
      
      public function set isGain(param1:Boolean) : void
      {
         _tips.visible = param1;
      }
      
      public function get isGain() : Boolean
      {
         return _tips.visible;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         if(_info != null)
         {
            playAction();
         }
         .super.info = param1;
         if(_tips)
         {
            addChild(_tips);
         }
      }
      
      public function playAction() : void
      {
         this.alpha = 0;
         TweenLite.to(this,1,{"alpha":1});
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         super.dispose();
      }
   }
}
