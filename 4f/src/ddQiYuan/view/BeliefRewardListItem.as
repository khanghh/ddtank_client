package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BeliefRewardListItem extends Sprite implements Disposeable
   {
       
      
      private var _data:Object;
      
      private var _beliefRewardConTf:FilterFrameText;
      
      private var _bagCell:BagCell;
      
      public function BeliefRewardListItem(){super();}
      
      private function initView() : void{}
      
      public function setData(param1:Object) : void{}
      
      public function dispose() : void{}
   }
}
