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
      
      public function WelfareCenterItem(param1:int){super();}
      
      protected function init() : void{}
      
      public function get canClick() : Boolean{return false;}
      
      public function get type() : int{return 0;}
      
      public function set isShine(param1:Boolean) : void{}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
