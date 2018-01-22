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
      
      public function ComposeItem(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("farmHouse.text.composeCount1");
         _tbxCount.mouseEnabled = false;
         _tbxUseCount = ComponentFactory.Instance.creatComponentByStylename("farmHouse.text.composeCount2");
         _tbxUseCount.mouseEnabled = false;
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         PositionUtils.setPos(param1,"farm.componseItem.cellPos");
         param1.width = 50;
         param1.height = 50;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         addChild(_tbxUseCount);
         addChild(_tbxCount);
         if(param1)
         {
            _total = PlayerManager.Instance.Self.getBag(14).getItemCountByTemplateId(param1.TemplateID);
            _tbxCount.text = _total.toString();
         }
         else
         {
            _tbxCount.text = "";
            _tbxUseCount.text = "";
         }
      }
      
      public function set useCount(param1:int) : void
      {
         _need = param1;
         _tbxUseCount.text = param1 > 0?"/" + param1.toString():"";
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
