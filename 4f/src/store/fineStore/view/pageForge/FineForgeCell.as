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
      
      public function FineForgeCell(param1:int, param2:String = "", param3:ItemTemplateInfo = null, param4:Boolean = true, param5:Boolean = true){super(null,null,null,null);}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override protected function createChildren() : void{}
      
      public function set bgType(param1:int) : void{}
      
      public function get type() : int{return 0;}
      
      public function get cellName() : String{return null;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
