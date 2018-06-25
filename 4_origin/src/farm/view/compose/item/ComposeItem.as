package farm.view.compose.item
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ComposeItem extends BaseCell
   {
       
      
      protected var _tbxUseCount:FilterFrameText;
      
      protected var _tbxCount:FilterFrameText;
      
      private var _total:int;
      
      private var _need:int;
      
      public function ComposeItem(bg:DisplayObject)
      {
         super(bg);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("farmHouse.text.composeCount1");
         _tbxCount.mouseEnabled = false;
         _tbxUseCount = ComponentFactory.Instance.creatComponentByStylename("farmHouse.text.composeCount2");
         _tbxUseCount.mouseEnabled = false;
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         PositionUtils.setPos(sp,"farm.componseItem.cellPos");
         sp.width = 50;
         sp.height = 50;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         addChild(_tbxUseCount);
         addChild(_tbxCount);
         if(value)
         {
            _total = PlayerManager.Instance.Self.getBag(14).getItemCountByTemplateId(value.TemplateID);
            _tbxCount.text = _total.toString();
         }
         else
         {
            _tbxCount.text = "";
            _tbxUseCount.text = "";
         }
      }
      
      public function set useCount(count:int) : void
      {
         _need = count;
         _tbxUseCount.text = count > 0?"/" + count.toString():"";
         fixPos();
      }
      
      private function fixPos() : void
      {
         if(_tbxCount && _tbxUseCount)
         {
            _tbxUseCount.x = this.width - _tbxUseCount.width - 6;
            _tbxCount.x = _tbxUseCount.x - _tbxCount.textWidth - 1;
         }
      }
      
      public function get maxCount() : int
      {
         return int(_total / _need);
      }
      
      override public function dispose() : void
      {
         _need = 0;
         _total = 0;
         if(_tbxUseCount)
         {
            ObjectUtils.disposeObject(_tbxUseCount);
            _tbxUseCount = null;
         }
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
            _tbxCount = null;
         }
         super.dispose();
      }
   }
}
