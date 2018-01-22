package store.fineStore.view.pageForge
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class FineForgeCell extends BaseCell implements ISelectable
   {
       
      
      private var _select:Boolean;
      
      private var _shine:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _type:int;
      
      private var _name:String;
      
      public function FineForgeCell(param1:int, param2:String = "", param3:ItemTemplateInfo = null, param4:Boolean = true, param5:Boolean = true)
      {
         _type = param1;
         _name = param2;
         var _loc6_:DisplayObject = ComponentFactory.Instance.creatBitmap("store.fineforge.cellBg" + _type);
         super(_loc6_,param3,param4,param5);
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_tipData && _tipData is GoodTipInfo)
         {
            GoodTipInfo(_tipData).suitIcon = true;
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _text = UICreatShortcut.creatTextAndAdd("storeFine.cell.text",_name,this);
         _shine = UICreatShortcut.creatAndAdd("store.fineforge.cellShine",this);
         _shine.visible = false;
         PicPos = new Point(5,6);
      }
      
      public function set bgType(param1:int) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
         ObjectUtils.disposeObject(_bg);
         _type = _type > 5?5:_type;
         _bg = ComponentFactory.Instance.creatBitmap("store.fineforge.cellBg" + _type);
         if(_type == 1)
         {
            _bg.x = 0;
            _bg.y = 0;
         }
         else
         {
            _bg.x = -7;
            _bg.y = -7;
         }
         addChildAt(_bg,0);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get cellName() : String
      {
         return _name;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_select == param1)
         {
            return;
         }
         _select = param1;
         _shine.visible = param1;
      }
      
      public function get selected() : Boolean
      {
         return _select;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_shine);
         _shine = null;
         super.dispose();
      }
   }
}
