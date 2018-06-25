package welfareCenter.icon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class WelfareCenterItem extends Sprite implements Disposeable, ISelectable
   {
       
      
      protected var _icon:MutipleImage;
      
      protected var _type:int;
      
      protected var _selected:Boolean;
      
      protected var _shine:MovieClip;
      
      protected var _filter:Array;
      
      public function WelfareCenterItem($type:int)
      {
         super();
         _type = $type;
         init();
      }
      
      protected function init() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.gift.icon" + _type);
         _icon.buttonMode = true;
         addChild(_icon);
         _shine = ComponentFactory.Instance.creat("asset.welfareCeneter.iconItemShine");
         PositionUtils.setPos(_shine,"welfareCenter.gradeGiftView.ItemShinePos");
         _shine.visible = false;
         addChild(_shine);
         _filter = ComponentFactory.Instance.creatFilters("welfareCenter.boxFilter");
         this.filters = _filter;
      }
      
      public function get canClick() : Boolean
      {
         return true;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set isShine(value:Boolean) : void
      {
         _shine.visible = value;
      }
      
      public function set autoSelect(value:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         this.filters = !!_selected?[]:_filter;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _shine = null;
         _filter = null;
      }
   }
}
