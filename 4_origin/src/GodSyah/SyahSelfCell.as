package GodSyah
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.filters.ColorMatrixFilter;
   
   public class SyahSelfCell extends BaseCell
   {
       
      
      private var _cellShineBg:Bitmap;
      
      private var _shineEnable:Boolean;
      
      public function SyahSelfCell()
      {
         super(ComponentFactory.Instance.creatBitmap("wonderfulactivity.GodSyah.syahView.0aphacell"));
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_shineEnable)
         {
            if(_pic)
            {
               _pic.filters = [];
            }
            _cellShineBg = ComponentFactory.Instance.creatBitmap("wonderfulactivity.GodSyah.syahView.cellShine");
            addChild(_cellShineBg);
         }
         else
         {
            _pic.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
      }
      
      public function get shineEnable() : Boolean
      {
         return _shineEnable;
      }
      
      public function set shineEnable(param1:Boolean) : void
      {
         _shineEnable = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_cellShineBg)
         {
            ObjectUtils.disposeObject(_cellShineBg);
            _cellShineBg = null;
         }
      }
   }
}
