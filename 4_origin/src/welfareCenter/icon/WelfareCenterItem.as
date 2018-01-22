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
      
      public function WelfareCenterItem(param1:int)
      {
         super();
         _type = param1;
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
      
      public function set isShine(param1:Boolean) : void
      {
         _shine.visible = param1;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
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
