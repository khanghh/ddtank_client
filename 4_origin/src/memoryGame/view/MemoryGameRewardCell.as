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
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,65,65);
         shape.graphics.endFill();
         super(0,null,true,shape,false);
         _tips = ComponentFactory.Instance.creatBitmap("asset.memoryGame.gain");
         addChild(_tips);
         isGain = false;
      }
      
      public function set isGain(value:Boolean) : void
      {
         _tips.visible = value;
      }
      
      public function get isGain() : Boolean
      {
         return _tips.visible;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         if(_info != null)
         {
            playAction();
         }
         .super.info = value;
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
