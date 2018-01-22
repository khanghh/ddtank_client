package sevenday.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SevendayTaskCell extends Sprite implements Disposeable
   {
       
      
      private var _cell:BagCell;
      
      private var _rewardCompleteIcon:Bitmap;
      
      private var _isGet:Boolean;
      
      public function SevendayTaskCell(){super();}
      
      private function init() : void{}
      
      public function update(param1:ItemTemplateInfo, param2:int = 1) : void{}
      
      public function get isGet() : Boolean{return false;}
      
      public function set isGet(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
