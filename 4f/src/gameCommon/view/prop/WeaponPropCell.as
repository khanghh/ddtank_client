package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class WeaponPropCell extends PropCell
   {
       
      
      private var _countField:FilterFrameText;
      
      public function WeaponPropCell(param1:String, param2:int){super(null,null);}
      
      private static function creatDeputyWeaponIcon(param1:int) : Bitmap{return null;}
      
      override public function setPossiton(param1:int, param2:int) : void{}
      
      override protected function drawLayer() : void{}
      
      override protected function configUI() : void{}
      
      public function setCount(param1:int) : void{}
      
      override public function set info(param1:PropInfo) : void{}
      
      override public function useProp() : void{}
      
      override public function dispose() : void{}
   }
}
