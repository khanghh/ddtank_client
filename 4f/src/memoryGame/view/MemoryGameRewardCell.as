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
      
      public function MemoryGameRewardCell(){super(null,null,null,null,null);}
      
      public function set isGain(param1:Boolean) : void{}
      
      public function get isGain() : Boolean{return false;}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      public function playAction() : void{}
      
      override public function dispose() : void{}
   }
}
