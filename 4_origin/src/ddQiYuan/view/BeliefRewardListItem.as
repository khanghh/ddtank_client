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
      
      public function BeliefRewardListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _beliefRewardConTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.beliefRewardConTf");
         addChild(_beliefRewardConTf);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
         _bagCell = new BagCell(1,null,true,_loc1_,false);
         _bagCell.PicPos = new Point(2,2);
         _bagCell.setContentSize(38,38);
         _bagCell.x = 150;
         addChild(_bagCell);
      }
      
      public function setData(param1:Object) : void
      {
         _data = param1;
         _beliefRewardConTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.beliefRewardConTfMsg",_data["offerTimes"]);
         var _loc2_:InventoryItemInfo = DDQiYuanManager.instance.getInventoryItemInfo(param1);
         _bagCell.info = _loc2_;
         _bagCell.setCount(_loc2_.Count);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _beliefRewardConTf = null;
         _bagCell = null;
      }
   }
}
