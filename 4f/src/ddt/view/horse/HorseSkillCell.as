package ddt.view.horse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseManager;
   import horse.data.HorseSkillGetVo;
   import horse.data.HorseSkillVo;
   
   public class HorseSkillCell extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _skillId:int;
      
      private var _skillGetInfo:HorseSkillGetVo;
      
      private var _skillInfo:HorseSkillVo;
      
      private var _skillIcon:Bitmap;
      
      public function HorseSkillCell(param1:int, param2:Boolean = true, param3:Boolean = false){super();}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
