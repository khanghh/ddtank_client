package ddtKingFloat.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class DDTKingFloatNameCell extends Sprite implements Disposeable
   {
       
      
      private var _selectedLight:Bitmap;
      
      private var _sprite:Sprite;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _isVIP:Boolean;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _index:int;
      
      public function DDTKingFloatNameCell(param1:int){super();}
      
      public function get index() : int{return 0;}
      
      private function initView() : void{}
      
      public function setData(param1:String, param2:int = 25, param3:Boolean = true) : void{}
      
      private function addNickName() : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
