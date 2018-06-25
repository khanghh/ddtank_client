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
      
      public function FineForgeCell(type:int, text:String = "", $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         _type = type;
         _name = text;
         var bg:DisplayObject = ComponentFactory.Instance.creatBitmap("store.fineforge.cellBg" + _type);
         super(bg,$info,showLoading,showTip);
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
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
      
      public function set bgType(value:int) : void
      {
         if(_type == value)
         {
            return;
         }
         _type = value;
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
      
      public function set selected(value:Boolean) : void
      {
         if(_select == value)
         {
            return;
         }
         _select = value;
         _shine.visible = value;
      }
      
      public function get selected() : Boolean
      {
         return _select;
      }
      
      public function set autoSelect(value:Boolean) : void
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
